import 'package:shared_preferences/shared_preferences.dart';

import 'progress_service.dart';

class A2ProgressService {
  static const String _completedLessonsKey =
      'a2_completed_lessons';

  // A2 lessons already use stable IDs a2_lesson_01 through a2_lesson_16.
  // Reward each completed lesson once; keep XP separate from exam scoring.
  static const Map<String, int> _lessonXp = {
    'a2_lesson_01': 30,
    'a2_lesson_02': 30,
    'a2_lesson_03': 30,
    'a2_lesson_04': 30,
    'a2_lesson_05': 30,
    'a2_lesson_06': 30,
    'a2_lesson_07': 30,
    'a2_lesson_08': 30,
    'a2_lesson_09': 30,
    'a2_lesson_10': 30,
    'a2_lesson_11': 30,
    'a2_lesson_12': 30,
    'a2_lesson_13': 30,
    'a2_lesson_14': 30,
    'a2_lesson_15': 30,
    'a2_lesson_16': 30,
  };

  static Future<Set<String>> getCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();

    final completed =
        prefs.getStringList(_completedLessonsKey) ?? <String>[];

    return completed.toSet();
  }

  static Future<void> completeLesson(String lessonId) async {
    final prefs = await SharedPreferences.getInstance();

    final completed =
        prefs.getStringList(_completedLessonsKey) ?? <String>[];

    // فقط بار اول پاداش بده
    if (completed.contains(lessonId)) {
      return;
    }

    completed.add(lessonId);

    await prefs.setStringList(
      _completedLessonsKey,
      completed,
    );

    // اضافه کردن XP مخصوص همان درس
    final xp = _lessonXp[lessonId] ?? 0;

    if (xp > 0) {
      await ProgressService.addXp(xp);
    }

    // ثبت روز مطالعه و Streak
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

    // Clear A2-owned lesson/exam state, preserving shared XP and other levels.
    for (final key in prefs.getKeys().where((key) => key.startsWith('a2_')).toList()) {
      await prefs.remove(key);
    }
  }
}