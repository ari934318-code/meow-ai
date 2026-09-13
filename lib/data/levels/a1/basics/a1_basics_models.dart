class A1BasicLesson {
  final String id;
  final String title;
  final String titleFa;
  final String explanation;
  final List<A1BasicExample> examples;
  final List<A1BasicQuestion> questions;

  const A1BasicLesson({
    required this.id,
    required this.title,
    required this.titleFa,
    required this.explanation,
    required this.examples,
    required this.questions,
  });
}

class A1BasicExample {
  final String english;
  final String persian;

  const A1BasicExample({
    required this.english,
    required this.persian,
  });
}

class A1BasicQuestion {
  final String question;
  final List<String> options;
  final String answer;

  const A1BasicQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });
}