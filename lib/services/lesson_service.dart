import '../models/lesson.dart';
import '../data/levels/a1/a1_data.dart';
import '../data/levels/a1/a1_models.dart';

class LessonService {
  /// Compatibility layer between the new A1 lesson system
  /// and the older LessonPage / Lesson model.
  ///
  /// The actual A1 content lives in:
  /// lib/data/levels/a1/
  ///
  /// This service only converts A1Lesson -> Lesson so older
  /// pages can continue working without duplicating content.

  static List<Lesson> get a1Lessons {
    return a1LessonsData.map(_convertA1Lesson).toList();
  }

  static Lesson _convertA1Lesson(A1Lesson lesson) {
    final sections = <LessonSection>[];

    // ------------------------------------------------------------
    // VOCABULARY
    // ------------------------------------------------------------
    if (lesson.words.isNotEmpty) {
      sections.add(
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          explanation:
              'Learn useful words and expressions related to ${lesson.topic}.',
          items: lesson.words.map(
            (word) {
              return LessonItem(
                english: word.english,
                persian: word.persian,
                pronunciation: word.pronunciation,
                example: word.example,
                examplePersian: '',
              );
            },
          ).toList(),
        ),
      );
    }

    // ------------------------------------------------------------
    // SENTENCES
    // ------------------------------------------------------------
    if (lesson.sentences.isNotEmpty) {
      sections.add(
        LessonSection(
          title: 'Useful Sentences',
          type: 'sentences',
          explanation:
              'Practice useful English sentences related to ${lesson.topic}.',
          items: lesson.sentences.map(
            (sentence) {
              return LessonItem(
                english: sentence.english,
                persian: sentence.persian,
                example: sentence.english,
                examplePersian: sentence.persian,
              );
            },
          ).toList(),
        ),
      );
    }

    // ------------------------------------------------------------
    // PRACTICE / QUESTIONS
    // ------------------------------------------------------------
    if (lesson.questions.isNotEmpty) {
      sections.add(
        LessonSection(
          title: 'Practice',
          type: 'practice',
          explanation:
              'Test your understanding of ${lesson.topic}.',
          questions: lesson.questions.map(
            (question) {
              final correctIndex =
                  question.options.indexOf(question.answer);

              return LessonQuestion(
                type: LessonQuestionType.multipleChoice,
                prompt: question.question,
                promptPersian: '',
                options: question.options,
                correctIndex: correctIndex,
                correctAnswer: question.answer,
              );
            },
          ).toList(),
        ),
      );
    }

    // ------------------------------------------------------------
    // SPEAKING
    // ------------------------------------------------------------
    if (lesson.speakingQuestions.isNotEmpty) {
      sections.add(
        LessonSection(
          title: 'Speaking',
          type: 'speaking',
          explanation:
              'Answer naturally in English and practice speaking.',
          questions: lesson.speakingQuestions.map(
            (question) {
              return LessonQuestion(
                type: LessonQuestionType.speaking,
                prompt: question.question,
                promptPersian: question.persian,
                correctAnswer:
                    question.acceptableAnswers.isNotEmpty
                        ? question.acceptableAnswers.first
                        : '',
              );
            },
          ).toList(),
        ),
      );
    }

    return Lesson(
      id: lesson.id,
      title: lesson.title,
      level: 'A1',
      description: lesson.topic,
      xp: _xpForLesson(lesson.id),
      sections: sections,
    );
  }

  static int _xpForLesson(String id) {
    switch (id) {
      case 'a1_01':
      case 'a1_02':
      case 'a1_03':
        return 40;

      case 'a1_04':
      case 'a1_05':
      case 'a1_06':
      case 'a1_07':
      case 'a1_08':
      case 'a1_09':
        return 45;

      case 'a1_10':
      case 'a1_11':
        return 50;

      case 'a1_12':
        return 60;

      default:
        return 40;
    }
  }
}

/// Alias used internally so the getter `a1Lessons` does not
/// recursively call itself.
///
/// The real source of A1 content is `a1_data.dart`.
final List<A1Lesson> a1LessonsData = a1Lessons;