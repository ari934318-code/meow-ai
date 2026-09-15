import '../data/levels/a1/a1_data.dart';
import '../models/vocabulary_practice_models.dart';

class A1VocabularyPracticeData {
  static List<VocabularyPracticeItem> get all {
    final result = <VocabularyPracticeItem>[];

    for (final lesson in a1Lessons) {
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