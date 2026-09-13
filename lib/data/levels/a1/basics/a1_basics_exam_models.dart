class A1BasicsExamQuestion {
  final String id;
  final String lessonId;
  final String topic;
  final String category;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final String? persian;
  final bool isSpeaking;
  final List<String> acceptableAnswers;

  const A1BasicsExamQuestion({
    required this.id,
    required this.lessonId,
    required this.topic,
    required this.category,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    this.persian,
    required this.isSpeaking,
    required this.acceptableAnswers,
  });
}

class A1BasicsExamAnswer {
  final String questionId;
  final String lessonId;
  final String category;
  final String topic;
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final String explanation;
  final bool isCorrect;
  final bool isSpeaking;

  const A1BasicsExamAnswer({
    required this.questionId,
    required this.lessonId,
    required this.category,
    required this.topic,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.explanation,
    required this.isCorrect,
    required this.isSpeaking,
  });
}

class A1BasicsExamResult {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int score;
  final List<A1BasicsExamAnswer> answers;

  const A1BasicsExamResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.score,
    required this.answers,
  });

  bool get passed {
    return score >= 70;
  }

  double get accuracy {
    if (totalQuestions == 0) {
      return 0;
    }

    return correctAnswers / totalQuestions;
  }

  List<A1BasicsExamAnswer> get wrongAnswerList {
    return answers
        .where((answer) => !answer.isCorrect)
        .toList();
  }

  Map<String, int> get wrongAnswersByTopic {
    final Map<String, int> result = {};

    for (final answer in wrongAnswerList) {
      result[answer.topic] =
          (result[answer.topic] ?? 0) + 1;
    }

    return result;
  }

  Map<String, int> get wrongAnswersByCategory {
    final Map<String, int> result = {};

    for (final answer in wrongAnswerList) {
      result[answer.category] =
          (result[answer.category] ?? 0) + 1;
    }

    return result;
  }
}