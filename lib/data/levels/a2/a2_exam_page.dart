import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'a2_exam_data.dart';
import 'a2_exam_models.dart';

class A2ExamPage extends StatefulWidget {
  const A2ExamPage({super.key});

  @override
  State<A2ExamPage> createState() => _A2ExamPageState();
}

class _A2ExamPageState extends State<A2ExamPage> {
  final PageController _pageController = PageController();

  late List<int?> _answers;
  int _currentIndex = 0;
  bool _finished = false;
  A2ExamResult? _result;

  static const int passScore = 70;

  @override
  void initState() {
    super.initState();

    _answers = List<int?>.filled(
      a2ExamQuestions.length,
      null,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (_finished) return;

    setState(() {
      _answers[_currentIndex] = index;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < a2ExamQuestions.length - 1) {
      setState(() {
        _currentIndex++;
      });

      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      _finishExam();
    }
  }

  void _previousQuestion() {
    if (_currentIndex == 0) return;

    setState(() {
      _currentIndex--;
    });

    _pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  Future<void> _finishExam() async {
    int correct = 0;
    int wrong = 0;
    int unanswered = 0;

    final List<A2ExamMistake> mistakes = [];

    for (int i = 0; i < a2ExamQuestions.length; i++) {
      final question = a2ExamQuestions[i];
      final selected = _answers[i];

      if (selected == null) {
        unanswered++;

        mistakes.add(
          A2ExamMistake(
            questionIndex: i,
            question: question.question,
            selectedAnswer: 'بدون پاسخ',
            correctAnswer: question.options[question.correctIndex],
            explanation: question.explanation,
          ),
        );

        continue;
      }

      if (selected == question.correctIndex) {
        correct++;
      } else {
        wrong++;

        mistakes.add(
          A2ExamMistake(
            questionIndex: i,
            question: question.question,
            selectedAnswer: question.options[selected],
            correctAnswer: question.options[question.correctIndex],
            explanation: question.explanation,
          ),
        );
      }
    }

    final double percentage =
        (correct / a2ExamQuestions.length) * 100;

    final bool passed = percentage >= passScore;

    final result = A2ExamResult(
      totalQuestions: a2ExamQuestions.length,
      correctAnswers: correct,
      wrongAnswers: wrong,
      unanswered: unanswered,
      percentage: percentage,
      passed: passed,
      mistakes: mistakes,
    );

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      'a2_exam_completed',
      passed,
    );

    await prefs.setBool(
      'a2_completed',
      passed,
    );

    await prefs.setDouble(
      'a2_exam_percentage',
      percentage,
    );

    await prefs.setInt(
      'a2_exam_correct',
      correct,
    );

    await prefs.setInt(
      'a2_exam_wrong',
      wrong,
    );

    await prefs.setInt(
      'a2_exam_unanswered',
      unanswered,
    );

    if (!mounted) return;

    setState(() {
      _result = result;
      _finished = true;
    });
  }

  Future<void> _restartExam() async {
    setState(() {
      _answers = List<int?>.filled(
        a2ExamQuestions.length,
        null,
      );

      _currentIndex = 0;
      _finished = false;
      _result = null;
    });

    if (_pageController.hasClients) {
      _pageController.jumpToPage(0);
    }
  }

  void _reviewMistakes() {
    if (_result == null || _result!.mistakes.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => A2MistakesPage(
          mistakes: _result!.mistakes,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_finished && _result != null) {
      return _buildResultPage(context, _result!);
    }

    final question = a2ExamQuestions[_currentIndex];
    final selected = _answers[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 Final Exam'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressHeader(),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: a2ExamQuestions.length,
                itemBuilder: (context, index) {
                  final item = a2ExamQuestions[index];
                  final selectedAnswer = _answers[index];

                  return _buildQuestionCard(
                    item,
                    selectedAnswer,
                  );
                },
              ),
            ),

            _buildBottomNavigation(
              selected: selected,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    final progress =
        (_currentIndex + 1) / a2ExamQuestions.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Question ${_currentIndex + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                '${a2ExamQuestions.length} Questions',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(
    A2ExamQuestion question,
    int? selected,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                question.question,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  height: 1.45,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          ...List.generate(
            question.options.length,
            (index) {
              final isSelected = selected == index;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OutlinedButton(
                  onPressed: () => _selectAnswer(index),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    alignment: Alignment.centerLeft,
                    side: BorderSide(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade400,
                      width: isSelected ? 2 : 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                              : Colors.transparent,
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                : Colors.grey.shade400,
                          ),
                        ),
                        child: Text(
                          String.fromCharCode(65 + index),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? Colors.white
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          question.options[index],
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation({
    required int? selected,
  }) {
    final isLast =
        _currentIndex == a2ExamQuestions.length - 1;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
        child: Row(
          children: [
            if (_currentIndex > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousQuestion,
                  child: const Text('Previous'),
                ),
              ),

            if (_currentIndex > 0)
              const SizedBox(width: 12),

            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: selected == null
                    ? null
                    : _nextQuestion,
                child: Text(
                  isLast ? 'Finish Exam' : 'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultPage(
    BuildContext context,
    A2ExamResult result,
  ) {
    final percentage =
        result.percentage.toStringAsFixed(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 Exam Result'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 12),

              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 8,
                    color: result.passed
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$percentage%',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                result.passed
                    ? 'A2 Completed! 🎉'
                    : 'A2 Not Passed',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: result.passed
                      ? Colors.green
                      : Colors.red,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                result.passed
                    ? 'You passed the A2 final exam.'
                    : 'You need ${passScore}% to pass the exam.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 25),

              _buildResultStats(result),

              const SizedBox(height: 24),

              if (result.mistakes.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _reviewMistakes,
                    icon: const Icon(
                      Icons.error_outline_rounded,
                    ),
                    label: Text(
                      'My Mistakes (${result.mistakes.length})',
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _restartExam,
                  icon: const Icon(
                    Icons.refresh_rounded,
                  ),
                  label: const Text(
                    'Retake Exam',
                  ),
                ),
              ),

              if (result.passed) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.lock_open_rounded),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'A2 is completed. B1 can now be unlocked.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultStats(A2ExamResult result) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _resultRow(
              'Total Questions',
              '${result.totalQuestions}',
            ),
            const Divider(height: 22),
            _resultRow(
              'Correct',
              '${result.correctAnswers}',
            ),
            const Divider(height: 22),
            _resultRow(
              'Wrong',
              '${result.wrongAnswers}',
            ),
            const Divider(height: 22),
            _resultRow(
              'Unanswered',
              '${result.unanswered}',
            ),
            const Divider(height: 22),
            _resultRow(
              'Final Score',
              '${result.percentage.toStringAsFixed(0)}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultRow(
    String title,
    String value,
  ) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// MISTAKES PAGE
// ============================================================

class A2MistakesPage extends StatelessWidget {
  final List<A2ExamMistake> mistakes;

  const A2MistakesPage({
    super.key,
    required this.mistakes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Mistakes'),
        centerTitle: true,
      ),
      body: mistakes.isEmpty
          ? const Center(
              child: Text(
                'No mistakes 🎉',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mistakes.length,
              itemBuilder: (context, index) {
                final mistake = mistakes[index];

                final unanswered =
                    mistake.selectedAnswer == 'بدون پاسخ';

                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 14,
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${mistake.questionIndex + 1}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          mistake.question,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(12),
                            color: unanswered
                                ? Colors.orange
                                    .withOpacity(0.10)
                                : Colors.red
                                    .withOpacity(0.08),
                          ),
                          child: Text(
                            unanswered
                                ? 'بدون پاسخ'
                                : 'Your answer:\n${mistake.selectedAnswer}',
                            style: TextStyle(
                              color: unanswered
                                  ? Colors.orange.shade800
                                  : Colors.red.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(12),
                            color: Colors.green
                                .withOpacity(0.08),
                          ),
                          child: Text(
                            'Correct answer:\n${mistake.correctAnswer}',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(
                          'Why?',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          mistake.explanation,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}