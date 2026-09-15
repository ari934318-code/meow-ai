import 'a2_lessons.dart';
import 'vocabulary_practice_models.dart';

class A2VocabularyPracticeData {
  static List<VocabularyPracticeItem> get all {
    final result = <VocabularyPracticeItem>[];

    for (final lesson in a2Lessons) {
      for (var index = 0; index < lesson.words.length; index++) {
        final word = lesson.words[index];

        result.add(
          VocabularyPracticeItem(
            id: '${lesson.id}_word_${index + 1}',
            level: 'A2',
            lessonId: lesson.id,
            lessonTitle: lesson.title,
            english: word.word,
            persian: word.meaning,
            pronunciation: word.pronunciation,
            example: word.example,
          ),
        );
      }
    }

    return result;
  }
}