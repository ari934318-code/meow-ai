import 'dart:math';

import 'package:flutter/material.dart';

import '../data/levels/a1/a1_exam_data.dart';
import '../data/levels/a1/a1_exam_model.dart';

class A1ExamPage extends StatefulWidget {
  const A1ExamPage({super.key});

  @override
  State<A1ExamPage> createState() => _A1ExamPageState();
}

class _A1ExamPageState extends State<A1ExamPage> {
  late final List<A1ExamQuestion> examQuestions;

  int currentIndex = 0;
  String? selectedAnswer;
  bool answerSubmitted = false;

  final List<A1ExamAnswer> answers = [];

  @override
  void initState() {
    super.initState();
    examQuestions = _createExamQuestions();
  }

  List<A1ExamQuestion> _createExamQuestions() {
    final random = Random();

    // گروه‌بندی سؤال‌ها بر اساس درس
    final Map<String, List<A1ExamQuestion>> questionsByLesson = {};

    for (final question in a1ExamQuestions) {
      questionsByLesson.putIfAbsent(question.lessonId, () => []);
      questionsByLesson[question.lessonId]!.add(question);
    }

    // سؤال‌ها را داخل هر درس مخلوط می‌کنیم.
    for (final questions in questionsByLesson.values) {
      questions.shuffle(random);
    }

    final List<A1ExamQuestion> selected = [];

    // 8 درس اول دو سؤال می‌دهند و 4 درس آخر یک سؤال.
    // در مجموع: 8×2 + 4×1 = 20 سؤال
    final lessonIds = questionsByLesson.keys.toList();

    for (int i = 0; i < lessonIds.length; i++) {
      final questions = questionsByLesson[lessonIds[i]]!;

      final amount = i < 8 ? 2 : 1;

      for (int j = 0; j < amount && j < questions.length; j++) {
        selected.add(questions[j]);
      }
    }

    // ترتیب نهایی سؤال‌ها هم تصادفی می‌شود.
    selected.shuffle(random);

    return selected;
  }

  void _selectAnswer(String answer) {
    if (answerSubmitted) return;

    setState(() {
      selectedAnswer = answer;
    });
  }

  void _submitAnswer() {
    if (selectedAnswer == null || answerSubmitted) return;

    final question = examQuestions[currentIndex];
    final isCorrect = selectedAnswer == question.correctAnswer;

    final examAnswer = A1ExamAnswer(
      questionId: question.id,
      selectedAnswer: selectedAnswer!,
      correctAnswer: question.correctAnswer,
      isCorrect: isCorrect,
    );

    setState(() {
      answerSubmitted = true;
      answers.add(examAnswer);
    });
  }

  void _nextQuestion() {
    if (!answerSubmitted) return;

    if (currentIndex < examQuestions.length - 1) {
      setState(() {
        currentIndex++;
        selectedAnswer = null;
        answerSubmitted = false;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    final correctAnswers =
        answers.where((answer) => answer.isCorrect).length;

    final wrongAnswers = answers.length - correctAnswers;

    final score = ((correctAnswers / examQuestions.length) * 100).round();

    final result = A1ExamResult(
      totalQuestions: examQuestions.length,
      correctAnswers: correctAnswers,
      wrongAnswers: wrongAnswers,
      score: score,
      answers: List.unmodifiable(answers),
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
    final question = examQuestions[currentIndex];
    final progress = (currentIndex + 1) / examQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('A1 Final Exam 🎓'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question ${currentIndex + 1} of ${examQuestions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF9B7EDE),
              ),

              const SizedBox(height: 28),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF9B7EDE).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  question.category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF7B5FC4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
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

                    final isSelected = selectedAnswer == option;
                    final isCorrect =
                        answerSubmitted &&
                        option == question.correctAnswer;

                    final isWrong =
                        answerSubmitted &&
                        isSelected &&
                        option != question.correctAnswer;

                    Color? backgroundColor;
                    Color? borderColor;

                    if (isCorrect) {
                      backgroundColor = Colors.green.withOpacity(0.12);
                      borderColor = Colors.green;
                    } else if (isWrong) {
                      backgroundColor = Colors.red.withOpacity(0.12);
                      borderColor = Colors.red;
                    } else if (isSelected) {
                      backgroundColor =
                          const Color(0xFF9B7EDE).withOpacity(0.12);
                      borderColor = const Color(0xFF9B7EDE);
                    }

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _selectAnswer(option),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: borderColor ??
                                Theme.of(context)
                                    .dividerColor,
                            width: borderColor != null ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (isCorrect)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            if (isWrong)
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

              if (answerSubmitted) ...[
                const SizedBox(height: 10),
                Text(
                  selectedAnswer == question.correctAnswer
                      ? 'Correct! 🎉'
                      : 'Not quite. Keep going! 💪',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color:
                        selectedAnswer == question.correctAnswer
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
              ],

              const SizedBox(height: 14),

              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: selectedAnswer == null
                      ? null
                      : answerSubmitted
                          ? _nextQuestion
                          : _submitAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B7EDE),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        Colors.grey.withOpacity(0.25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    answerSubmitted
                        ? currentIndex == examQuestions.length - 1
                            ? 'See Result'
                            : 'Next Question'
                        : 'Check Answer',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
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
        title: const Text('A1 Exam Result'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Text(
                passed ? 'A1 Passed! 🎉' : 'Keep Practicing! 💜',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                passed
                    ? 'You passed the A1 final exam.'
                    : 'You need 70% to pass the A1 final exam.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF9B7EDE),
                    width: 8,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${result.score}%',
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

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

              const SizedBox(height: 24),

              Expanded(
                child: result.wrongAnswerList.isEmpty
                    ? const Center(
                        child: Text(
                          'Perfect! No wrong answers 🎉',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: result.wrongAnswerList.length,
                        itemBuilder: (context, index) {
                          final answer =
                              result.wrongAnswerList[index];

                          final question =
                              a1ExamQuestions.firstWhere(
                            (q) => q.id == answer.questionId,
                          );

                          return Container(
                            margin:
                                const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.red.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Question ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  question.question,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  'Your answer: ${answer.selectedAnswer}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  'Correct answer: ${answer.correctAnswer}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const A1ExamPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B7EDE),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Take Exam Again',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF9B7EDE),
                    side: const BorderSide(
                      color: Color(0xFF9B7EDE),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Back to Lessons',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.45),
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
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(title),
        ],
      ),
    );
  }
}