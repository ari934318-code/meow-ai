class Lesson {
  final String id;
  final String title;
  final String level;
  final String description;
  final int xp;
  final List<LessonSection> sections;

  const Lesson({
    required this.id,
    required this.title,
    required this.level,
    required this.description,
    required this.xp,
    this.sections = const [],
  });
}

class LessonSection {
  final String title;
  final String type;
  final String explanation;
  final List<LessonItem> items;
  final List<LessonQuestion> questions;

  const LessonSection({
    required this.title,
    required this.type,
    this.explanation = '',
    this.items = const [],
    this.questions = const [],
  });
}

class LessonItem {
  final String english;
  final String persian;
  final String example;
  final String examplePersian;
  final String pronunciation;

  // Used for Common Mistakes sections.
  final String questionPersian;
  final String wrongAnswer;
  final String correctAnswer;

  const LessonItem({
    required this.english,
    required this.persian,
    this.example = '',
    this.examplePersian = '',
    this.pronunciation = '',
    this.questionPersian = '',
    this.wrongAnswer = '',
    this.correctAnswer = '',
  });
}

enum LessonQuestionType {
  multipleChoice,
  fillBlank,
  speaking,
  readAloud,
}

class LessonQuestion {
  final LessonQuestionType type;
  final String prompt;
  final String promptPersian;
  final String sentence;
  final List<String> options;
  final int correctIndex;
  final String correctAnswer;
  final String explanation;

  const LessonQuestion({
    required this.type,
    required this.prompt,
    this.promptPersian = '',
    this.sentence = '',
    this.options = const [],
    this.correctIndex = -1,
    this.correctAnswer = '',
    this.explanation = '',
  });
}