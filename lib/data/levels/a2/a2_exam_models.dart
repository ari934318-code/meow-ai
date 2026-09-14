class A2ExamQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const A2ExamQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class A2ExamAnswer {
  final int questionIndex;
  final int? selectedIndex;

  const A2ExamAnswer({
    required this.questionIndex,
    required this.selectedIndex,
  });

  bool get isAnswered => selectedIndex != null;
}

class A2ExamMistake {
  final int questionIndex;
  final String question;
  final String selectedAnswer;
  final String correctAnswer;
  final String explanation;

  const A2ExamMistake({
    required this.questionIndex,
    required this.question,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.explanation,
  });
}

class A2ExamResult {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int unanswered;
  final double percentage;
  final bool passed;
  final List<A2ExamMistake> mistakes;

  const A2ExamResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.unanswered,
    required this.percentage,
    required this.passed,
    required this.mistakes,
  });
}