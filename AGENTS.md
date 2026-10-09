# Meow AI Development Agent Guidelines

These instructions apply to the entire Meow AI repository. Read this file before planning or changing code.

## Project context
- Meow AI is a Flutter/Dart English-learning app designed for Persian-speaking learners.
- Preserve the existing app architecture and conventions. Inspect the relevant files before proposing or implementing changes; do not assume a page, model, route, or data structure exists.
- The current repository uses Flutter localization helpers, `shared_preferences`, `flutter_tts`, `speech_to_text`, and `image_picker`. Do not add dependencies unless a real requirement cannot reasonably be met with the current stack.
- The repository's existing A1 Basics curriculum contains 16 lessons with stable IDs `a1_basic_01` through `a1_basic_16`. Do not rename IDs or alter persisted preference keys without a migration plan.
- The project has existing lesson data, listening data, exam data, reusable models, and data-integrity tests. Treat these as the primary source of truth and inspect them before extending a level.
- A future B1 curriculum is planned as 30 lessons across 5 units. Planned lesson/practice areas include overview, vocabulary, typed recall, grammar, exercises, listening, reading, speaking, real English, writing, mixed practice, and challenge. This is a product requirement, not proof that these features already exist. Verify current implementation before coding.

## Required workflow for every task
1. Inspect the current implementation and nearby tests before editing. Search for reusable widgets, models, route patterns, theme tokens, localization conventions, progress storage, and existing question formats.
2. Briefly state the intended plan and identify affected files before a broad or risky change.
3. Prefer small, coherent changes. Keep new functionality consistent with existing patterns and avoid unrelated refactors.
4. For large features, split work into reviewable stages (data/model, UI, navigation/state, tests). Do not claim a feature is complete merely because files were generated.
5. Add or update tests for data integrity, scoring, persistence, and navigation logic where practical.
6. Run relevant formatting, analysis, and tests when the execution environment allows it. Clearly report which commands actually ran and their results. Never claim tests passed if they were not executed.
7. Summarize files changed, behavior implemented, tests run, known limitations, and any manual checks still needed.

## UI and design consistency
- Treat existing screens and reusable components as the canonical design reference. Inspect them before creating a new screen.
- Reuse the app's theme, spacing, typography, buttons, cards, progress indicators, and navigation patterns instead of inventing a second design system.
- Preserve the Meow AI visual identity. Existing A1 lesson UI has used a lavender accent (currently referenced in project context as `#9B7EDE`; verify the actual theme source before use) and a cat-themed header. Do not hard-code a color if an existing theme token or widget already provides it.
- Support both light and dark themes. Check contrast, disabled/selected/correct/incorrect states, and loading/empty states.
- Support Persian and English. Persian content must render right-to-left; English examples and answer text must remain readable in left-to-right order. Follow existing localization patterns and use the current global language setting rather than assuming one language.
- Keep layouts usable on small Android screens. Avoid overflow, tiny tap targets, and text clipped by long Persian or English content.
- Do not change existing visual behavior broadly without a specific requirement.

## Learning content standards
- Match content difficulty to the stated CEFR level. Do not label content B1 if its vocabulary, grammar, or task complexity is clearly A1/A2.
- Provide accurate, natural English, meaningful Persian translations, and concise explanations that teach the underlying concept.
- Use varied exercise formats when supported by the existing UI: multiple choice, fill-in-the-blank, typed recall, word order, translation, listening, speaking, reading, and writing. Confirm that the current player actually supports a question type before emitting data for it.
- Questions must test the lesson objective, not just repeat its explanation. Use plausible distractors that are wrong for a clear reason; avoid duplicate options and ambiguous questions.
- Every multiple-choice question must have a non-empty prompt, exactly the expected number of distinct options for that screen/model, and one unambiguous correct answer included among the options.
- For typed answers, include accepted variants only when linguistically valid. Normalize answers consistently with the app's existing evaluator; do not silently accept answers that change the meaning.
- Provide Persian translations and explanations wherever the current model/screen supports them. Do not leave blank localization fields when the app expects them.
- Avoid duplicating the same question across a lesson and its final exam unless deliberate spaced review is intended. Final exams should cover all required lessons and mix topics proportionately.
- Listening tasks must distinguish listening comprehension from reading-only recognition when audio playback is part of the intended interaction. Verify how the current UI plays audio before designing the data.
- Speaking tasks must have clear prompts and acceptable-answer rules. Do not claim speech recognition is reliable in every locale/device; account for permissions and unsupported recognition.
- Content should be original. Do not copy textbook pages or copyrighted course material.

## Data, progress, and assessment safety
- Preserve stable lesson IDs, exam IDs, SharedPreferences keys, and completion semantics unless the task explicitly requires a migration.
- Inspect existing progress and exam logic before adding a new level. Namespace new keys by level and feature; do not reuse A1/A2 keys for B1.
- Keep scoring deterministic and test boundaries, unanswered questions, retries, and pass/fail thresholds.
- Do not let incomplete or failed tasks mark lessons or exams as completed.
- Avoid destructive changes to user progress. If a schema/key migration is necessary, provide a safe migration path and tests.
- Validate lesson-to-question references so no question points to a missing lesson and required lessons are not omitted from an exam.

## Code quality and safety
- Follow Dart/Flutter style already used in the repository and keep functions and widgets reasonably focused.
- Prefer existing packages and Flutter SDK APIs. Do not add paid APIs, API keys, secrets, analytics, or network services without explicit approval.
- Never place secrets or private tokens in source control.
- Do not overwrite unrelated work or make broad changes simply to satisfy a task quickly.
- For risky changes, create or use a feature branch and present a reviewable diff/PR rather than pushing straight to `main`.
- Do not merge a pull request, delete data, or alter release/versioning settings without explicit approval.
- If requirements are ambiguous, inspect existing code first; ask a focused question only when a consequential decision cannot be safely inferred.

## Definition of done
A feature is ready for review only when:
- it follows existing design and localization patterns;
- data, navigation, state, and persistence are connected rather than isolated mockups;
- relevant integrity tests are added or updated;
- available analysis/tests have been run and honestly reported;
- remaining limitations and manual verification steps are listed.
