class A2Word {
  final String word;
  final String meaning;
  final String pronunciation;
  final String example;
  final String exampleTranslation;

  const A2Word({
    required this.word,
    required this.meaning,
    required this.pronunciation,
    required this.example,
    required this.exampleTranslation,
  });
}

class A2Sentence {
  final String english;
  final String pronunciation;
  final String translation;

  const A2Sentence({
    required this.english,
    required this.pronunciation,
    required this.translation,
  });
}

class A2Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const A2Question({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class A2FillBlank {
  final String sentence;
  final List<String> options;
  final int correctIndex;

  const A2FillBlank({
    required this.sentence,
    required this.options,
    required this.correctIndex,
  });
}

class A2SpeakingQuestion {
  final String question;
  final String pronunciation;

  const A2SpeakingQuestion({
    required this.question,
    required this.pronunciation,
  });
}

class A2Lesson {
  final String id;
  final String title;
  final String topic;

  final List<A2Word> words;
  final List<A2Sentence> sentences;
  final List<A2Question> questions;
  final List<A2FillBlank> fillBlanks;
  final List<A2SpeakingQuestion> speakingQuestions;

  const A2Lesson({
    required this.id,
    required this.title,
    required this.topic,
    required this.words,
    required this.sentences,
    required this.questions,
    required this.fillBlanks,
    required this.speakingQuestions,
  });
}