enum VocabularyPracticeType {
  englishToPersian,
  persianToEnglish,
  exampleToWord,
  wordToExample,
}

class VocabularyPracticeItem {
  final String id;
  final String level;
  final String lessonId;
  final String lessonTitle;

  final String english;
  final String persian;
  final String pronunciation;
  final String example;

  const VocabularyPracticeItem({
    required this.id,
    required this.level,
    required this.lessonId,
    required this.lessonTitle,
    required this.english,
    required this.persian,
    required this.pronunciation,
    required this.example,
  });
}

class VocabularyPracticeQuestion {
  final VocabularyPracticeType type;

  final VocabularyPracticeItem item;

  final String question;
  final List<String> options;
  final String correctAnswer;

  const VocabularyPracticeQuestion({
    required this.type,
    required this.item,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}