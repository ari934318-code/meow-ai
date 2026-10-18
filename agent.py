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


def run(cmd, timeout=900):
    p = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=timeout)
    return p.returncode, (p.stdout + p.stderr)


def analyze():
    code, out = run("flutter analyze --no-pub --no-fatal-infos --no-fatal-warnings")
    return code == 0, out[-6000:]


def files_from_analyze(out):
    seen = []
    for m in re.finditer(r"•\s+((?:lib|test)/[^\s:]+\.dart):\d+", out):
        if m.group(1) not in seen:
            seen.append(m.group(1))
    return seen[:4]


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
    log = []
    for e in edits[:8]:
        rel, old, new = e.get("path", ""), e.get("old", ""), e.get("new", "")
        p = safe_path(rel)
        if p is None:
            log.append(f"SKIP {rel}: path not allowed"); continue
        if old == "":
            if p.exists():
                log.append(f"SKIP {rel}: file exists (use old/new)"); continue
            p.parent.mkdir(parents=True, exist_ok=True); p.write_text(new)
            log.append(f"CREATED {rel}"); continue
        if not p.is_file():
            log.append(f"SKIP {rel}: not found"); continue
        txt = p.read_text()
        if txt.count(old) != 1:
            log.append(f"SKIP {rel}: 'old' matched {txt.count(old)} times (need exactly 1)"); continue
        p.write_text(txt.replace(old, new, 1))
        log.append(f"EDITED {rel}")
    return log


def parse(reply):
    # Accept JSON directly or wrapped in a Markdown code fence.
    cleaned = reply.strip()
    if cleaned.startswith(chr(96) * 3):
        cleaned = re.sub(r"^```(?:json)?\s*", "", cleaned, count=1, flags=re.I)
        cleaned = re.sub(r"\s*```$", "", cleaned, count=1)
    try:
        data = json.loads(cleaned)
    except json.JSONDecodeError:
        match = re.search(r"\{.*\}", cleaned, re.S)
        if not match:
            return {}
        try:
            data = json.loads(match.group(0))
        except json.JSONDecodeError:
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
    try:
        ok, out = analyze()
        requested_files = files_from_task(TASK)
        files = list(dict.fromkeys(FILES + requested_files + files_from_analyze(out)))[:5]
        notes.append(f"analyze at start: {'clean' if ok else 'errors'}; context files: {files or 'none'}")
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
            else:
                res = apply_edits(data.get("edits", []))
                notes.append(f"round {rnd}: {data.get('summary', '(no summary)')}")
                notes += [f"  {r}" for r in res]
            ok, out = analyze()
            notes.append(f"  analyze after round {rnd}: {'clean' if ok else 'errors remain'}")
            if not ok:
                notes.append(f"  analyzer output after round {rnd} (last 2500 chars):\\n{out[-2500:]}")
            if data.get("done") and ok:
                completed = True
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
    log_progress(status, notes)
    print("\n".join(notes))
    if status != "finished":
        sys.exit(1)


if __name__ == "__main__":
    main()
