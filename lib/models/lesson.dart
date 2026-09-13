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

  const LessonSection({
    required this.title,
    required this.type,
    this.explanation = '',
    this.items = const [],
  });
}

class LessonItem {
  final String english;
  final String persian;
  final String example;
  final String pronunciation;

  const LessonItem({
    required this.english,
    required this.persian,
    this.example = '',
    this.pronunciation = '',
  });
}