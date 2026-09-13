import 'package:flutter/material.dart';

import '../data/levels/a1/a1_exam_data.dart';
import '../data/levels/a1/a1_exam_model.dart';

class A1ExamPage extends StatefulWidget {
  const A1ExamPage({super.key});

  @override
  State<A1ExamPage> createState() => _A1ExamPageState();
}

class _A1ExamPageState extends State<A1ExamPage> {
  int currentIndex = 0;
  String? selectedAnswer;
  bool answerSubmitted = false;

  final List<A1ExamAnswer> userAnswers = [];

  A1ExamQuestion get currentQuestion {
    return a1ExamQuestions[currentIndex];
  }

  void selectAnswer(String answer) {
    if (answerSubmitted) return;

    setState(() {
      selectedAnswer = answer;
    });
  }

  void submitAnswer() {
    if (selectedAnswer == null || answerSubmitted) return;

    final question = currentQuestion;
    final isCorrect = selectedAnswer == question.correctAnswer;

    setState(() {
      answerSubmitted = true;

      userAnswers.add(
        A1ExamAnswer(
          questionId: question.id,
          selectedAnswer: selectedAnswer!,
          correctAnswer: question.correctAnswer,
          isCorrect: isCorrect,
        ),
      );
    });
  }

  void nextQuestion() {
    if (!answerSubmitted) return;

    if (currentIndex < a1ExamQuestions.length - 1) {
      setState(() {
        currentIndex++;
        selectedAnswer = null;
        answerSubmitted = false;
      });
    } else {
      showResult();
    }
  }

  void showResult() {
    final total = userAnswers.length;
    final correct =
        userAnswers.where((answer) => answer.isCorrect).length;
    final wrong = total - correct;

    final score = total == 0 ? 0 : ((correct / total) * 100).round();

    final result = A1ExamResult(
      totalQuestions: total,
      correctAnswers: correct,
      wrongAnswers: wrong,
      score: score,
      answers: List.unmodifiable(userAnswers),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => A1ExamResultPage(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = currentQuestion;

    final progress =
        (currentIndex + 1) / a1ExamQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('A1 Final Exam'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                borderRadius: BorderRadius.circular(20),
              ),

              const SizedBox(height: 18),

              Text(
                'Question ${currentIndex + 1} of ${a1ExamQuestions.length}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF9B7EDE).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  question.category,
                  style: const TextStyle(
                    color: Color(0xFF9B7EDE),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: ListView.separated(
                  itemCount: question.options.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final option = question.options[index];

                    final isSelected =
                        selectedAnswer == option;

                    final isCorrect =
                        option == question.correctAnswer;

                    Color? backgroundColor;

                    if (answerSubmitted) {
                      if (isCorrect) {
                        backgroundColor =
                            Colors.green.withOpacity(0.15);
                      } else if (isSelected) {
                        backgroundColor =
                            Colors.red.withOpacity(0.15);
                      }
                    } else if (isSelected) {
                      backgroundColor =
                          const Color(0xFF9B7EDE).withOpacity(0.15);
                    }

                    return InkWell(
                      onTap: () => selectAnswer(option),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF9B7EDE)
                                : Colors.grey.withOpacity(0.3),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            if (answerSubmitted && isCorrect)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),

                            if (answerSubmitted &&
                                isSelected &&
                                !isCorrect)
                              const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (answerSubmitted)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    selectedAnswer == question.correctAnswer
                        ? 'Correct! 🎉'
                        : 'Wrong. Correct answer: ${question.correctAnswer}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          selectedAnswer == question.correctAnswer
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedAnswer == null
                      ? null
                      : answerSubmitted
                          ? nextQuestion
                          : submitAnswer,
                  child: Text(
                    answerSubmitted
                        ? currentIndex ==
                                a1ExamQuestions.length - 1
                            ? 'See Results'
                            : 'Next Question'
                        : 'Check Answer',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class A1ExamResultPage extends StatelessWidget {
  final A1ExamResult result;

  const A1ExamResultPage({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final passed = result.passed;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Result'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Icon(
              passed
                  ? Icons.emoji_events
                  : Icons.menu_book,
              size: 80,
              color: passed
                  ? Colors.amber
                  : const Color(0xFF9B7EDE),
            ),

            const SizedBox(height: 16),

            Center(
              child: Text(
                passed ? 'A1 Passed! 🎉' : 'Keep Practicing!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                '${result.score}%',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9B7EDE),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Correct',
                    value: '${result.correctAnswers}',
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Wrong',
                    value: '${result.wrongAnswers}',
                    icon: Icons.cancel,
                    iconColor: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            if (result.wrongAnswerList.isNotEmpty) ...[
              const Text(
                'Your Mistakes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...result.wrongAnswerList.map(
                (answer) {
                  final question = a1ExamQuestions.firstWhere(
                    (q) => q.id == answer.questionId,
                  );

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            question.question,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Your answer: ${answer.selectedAnswer}',
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Correct answer: ${answer.correctAnswer}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ] else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Perfect! No mistakes 🎉',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.withOpacity(0.25),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}