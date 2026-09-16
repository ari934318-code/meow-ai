import 'vocabulary_practice_models.dart';

class A1BasicsVocabularyPracticeData {
  static List<VocabularyPracticeItem> get all {
    final result = <VocabularyPracticeItem>[];

    for (final lesson in a1BasicsLessons) {
      for (var index = 0; index < lesson.vocabulary.length; index++) {
        final word = lesson.vocabulary[index];

        result.add(
          VocabularyPracticeItem(
            id: '${lesson.id}_vocab_${index + 1}',
            level: 'A1',
            lessonId: lesson.id,
            lessonTitle: lesson.title,
            english: word.english,
            persian: word.persian,
            pronunciation: word.pronunciation ?? '',
            example: word.example,
          ),
        );
      }
    }

    return result;
  }

  static List<VocabularyPracticeItem> forLesson(String lessonId) {
    return all.where((item) => item.lessonId == lessonId).toList();
  }
}