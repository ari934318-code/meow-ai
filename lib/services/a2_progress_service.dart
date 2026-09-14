import 'package:shared_preferences/shared_preferences.dart';

import 'progress_service.dart';

class A2ProgressService {
  static const String _completedLessonsKey =
      'a2_completed_lessons';

  // XP هر درس A2
  // شناسه‌ها و XP واقعی درس‌های A2 را اینجا قرار می‌دهیم.
  static const Map<String, int> _lessonXp = {};

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

    await prefs.remove(_completedLessonsKey);
  }
}