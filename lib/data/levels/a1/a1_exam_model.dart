class A1ExamQuestion {
  final String question;
  final List<String> options;
  final String answer;
  final String category;

  const A1ExamQuestion({
    required this.question,
    required this.options,
    required this.answer,
    required this.category,
  });
}

class A1Exam {
  final String id;
  final String title;
  final String description;
  final List<A1ExamQuestion> questions;
  final int passingScore;

  const A1Exam({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.passingScore,
  });
}
