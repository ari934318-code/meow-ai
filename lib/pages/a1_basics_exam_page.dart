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
      onError: (error) {
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

    final selectedMultipleChoice =
        multipleChoice.take(20).toList();

    final selectedSpeaking =
        speaking.take(5).toList();

    final combined = [
      ...selectedMultipleChoice,
      ...selectedSpeaking,
    ];

    combined.shuffle(_random);

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

    if (!_speechAvailable) {
      return;
    }

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

      isCorrect =
          userAnswer == question.correctAnswer;
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

    final encodedWrongAnswers =
        wrongAnswers.map((answer) {
      final question =
          a1BasicsExamQuestions.firstWhere(
        (question) =>
            question.id == answer.questionId,
        orElse: () =>
            A1BasicsExamQuestion(
          id: answer.questionId,
          lessonId: answer.lessonId,
          topic: answer.topic,
          category: answer.category,
          question: answer.question,
          options: const [],
          correctAnswer:
              answer.correctAnswer,
          explanation:
              answer.explanation,
          persian: null,
          isSpeaking:
              answer.isSpeaking,
          acceptableAnswers:
              const [],
        ),
      );

      return {
        'questionId':
            answer.questionId,
        'lessonId':
            answer.lessonId,
        'category':
            answer.category,
        'topic':
            answer.topic,
        'question':
            answer.question,
        'userAnswer':
            answer.userAnswer,
        'correctAnswer':
            answer.correctAnswer,
        'explanation':
            answer.explanation,
        'isCorrect':
            answer.isCorrect,
        'isSpeaking':
            answer.isSpeaking,

        'options':
            question.options,
      };
    }).toList();

    await prefs.setString(
      'a1_basics_wrong_answers',
      jsonEncode(
        encodedWrongAnswers,
      ),
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

    // If the user passes Basics at least once,
    // it stays completed permanently.
    //
    // A later failed retake must NOT lock Lesson 1 again.
    if (result.passed) {
      await prefs.setBool(
        'a1_basics_completed',
        true,
      );
    }
  }

  Future<void> _restartExam() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(
      'a1_basics_wrong_answers',
    );

    await prefs.remove(
      'a1_basics_exam_score',
    );

    await prefs.remove(
      'a1_basics_exam_correct',
    );

    await prefs.remove(
      'a1_basics_exam_wrong',
    );

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

  Color _questionColor(
    BuildContext context,
  ) {
    final theme =
        Theme.of(context);

    if (!_answerSubmitted) {
      return theme.colorScheme.primary;
    }

    if (_currentQuestion.isSpeaking) {
      final correct =
          _checkSpeakingAnswer(
        _currentQuestion,
        _spokenAnswer,
      );

      return correct
          ? Colors.green
          : Colors.red;
    }

    return _selectedAnswer ==
            _currentQuestion
                .correctAnswer
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
  Widget build(
    BuildContext context,
  ) {
    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (_showResult) {
      return _buildResultPage();
    }

    return _buildExamPage();
  }

  Widget _buildExamPage() {
    final question =
        _currentQuestion;

    final progress =
        (_currentIndex + 1) /
            _questions.length;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Basics Exam'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .stretch,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  Text(
                    'Question ${_currentIndex + 1} / ${_questions.length}',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                  Text(
                    question.category,
                    style: TextStyle(
                      color:
                          Theme.of(
                        context,
                      ).colorScheme.primary,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),

              ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
                child:
                    LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                ),
              ),

              const SizedBox(
                height: 28,
              ),

              Text(
                question.topic,
                style: TextStyle(
                  color:
                      Theme.of(
                    context,
                  ).colorScheme.primary,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              Text(
                question.question,
                style:
                    const TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              if (question.persian !=
                  null)
                Text(
                  question.persian!,
                  style: TextStyle(
                    fontSize: 15,
                    color:
                        Theme.of(
                      context,
                    )
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(
                          0.7,
                        ),
                  ),
                ),

              const SizedBox(
                height: 12,
              ),

              Align(
                alignment:
                    Alignment.centerLeft,
                child:
                    IconButton(
                  onPressed:
                      _speakQuestion,
                  icon:
                      const Icon(
                    Icons
                        .volume_up_rounded,
                  ),
                  tooltip: 'Listen',
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Expanded(
                child: question
                        .isSpeaking
                    ? _buildSpeakingQuestion(
                        question,
                      )
                    : _buildMultipleChoiceQuestion(
                        question,
                      ),
              ),

              const SizedBox(
                height: 12,
              ),

              if (_answerSubmitted)
                Container(
                  padding:
                      const EdgeInsets
                          .all(14),
                  decoration:
                      BoxDecoration(
                    color:
                        _questionColor(
                      context,
                    ).withOpacity(
                      0.10,
                    ),
                    borderRadius:
                        BorderRadius
                            .circular(
                      16,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        _isCurrentAnswerCorrect()
                            ? 'Correct! 🎉'
                            : 'Not quite.',
                        style: TextStyle(
                          color:
                              _questionColor(
                            context,
                          ),
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Correct answer: ${question.correctAnswer}',
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        question
                            .explanation,
                      ),
                    ],
                  ),
                ),

              const SizedBox(
                height: 12,
              ),

              SizedBox(
                height: 54,
                child:
                    ElevatedButton(
                  onPressed:
                      _canSubmit()
                          ? (_answerSubmitted
                              ? _nextQuestion
                              : _submitAnswer)
                          : null,
                  child: Text(
                    _answerSubmitted
                        ? (_isLastQuestion
                            ? 'See Result'
                            : 'Next')
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

  Widget _buildMultipleChoiceQuestion(
    A1BasicsExamQuestion question,
  ) {
    return ListView.separated(
      itemCount:
          question.options.length,
      separatorBuilder:
          (_, __) =>
              const SizedBox(
        height: 10,
      ),
      itemBuilder:
          (context, index) {
        final option =
            question.options[index];

        final selected =
            _selectedAnswer ==
                option;

        final isCorrect =
            _answerSubmitted &&
                option ==
                    question
                        .correctAnswer;

        final isWrong =
            _answerSubmitted &&
                selected &&
                option !=
                    question
                        .correctAnswer;

        Color? backgroundColor;

        if (isCorrect) {
          backgroundColor =
              Colors.green
                  .withOpacity(0.15);
        } else if (isWrong) {
          backgroundColor =
              Colors.red
                  .withOpacity(0.15);
        }

        return InkWell(
          onTap:
              _answerSubmitted
                  ? null
                  : () =>
                      _selectAnswer(
                        option,
                      ),
          borderRadius:
              BorderRadius.circular(
            16,
          ),
          child: Container(
            padding:
                const EdgeInsets.all(
              16,
            ),
            decoration:
                BoxDecoration(
              color:
                  backgroundColor,
              borderRadius:
                  BorderRadius.circular(
                16,
              ),
              border: Border.all(
                color: selected
                    ? Theme.of(
                        context,
                      ).colorScheme.primary
                    : Theme.of(
                        context,
                      ).dividerColor,
                width:
                    selected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option,
                    style:
                        const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                if (isCorrect)
                  const Icon(
                    Icons
                        .check_circle,
                    color:
                        Colors.green,
                  ),
                if (isWrong)
                  const Icon(
                    Icons.cancel,
                    color:
                        Colors.red,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpeakingQuestion(
    A1BasicsExamQuestion question,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment
              .stretch,
      children: [
        Container(
          padding:
              const EdgeInsets.all(
            18,
          ),
          decoration:
              BoxDecoration(
            borderRadius:
                BorderRadius.circular(
              18,
            ),
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.08),
          ),
          child: Text(
            'Speak in English and answer using your voice.',
            style: TextStyle(
              color:
                  Theme.of(context)
                      .colorScheme
                      .primary,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment
                      .center,
              children: [
                GestureDetector(
                  onTap:
                      _isListening
                          ? _stopListening
                          : _startListening,
                  child:
                      AnimatedContainer(
                    duration:
                        const Duration(
                      milliseconds: 200,
                    ),
                    width: 90,
                    height: 90,
                    decoration:
                        BoxDecoration(
                      shape:
                          BoxShape.circle,
                      color: _isListening
                          ? Colors.red
                          : Theme.of(
                              context,
                            )
                              .colorScheme
                              .primary,
                    ),
                    child: Icon(
                      _isListening
                          ? Icons
                              .stop_rounded
                          : Icons
                              .mic_rounded,
                      color:
                          Colors.white,
                      size: 42,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                  _isListening
                      ? 'Listening...'
                      : 'Tap the microphone',
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                if (_spokenAnswer
                    .isNotEmpty)
                  Container(
                    width:
                        double.infinity,
                    padding:
                        const EdgeInsets
                            .all(16),
                    decoration:
                        BoxDecoration(
                      borderRadius:
                          BorderRadius
                              .circular(
                        16,
                      ),
                      border:
                          Border.all(
                        color:
                            Theme.of(
                          context,
                        ).dividerColor,
                      ),
                    ),
                    child: Text(
                      _spokenAnswer,
                      textAlign:
                          TextAlign.center,
                      style:
                          const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _canSubmit() {
    if (_answerSubmitted) {
      return true;
    }

    if (_currentQuestion
        .isSpeaking) {
      return _spokenAnswer
          .trim()
          .isNotEmpty;
    }

    return _selectedAnswer !=
        null;
  }

  bool _isCurrentAnswerCorrect() {
    final question =
        _currentQuestion;

    if (question.isSpeaking) {
      return _checkSpeakingAnswer(
        question,
        _spokenAnswer,
      );
    }

    return _selectedAnswer ==
        question.correctAnswer;
  }

  Widget _buildResultPage() {
    final correct =
        _answers.where(
      (answer) =>
          answer.isCorrect,
    ).length;

    final wrong =
        _answers.length - correct;

    final score = _answers.isEmpty
        ? 0
        : ((correct /
                    _answers.length) *
                100)
            .round();

    final passed = score >= 70;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Exam Result'),
        centerTitle: true,
      ),
      body: SafeArea(
        child:
            SingleChildScrollView(
          padding:
              const EdgeInsets.all(
            20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              Icon(
                passed
                    ? Icons
                        .emoji_events_rounded
                    : Icons
                        .menu_book_rounded,
                size: 80,
                color: passed
                    ? Colors.amber
                    : Theme.of(context)
                        .colorScheme
                        .primary,
              ),

              const SizedBox(
                height: 20,
              ),

              Text(
                passed
                    ? 'You passed! 🎉'
                    : 'Keep practicing!',
                style:
                    const TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              Text(
                '$score%',
                style: TextStyle(
                  fontSize: 52,
                  fontWeight:
                      FontWeight.bold,
                  color: passed
                      ? Colors.green
                      : Colors.red,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Expanded(
                    child:
                        _resultCard(
                      'Correct',
                      '$correct',
                      Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child:
                        _resultCard(
                      'Wrong',
                      '$wrong',
                      Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 28,
              ),

              if (wrong > 0) ...[
                const Align(
                  alignment:
                      Alignment.centerLeft,
                  child: Text(
                    'Your mistakes',
                    style:
                        TextStyle(
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                ..._answers
                    .where(
                      (answer) =>
                          !answer.isCorrect,
                    )
                    .map(
                      _buildWrongAnswerCard,
                    ),
              ],

              const SizedBox(
                height: 20,
              ),

              if (passed)
                Container(
                  width:
                      double.infinity,
                  padding:
                      const EdgeInsets
                          .all(16),
                  decoration:
                      BoxDecoration(
                    borderRadius:
                        BorderRadius
                            .circular(
                      18,
                    ),
                    color: Colors.green
                        .withOpacity(
                      0.10,
                    ),
                  ),
                  child:
                      const Text(
                    'Basics completed! Lesson 1 can now be unlocked.',
                    textAlign:
                        TextAlign.center,
                    style:
                        TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width:
                    double.infinity,
                height: 54,
                child:
                    ElevatedButton(
                  onPressed:
                      _restartExam,
                  child:
                      const Text(
                    'Take the Exam Again',
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
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(18),
        color:
            color.withOpacity(0.10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildWrongAnswerCard(
    A1BasicsExamAnswer answer,
  ) {
    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: Colors.red
              .withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,
        children: [
          Text(
            answer.topic,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .primary,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            answer.question,
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Text(
            'Your answer:',
            style: TextStyle(
              color:
                  Colors.red.shade700,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(
            answer.userAnswer.isEmpty
                ? 'No answer'
                : answer.userAnswer,
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            'Correct answer:',
            style: TextStyle(
              color:
                  Colors.green.shade700,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(
            answer.correctAnswer,
          ),

          const SizedBox(
            height: 10,
          ),

          const Text(
            'Why?',
            style:
                TextStyle(
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(
            answer.explanation,
          ),
        ],
      ),
    );
  }
}