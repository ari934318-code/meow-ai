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

class A2Grammar {
  final String title;
  final String explanation;
  final String explanationTranslation;
  final List<String> examples;
  final List<String> exampleTranslations;

  const A2Grammar({
    required this.title,
    required this.explanation,
    this.explanationTranslation = '',
    required this.examples,
    this.exampleTranslations = const [],
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

class A2SentenceOrdering {
  final String sentence;
  final List<String> shuffledWords;

  const A2SentenceOrdering({
    required this.sentence,
    required this.shuffledWords,
  });
}

class A2Matching {
  final String left;
  final String right;

  const A2Matching({
    required this.left,
    required this.right,
  });
}

class A2SentenceBuilding {
  final String meaning;
  final List<String> words;
  final String correctSentence;
  final String pronunciation;

  const A2SentenceBuilding({
    required this.meaning,
    required this.words,
    required this.correctSentence,
    required this.pronunciation,
  });
}

class A2Conversation {
  final String speaker;
  final String english;
  final String pronunciation;
  final String translation;

  const A2Conversation({
    required this.speaker,
    required this.english,
    required this.pronunciation,
    required this.translation,
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

class A2Challenge {
  final String title;
  final String instruction;
  final List<String> tasks;

  const A2Challenge({
    required this.title,
    required this.instruction,
    required this.tasks,
  });
}

class A2Review {
  final String title;
  final List<String> points;

  const A2Review({
    required this.title,
    required this.points,
  });
}

class A2Lesson {
  final String id;
  final String title;
  final String topic;

  final List<A2Word> words;
  final List<A2Sentence> sentences;
  final List<A2Grammar> grammar;

  final List<A2Question> questions;
  final List<A2FillBlank> fillBlanks;
  final List<A2SentenceOrdering> sentenceOrdering;
  final List<A2Matching> matching;
  final List<A2SentenceBuilding> sentenceBuilding;

  final List<A2Conversation> conversations;
  final List<A2SpeakingQuestion> speakingQuestions;

  final List<A2Challenge> challenges;
  final List<A2Review> reviews;

  const A2Lesson({
    required this.id,
    required this.title,
    required this.topic,
    required this.words,
    required this.sentences,
    required this.grammar,
    required this.questions,
    required this.fillBlanks,
    required this.sentenceOrdering,
    required this.matching,
    required this.sentenceBuilding,
    required this.conversations,
    required this.speakingQuestions,
    required this.challenges,
    required this.reviews,
  });
}