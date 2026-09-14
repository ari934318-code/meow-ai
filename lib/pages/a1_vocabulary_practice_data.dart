import 'a1_models.dart';
import 'vocabulary_practice_models.dart';

// ------------------------------------------------------------
// A1 Vocabulary Practice Data
// ------------------------------------------------------------
//
// این فایل Vocabularyهای واقعی درس‌های A1 را به سیستم مشترک
// Vocabulary Practice وصل می‌کند.
//
// بعداً A2 و B1 و ... دقیقاً با همین ساختار اضافه می‌شوند.
// ------------------------------------------------------------

class A1VocabularyPracticeData {
  static List<VocabularyPracticeItem> fromLessons(
    List<A1Lesson> lessons,
  ) {
    final result = <VocabularyPracticeItem>[];

    for (final lesson in lessons) {
      for (var index = 0; index < lesson.words.length; index++) {
        final word = lesson.words[index];

        result.add(
          VocabularyPracticeItem(
            id: '${lesson.id}_word_${index + 1}',
            level: 'A1',
            lessonId: lesson.id,
            lessonTitle: lesson.title,
            english: word.english,
            persian: word.persian,
            pronunciation: word.pronunciation,
            example: word.example,
          ),
        );
      }
    }

    return result;
  }
}