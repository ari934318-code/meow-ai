import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib/data/levels/a2/a2_data.dart';
import '../lib/services/a2_progress_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('A2ProgressService storage compatibility', () {
    test('migrates legacy completion flags into the canonical list', () async {
      final prefs = await SharedPreferences.getInstance();
      final legacyLesson = a2Lessons.first;

      await prefs.setBool(
        'a2_lesson_completed_${legacyLesson.id}',
        true,
      );

      final completed = await A2ProgressService.getCompletedLessons();

      expect(completed, contains(legacyLesson.id));
      expect(
        prefs.getStringList('a2_completed_lessons'),
        contains(legacyLesson.id),
      );
    });

    test('preserves canonical progress and syncs legacy flags', () async {
      final prefs = await SharedPreferences.getInstance();
      final canonicalLesson = a2Lessons[1];

      await prefs.setStringList(
        'a2_completed_lessons',
        [canonicalLesson.id],
      );

      final completed = await A2ProgressService.getCompletedLessons();

      expect(completed, contains(canonicalLesson.id));
      expect(
        prefs.getBool('a2_lesson_completed_${canonicalLesson.id}'),
        isTrue,
      );
    });

    test('completion is idempotent and writes both storage formats', () async {
      final prefs = await SharedPreferences.getInstance();
      final lessonId = a2Lessons.first.id;

      await A2ProgressService.completeLesson(lessonId);
      await A2ProgressService.completeLesson(lessonId);

      expect(
        prefs.getStringList('a2_completed_lessons')!
            .where((id) => id == lessonId)
            .length,
        1,
      );
      expect(
        prefs.getBool('a2_lesson_completed_${lessonId}'),
        isTrue,
      );
    });

    test('reset clears canonical and legacy completion state', () async {
      final prefs = await SharedPreferences.getInstance();
      final ids = a2Lessons.take(2).map((lesson) => lesson.id).toList();

      await prefs.setStringList('a2_completed_lessons', ids);
      for (final id in ids) {
        await prefs.setBool('a2_lesson_completed_${id}', true);
      }

      await A2ProgressService.resetProgress();

      expect(prefs.getStringList('a2_completed_lessons'), isNull);
      for (final id in ids) {
        expect(prefs.getBool('a2_lesson_completed_${id}'), isNull);
      }
    });
  });
}
