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
  final String type;
  final String question;
  final List<String> options;
  final String answer;
  final String? explanation;

  const A1BasicQuestion({
    required this.type,
    required this.question,
    required this.options,
    required this.answer,
    this.explanation,
  });
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