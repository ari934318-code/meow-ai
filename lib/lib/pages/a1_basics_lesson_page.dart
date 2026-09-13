import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
  static const Color lavender = Color(0xFFB9A7E8);

  static const String _completedLessonsKey =
      'a1_basics_completed_lessons';

  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final Random _random = Random();

  final PageController _pageController =
      PageController();

  bool speechAvailable = false;
  bool isFinishing = false;

  int currentSection = 0;
  int currentQuestion = 0;
  int currentSpeakingQuestion = 0;

  final Set<int> _completedExamples = {};
  final Set<int> _completedQuestions = {};
  final Set<int> _completedSpeaking = {};

  final Map<int, int> _selectedAnswers = {};
  final Map<int, List<String>> _shuffledOptions = {};

  final Map<int, String> _recognizedSpeech = {};
  final Map<int, String> _speechMessage = {};
  final Map<int, bool> _isListening = {};

  int? _activeSpeechIndex;

  String? _activeAudioKey;

  @override
  void initState() {
    super.initState();

    _shuffleQuestions();
    _setupTts();
    _setupSpeech();
  }

  @override
  void dispose() {
    _speech.stop();
    _tts.stop();
    _pageController.dispose();
    super.dispose();
  }

  void _shuffleQuestions() {
    for (int i = 0;
        i < widget.lesson.questions.length;
        i++) {
      final question = widget.lesson.questions[i];

      final options =
          List<String>.from(question.options);

      options.shuffle(_random);

      _shuffledOptions[i] = options;
    }
  }

  List<String> _optionsFor(int index) {
    return _shuffledOptions[index] ??
        List<String>.from(
          widget.lesson.questions[index].options,
        );
  }

  Future<void> _setupTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    _tts.setCompletionHandler(() {
      if (!mounted) return;

      final key = _activeAudioKey;

      if (key == null) return;

      setState(() {
        if (key.startsWith('example_')) {
          final index = int.tryParse(
            key.replaceFirst('example_', ''),
          );

          if (index != null) {
            _completedExamples.add(index);
          }
        }
      });

      _activeAudioKey = null;
    });
  }

  Future<void> _setupSpeech() async {
    try {
      final available = await _speech.initialize(
        onStatus: (status) {
          if (!mounted) return;

          if (status == 'done' ||
              status == 'notListening') {
            final active = _activeSpeechIndex;

            if (active != null) {
              setState(() {
                _isListening[active] = false;
              });
            }

            _activeSpeechIndex = null;
          }
        },
        onError: (error) {
          if (!mounted) return;

          final active = _activeSpeechIndex;

          if (active != null) {
            setState(() {
              _isListening[active] = false;
              _speechMessage[active] =
                  'Speech recognition error.';
            });
          }

          _activeSpeechIndex = null;
        },
      );

      if (!mounted) return;

      setState(() {
        speechAvailable = available;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        speechAvailable = false;
      });
    }
  }

  Future<void> _speak(
    String text, {
    String? audioKey,
  }) async {
    if (text.trim().isEmpty) return;

    await _tts.stop();

    _activeAudioKey = audioKey;

    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    await _tts.speak(text);
  }

  Future<void> _startListening(int index) async {
    if (!speechAvailable) {
      await _setupSpeech();
    }

    if (!speechAvailable) {
      if (!mounted) return;

      setState(() {
        _speechMessage[index] =
            'Speech recognition is not available on this device.';
      });

      return;
    }

    if (_activeSpeechIndex != null &&
        _activeSpeechIndex != index) {
      await _speech.stop();

      final previous = _activeSpeechIndex;

      if (mounted && previous != null) {
        setState(() {
          _isListening[previous] = false;
        });
      }
    }

    await _tts.stop();

    _activeSpeechIndex = index;

    if (!mounted) return;

    setState(() {
      _isListening[index] = true;
      _recognizedSpeech[index] = '';
      _speechMessage[index] = '';
    });

    await _speech.listen(
      onResult: (result) {
        if (!mounted) return;

        setState(() {
          _recognizedSpeech[index] =
              result.recognizedWords;
        });

        if (result.finalResult) {
          _checkSpeakingAnswer(index);
        }
      },
      localeId: 'en_US',
      listenMode: stt.ListenMode.dictation,
      partialResults: true,
      cancelOnError: true,
      listenFor: const Duration(seconds: 12),
      pauseFor: const Duration(seconds: 3),
    );
  }

  Future<void> _stopListening(int index) async {
    await _speech.stop();

    if (_activeSpeechIndex == index) {
      _activeSpeechIndex = null;
    }

    if (!mounted) return;

    setState(() {
      _isListening[index] = false;
    });

    await _checkSpeakingAnswer(index);
  }

  Future<void> _checkSpeakingAnswer(int index) async {
    final question =
        widget.lesson.speakingQuestions[index];

    final spoken = _normalize(
      _recognizedSpeech[index] ?? '',
    );

    if (spoken.isEmpty) {
      if (!mounted) return;

      setState(() {
        _speechMessage[index] =
            'I could not understand your answer. Try again.';
      });

      return;
    }

    double bestSimilarity = 0;

    for (final acceptable
        in question.acceptableAnswers) {
      final target = _normalize(acceptable);

      final similarity =
          _similarity(spoken, target);

      if (similarity > bestSimilarity) {
        bestSimilarity = similarity;
      }
    }

    if (bestSimilarity >= 0.78) {
      if (!mounted) return;

      setState(() {
        _speechMessage[index] =
            'Correct! 🎉';

        _completedSpeaking.add(index);
      });

      await _speak('Correct!');
    } else {
      if (!mounted) return;

      setState(() {
        _speechMessage[index] =
            'Not quite. Try again and listen carefully.';
      });
    }
  }

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(
          RegExp(r"[^\w\s']"),
          '',
        )
        .replaceAll(
          RegExp(r'\s+'),
          ' ',
        )
        .trim();
  }

  double _similarity(
    String first,
    String second,
  ) {
    if (first == second) return 1.0;

    if (first.isEmpty || second.isEmpty) {
      return 0.0;
    }

    final firstWords = first.split(' ');
    final secondWords = second.split(' ');

    int matched = 0;

    for (final word in firstWords) {
      if (secondWords.contains(word)) {
        matched++;
      }
    }

    final total = {
      ...firstWords,
      ...secondWords,
    }.length;

    if (total == 0) return 0.0;

    return (matched * 2) /
        (firstWords.length + secondWords.length);
  }

  bool _areExamplesCompleted() {
    return _completedExamples.length >=
        widget.lesson.examples.length;
  }

  bool _areQuestionsCompleted() {
    return _completedQuestions.length >=
        widget.lesson.questions.length;
  }

  bool _areSpeakingCompleted() {
    if (widget.lesson.speakingQuestions.isEmpty) {
      return true;
    }

    return _completedSpeaking.length >=
        widget.lesson.speakingQuestions.length;
  }

  bool get _lessonCompleted =>
      _areExamplesCompleted() &&
      _areQuestionsCompleted() &&
      _areSpeakingCompleted();

  bool _isLastSection() {
    return currentSection >=
        widget.lesson.sections.length - 1;
  }

  bool _canGoNextSection() {
    return currentSection <
        widget.lesson.sections.length - 1;
  }

  void _nextSection() {
    if (!_canGoNextSection()) return;

    _pageController.nextPage(
      duration:
          const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _previousSection() {
    if (currentSection <= 0) return;

    _pageController.previousPage(
      duration:
          const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _selectAnswer(
    int questionIndex,
    int optionIndex,
  ) {
    if (_selectedAnswers.containsKey(
      questionIndex,
    )) {
      return;
    }

    final question =
        widget.lesson.questions[questionIndex];

    final options =
        _optionsFor(questionIndex);

    final selected =
        options[optionIndex];

    setState(() {
      _selectedAnswers[questionIndex] =
          optionIndex;

      // چه درست چه غلط، سؤال انجام شده محسوب می‌شود.
      _completedQuestions.add(questionIndex);
    });

    if (selected == question.answer) {
      _speak('Correct!');
    }
  }

  Future<void> _completeLesson() async {
    if (!_lessonCompleted || isFinishing) {
      return;
    }

    setState(() {
      isFinishing = true;
    });

    final prefs =
        await SharedPreferences.getInstance();

    final existing =
        prefs.getStringList(
              _completedLessonsKey,
            ) ??
            [];

    final completed =
        existing.toSet();

    completed.add(widget.lesson.id);

    await prefs.setStringList(
      _completedLessonsKey,
      completed.toList(),
    );

    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(24),
          ),
          title: const Text(
            'Lesson Complete! 🎉',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'You completed ${widget.lesson.title}.\n\n'
            'Great job! 🐱💜',
            style: const TextStyle(
              height: 1.5,
            ),
          ),
          actions: [
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: lavender,
                foregroundColor: Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lesson.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          20,
          10,
          20,
          110,
        ),
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildExplanation(),
          const SizedBox(height: 22),
          _buildSections(),
          const SizedBox(height: 22),
          _buildExamples(),
          const SizedBox(height: 22),
          _buildQuestions(),
          const SizedBox(height: 22),
          _buildSpeaking(),
          const SizedBox(height: 25),
          _buildCompleteButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.11),
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: lavender.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            widget.lesson.title,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.lesson.titleFa,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: lavender.withOpacity(0.14),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Text(
              widget.lesson.topic,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: lavender,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanation() {
    return _buildCard(
      icon: Icons.menu_book_rounded,
      title: 'Explanation',
      child: Text(
        widget.lesson.explanation,
        style: const TextStyle(
          fontSize: 15,
          height: 1.65,
        ),
      ),
    );
  }

  Widget _buildSections() {
    if (widget.lesson.sections.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Learn',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        ...widget.lesson.sections
            .map(_buildSectionCard),
      ],
    );
  }

  Widget _buildSectionCard(
    A1BasicSection section,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.withOpacity(0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            section.titleFa,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            section.explanation,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
          if (section.examples.isNotEmpty) ...[
            const SizedBox(height: 15),
            ...section.examples.map(
              (example) => _buildExampleTile(
                example,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExamples() {
    if (widget.lesson.examples.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildCard(
      icon: Icons.lightbulb_rounded,
      title: 'Examples',
      child: Column(
        children: List.generate(
          widget.lesson.examples.length,
          (index) {
            final example =
                widget.lesson.examples[index];

            return _buildExampleTile(
              example,
              index: index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildExampleTile(
    A1BasicExample example, {
    int? index,
  }) {
    final completed = index != null &&
        _completedExamples.contains(index);

    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: completed
            ? Colors.green.withOpacity(0.06)
            : lavender.withOpacity(0.06),
        borderRadius:
            BorderRadius.circular(17),
        border: Border.all(
          color: completed
              ? Colors.green.withOpacity(0.18)
              : lavender.withOpacity(0.10),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  example.english,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  example.persian,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                if (example.pronunciation != null &&
                    example.pronunciation!
                        .trim()
                        .isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    example.pronunciation!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle:
                          FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: index == null
                ? () => _speak(
                      example.english,
                    )
                : () => _speak(
                      example.english,
                      audioKey:
                          'example_$index',
                    ),
            icon: Icon(
              completed
                  ? Icons.check_circle_rounded
                  : Icons.volume_up_rounded,
              color: completed
                  ? Colors.green
                  : lavender,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestions() {
    if (widget.lesson.questions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Practice',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          widget.lesson.questions.length,
          (index) => _buildQuestionCard(
            index,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(
    int index,
  ) {
    final question =
        widget.lesson.questions[index];

    final options =
        _optionsFor(index);

    final selected =
        _selectedAnswers[index];

    final answered =
        selected != null;

    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: answered
              ? Colors.green.withOpacity(0.18)
              : lavender.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color:
                      lavender.withOpacity(0.13),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.w800,
                      color: lavender,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          ...List.generate(
            options.length,
            (optionIndex) {
              final option =
                  options[optionIndex];

              final isSelected =
                  selected == optionIndex;

              final isCorrect =
                  option == question.answer;

              Color background;
              Color border;
              Color text;

              if (!answered) {
                background =
                    Theme.of(context)
                        .colorScheme
                        .surface;
                border =
                    Colors.grey.withOpacity(
                  0.14,
                );
                text =
                    Theme.of(context)
                        .colorScheme
                        .onSurface;
              } else if (isCorrect) {
                background =
                    Colors.green.withOpacity(
                  0.10,
                );
                border =
                    Colors.green.withOpacity(
                  0.32,
                );
                text = Colors.green.shade700;
              } else if (isSelected) {
                background =
                    Colors.redAccent
                        .withOpacity(0.10);
                border =
                    Colors.redAccent
                        .withOpacity(0.32);
                text = Colors.redAccent;
              } else {
                background =
                    Theme.of(context)
                        .colorScheme
                        .surface;
                border =
                    Colors.grey.withOpacity(
                  0.10,
                );
                text =
                    Theme.of(context)
                        .colorScheme
                        .onSurface;
              }

              return Container(
                margin:
                    const EdgeInsets.only(
                  bottom: 8,
                ),
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(15),
                  onTap: answered
                      ? null
                      : () => _selectAnswer(
                            index,
                            optionIndex,
                          ),
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 13,
                      vertical: 13,
                    ),
                    decoration:
                        BoxDecoration(
                      color: background,
                      borderRadius:
                          BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        color: border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w600,
                              color: text,
                            ),
                          ),
                        ),
                        if (answered &&
                            isCorrect)
                          const Icon(
                            Icons
                                .check_circle_rounded,
                            color: Colors.green,
                            size: 20,
                          )
                        else if (answered &&
                            isSelected)
                          const Icon(
                            Icons.cancel_rounded,
                            color:
                                Colors.redAccent,
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
              question.explanation != null &&
              question.explanation!
                  .trim()
                  .isNotEmpty) ...[
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color:
                    lavender.withOpacity(0.07),
                borderRadius:
                    BorderRadius.circular(13),
              ),
              child: Text(
                question.explanation!,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSpeaking() {
    if (widget.lesson.speakingQuestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Speaking 🎤',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          widget.lesson.speakingQuestions.length,
          (index) => _buildSpeakingCard(index),
        ),
      ],
    );
  }

  Widget _buildSpeakingCard(
    int index,
  ) {
    final question =
        widget.lesson.speakingQuestions[index];

    final listening =
        _isListening[index] ?? false;

    final recognized =
        _recognizedSpeech[index] ?? '';

    final message =
        _speechMessage[index] ?? '';

    final completed =
        _completedSpeaking.contains(index);

    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: completed
            ? Colors.green.withOpacity(0.06)
            : lavender.withOpacity(0.07),
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: completed
              ? Colors.green.withOpacity(0.18)
              : lavender.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            question.persian,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _speak(
                    question.acceptableAnswers
                            .isNotEmpty
                        ? question
                            .acceptableAnswers
                            .first
                        : question.question,
                  ),
                  icon: const Icon(
                    Icons.volume_up_rounded,
                  ),
                  label:
                      const Text('Listen'),
                  style:
                      OutlinedButton.styleFrom(
                    foregroundColor: lavender,
                    side: BorderSide(
                      color:
                          lavender.withOpacity(
                        0.3,
                      ),
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: completed
                      ? null
                      : listening
                          ? () =>
                              _stopListening(
                                index,
                              )
                          : () =>
                              _startListening(
                                index,
                              ),
                  icon: Icon(
                    listening
                        ? Icons.stop_rounded
                        : Icons.mic_rounded,
                  ),
                  label: Text(
                    listening
                        ? 'Stop'
                        : 'Speak 🎤',
                  ),
                  style:
                      FilledButton.styleFrom(
                    backgroundColor:
                        listening
                            ? Colors.redAccent
                            : lavender,
                    foregroundColor:
                        Colors.white,
                    disabledBackgroundColor:
                        Colors.green
                            .withOpacity(
                      0.18,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (listening) ...[
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(
                  Icons.mic_rounded,
                  size: 16,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 6),
                Text(
                  'Listening...',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.redAccent,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          if (recognized.isNotEmpty) ...[
            const SizedBox(height: 11),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surface,
                borderRadius:
                    BorderRadius.circular(13),
              ),
              child: Text(
                recognized,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ],
          if (message.isNotEmpty) ...[
            const SizedBox(height: 9),
            Text(
              message,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: message
                        .startsWith('Correct')
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
          ],
          if (completed) ...[
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: Colors.green,
                ),
                SizedBox(width: 6),
                Text(
                  'Completed',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCompleteButton() {
    final completed = _lessonCompleted;

    return Column(
      children: [
        if (!completed)
          Container(
            width: double.infinity,
            margin:
                const EdgeInsets.only(bottom: 12),
            padding:
                const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.orange
                  .withOpacity(0.08),
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: const Text(
              'برای کامل کردن درس، مثال‌ها را گوش بده، همه سؤال‌ها را جواب بده و Speaking را انجام بده. 🔒',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: completed
                ? _completeLesson
                : null,
            style: FilledButton.styleFrom(
              backgroundColor: lavender,
              foregroundColor: Colors.white,
              disabledBackgroundColor:
                  lavender.withOpacity(0.18),
              disabledForegroundColor:
                  Colors.white.withOpacity(0.55),
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 17,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),
            ),
            child: Text(
              completed
                  ? 'Complete Lesson 🎉'
                  : 'Complete all activities 🔒',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.withOpacity(0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color:
                      lavender.withOpacity(0.13),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: lavender,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}