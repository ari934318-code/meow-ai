class A1BasicLesson {
  final String id;
  final String title;
  final String titleFa;
  final String topic;
  final String explanation;

  final List<A1BasicSection> sections;
  final List<A1BasicExample> examples;
  final List<A1BasicQuestion> questions;
  final List<A1BasicSpeakingQuestion> speakingQuestions;

  const A1BasicLesson({
    required this.id,
    required this.title,
    required this.titleFa,
    required this.topic,
    required this.explanation,
    required this.sections,
    required this.examples,
    required this.questions,
    required this.speakingQuestions,
  });
}

class A1BasicSection {
  final String title;
  final String titleFa;
  final String explanation;
  final List<A1BasicExample> examples;

  const A1BasicSection({
    required this.title,
    required this.titleFa,
    required this.explanation,
    required this.examples,
  });
}

class A1BasicExample {
  final String english;
  final String persian;
  final String? pronunciation;

  const A1BasicExample({
    required this.english,
    required this.persian,
    this.pronunciation,
  });
}

class A1BasicQuestion {
  /// Supported types:
  ///
  /// multipleChoice
  /// typing
  /// fillInTheBlank
  ///
  /// Multiple choice can freely mix:
  /// English → English
  /// English → Persian
  /// Persian → English
  /// Persian → Persian
  ///
  /// The page simply displays the data exactly as authored.
  final String type;

  /// Main question/prompt shown to the learner.
  ///
  /// Examples:
  /// "What does 'tired' mean?"
  /// "خسته به انگلیسی چیست؟"
  /// "I ___ tired."
  final String question;

  /// Options used by multiple-choice questions.
  ///
  /// For typing and fillInTheBlank this can be an empty list.
  final List<String> options;

  /// Primary correct answer.
  ///
  /// For multiple choice:
  /// the correct option.
  ///
  /// For typing:
  /// the main accepted answer.
  ///
  /// For fillInTheBlank:
  /// the word that fills the blank.
  final String answer;

  /// Additional accepted answers for typing/fill-in-the-blank.
  ///
  /// This allows more than one valid answer.
  ///
  /// Example:
  /// answer: "mom"
  /// acceptableAnswers: ["mom", "mum", "mother"]
  final List<String> acceptableAnswers;

  /// Optional explanation shown after answering.
  final String? explanation;

  /// Optional hint shown for typing/fill-in-the-blank.
  ///
  /// Example:
  /// "Think about the verb 'to be'."
  final String? hint;

  const A1BasicQuestion({
    required this.type,
    required this.question,
    required this.options,
    required this.answer,
    this.acceptableAnswers = const [],
    this.explanation,
    this.hint,
  });

  /// Returns all valid answers for this question.
  List<String> get allAcceptedAnswers {
    final answers = <String>[
      answer,
      ...acceptableAnswers,
    ];

    final result = <String>[];

    for (final item in answers) {
      final normalized = item.trim();

      if (normalized.isEmpty) continue;

      if (!result.contains(normalized)) {
        result.add(normalized);
      }
    }

    return result;
  }
}

class A1BasicSpeakingQuestion {
  final String question;
  final String persian;
  final List<String> acceptableAnswers;

  const A1BasicSpeakingQuestion({
    required this.question,
    required this.persian,
    required this.acceptableAnswers,
  });
}