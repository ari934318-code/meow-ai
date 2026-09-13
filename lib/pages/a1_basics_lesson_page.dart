import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/levels/a1/basics/a1_basics_models.dart';

class A1BasicsLessonPage extends StatefulWidget {
  final A1BasicLesson lesson;

  const A1BasicsLessonPage({
    super.key,
    required this.lesson,
  });

  @override
  State<A1BasicsLessonPage> createState() =>
      _A1BasicsLessonPageState();
}

class _A1BasicsLessonPageState
    extends State<A1BasicsLessonPage> {
  static const String _completedLessonsKey =
      'a1_basics_completed_lessons';

  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  final Set<int> _answeredQuestions = {};
  final Set<int> _completedSpeaking = {};
  final Set<int> _listenedExamples = {};

  final Map<int, String> _selectedAnswers = {};

  late List<A1BasicQuestion> _questions;
  late final List<_A1Stage> _stages;

  bool _speechAvailable = false;
  bool _isListening = false;

  int? _currentSpeakingIndex;
  String _recognizedText = '';

  int _currentStage = 0;

  @override
  void initState() {
    super.initState();

    // مهم:
    // سؤال‌ها نباید Shuffle شوند چون Stageها
    // بر اساس ترتیب ثابت سؤال‌ها ساخته شده‌اند.
    _questions =
        List<A1BasicQuestion>.from(
      widget.lesson.questions,
    );

    _stages = _buildStages();

    _initializeSpeech();
    _initializeTts();
    _loadProgress();
  }

  // ------------------------------------------------------------
  // STAGES
  // ------------------------------------------------------------

  List<_A1Stage> _buildStages() {
    final totalQuestions =
        widget.lesson.questions.length;

    final totalSpeaking =
        widget.lesson.speakingQuestions.length;

    // Pronouns
    if (widget.lesson.id == 'a1_basic_01') {
      return [
        _A1Stage(
          title: 'I & You',
          titleFa: 'مرحله ۱: I و You',
          description:
              'اول با I و You آشنا شو و کاربردشان را یاد بگیر.',
          questionStart: 0,
          questionEnd:
              min(6, totalQuestions),
        ),

        _A1Stage(
          title: 'He & She',
          titleFa: 'مرحله ۲: He و She',
          description:
              'حالا تفاوت He و She را یاد بگیر.',
          questionStart: 6,
          questionEnd:
              min(12, totalQuestions),
        ),

        _A1Stage(
          title: 'It',
          titleFa: 'مرحله ۳: It',
          description:
              'کاربرد It برای چیزها، موقعیت‌ها و حیوانات را تمرین کن.',
          questionStart: 12,
          questionEnd:
              min(17, totalQuestions),
        ),

        _A1Stage(
          title: 'We & They',
          titleFa: 'مرحله ۴: We و They',
          description:
              'ضمیرهای مربوط به گروه‌ها را تمرین کن.',
          questionStart: 17,
          questionEnd:
              min(23, totalQuestions),
        ),

        _A1Stage(
          title: 'Mixed Pronouns',
          titleFa: 'مرحله ۵: ترکیب ضمیرها',
          description:
              'حالا همه ضمیرها را با هم تمرین کن.',
          questionStart: 23,
          questionEnd:
              min(29, totalQuestions),
        ),

        _A1Stage(
          title: 'Grammar Practice',
          titleFa: 'مرحله ۶: am / is / are',
          description:
              'ضمیرها را با am، is و are درست استفاده کن.',
          questionStart: 29,
          questionEnd:
              min(34, totalQuestions),
        ),

        _A1Stage(
          title: 'Translation & Word Order',
          titleFa: 'مرحله ۷: ترجمه و جمله‌سازی',
          description:
              'ترجمه، ترتیب کلمات و نکات مهم ضمیرها را تمرین کن.',
          questionStart: 34,
          questionEnd: totalQuestions,
        ),

        _A1Stage(
          title: 'Speaking',
          titleFa: 'مرحله ۸: مکالمه',
          description:
              'حالا نوبت حرف زدنه. با صدای خودت جواب بده.',
          questionStart: totalQuestions,
          questionEnd: totalQuestions,
          speakingStart: 0,
          speakingEnd: totalSpeaking,
        ),
      ];
    }

    return _buildGenericStages(
      totalQuestions,
      totalSpeaking,
    );
  }

  List<_A1Stage> _buildGenericStages(
    int totalQuestions,
    int totalSpeaking,
  ) {
    if (totalQuestions == 0 &&
        totalSpeaking == 0) {
      return [];
    }

    final stages = <_A1Stage>[];

    const stageCount = 5;

    for (int i = 0; i < stageCount; i++) {
      final start =
          ((totalQuestions * i) / stageCount)
              .floor();

      final end =
          ((totalQuestions * (i + 1)) /
                  stageCount)
              .floor();

      if (start == end &&
          totalQuestions > 0) {
        continue;
      }

      stages.add(
        _A1Stage(
          title: 'Stage ${i + 1}',
          titleFa: 'مرحله ${i + 1}',
          description:
              'تمرین‌های این بخش را کامل کن.',
          questionStart: start,
          questionEnd: end,
        ),
      );
    }

    if (totalSpeaking > 0) {
      stages.add(
        _A1Stage(
          title: 'Speaking',
          titleFa: 'تمرین مکالمه',
          description:
              'با صدای خودت به سؤال‌ها پاسخ بده.',
          questionStart: totalQuestions,
          questionEnd: totalQuestions,
          speakingStart: 0,
          speakingEnd: totalSpeaking,
        ),
      );
    }

    return stages;
  }

  // ------------------------------------------------------------
  // PROGRESS
  // ------------------------------------------------------------

  String get _stageKey =>
      'a1_basics_stage_${widget.lesson.id}';

  Future<void> _loadProgress() async {
    final prefs =
        await SharedPreferences.getInstance();

    final savedStage =
        prefs.getInt(_stageKey);

    if (!mounted) return;

    setState(() {
      _currentStage = min(
        savedStage ?? 0,
        max(0, _stages.length - 1),
      );
    });
  }

  Future<void> _saveStage(int stage) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setInt(
      _stageKey,
      stage,
    );
  }

  // ------------------------------------------------------------
  // TTS
  // ------------------------------------------------------------

  Future<void> _initializeTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);
  }

  Future<void> _speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  // ------------------------------------------------------------
  // SPEECH
  // ------------------------------------------------------------

  Future<void> _initializeSpeech() async {
    _speechAvailable =
        await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening' &&
            mounted) {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (_) {
        if (mounted) {
          setState(() {
            _isListening = false;
          });
        }
      },
    );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _startListening(
    int index,
  ) async {
    if (!_speechAvailable) {
      await _initializeSpeech();
    }

    if (!_speechAvailable) {
      return;
    }

    setState(() {
      _currentSpeakingIndex = index;
      _isListening = true;
      _recognizedText = '';
    });

    await _speech.listen(
      onResult:
          (SpeechRecognitionResult result) {
        if (!mounted) return;

        setState(() {
          _recognizedText =
              result.recognizedWords;
        });

        if (result.finalResult) {
          _checkSpeakingAnswer(
            index,
            result.recognizedWords,
          );
        }
      },
      localeId: 'en_US',
      listenMode: stt.ListenMode.dictation,
      partialResults: true,
      listenFor:
          const Duration(seconds: 12),
      pauseFor:
          const Duration(seconds: 3),
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();

    if (mounted) {
      setState(() {
        _isListening = false;
      });
    }
  }

  void _checkSpeakingAnswer(
    int index,
    String spokenText,
  ) {
    final normalizedSpoken =
        _normalize(spokenText);

    if (normalizedSpoken.isEmpty) {
      return;
    }

    final acceptable =
        widget.lesson.speakingQuestions[index]
            .acceptableAnswers;

    double bestScore = 0;

    for (final answer in acceptable) {
      final score = _similarity(
        normalizedSpoken,
        _normalize(answer),
      );

      if (score > bestScore) {
        bestScore = score;
      }
    }

    final correct = bestScore >= 0.78;

    if (mounted) {
      setState(() {
        _isListening = false;

        if (correct) {
          _completedSpeaking.add(index);
        }
      });
    }

    _showSpeakingResult(correct);
  }

  void _showSpeakingResult(bool correct) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          correct
              ? 'آفرین! درست گفتی 😼💜'
              : 'تقریباً! دوباره امتحانش کن 😼',
        ),
        duration:
            const Duration(seconds: 2),
      ),
    );
  }

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(
          RegExp(r'[^\w\s]'),
          '',
        )
        .replaceAll(
          RegExp(r'\s+'),
          ' ',
        )
        .trim();
  }

  double _similarity(
    String a,
    String b,
  ) {
    if (a == b) {
      return 1.0;
    }

    if (a.isEmpty || b.isEmpty) {
      return 0.0;
    }

    final distance =
        _levenshtein(a, b);

    final maxLength =
        max(a.length, b.length);

    return 1 -
        (distance / maxLength);
  }

  int _levenshtein(
    String a,
    String b,
  ) {
    final previous =
        List<int>.generate(
      b.length + 1,
      (index) => index,
    );

    for (int i = 1;
        i <= a.length;
        i++) {
      final current =
          List<int>.filled(
        b.length + 1,
        0,
      );

      current[0] = i;

      for (int j = 1;
          j <= b.length;
          j++) {
        final cost =
            a[i - 1] == b[j - 1]
                ? 0
                : 1;

        current[j] = min(
          min(
            current[j - 1] + 1,
            previous[j] + 1,
          ),
          previous[j - 1] + cost,
        );
      }

      for (
        int j = 0;
        j < current.length;
        j++
      ) {
        previous[j] =
            current[j];
      }
    }

    return previous[b.length];
  }

  // ------------------------------------------------------------
  // QUESTION LOGIC
  // ------------------------------------------------------------

  bool _questionCorrect(
    A1BasicQuestion question,
    String answer,
  ) {
    return answer == question.answer;
  }

  void _answerQuestion(
    A1BasicQuestion question,
    int index,
    String option,
  ) {
    final isCorrect =
        _questionCorrect(
      question,
      option,
    );

    setState(() {
      _selectedAnswers[index] =
          option;
    });

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    if (isCorrect) {
      setState(() {
        _answeredQuestions.add(index);
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('درست! 😼💜'),
          duration:
              Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'نه 😼 جواب درست: ${question.answer}',
          ),
          duration:
              const Duration(seconds: 2),
        ),
      );
    }
  }

  // ------------------------------------------------------------
  // STAGE COMPLETION
  // ------------------------------------------------------------

  bool _stageCompleted(
    _A1Stage stage,
  ) {
    final questionDone =
        List.generate(
      stage.questionEnd -
          stage.questionStart,
      (i) =>
          stage.questionStart + i,
    ).every(
      (index) =>
          _answeredQuestions
              .contains(index),
    );

    final speakingDone =
        List.generate(
      stage.speakingEnd -
          stage.speakingStart,
      (i) =>
          stage.speakingStart + i,
    ).every(
      (index) =>
          _completedSpeaking
              .contains(index),
    );

    return questionDone &&
        speakingDone;
  }

  Future<void> _finishCurrentStage()
      async {
    final stage =
        _stages[_currentStage];

    if (!_stageCompleted(stage)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'اول همه تمرین‌های این مرحله رو درست کامل کن 😼',
          ),
        ),
      );

      return;
    }

    if (_currentStage <
        _stages.length - 1) {
      final nextStage =
          _currentStage + 1;

      setState(() {
        _currentStage =
            nextStage;
      });

      await _saveStage(
        nextStage,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'مرحله بعد باز شد! 🎉\n'
            '${_stages[nextStage].titleFa}',
          ),
          duration:
              const Duration(seconds: 2),
        ),
      );

      return;
    }

    await _completeLesson();
  }

  Future<void> _completeLesson()
      async {
    final prefs =
        await SharedPreferences
            .getInstance();

    final completed =
        prefs.getStringList(
              _completedLessonsKey,
            ) ??
            [];

    if (!completed
        .contains(widget.lesson.id)) {
      completed.add(
        widget.lesson.id,
      );
    }

    await prefs.setStringList(
      _completedLessonsKey,
      completed,
    );

    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'درس کامل شد 🎉',
          ),
          content: Text(
            'آفرین! درس «${widget.lesson.titleFa}» '
            'را کامل کردی.\n\n'
            'حالا می‌تونی بری سراغ درس بعدی 😼💜',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child:
                  const Text('باشه'),
            ),
          ],
        );
      },
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  // ------------------------------------------------------------
  // UI
  // ------------------------------------------------------------

  Widget _buildProgressHeader() {
    if (_stages.isEmpty) {
      return const SizedBox.shrink();
    }

    final total =
        _stages.length;

    final progress =
        (_currentStage + 1) /
            total;

    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'مرحله ${_currentStage + 1} از $total',
                    style:
                        const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: TextStyle(
                    color:
                        Theme.of(context)
                            .colorScheme
                            .primary,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    String titleFa,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            titleFa,
            style:
                Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                      fontWeight:
                          FontWeight.bold,
                    ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style:
                Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                      color:
                          Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(
                                0.65,
                              ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(
    A1BasicQuestion question,
    int index,
  ) {
    final answered =
        _answeredQuestions
            .contains(index);

    final selected =
        _selectedAnswers[index];

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    question.question,
                    style:
                        const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Listen',
                  onPressed: () {
                    _speak(
                      question.question,
                    );
                  },
                  icon:
                      const Icon(
                    Icons
                        .volume_up_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ...question.options.map(
              (option) {
                final isSelected =
                    selected ==
                        option;

                final isCorrectOption =
                    answered &&
                        option ==
                            question.answer;

                return Padding(
                  padding:
                      const EdgeInsets
                          .only(
                    bottom: 8,
                  ),
                  child:
                      SizedBox(
                    width:
                        double.infinity,
                    child:
                        OutlinedButton(
                      onPressed:
                          answered
                              ? null
                              : () {
                                  _answerQuestion(
                                    question,
                                    index,
                                    option,
                                  );
                                },
                      style:
                          OutlinedButton.styleFrom(
                        alignment:
                            Alignment
                                .centerLeft,
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal:
                              14,
                          vertical:
                              12,
                        ),
                      ),
                      child:
                          Row(
                        children: [
                          Expanded(
                            child:
                                Text(
                              option,
                            ),
                          ),

                          if (isCorrectOption)
                            const Icon(
                              Icons
                                  .check_circle,
                              size: 20,
                            )
                          else if (isSelected &&
                              !answered)
                            const Icon(
                              Icons
                                  .radio_button_checked,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            if (answered &&
                question.explanation !=
                    null) ...[
              const SizedBox(
                height: 8,
              ),
              Text(
                question
                    .explanation!,
                style: TextStyle(
                  color:
                      Theme.of(context)
                          .colorScheme
                          .primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSpeakingQuestion(
    A1BasicSpeakingQuestion
        question,
    int index,
  ) {
    final completed =
        _completedSpeaking
            .contains(index);

    final active =
        _currentSpeakingIndex ==
            index;

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Expanded(
                  child: Text(
                    question.question,
                    style:
                        const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _speak(
                      question.question,
                    );
                  },
                  icon:
                      const Icon(
                    Icons
                        .volume_up_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 6,
            ),

            Text(
              question.persian,
            ),

            const SizedBox(
              height: 14,
            ),

            if (active &&
                _recognizedText
                    .isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets
                        .only(
                  bottom: 10,
                ),
                child: Text(
                  'شنیدم: $_recognizedText',
                  style: TextStyle(
                    color:
                        Theme.of(context)
                            .colorScheme
                            .primary,
                  ),
                ),
              ),

            SizedBox(
              width:
                  double.infinity,
              child:
                  ElevatedButton.icon(
                onPressed: completed
                    ? null
                    : (_isListening &&
                            active
                        ? _stopListening
                        : () {
                            _startListening(
                              index,
                            );
                          }),
                icon: Icon(
                  _isListening &&
                          active
                      ? Icons.stop
                      : Icons.mic,
                ),
                label: Text(
                  completed
                      ? 'Completed ✓'
                      : (_isListening &&
                              active
                          ? 'Stop'
                          : 'Speak'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStage() {
    if (_stages.isEmpty) {
      return const SizedBox.shrink();
    }

    final stage =
        _stages[_currentStage];

    final stageQuestions =
        List.generate(
      stage.questionEnd -
          stage.questionStart,
      (index) =>
          stage.questionStart +
          index,
    );

    final stageSpeaking =
        List.generate(
      stage.speakingEnd -
          stage.speakingStart,
      (index) =>
          stage.speakingStart +
          index,
    );

    final completed =
        _stageCompleted(stage);

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        // Stage header
        Card(
          child: Padding(
            padding:
                const EdgeInsets.all(
              18,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration:
                          BoxDecoration(
                        color: Theme.of(
                          context,
                        )
                            .colorScheme
                            .primary
                            .withOpacity(
                              0.12,
                            ),
                        shape:
                            BoxShape.circle,
                      ),
                      child:
                          Center(
                        child: Text(
                          '${_currentStage + 1}',
                          style:
                              TextStyle(
                            color: Theme.of(
                              context,
                            )
                                .colorScheme
                                .primary,
                            fontWeight:
                                FontWeight
                                    .bold,
                            fontSize:
                                18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            stage.titleFa,
                            style:
                                const TextStyle(
                              fontSize:
                                  22,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            stage.title,
                            style:
                                TextStyle(
                              color: Theme.of(
                                context,
                              )
                                  .colorScheme
                                  .primary,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 14,
                ),

                Text(
                  stage.description,
                  style:
                      const TextStyle(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Questions
        if (stageQuestions
            .isNotEmpty) ...[
          _buildSectionTitle(
            'Practice',
            'تمرین',
          ),

          ...stageQuestions.map(
            (index) =>
                _buildQuestion(
              _questions[index],
              index,
            ),
          ),
        ],

        // Speaking
        if (stageSpeaking
            .isNotEmpty) ...[
          _buildSectionTitle(
            'Speaking',
            'تمرین مکالمه',
          ),

          ...stageSpeaking.map(
            (index) =>
                _buildSpeakingQuestion(
              widget.lesson
                  .speakingQuestions[
                      index],
              index,
            ),
          ),
        ],

        const SizedBox(
          height: 18,
        ),

        SizedBox(
          width:
              double.infinity,
          child:
              ElevatedButton.icon(
            onPressed: completed
                ? _finishCurrentStage
                : null,
            icon: Icon(
              _currentStage ==
                      _stages.length - 1
                  ? Icons
                      .check_circle
                  : Icons
                      .arrow_forward,
            ),
            label: Text(
              _currentStage ==
                      _stages.length - 1
                  ? 'Complete Lesson'
                  : 'Complete Stage',
            ),
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        if (!completed)
          Center(
            child: Text(
              'برای رفتن به مرحله بعد، همه تمرین‌ها را درست انجام بده.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(
                  context,
                )
                    .colorScheme
                    .onSurface
                    .withOpacity(
                      0.6,
                    ),
              ),
            ),
          ),
      ],
    );
  }

  // ------------------------------------------------------------
  // EXAMPLE
  // ------------------------------------------------------------

  Widget _buildExample(
    A1BasicExample example,
    int index,
  ) {
    final listened =
        _listenedExamples
            .contains(index);

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    example.english,
                    style:
                        const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Listen',
                  onPressed: () async {
                    await _speak(
                      example.english,
                    );

                    if (mounted) {
                      setState(() {
                        _listenedExamples
                            .add(index);
                      });
                    }
                  },
                  icon: Icon(
                    listened
                        ? Icons.volume_up
                        : Icons
                            .volume_up_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              example.persian,
            ),
            if (example.pronunciation !=
                null) ...[
              const SizedBox(
                height: 5,
              ),
              Text(
                example.pronunciation!,
                style: TextStyle(
                  color:
                      Theme.of(context)
                          .colorScheme
                          .primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lesson.titleFa,
        ),
      ),

      body: SafeArea(
        child:
            SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            30,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              // Lesson title
              Text(
                widget.lesson.title,
                style:
                    Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
              ),

              const SizedBox(
                height: 4,
              ),

              Text(
                widget.lesson.topic,
                style:
                    Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color: Theme.of(
                            context,
                          )
                              .colorScheme
                              .primary,
                        ),
              ),

              const SizedBox(
                height: 18,
              ),

              // Progress
              _buildProgressHeader(),

              const SizedBox(
                height: 14,
              ),

              // Current stage only
              _buildCurrentStage(),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// STAGE MODEL
// ============================================================

class _A1Stage {
  final String title;
  final String titleFa;
  final String description;

  final int questionStart;
  final int questionEnd;

  final int speakingStart;
  final int speakingEnd;

  const _A1Stage({
    required this.title,
    required this.titleFa,
    required this.description,
    required this.questionStart,
    required this.questionEnd,
    this.speakingStart = 0,
    this.speakingEnd = 0,
  });
}