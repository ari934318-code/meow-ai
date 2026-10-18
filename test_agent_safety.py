import contextlib
import importlib.util
import io
import pathlib
import tempfile
import unittest
from unittest import mock

SPEC = importlib.util.spec_from_file_location("meow_agent", pathlib.Path(__file__).with_name("agent.py"))
agent = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(agent)


class AgentSafetyTests(unittest.TestCase):
    def test_run_reports_timeout_and_preserves_captured_output(self):
        timeout = __import__("subprocess").TimeoutExpired("fake-command", 1, output=b"partial output")
        with mock.patch.object(agent.subprocess, "run", side_effect=timeout):
            with contextlib.redirect_stdout(io.StringIO()) as output:
                with self.assertRaises(__import__("subprocess").TimeoutExpired):
                    agent.run("fake-command", timeout=1)
        self.assertIn("partial output", output.getvalue())
        self.assertIn("timed out after 1s", output.getvalue())

    def test_analyze_converts_timeout_to_diagnostic_failure(self):
        timeout = __import__("subprocess").TimeoutExpired("flutter analyze", 120, output=b"analyzer started")
        with mock.patch.object(agent, "run", side_effect=timeout):
            ok, diagnostic = agent.analyze()
        self.assertFalse(ok)
        self.assertIn("analyzer started", diagnostic)
        self.assertIn("timed out after 120 seconds", diagnostic)

    def test_existing_analyzer_errors_do_not_block_unchanged_diagnostics(self):
        baseline = "  error • Undefined name 'missing' • lib/example.dart:10:3 • undefined_identifier"
        shifted = "  error • Undefined name 'missing' • lib/example.dart:14:3 • undefined_identifier"
        self.assertEqual(len(agent.analyzer_diagnostics(baseline)), 1)
        self.assertTrue(agent.analysis_has_no_regressions(False, baseline, False, shifted))

    def test_new_analyzer_diagnostic_blocks_completion(self):
        baseline = "  error • Undefined name 'missing' • lib/example.dart:10:3 • undefined_identifier"
        changed = baseline + "\\n" + "  error • Undefined name 'other' • lib/example.dart:20:3 • undefined_identifier"
        self.assertFalse(agent.analysis_has_no_regressions(False, baseline, False, changed))

    def test_clean_baseline_still_requires_clean_analysis(self):
        self.assertFalse(agent.analysis_has_no_regressions(True, "", False, "analyzer failed"))

    def test_read_only_mode_does_not_apply_edits_or_write_progress(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = pathlib.Path(tmp)
            existing = root / "sample.txt"
            existing.write_text("original")
            (root / "agent").mkdir()
            (root / "agent" / "AGENT.md").write_text("test rules")
            progress = root / "agent" / "PROGRESS.md"
            pr_body = root / "pr_body.md"

            with (
                mock.patch.object(agent, "ROOT", root),
                mock.patch.object(agent, "PROGRESS", progress),
                mock.patch.object(agent, "PR_BODY", pr_body),
                mock.patch.object(agent, "TASK", "READ-ONLY DIAGNOSTIC MODE: inspect sample.txt; do not modify any files"),
                mock.patch.object(agent, "KEY", "test-key"),
                mock.patch.object(agent, "MODEL", "test-model"),
                mock.patch.object(agent, "MAX_ROUNDS", 3),
                mock.patch.object(agent, "analyze", return_value=(True, "No issues")),
                mock.patch.object(agent, "tree", return_value="sample.txt"),
                mock.patch.object(agent, "chat", return_value='{"summary":"diagnostic complete","edits":[{"path":"sample.txt","old":"original","new":"changed"}],"done":true}'),
                contextlib.redirect_stdout(io.StringIO()) as output,
            ):
                agent.main()

            self.assertEqual(existing.read_text(), "original")
            self.assertFalse(progress.exists())
            self.assertFalse(pr_body.exists())
            self.assertIn("READ-ONLY CONFIRMED", output.getvalue())
            self.assertIn("none were applied", output.getvalue())


    def test_main_does_not_accept_done_when_edits_were_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = pathlib.Path(tmp).resolve()
            (root / "agent").mkdir()
            (root / "agent" / "AGENT.md").write_text("rules")
            progress = root / "agent" / "PROGRESS.md"
            pr_body = root / "pr_body.md"
            replies = [
                '{"summary":"I fixed it","edits":[{"path":"../outside.txt","old":"a","new":"b"}],"done":true}',
                '{"summary":"Still done","edits":[],"done":true}',
            ]
            with (
                mock.patch.object(agent, "ROOT", root),
                mock.patch.object(agent, "PROGRESS", progress),
                mock.patch.object(agent, "PR_BODY", pr_body),
                mock.patch.object(agent, "TASK", "Fix a safe sample"),
                mock.patch.object(agent, "KEY", "test-key"),
                mock.patch.object(agent, "MODEL", "test-model"),
                mock.patch.object(agent, "MAX_ROUNDS", 2),
                mock.patch.object(agent, "analyze", return_value=(True, "No issues")),
                mock.patch.object(agent, "tree", return_value="sample.txt"),
                mock.patch.object(agent, "chat", side_effect=replies),
                contextlib.redirect_stdout(io.StringIO()) as output,
            ):
                with self.assertRaises(SystemExit) as raised:
                    agent.main()
            self.assertEqual(raised.exception.code, 1)
            self.assertIn("no proposed edits were applied", output.getvalue())
            self.assertIn("FAILED", progress.read_text())
            self.assertNotIn("finished", progress.read_text().splitlines()[-2].lower())

    def test_main_marks_task_failed_when_model_says_done_but_edit_payload_is_invalid(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = pathlib.Path(tmp).resolve()
            (root / "agent").mkdir()
            (root / "agent" / "AGENT.md").write_text("rules")
            progress = root / "agent" / "PROGRESS.md"
            pr_body = root / "pr_body.md"
            with (
                mock.patch.object(agent, "ROOT", root),
                mock.patch.object(agent, "PROGRESS", progress),
                mock.patch.object(agent, "PR_BODY", pr_body),
                mock.patch.object(agent, "TASK", "Fix a safe sample"),
                mock.patch.object(agent, "KEY", "test-key"),
                mock.patch.object(agent, "MODEL", "test-model"),
                mock.patch.object(agent, "MAX_ROUNDS", 1),
                mock.patch.object(agent, "analyze", return_value=(True, "No issues")),
                mock.patch.object(agent, "tree", return_value="sample.txt"),
                mock.patch.object(agent, "chat", return_value='{"summary":"done","edits":{},"done":true}'),
                contextlib.redirect_stdout(io.StringIO()) as output,
            ):
                with self.assertRaises(SystemExit) as raised:
                    agent.main()
            self.assertEqual(raised.exception.code, 1)
            self.assertIn("invalid edit payload", output.getvalue())
            self.assertIn("FAILED", progress.read_text())

    def test_apply_edits_skips_non_list_payload(self):
        self.assertEqual(agent.apply_edits({"path": "x", "old": "a", "new": "b"}), [
            "SKIP edits: expected a list"
        ])

    def test_apply_edits_skips_malformed_edit_entries(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = pathlib.Path(tmp).resolve()
            with mock.patch.object(agent, "ROOT", root):
                result = agent.apply_edits([
                    "not an object",
                    {"path": "sample.txt", "old": 1, "new": "text"},
                    {"path": "", "old": "", "new": "text"},
                ])
            self.assertEqual(len(result), 3)
            self.assertIn("expected an object", result[0])
            self.assertIn("must be strings", result[1])
            self.assertIn("invalid path", result[2])
            self.assertFalse((root / "sample.txt").exists())

    def test_apply_edits_enforces_eight_edit_limit(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = pathlib.Path(tmp).resolve()
            edits = [
                {"path": f"file_{i}.txt", "old": "", "new": "created"}
                for i in range(9)
            ]
            with mock.patch.object(agent, "ROOT", root):
                result = agent.apply_edits(edits)
            self.assertEqual(sum(item.startswith("CREATED") for item in result), 8)
            self.assertIn("SKIP 1 additional edits: limit is 8", result[-1])
            self.assertFalse((root / "file_8.txt").exists())

    def test_safe_path_rejects_traversal_and_protected_paths(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = pathlib.Path(tmp).resolve()
            with mock.patch.object(agent, "ROOT", root):
                self.assertIsNone(agent.safe_path("../outside.txt"))
                self.assertIsNone(agent.safe_path(".github/workflows/test.yml"))
                self.assertIsNone(agent.safe_path("agent/PROGRESS.md"))
                self.assertEqual(agent.safe_path("lib/example.dart"), root / "lib" / "example.dart")

    def test_apply_edits_skips_ambiguous_replacements(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = pathlib.Path(tmp).resolve()
            sample = root / "sample.txt"
            sample.write_text("repeat repeat")
            with mock.patch.object(agent, "ROOT", root):
                result = agent.apply_edits([
                    {"path": "sample.txt", "old": "repeat", "new": "changed"}
                ])
            self.assertEqual(sample.read_text(), "repeat repeat")
            self.assertEqual(len(result), 1)
            self.assertIn("matched 2 times", result[0])

    def test_apply_edits_rejects_path_traversal_without_writing(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = pathlib.Path(tmp).resolve()
            outside = root.parent / (root.name + "-outside.txt")
            outside.write_text("safe")
            try:
                with mock.patch.object(agent, "ROOT", root):
                    result = agent.apply_edits([
                        {"path": "../" + outside.name, "old": "safe", "new": "changed"}
                    ])
                self.assertEqual(outside.read_text(), "safe")
                self.assertIn("path not allowed", result[0])
            finally:
                outside.unlink(missing_ok=True)


    def test_parse_accepts_raw_json(self):
        self.assertEqual(agent.parse('{"summary":"ok","done":true}'), {"summary": "ok", "done": True})

    def test_parse_accepts_fenced_json(self):
        reply = ' ```json\n{"summary":"ok","done":true}\n``` '
        self.assertEqual(agent.parse(reply), {"summary": "ok", "done": True})

    def test_parse_extracts_json_surrounded_by_prose(self):
        reply = 'Here is the result:\n{"summary":"ok","done":true}\nThat is all.'
        self.assertEqual(agent.parse(reply), {"summary": "ok", "done": True})

    def test_parse_handles_braces_inside_json_string(self):
        reply = 'Result: {"summary":"literal {brace} inside text","done":true} end'
        self.assertEqual(
            agent.parse(reply),
            {"summary": "literal {brace} inside text", "done": True},
        )

    def test_parse_returns_empty_dict_for_malformed_json(self):
        self.assertEqual(agent.parse('Result: {"summary": broken}'), {})

    def test_parse_returns_empty_dict_for_json_array(self):
        self.assertEqual(agent.parse('[{"summary":"not an object"}]'), {})


if __name__ == "__main__":
    unittest.main()
