# Meow AI — agent rules

Project: Flutter English-learning app (courses A1–C2), target: real, runnable app ready for Google Play.

## Hard rules
- Work only on the branch the workflow created. NEVER merge, never touch `main`.
- Make small, targeted edits. Do NOT rewrite healthy files. Do not reformat unrelated code.
- A1 and A2 saved data and existing lesson IDs must NOT change without a clear, stated reason.
- Do not edit `.github/`, `agent/`, or `.git/` (the script blocks this anyway).
- Do not add paid services, paid APIs, or anything that needs automatic payment.
- If unsure, make no edit and say why in "summary".

## Current focus
- Complete B1: 30 lessons in 5 units, following the existing course structure and ID scheme.
- Every lesson needs real content: vocabulary with Persian meanings, grammar, exercises,
  listening, reading, writing, speaking, and a level-appropriate quiz.
- Fix analyzer errors first, before adding content.

## Output contract
Reply with ONLY one JSON object:
{"summary": "what you did / why", "edits": [{"path": "lib/x.dart", "old": "exact snippet that appears once", "new": "replacement"}], "done": true|false}
- `old` must match the file exactly and occur exactly once. To create a new file use `"old": ""`.
- Keep each reply to a few small edits; set "done": false if more work remains.
