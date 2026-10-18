#!/usr/bin/env python3
"""Meow agent: tiny, free, PR-only coding agent. Standard library only."""
import datetime, json, os, pathlib, re, subprocess, sys, time
import urllib.error, urllib.request

ROOT = pathlib.Path.cwd().resolve()
BASE = os.environ.get("LLM_BASE_URL", "https://models.github.ai/inference").rstrip("/")
KEY = os.environ.get("LLM_API_KEY") or os.environ.get("GITHUB_TOKEN", "")
MODEL = os.environ.get("MODEL", "openai/gpt-4o-mini")
TASK = os.environ.get("TASK", "").strip()
FILES = [f.strip() for f in os.environ.get("FILES", "").split(",") if f.strip()]
MAX_ROUNDS = int(os.environ.get("MAX_ROUNDS", "3"))
MAX_FILE_CHARS = int(os.environ.get("MAX_FILE_CHARS", "9000"))
PROTECTED = (".git/", ".github/", "agent/")
PROGRESS = ROOT / "agent" / "PROGRESS.md"
PR_BODY = pathlib.Path(os.environ.get("PR_BODY_PATH", "/tmp/pr_body.md"))


class QuotaStop(Exception):
    pass


def chat(messages):
    body = json.dumps({"model": MODEL, "messages": messages, "temperature": 0.2}).encode()
    req = urllib.request.Request(
        f"{BASE}/chat/completions", data=body,
        headers={"Content-Type": "application/json", "Authorization": f"Bearer {KEY}"})
    for attempt in range(2):
        try:
            with urllib.request.urlopen(req, timeout=120) as r:
                return json.load(r)["choices"][0]["message"]["content"]
        except urllib.error.HTTPError as e:
            detail = e.read().decode(errors="replace")[:300]
            if e.code in (413, 429) or "rate" in detail.lower() or "quota" in detail.lower():
                raise QuotaStop(f"HTTP {e.code}: {detail}")
            if e.code >= 500 and attempt == 0:
                time.sleep(5); continue
            raise RuntimeError(f"HTTP {e.code}: {detail}")


def run(cmd, timeout=120):
    """Run a command with a hard timeout and print its captured output."""
    print(f"$ {cmd} (timeout: {timeout}s)", flush=True)
    try:
        p = subprocess.run(
            cmd, shell=True, capture_output=True, text=True, timeout=timeout,
        )
    except subprocess.TimeoutExpired as exc:
        captured = exc.stdout or ""
        if isinstance(captured, bytes):
            captured = captured.decode(errors="replace")
        captured_err = exc.stderr or ""
        if isinstance(captured_err, bytes):
            captured_err = captured_err.decode(errors="replace")
        output = captured + captured_err
        if output:
            print(output[-12000:], end="", flush=True)
        print(f"\\n::error::Command timed out after {timeout}s: {cmd}", flush=True)
        raise subprocess.TimeoutExpired(cmd, timeout, output=output)
    output = p.stdout + p.stderr
    if output:
        print(output[-20000:], end="", flush=True)
    return p.returncode, output


def analyze():
    try:
        code, out = run(
            "flutter analyze --no-pub --no-fatal-infos --no-fatal-warnings",
            timeout=120,
        )
        return code == 0, out[-6000:]
    except subprocess.TimeoutExpired as exc:
        captured = exc.output or ""
        if isinstance(captured, bytes):
            captured = captured.decode(errors="replace")
        return False, (str(captured) + "\\nERROR: flutter analyze timed out after 120 seconds.")[-6000:]


def files_from_analyze(out):
    seen = []
    for m in re.finditer(r"•\s+((?:lib|test)/[^\s:]+\.dart):\d+", out):
        if m.group(1) not in seen:
            seen.append(m.group(1))
    return seen[:4]



def analyzer_diagnostics(out):
    """Return stable analyzer diagnostic signatures, ignoring line/column shifts."""
    diagnostics = set()
    for line in out.splitlines():
        parts = [part.strip() for part in line.split("•")]
        if len(parts) < 3:
            continue
        severity = parts[0].lower()
        if severity not in {"error", "warning", "info"}:
            continue
        location_index = next(
            (i for i, part in enumerate(parts)
             if re.search(r"(?:lib|test)/[^ \t:]+\.dart:\d+:\d+", part)),
            None,
        )
        if location_index is None or location_index < 2:
            continue
        message = parts[1]
        code = parts[location_index + 1] if location_index + 1 < len(parts) else ""
        diagnostics.add((severity, message, code))
    return diagnostics


def analysis_has_no_regressions(baseline_ok, baseline_out, current_ok, current_out):
    """Accept pre-existing analyzer failures only when edits add no diagnostics."""
    if current_ok:
        return True
    if baseline_ok:
        return False
    baseline = analyzer_diagnostics(baseline_out)
    current = analyzer_diagnostics(current_out)
    return bool(baseline) and current.issubset(baseline)

def files_from_task(task):
    """Include explicitly mentioned repository file paths in the model context."""
    candidates = re.findall(
        r"(?<![A-Za-z0-9_./-])(?:[A-Za-z0-9_.-]+/)*[A-Za-z0-9_.-]+\.(?:py|md|yaml|yml|dart|json)(?![A-Za-z0-9_.-])",
        task,
    )
    found = []
    for rel in candidates:
        path = (ROOT / rel).resolve()
        if ROOT in path.parents and path.is_file() and rel not in found:
            found.append(rel)
    return found[:5]


def read_files(paths):
    parts = []
    for p in paths:
        f = ROOT / p
        if f.is_file():
            txt = f.read_text(errors="replace")
            note = "\n[...TRUNCATED, do not edit beyond this point...]" if len(txt) > MAX_FILE_CHARS else ""
            parts.append(f"=== {p} ===\n{txt[:MAX_FILE_CHARS]}{note}")
    return "\n\n".join(parts)


def tree():
    _, out = run("git ls-files lib test pubspec.yaml agent.py AGENT.md | head -160")
    return out


def safe_path(rel):
    p = (ROOT / rel).resolve()
    if ROOT not in p.parents:
        return None
    r = p.relative_to(ROOT).as_posix()
    return None if r.startswith(PROTECTED) else p


def apply_edits(edits):
    """Apply only well-formed, bounded edits to paths inside the repository."""
    log = []
    if not isinstance(edits, list):
        return ["SKIP edits: expected a list"]
    for index, edit in enumerate(edits[:8]):
        if not isinstance(edit, dict):
            log.append(f"SKIP edit {index + 1}: expected an object")
            continue
        rel = edit.get("path")
        old = edit.get("old", "")
        new = edit.get("new")
        if not isinstance(rel, str) or not rel.strip():
            log.append(f"SKIP edit {index + 1}: invalid path")
            continue
        if not isinstance(old, str) or not isinstance(new, str):
            log.append(f"SKIP {rel}: 'old' and 'new' must be strings")
            continue
        p = safe_path(rel)
        if p is None:
            log.append(f"SKIP {rel}: path not allowed")
            continue
        if old == "":
            if p.exists():
                log.append(f"SKIP {rel}: file exists (use old/new)")
                continue
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text(new, encoding="utf-8")
            log.append(f"CREATED {rel}")
            continue
        if not p.is_file():
            log.append(f"SKIP {rel}: not found")
            continue
        txt = p.read_text(encoding="utf-8")
        matches = txt.count(old)
        if matches != 1:
            log.append(f"SKIP {rel}: 'old' matched {matches} times (need exactly 1)")
            continue
        p.write_text(txt.replace(old, new, 1), encoding="utf-8")
        log.append(f"EDITED {rel}")
    if len(edits) > 8:
        log.append(f"SKIP {len(edits) - 8} additional edits: limit is 8")
    return log


def parse(reply):
    """Parse a JSON object from a model reply, tolerating surrounding prose."""
    cleaned = reply.strip()
    if cleaned.startswith(chr(96) * 3):
        cleaned = re.sub(r"^```(?:json)?\s*", "", cleaned, count=1, flags=re.I)
        cleaned = re.sub(r"\s*```$", "", cleaned, count=1)

    try:
        data = json.loads(cleaned)
    except json.JSONDecodeError:
        # Try each opening brace with JSONDecoder.raw_decode. Unlike a greedy
        # regex, the decoder correctly handles braces inside JSON string values.
        decoder = json.JSONDecoder()
        data = None
        for match in re.finditer(r"\{", cleaned):
            try:
                candidate, _ = decoder.raw_decode(cleaned[match.start():])
            except json.JSONDecodeError:
                continue
            if isinstance(candidate, dict):
                data = candidate
                break
        if data is None:
            return {}
    return data if isinstance(data, dict) else {}


def log_progress(status, notes):
    stamp = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%d %H:%M UTC")
    entry = f"\n## {stamp} — {status}\nTask: {TASK}\nModel: {MODEL}\n" + "\n".join(f"- {n}" for n in notes) + "\n"
    with PROGRESS.open("a") as f:
        f.write(entry)
    PR_BODY.write_text(f"Automated by meow-agent ({MODEL}). **Do not merge without review.**\n{entry}")


def main():
    if not TASK or not KEY:
        sys.exit("TASK and an API key (GITHUB_TOKEN or LLM_API_KEY) are required")
    rules = (ROOT / "agent" / "AGENT.md").read_text()
    past = PROGRESS.read_text()[-2500:] if PROGRESS.exists() else ""
    notes, status = [], "finished"
    completed = False
    read_only = bool(re.search(
        r"READ[- ]ONLY DIAGNOSTIC MODE|do not modify.*files|no files? (?:may be )?modified",
        TASK, re.I | re.S,
    ))
    if read_only:
        print("READ-ONLY MODE: file edits and repository progress writes are disabled.", flush=True)
    try:
        ok, out = analyze()
        requested_files = files_from_task(TASK)
        files = list(dict.fromkeys(FILES + requested_files + files_from_analyze(out)))[:5]
        baseline_ok, baseline_out = ok, out
        baseline_diagnostics = analyzer_diagnostics(out)
        notes.append(f"analyze at start: {'clean' if ok else 'errors'}; context files: {files or 'none'}")
        if not ok and baseline_diagnostics:
            notes.append(f"baseline analyzer diagnostics tracked: {len(baseline_diagnostics)}")
        if not ok:
            notes.append("analyzer output at start (last 2500 chars):\\n" + out[-2500:])
        feedback = ""
        for rnd in range(1, MAX_ROUNDS + 1):
            user = (f"TASK: {TASK}\n\nRECENT PROGRESS LOG:\n{past}\n\nPROJECT FILES:\n{tree()}\n\n"
                    f"ANALYZER OUTPUT:\n{out}\n\nFILE CONTENTS:\n{read_files(files)}\n\n{feedback}")
            reply = chat([{"role": "system", "content": rules}, {"role": "user", "content": user}])
            data = parse(reply)
            if not any(key in data for key in ("summary", "edits", "done")):
                preview = " ".join(reply.split())[:1200]
                notes.append(f"round {rnd}: model response was not valid agent JSON; preview: {preview}")
                res = []
            elif read_only:
                res = []
                notes.append(f"round {rnd} (read-only): {data.get('summary', '(no summary)')}")
                notes.append("Model-proposed edits were intentionally not applied.")
                if data.get("edits"):
                    notes.append(f"Model suggested {len(data['edits'])} edit(s); none were applied.")
                completed = True
                break
            else:
                proposed_edits = data.get("edits", [])
                if not isinstance(proposed_edits, list):
                    notes.append(f"round {rnd}: invalid edit payload; expected a list, no edits applied")
                    res = ["SKIP edits: expected a list"]
                else:
                    res = apply_edits(proposed_edits)
                notes.append(f"round {rnd}: {data.get('summary', '(no summary)')}")
                notes += [f"  {r}" for r in res]
                if proposed_edits and not any(
                    item.startswith(("EDITED ", "CREATED ")) for item in res
                ):
                    feedback = (
                        "Your previous edit payload was rejected or made no changes. "
                        "Do not claim the requested task is complete unless the code "
                        "actually changed and verification passes. Correct the payload "
                        "or explain why no safe edit is possible."
                    )
                    notes.append("  no proposed edits were applied; completion requires explicit verification")
            ok, out = analyze()
            no_regressions = analysis_has_no_regressions(
                baseline_ok, baseline_out, ok, out
            )
            notes.append(
                f"  analyze after round {rnd}: "
                f"{'clean' if ok else ('baseline errors only' if no_regressions else 'errors remain/new diagnostics')}"
            )
            if not ok:
                notes.append(f"  analyzer output after round {rnd} (last 2500 chars):\\n{out[-2500:]}")
            if data.get("done") and no_regressions:
                completed = True
                if not ok:
                    notes.append(
                        "  completed: analyzer still has baseline diagnostics, "
                        "but this round introduced no new parsed diagnostics"
                    )
                break
            files = list(dict.fromkeys(files + files_from_analyze(out) + [e.get("path", "") for e in data.get("edits", [])]))[:5]
            feedback = "RESULT OF YOUR LAST EDITS:\n" + "\n".join(res)
    except QuotaStop as q:
        status = "PAUSED (usage limit)"
        notes.append(f"stopped at quota: {q}. Re-run the workflow later with the same task to resume.")
    except Exception as ex:  # report, never crash silently
        status = "FAILED"
        notes.append(f"error: {ex}")
    if status == "finished" and not completed:
        status = "FAILED"
        notes.append("agent did not confirm completion within the allowed rounds, or analyzer errors remain")
    if not read_only:
        log_progress(status, notes)
    else:
        notes.append("READ-ONLY CONFIRMED: skipped PROGRESS.md and PR-body writes.")
    print("\\n".join(notes), flush=True)
    if status != "finished":
        sys.exit(1)


if __name__ == "__main__":
    main()
