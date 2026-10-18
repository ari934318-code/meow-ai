import 'package:shared_preferences/shared_preferences.dart';

import 'progress_service.dart';
import '../data/levels/a2/a2_data.dart';

class A2ProgressService {
  static const String _completedLessonsKey =
      'a2_completed_lessons';

  // XP هر درس A2
  // شناسه‌ها و XP واقعی درس‌های A2 را اینجا قرار می‌دهیم.
  static const Map<String, int> _lessonXp = {};

  static Future<Set<String>> getCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();

    final completed =
        (prefs.getStringList(_completedLessonsKey) ?? <String>[])
            .toSet();

    // Migrate legacy per-lesson flags into the canonical list without
    // discarding progress saved by either storage format.
    for (final lesson in a2Lessons) {
      final legacyKey = 'a2_lesson_completed_${lesson.id}';
      if (prefs.getBool(legacyKey) == true) {
        completed.add(lesson.id);
      }
    }

    await prefs.setStringList(
      _completedLessonsKey,
      completed.toList(),
    );

    // Keep the legacy flags in sync for screens or older app versions
    // that still read them directly.
    for (final lesson in a2Lessons) {
      if (completed.contains(lesson.id)) {
        await prefs.setBool(
          'a2_lesson_completed_${lesson.id}',
          true,
        );
      }
    }

    return completed;
  }

  static Future<void> completeLesson(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();

    final completed = await getCompletedLessons();
    final wasCompleted = completed.contains(lessonId);

    completed.add(lessonId);

    await prefs.setStringList(
      _completedLessonsKey,
      completed.toList(),
    );

    // Preserve compatibility with the legacy A2 lesson list.
    await prefs.setBool(
      'a2_lesson_completed_${lessonId}',
      true,
    );

    // Only award XP and study streak on the first completion.
    if (wasCompleted) {
      return;
    }

    final xp = _lessonXp[lessonId] ?? 0;

    if (xp > 0) {
      await ProgressService.addXp(xp);
    }

    await ProgressService.recordStudyDay();
  }

  static Future<bool> isLessonCompleted(
    String lessonId,
  ) async {
    final completed = await getCompletedLessons();

    return completed.contains(lessonId);
  }

  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_completedLessonsKey);

    for (final lesson in a2Lessons) {
      await prefs.remove(
        'a2_lesson_completed_${lesson.id}',
      );
    }
  }
}