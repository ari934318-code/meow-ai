import 'package:shared_preferences/shared_preferences.dart';

class A1ProgressService {
  static const String _completedLessonsKey = 'a1_completed_lessons';

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

    if (!completed.contains(lessonId)) {
      completed.add(lessonId);
      await prefs.setStringList(
        _completedLessonsKey,
        completed,
      );
    }
  }

  static Future<bool> isLessonCompleted(String lessonId) async {
    final completed = await getCompletedLessons();
    return completed.contains(lessonId);
  }

  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_completedLessonsKey);
  }
}