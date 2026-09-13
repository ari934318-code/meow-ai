import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../localization.dart';
import '../services/practice_service.dart';

class PracticeBasicsMistakesPage extends StatefulWidget {
  const PracticeBasicsMistakesPage({
    super.key,
  });

  @override
  State<PracticeBasicsMistakesPage> createState() =>
      _PracticeBasicsMistakesPageState();
}

class _PracticeBasicsMistakesPageState
    extends State<PracticeBasicsMistakesPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  final FlutterTts _tts = FlutterTts();

  bool _loading = true;
  bool _finished = false;

  List<Map<String, dynamic>> _mistakes = [];
  List<Map<String, dynamic>> _questions = [];

  int _currentIndex = 0;
  int _correctCount = 0;

  String? _selectedAnswer;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _loadPractice();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _loadPractice() async {
    final mistakes =
        await PracticeService.getBasicsWrongAnswers();

    if (!mounted) return;

    final shuffled = List<Map<String, dynamic>>.from(mistakes)
      ..shuffle(Random());

    setState(() {
      _mistakes = mistakes;
      _questions = shuffled;
      _loading = false;
    });

    if (_questions.isNotEmpty) {
      await _speakQuestion();
    }
  }

  Future<void> _speakQuestion() async {
    if (_questions.isEmpty ||
        _currentIndex >= _questions.length) {
      return;
    }

    final question =
        _questions[_currentIndex]['question']
            ?.toString() ??
        '';

    if (question.isEmpty) return;

    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.speak(question);
  }

  void _selectAnswer(String answer) {
    if (_answered) return;

    final current = _questions[_currentIndex];

    final correctAnswer =
        current['correctAnswer']?.toString() ?? '';

    final isCorrect =
        answer.trim().toLowerCase() ==
        correctAnswer.trim().toLowerCase();

    setState(() {
      _selectedAnswer = answer;
      _answered = true;

      if (isCorrect) {
        _correctCount++;
      }
    });
  }

  void _nextQuestion() {
    if (!_answered) return;

    if (_currentIndex >= _questions.length - 1) {
      setState(() {
        _finished = true;
      });
      return;
    }

    setState(() {
      _currentIndex++;
      _selectedAnswer = null;
      _answered = false;
    });

    _speakQuestion();
  }

  Future<void> _restartPractice() async {
    final shuffled =
        List<Map<String, dynamic>>.from(_mistakes)
          ..shuffle(Random());

    setState(() {
      _questions = shuffled;
      _currentIndex = 0;
      _correctCount = 0;
      _selectedAnswer = null;
      _answered = false;
      _finished = false;
    });

    await _speakQuestion();
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lang.isPersian
              ? 'تمرین اشتباهات'
              : 'Mistake Practice',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: _buildBody(
          context,
          lang.isPersian,
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    bool isPersian,
  ) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_questions.isEmpty) {
      return _buildEmptyState(isPersian);
    }

    if (_finished) {
      return _buildResult(
        context,
        isPersian,
      );
    }

    return _buildQuestion(
      context,
      isPersian,
    );
  }

  Widget _buildQuestion(
    BuildContext context,
    bool isPersian,
  ) {
    final current = _questions[_currentIndex];

    final question =
        current['question']?.toString() ?? '';

    final correctAnswer =
        current['correctAnswer']?.toString() ?? '';

    final explanation =
        current['explanation']?.toString() ?? '';

    final options = _getOptions(current);

    final progress =
        (_currentIndex + 1) / _questions.length;

    final isCorrect =
        _selectedAnswer != null &&
        _selectedAnswer!.trim().toLowerCase() ==
            correctAnswer.trim().toLowerCase();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        30,
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor:
                      lavender.withOpacity(0.12),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(
                    lavender,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${_currentIndex + 1}/${_questions.length}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.09),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Text(
                isPersian
                    ? 'اشتباه قبلی'
                    : 'Previous mistake',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const Spacer(),

            IconButton(
              onPressed: _speakQuestion,
              icon: const Icon(
                Icons.volume_up_rounded,
              ),
              color: lavender,
            ),
          ],
        ),

        const SizedBox(height: 14),

        Text(
          question,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.35,
          ),
        ),

        const SizedBox(height: 28),

        ...options.map(
          (option) {
            final selected =
                _selectedAnswer == option;

            final correct =
                option.trim().toLowerCase() ==
                    correctAnswer
                        .trim()
                        .toLowerCase();

            Color borderColor =
                Theme.of(context)
                    .dividerColor;

            Color backgroundColor =
                Theme.of(context)
                    .colorScheme
                    .surface;

            if (_answered && correct) {
              borderColor = Colors.green;
              backgroundColor =
                  Colors.green.withOpacity(0.08);
            } else if (_answered && selected) {
              borderColor = Colors.red;
              backgroundColor =
                  Colors.red.withOpacity(0.08);
            } else if (selected) {
              borderColor = lavender;
              backgroundColor =
                  lavender.withOpacity(0.08);
            }

            return Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(18),
                onTap: () => _selectAnswer(option),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius:
                        BorderRadius.circular(18),
                    border: Border.all(
                      color: borderColor,
                      width: selected ||
                              (_answered && correct)
                          ? 1.5
                          : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),

                      if (_answered && correct)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                        )
                      else if (_answered &&
                          selected &&
                          !correct)
                        const Icon(
                          Icons.cancel_rounded,
                          color: Colors.red,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        if (_answered) ...[
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isCorrect
                  ? Colors.green.withOpacity(0.08)
                  : Colors.red.withOpacity(0.08),
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCorrect
                          ? Icons.check_circle_rounded
                          : Icons.info_outline_rounded,
                      color: isCorrect
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCorrect
                          ? (isPersian
                              ? 'درست شد! 🎉'
                              : 'Correct! 🎉')
                          : (isPersian
                              ? 'هنوز نه 😼'
                              : 'Not quite yet 😼'),
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w700,
                        color: isCorrect
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  isPersian
                      ? 'جواب درست: $correctAnswer'
                      : 'Correct answer: $correctAnswer',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                if (explanation.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    explanation,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: lavender,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(17),
                ),
              ),
              child: Text(
                _currentIndex ==
                        _questions.length - 1
                    ? (isPersian
                        ? 'دیدن نتیجه'
                        : 'See Result')
                    : (isPersian
                        ? 'سؤال بعدی'
                        : 'Next Question'),
              ),
            ),
          ),
        ],
      ],
    );
  }

  List<String> _getOptions(
    Map<String, dynamic> question,
  ) {
    final raw = question['options'];

    if (raw is List) {
      return raw
          .map((item) => item.toString())
          .where((item) => item.isNotEmpty)
          .toList();
    }

    final correct =
        question['correctAnswer']?.toString() ?? '';

    final userAnswer =
        question['userAnswer']?.toString() ?? '';

    final result = <String>[];

    if (userAnswer.isNotEmpty) {
      result.add(userAnswer);
    }

    if (correct.isNotEmpty &&
        !result.contains(correct)) {
      result.add(correct);
    }

    return result;
  }

  Widget _buildResult(
    BuildContext context,
    bool isPersian,
  ) {
    final total = _questions.length;

    final percentage = total == 0
        ? 0
        : ((_correctCount / total) * 100)
            .round();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: lavender.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                percentage >= 70
                    ? Icons.celebration_rounded
                    : Icons.refresh_rounded,
                size: 52,
                color: lavender,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              isPersian
                  ? 'تمرین تموم شد! 🎉'
                  : 'Practice complete! 🎉',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              isPersian
                  ? '$_correctCount از $total سؤال رو درست جواب دادی.'
                  : 'You got $_correctCount out of $total correct.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '$percentage%',
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                color: lavender,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _restartPractice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: lavender,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(17),
                  ),
                ),
                child: Text(
                  isPersian
                      ? 'دوباره تمرین کن'
                      : 'Practice Again',
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(17),
                  ),
                ),
                child: Text(
                  isPersian
                      ? 'برگشت'
                      : 'Back',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    bool isPersian,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 80,
              color: lavender,
            ),
            const SizedBox(height: 20),
            Text(
              isPersian
                  ? 'اشتباهی برای تمرین نیست 🎉'
                  : 'No mistakes to practice 🎉',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}