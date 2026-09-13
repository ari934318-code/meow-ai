class A1Lesson {
  final String id;
  final String title;
  final String topic;
  final List<A1Word> words;
  final List<A1Sentence> sentences;
  final List<A1Question> questions;

  const A1Lesson({
    required this.id,
    required this.title,
    required this.topic,
    required this.words,
    required this.sentences,
    required this.questions,
  });
}

class A1Word {
  final String english;
  final String persian;
  final String pronunciation;
  final String example;

  const A1Word({
    required this.english,
    required this.persian,
    required this.pronunciation,
    required this.example,
  });
}

class A1Sentence {
  final String english;
  final String persian;

  const A1Sentence({
    required this.english,
    required this.persian,
  });
}

class A1Question {
  final String question;
  final List<String> options;
  final String answer;

  const A1Question({
    required this.question,
    required this.options,
    required this.answer,
  });
}