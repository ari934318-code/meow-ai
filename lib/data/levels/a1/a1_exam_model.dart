class A1ExamQuestion {
  final String id;
  final String lessonId;
  final String category;
  final String question;
  final String? questionFa;
  final List<String> options;
  final String correctAnswer;

  const A1ExamQuestion({
    required this.id,
    required this.lessonId,
    required this.category,
    required this.question,
    this.questionFa,
    required this.options,
    required this.correctAnswer,
  });
}

class A1ExamAnswer {
  final String questionId;
  final String selectedAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const A1ExamAnswer({
    required this.questionId,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });
}

class A1ExamResult {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int score;
  final List<A1ExamAnswer> answers;

  const A1ExamResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.score,
    required this.answers,
  });

  List<A1ExamAnswer> get wrongAnswerList {
    return answers.where((answer) => !answer.isCorrect).toList();
  }

  double get accuracy {
    if (totalQuestions == 0) return 0;
    return correctAnswers / totalQuestions;
  }

  bool get passed {
    return score >= 70;
  }
}