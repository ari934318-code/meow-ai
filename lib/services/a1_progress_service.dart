import 'package:shared_preferences/shared_preferences.dart';

import 'progress_service.dart';

class A1ProgressService {
  static const String _completedLessonsKey = 'a1_completed_lessons';

  // XP هر درس A1
  static const Map<String, int> _lessonXp = {
    'a1_01': 40,
    'a1_02': 40,
    'a1_03': 40,
    'a1_04': 45,
    'a1_05': 45,
    'a1_06': 45,
    'a1_07': 45,
    'a1_08': 45,
    'a1_09': 50,
    'a1_10': 50,
    'a1_11': 50,
    'a1_12': 60,
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

    // ذخیره درس تکمیل‌شده
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

  static Future<bool> isLessonCompleted(String lessonId) async {
    final completed = await getCompletedLessons();

    return completed.contains(lessonId);
  }

  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_completedLessonsKey);

    // ریست XP، Practice، Speaking، Study Days و Streak
    await ProgressService.resetProgress();
  }
}