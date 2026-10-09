# Meow AI: Implementation and Release Checklist

This is a living checklist. A checked item means it has been verified in code or by an executed command; catalog entries and intended UI are not proof of a working feature.

## Audit baseline

- Repository baseline: `main` at `0ca136ab7804ce517f44cd9b317be2f7411b5d1d` (2026-09-23).
- Flutter CI configuration specifies Flutter `3.47.4`, stable channel, Java 17, and Android compile SDK 36.
- No `AGENTS.md` exists on `main`; the development guidelines on `agent/meow-development-guidelines` were reviewed.
- A local checkout and Flutter/Dart executables are unavailable in this connected environment. Source changes can be made through GitHub, but tests and builds must be verified by CI or a local Flutter environment.
- `pubspec.lock` on the baseline is only 368 bytes and does not resemble a generated dependency lockfile. Regenerate with `flutter pub get`; do not hand-edit it.
- `android/key.properties` was tracked on the baseline and contained signing-property values. The feature branch removes it and ignores local signing material. Removing it from the latest tree does not remove it from Git history; rotate any real credentials that were committed and verify that the keystore/passwords are valid only in GitHub Actions secrets.

## Priority 1: Build and release blockers

- [ ] Run `flutter pub get` with Flutter 3.47.4 and regenerate a valid `pubspec.lock`.
- [ ] Run `flutter analyze` and resolve build-breaking or relevant analyzer findings.
- [ ] Run `flutter test` and fix regressions.
- [ ] Build Android debug APK without release secrets.
- [ ] Verify release signing only uses GitHub secrets and ignored local files; rotate any previously committed signing credentials.
- [ ] Review Android manifest permissions, app ID, versioning, and release workflow behavior.

## Priority 2: Data integrity and navigation

- [ ] Add integrity tests for every lesson catalog: IDs, uniqueness, ordering, required content, valid answers/options, and valid lesson references.
- [ ] Verify home, learn, practice, profile, progress, settings, Meow, lesson lists, and exam navigation.
- [ ] Ensure unavailable/incomplete lessons are clearly unavailable and cannot silently open an unrelated or empty screen.
- [ ] Preserve existing lesson IDs and route behavior unless a reviewed migration is needed.

## Priority 3: Progress, persistence, and unlocking

- [ ] Audit A1 legacy lessons versus A1 Basics IDs and progress keys.
- [ ] Verify A2 lesson completion and exam completion are distinct, persisted, and correctly unlocked.
- [ ] Fix and test B1 unlocking so it depends on genuinely completed lessons rather than catalog metadata.
- [ ] Add tests for restart persistence, duplicate completion, retries, reset behavior, and XP awarded once.
- [ ] Replace hard-coded home XP/streak display with actual progress service values.

## Priority 4: Curriculum completeness

- [ ] A1 legacy course: verify all registered lesson content and its completion path.
- [ ] A1 Basics: verify 16 stable IDs, Persian explanations, exercises, listening, and exam coverage.
- [ ] A2: verify 16 lessons, exercise validation, final exam scoring, mistakes, and Persian assistance.
- [ ] B1: only lesson 1 currently has detailed registered lesson content; implement lessons in reviewable batches using the established B1 model and player.
- [ ] B2, C1, C2: currently appear in level selection but have no evidenced lesson curriculum/entry flow; do not label them complete until content, player, persistence, and tests exist.
- [ ] For every level, confirm vocabulary, grammar, examples, exercises, reading/listening, speaking/writing, review, and challenge are supported by actual UI and answer evaluation before adding data.

## Priority 5: Exams and practice

- [ ] Test scoring boundaries, pass thresholds, unanswered answers, answer indices, retry behavior, and result persistence.
- [ ] Ensure exams cover required lessons with non-ambiguous questions and complete explanations/localization.
- [ ] Verify wrong-answer capture, retrieval, filtering, and clearing across all supported levels.
- [ ] Connect vocabulary/listening/writing/speaking/mistake-review practice to actual course data.

## Priority 6: Meow Brain and offline behavior

- [ ] Add tests for Persian/English normalization, intent routing, translation, meaning, pronunciation, and unknown inputs.
- [ ] Verify the learning-memory storage/validation/privacy filter before extending it.
- [ ] Keep core learning usable offline; no paid APIs, credentials, or network dependency without explicit approval.
- [ ] Clearly distinguish local rule-based responses from any future AI integration.

## Priority 7: UI, accessibility, and localization

- [ ] Verify light/dark themes, small-screen layout, touch targets, semantics, loading/empty/error states, and contrast.
- [ ] Verify Persian RTL layout and correct LTR rendering for embedded English sentences and answers.
- [ ] Replace placeholder statistics and hard-coded level labels with persisted app state.
- [ ] Preserve the current lavender/cat visual identity and established navigation.

## Priority 8: Verification and release readiness

- [ ] Keep CI green for `flutter pub get`, `flutter analyze`, `flutter test`, and Android debug build.
- [ ] Run focused data-integrity and progress tests after each change.
- [ ] Verify signed release APK generation with protected CI secrets only.
- [ ] Inspect final APK installation/launch, onboarding, core lesson completion, exam pass/fail, and persistence on Android.
- [ ] Prepare a release checklist and changelog; do not publish or merge without owner authorization.

## Verified in this pass

- [x] Read development guidance available on `agent/meow-development-guidelines`.
- [x] Inspected the repository tree, app entry point, learning-level selector, A1 Basics catalog/test, A2 catalog/exam, B1 catalog/lesson interface/player, progress services, Meow Brain, Android Gradle configuration, and existing APK workflow.
- [x] Confirmed the B1 screen only opens detailed lesson 1; other catalog items do not yet route to lesson content.
- [x] Added ignore rules for local Android release signing material and removed the tracked `android/key.properties` from this feature branch.
- [ ] Flutter commands/tests/build: not run in this environment; use the new CI workflow or a Flutter 3.47.4 checkout to verify.
