import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../data/levels/a1/basics/a1_basics_exam_data.dart';
import '../data/levels/a1/basics/a1_basics_exam_models.dart';

class A1BasicsExamPage extends StatefulWidget {
  const A1BasicsExamPage({super.key});

  @override
  State<A1BasicsExamPage> createState() => _A1BasicsExamPageState();
}

class _A1BasicsExamPageState extends State<A1BasicsExamPage> {
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final Random _random = Random();

  List<A1BasicsExamQuestion> _questions = [];

  final List<A1BasicsExamAnswer> _answers = [];

  int _currentIndex = 0;

  String? _selectedAnswer;
  String _spokenAnswer = '';

  bool _isListening = false;
  bool _speechAvailable = false;
  bool _showResult = false;
  bool _answerSubmitted = false;

  @override
  void initState() {
    super.initState();

    _prepareExam();
    _initializeSpeech();
    _configureTts();
  }

  Future<void> _configureTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
  }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize(
      onStatus: (status) {
        if (!mounted) return;

        if (status == 'notListening') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (_) {
        if (!mounted) return;

        setState(() {
          _isListening = false;
        });
      },
    );

    if (!mounted) return;

    setState(() {
      _speechAvailable = available;
    });
  }

  void _prepareExam() {
    final multipleChoice = a1BasicsExamQuestions
        .where((question) => !question.isSpeaking)
        .toList()
      ..shuffle(_random);

    final speaking = a1BasicsExamQuestions
        .where((question) => question.isSpeaking)
        .toList()
      ..shuffle(_random);

    final selectedMultipleChoice = multipleChoice.take(20).toList();
    final selectedSpeaking = speaking.take(5).toList();

    final combined = [
      ...selectedMultipleChoice,
      ...selectedSpeaking,
    ]..shuffle(_random);

    setState(() {
      _questions = combined;
    });
  }

  A1BasicsExamQuestion get _currentQuestion {
    return _questions[_currentIndex];
  }

  bool get _isLastQuestion {
    return _currentIndex == _questions.length - 1;
  }

  Future<void> _speakQuestion() async {
    await _tts.stop();

    await _tts.speak(
      _currentQuestion.question,
    );
  }

  void _selectAnswer(String answer) {
    if (_answerSubmitted) return;

    setState(() {
      _selectedAnswer = answer;
    });
  }

  Future<void> _startListening() async {
    if (!_speechAvailable) {
      await _initializeSpeech();
    }

    if (!_speechAvailable) return;

    setState(() {
      _isListening = true;
      _spokenAnswer = '';
    });

    await _speech.listen(
      localeId: 'en_US',
      onResult: (result) {
        if (!mounted) return;

        setState(() {
          _spokenAnswer = result.recognizedWords;
        });
      },
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();

    if (!mounted) return;

    setState(() {
      _isListening = false;
    });
  }

  bool _checkSpeakingAnswer(
    A1BasicsExamQuestion question,
    String answer,
  ) {
    final normalized = _normalize(answer);

    if (normalized.isEmpty) {
      return false;
    }

    for (final accepted in question.acceptableAnswers) {
      final acceptedNormalized = _normalize(accepted);

      if (normalized.contains(acceptedNormalized)) {
        return true;
      }
    }

    final correctNormalized =
        _normalize(question.correctAnswer);

    if (normalized.contains(correctNormalized)) {
      return true;
    }

    return false;
  }

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  Future<void> _submitAnswer() async {
    if (_answerSubmitted) return;

    final question = _currentQuestion;

    String userAnswer;
    bool isCorrect;

    if (question.isSpeaking) {
      userAnswer = _spokenAnswer.trim();

      isCorrect = _checkSpeakingAnswer(
        question,
        userAnswer,
      );
    } else {
      userAnswer = _selectedAnswer ?? '';
      isCorrect = userAnswer == question.correctAnswer;
    }

    final answer = A1BasicsExamAnswer(
      questionId: question.id,
      lessonId: question.lessonId,
      category: question.category,
      topic: question.topic,
      question: question.question,
      userAnswer: userAnswer,
      correctAnswer: question.correctAnswer,
      explanation: question.explanation,
      isCorrect: isCorrect,
      isSpeaking: question.isSpeaking,
    );

    setState(() {
      _answers.add(answer);
      _answerSubmitted = true;
    });
  }

  Future<void> _nextQuestion() async {
    if (!_answerSubmitted) return;

    if (_isLastQuestion) {
      await _finishExam();
      return;
    }

    setState(() {
      _currentIndex++;
      _selectedAnswer = null;
      _spokenAnswer = '';
      _answerSubmitted = false;
    });
  }

  Future<void> _finishExam() async {
    final total = _answers.length;

    final correct =
        _answers.where((answer) => answer.isCorrect).length;

    final wrong = total - correct;

    final score = total == 0
        ? 0
        : ((correct / total) * 100).round();

    final result = A1BasicsExamResult(
      totalQuestions: total,
      correctAnswers: correct,
      wrongAnswers: wrong,
      score: score,
      answers: List.unmodifiable(_answers),
    );

    await _saveExamResult(result);

    if (!mounted) return;

    setState(() {
      _showResult = true;
    });
  }

  Future<void> _saveExamResult(
    A1BasicsExamResult result,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final wrongAnswers = result.wrongAnswerList;

    final encodedWrongAnswers = wrongAnswers.map((answer) {
      final question = a1BasicsExamQuestions.firstWhere(
        (question) => question.id == answer.questionId,
        orElse: () => A1BasicsExamQuestion(
          id: answer.questionId,
          lessonId: answer.lessonId,
          topic: answer.topic,
          category: answer.category,
          question: answer.question,
          options: const [],
          correctAnswer: answer.correctAnswer,
          explanation: answer.explanation,
          persian: null,
          isSpeaking: answer.isSpeaking,
          acceptableAnswers: const [],
        ),
      );

      return {
        'questionId': answer.questionId,
        'lessonId': answer.lessonId,
        'category': answer.category,
        'topic': answer.topic,
        'question': answer.question,
        'userAnswer': answer.userAnswer,
        'correctAnswer': answer.correctAnswer,
        'explanation': answer.explanation,
        'isCorrect': answer.isCorrect,
        'isSpeaking': answer.isSpeaking,
        'options': question.options,
      };
    }).toList();

    await prefs.setString(
      'a1_basics_wrong_answers',
      jsonEncode(encodedWrongAnswers),
    );

    await prefs.setInt(
      'a1_basics_exam_score',
      result.score,
    );

    await prefs.setInt(
      'a1_basics_exam_correct',
      result.correctAnswers,
    );

    await prefs.setInt(
      'a1_basics_exam_wrong',
      result.wrongAnswers,
    );

    await prefs.setBool(
      'a1_basics_exam_passed',
      result.passed,
    );

    if (result.passed) {
      await prefs.setBool(
        'a1_basics_completed',
        true,
      );
    }
  }

  Future<void> _restartExam() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('a1_basics_wrong_answers');
    await prefs.remove('a1_basics_exam_score');
    await prefs.remove('a1_basics_exam_correct');
    await prefs.remove('a1_basics_exam_wrong');

    setState(() {
      _answers.clear();
      _currentIndex = 0;
      _selectedAnswer = null;
      _spokenAnswer = '';
      _answerSubmitted = false;
      _showResult = false;
    });

    _prepareExam();
  }

  Color _questionColor(BuildContext context) {
    final theme = Theme.of(context);

    if (!_answerSubmitted) {
      return theme.colorScheme.primary;
    }

    if (_currentQuestion.isSpeaking) {
      final correct = _checkSpeakingAnswer(
        _currentQuestion,
        _spokenAnswer,
      );

      return correct ? Colors.green : Colors.red;
    }

    return _selectedAnswer == _currentQuestion.correctAnswer
        ? Colors.green
        : Colors.red;
  }

  @override
  void dispose() {
    _tts.stop();
    _speech.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_showResult) {
      return _buildResultPage();
    }

    return _buildExamPage();
  }

  Widget _buildExamPage() {
    final question = _currentQuestion;
    final progress = (_currentIndex + 1) / _questions.length;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'A1 Basics Exam',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Question ${_currentIndex + 1}',
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${_questions.length} total',
                        style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withOpacity(0.55),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 7,
                      backgroundColor: primary.withOpacity(0.10),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildQuestionCard(question, primary),

                    const SizedBox(height: 18),

                    question.isSpeaking
                        ? _buildSpeakingQuestion(question)
                        : _buildMultipleChoiceQuestion(question),

                    if (_answerSubmitted) ...[
                      const SizedBox(height: 18),
                      _buildFeedbackCard(question),
                    ],

                    const SizedBox(height: 20),

                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _canSubmit()
                            ? (_answerSubmitted
                                ? _nextQuestion
                                : _submitAnswer)
                            : null,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          _answerSubmitted
                              ? (_isLastQuestion
                                  ? 'See Result'
                                  : 'Next')
                              : 'Check Answer',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(
    A1BasicsExamQuestion question,
    Color primary,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.category,
                      style: TextStyle(
                        color: primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      question.topic,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(0.55),
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: primary.withOpacity(0.10),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _speakQuestion,
                  child: Padding(
                    padding: const EdgeInsets.all(11),
                    child: Icon(
                      Icons.volume_up_rounded,
                      color: primary,
                      size: 21,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Text(
            question.question,
            style: const TextStyle(
              fontSize: 23,
              height: 1.35,
              fontWeight: FontWeight.w700,
            ),
          ),

          if (question.persian != null) ...[
            const SizedBox(height: 10),
            Text(
              question.persian!,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withOpacity(0.60),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceQuestion(
    A1BasicsExamQuestion question,
  ) {
    return Column(
      children: List.generate(
        question.options.length,
        (index) {
          final option = question.options[index];

          final selected = _selectedAnswer == option;

          final isCorrect =
              _answerSubmitted &&
              option == question.correctAnswer;

          final isWrong =
              _answerSubmitted &&
              selected &&
              option != question.correctAnswer;

          Color? backgroundColor;
          Color borderColor = Theme.of(context)
              .dividerColor
              .withOpacity(0.65);

          if (isCorrect) {
            backgroundColor = Colors.green.withOpacity(0.10);
            borderColor = Colors.green.withOpacity(0.65);
          } else if (isWrong) {
            backgroundColor = Colors.red.withOpacity(0.10);
            borderColor = Colors.red.withOpacity(0.65);
          } else if (selected) {
            backgroundColor = Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.10);
            borderColor = Theme.of(context).colorScheme.primary;
          }

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == question.options.length - 1 ? 0 : 12,
            ),
            child: Material(
              color: backgroundColor ?? Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                onTap: _answerSubmitted
                    ? null
                    : () => _selectAnswer(option),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 62,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: borderColor,
                      width: selected || isCorrect || isWrong ? 1.7 : 1,
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
                          color: selected
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.08),
                        ),
                        child: Text(
                          String.fromCharCode(65 + index),
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : Theme.of(context)
                                    .colorScheme
                                    .primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Text(
                          option,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      if (isCorrect)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                        ),

                      if (isWrong)
                        const Icon(
                          Icons.cancel_rounded,
                          color: Colors.red,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpeakingQuestion(
    A1BasicsExamQuestion question,
  ) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.45),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.record_voice_over_rounded,
                  color: primary,
                  size: 21,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Answer in English using your voice.',
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          GestureDetector(
            onTap: _isListening
                ? _stopListening
                : _startListening,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isListening
                    ? Colors.red
                    : primary,
                boxShadow: [
                  BoxShadow(
                    color: (_isListening
                            ? Colors.red
                            : primary)
                        .withOpacity(0.20),
                    blurRadius: 20,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Icon(
                _isListening
                    ? Icons.stop_rounded
                    : Icons.mic_rounded,
                color: Colors.white,
                size: 42,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            _isListening
                ? 'Listening...'
                : 'Tap to speak',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 18),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: _spokenAnswer.isEmpty
                ? Text(
                    'Your answer will appear here.',
                    key: const ValueKey('empty'),
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.45),
                    ),
                  )
                : Container(
                    key: ValueKey(_spokenAnswer),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context)
                          .scaffoldBackgroundColor,
                    ),
                    child: Text(
                      _spokenAnswer,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(
    A1BasicsExamQuestion question,
  ) {
    final correct = _isCurrentAnswerCorrect();
    final color = correct ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            correct
                ? Icons.check_circle_rounded
                : Icons.info_rounded,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  correct ? 'Correct! 🎉' : 'Not quite.',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Correct answer: ${question.correctAnswer}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  question.explanation,
                  style: const TextStyle(
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _canSubmit() {
    if (_answerSubmitted) {
      return true;
    }

    if (_currentQuestion.isSpeaking) {
      return _spokenAnswer.trim().isNotEmpty;
    }

    return _selectedAnswer != null;
  }

  bool _isCurrentAnswerCorrect() {
    final question = _currentQuestion;

    if (question.isSpeaking) {
      return _checkSpeakingAnswer(
        question,
        _spokenAnswer,
      );
    }

    return _selectedAnswer == question.correctAnswer;
  }

  Widget _buildResultPage() {
    final correct =
        _answers.where((answer) => answer.isCorrect).length;

    final wrong = _answers.length - correct;

    final score = _answers.isEmpty
        ? 0
        : ((correct / _answers.length) * 100).round();

    final passed = score >= 70;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Exam Result',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 28,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Theme.of(context).cardColor,
                  border: Border.all(
                    color:
                        Theme.of(context).dividerColor.withOpacity(0.45),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (passed ? Colors.green : primary)
                            .withOpacity(0.10),
                      ),
                      child: Icon(
                        passed
                            ? Icons.emoji_events_rounded
                            : Icons.menu_book_rounded,
                        size: 44,
                        color: passed ? Colors.green : primary,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      passed
                          ? 'You passed! 🎉'
                          : 'Keep practicing!',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      passed
                          ? 'A1 Basics completed'
                          : 'You need 70% to pass',
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(0.60),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      '$score%',
                      style: TextStyle(
                        fontSize: 58,
                        height: 1,
                        fontWeight: FontWeight.w900,
                        color: passed ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _resultCard(
                      'Correct',
                      '$correct',
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _resultCard(
                      'Wrong',
                      '$wrong',
                      Colors.red,
                    ),
                  ),
                ],
              ),

              if (wrong > 0) ...[
                const SizedBox(height: 28),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Review your mistakes',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                ..._answers
                    .where((answer) => !answer.isCorrect)
                    .map(_buildWrongAnswerCard),
              ],

              if (passed) ...[
                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.withOpacity(0.09),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.18),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Basics completed! Lesson 1 can now be unlocked.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _restartExam,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Take the Exam Again',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
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

  Widget _resultCard(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(0.08),
        border: Border.all(
          color: color.withOpacity(0.14),
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWrongAnswerCard(
    A1BasicsExamAnswer answer,
  ) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Colors.red.withOpacity(0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            answer.topic,
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            answer.question,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 15),

          _answerReviewRow(
            'Your answer',
            answer.userAnswer.isEmpty
                ? 'No answer'
                : answer.userAnswer,
            Colors.red,
          ),

          const SizedBox(height: 12),

          _answerReviewRow(
            'Correct answer',
            answer.correctAnswer,
            Colors.green,
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Why?',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  answer.explanation,
                  style: const TextStyle(
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _answerReviewRow(
    String title,
    String value,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}