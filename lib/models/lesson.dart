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

  const LessonItem({
    required this.english,
    required this.persian,
    this.example = '',
    this.examplePersian = '',
    this.pronunciation = '',
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

  /// جمله یا سؤال اصلی انگلیسی
  final String prompt;

  /// معنی فارسی جمله یا سؤال اصلی
  final String promptPersian;

  /// جمله‌ای که ممکن است جای خالی داشته باشد
  final String sentence;

  /// گزینه‌های انگلیسی
  final List<String> options;

  /// شماره گزینه درست
  final int correctIndex;

  /// جواب مورد انتظار برای جای خالی یا تمرین گفتاری
  final String correctAnswer;

  /// توضیح فارسی در صورت نیاز
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