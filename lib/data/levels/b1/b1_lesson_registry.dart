import 'b1_lessons.dart';
import 'b1_lesson_01_data.dart';
import 'b1_lesson_02_data.dart';
import 'b1_practice_lessons_data.dart';

/// Resolves catalog entries by stable ID and only exposes content with a player.
class B1LessonRegistry {
  static String idForNumber(int number) =>
      'b1_lesson_${number.toString().padLeft(2, '0')}';

  static B1Lesson? findById(String lessonId) {
    for (final lesson in b1Lessons) {
      if (idForNumber(lesson.id) == lessonId) return lesson;
    }
    return null;
  }

  static bool hasContent(String lessonId) =>
      lessonId == B1Lesson01Data.id ||
      lessonId == B1Lesson02Data.id ||
      b1PracticeLessons.containsKey(lessonId);

  static B1Lesson? resolvePlayable(String lessonId) {
    final lesson = findById(lessonId);
    return lesson != null && hasContent(lessonId) ? lesson : null;
  }
}
