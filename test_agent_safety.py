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

    def test_read_only_mode_does_not_apply_edits_or_write_progress(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = pathlib.Path(tmp)
            existing = root / "sample.txt"
            existing.write_text("original")
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


if __name__ == "__main__":
    unittest.main()
