import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../data/levels/b1/b1_lesson_01_data.dart';

class B1LessonDetailPage extends StatefulWidget {
  const B1LessonDetailPage({super.key});

  @override
  State<B1LessonDetailPage> createState() => _B1LessonDetailPageState();
}

class _B1LessonDetailPageState extends State<B1LessonDetailPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  static const String progressKey =
      'b1_lesson_progress_b1_lesson_01';

  static const String completedKey =
      'b1_completed_lessons';

  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  final List<TextEditingController> _typingControllers = [];
  final List<TextEditingController> _errorControllers = [];
  final List<TextEditingController> _transformControllers = [];
  final List<TextEditingController> _writingControllers = [];

  int _stage = 0;

  bool _isPersian = true;
  bool _speechAvailable = false;
  bool _isListening = false;

  int? _speakingIndex;

  String _recognizedText = '';

  final Set<int> _vocabularyDone = {};
  final Set<int> _grammarDone = {};
  final Set<int> _grammarCorrect = {};

  final Set<int> _typingDone = {};
  final Set<int> _typingCorrect = {};

  final Set<int> _errorDone = {};
  final Set<int> _errorCorrect = {};

  final Set<int> _transformDone = {};
  final Set<int> _transformCorrect = {};

  final Set<int> _listeningDone = {};
  final Set<int> _listeningCorrect = {};

  final Set<int> _readingDone = {};
  final Set<int> _readingCorrect = {};

  final Set<int> _mixedDone = {};
  final Set<int> _mixedCorrect = {};

  final Set<int> _speakingDone = {};
  final Set<int> _audioPlayed = {};

  bool _writingDone = false;
  bool _challengeDone = false;
  bool _reviewDone = false;

  @override
  void initState() {
    super.initState();

    for (final _ in B1Lesson01Data.typingPractice) {
      _typingControllers.add(TextEditingController());
    }

    for (final _ in B1Lesson01Data.errorCorrection) {
      _errorControllers.add(TextEditingController());
    }

    for (final _ in B1Lesson01Data.transformations) {
      _transformControllers.add(TextEditingController());
    }

    for (final _ in B1Lesson01Data.writing) {
      _writingControllers.add(TextEditingController());
    }

    _initializeTts();
    _initializeSpeech();
    _loadProgress();
  }

  Future<void> _initializeTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);
  }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize(
      onStatus: (status) {
        if (!mounted) return;

        if (status == 'done' || status == 'notListening') {
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

  @override
  void dispose() {
    _tts.stop();
    _speech.stop();

    for (final controller in _typingControllers) {
      controller.dispose();
    }

    for (final controller in _errorControllers) {
      controller.dispose();
    }

    for (final controller in _transformControllers) {
      controller.dispose();
    }

    for (final controller in _writingControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  String _normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll('ي', 'ی')
        .replaceAll('ك', 'ک')
        .replaceAll(RegExp(r'''[.,!?;:'"()\[\]{}]'''), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  bool _matchesAccepted(
    String value,
    List<String> acceptedAnswers,
  ) {
    final normalized = _normalize(value);

    return acceptedAnswers.any(
      (answer) => _normalize(answer) == normalized,
    );
  }

  Future<void> _speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> _loadProgress() async {
    final preferences = await SharedPreferences.getInstance();

    final raw = preferences.getString(progressKey);

    if (raw == null) return;

    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;

      _stage = data['stage'] ?? 0;

      _writingDone = data['writingDone'] == true;
      _challengeDone = data['challengeDone'] == true;
      _reviewDone = data['reviewDone'] == true;

      _restoreSet(data['vocabularyDone'], _vocabularyDone);

      _restoreSet(data['grammarDone'], _grammarDone);
      _restoreSet(data['grammarCorrect'], _grammarCorrect);

      _restoreSet(data['typingDone'], _typingDone);
      _restoreSet(data['typingCorrect'], _typingCorrect);

      _restoreSet(data['errorDone'], _errorDone);
      _restoreSet(data['errorCorrect'], _errorCorrect);

      _restoreSet(data['transformDone'], _transformDone);
      _restoreSet(
        data['transformCorrect'],
        _transformCorrect,
      );

      _restoreSet(data['listeningDone'], _listeningDone);
      _restoreSet(
        data['listeningCorrect'],
        _listeningCorrect,
      );

      _restoreSet(data['readingDone'], _readingDone);
      _restoreSet(
        data['readingCorrect'],
        _readingCorrect,
      );

      _restoreSet(data['mixedDone'], _mixedDone);
      _restoreSet(
        data['mixedCorrect'],
        _mixedCorrect,
      );

      _restoreSet(data['speakingDone'], _speakingDone);
      _restoreSet(data['audioPlayed'], _audioPlayed);

      _restoreText(
        data['typingValues'],
        _typingControllers,
      );

      _restoreText(
        data['errorValues'],
        _errorControllers,
      );

      _restoreText(
        data['transformValues'],
        _transformControllers,
      );

      _restoreText(
        data['writingValues'],
        _writingControllers,
      );

      if (mounted) {
        setState(() {});
      }
    } catch (_) {
      // Ignore corrupted progress and start fresh.
    }
  }

  void _restoreSet(
    dynamic value,
    Set<int> target,
  ) {
    if (value is! List) return;

    target.addAll(
      value
          .whereType<num>()
          .map((number) => number.toInt()),
    );
  }

  void _restoreText(
    dynamic value,
    List<TextEditingController> controllers,
  ) {
    if (value is! List) return;

    for (
      int i = 0;
      i < value.length && i < controllers.length;
      i++
    ) {
      controllers[i].text = value[i].toString();
    }
  }

  Future<void> _saveProgress() async {
    final preferences = await SharedPreferences.getInstance();

    final data = {
      'stage': _stage,

      'writingDone': _writingDone,
      'challengeDone': _challengeDone,
      'reviewDone': _reviewDone,

      'vocabularyDone': _vocabularyDone.toList(),

      'grammarDone': _grammarDone.toList(),
      'grammarCorrect': _grammarCorrect.toList(),

      'typingDone': _typingDone.toList(),
      'typingCorrect': _typingCorrect.toList(),

      'errorDone': _errorDone.toList(),
      'errorCorrect': _errorCorrect.toList(),

      'transformDone': _transformDone.toList(),
      'transformCorrect': _transformCorrect.toList(),

      'listeningDone': _listeningDone.toList(),
      'listeningCorrect': _listeningCorrect.toList(),

      'readingDone': _readingDone.toList(),
      'readingCorrect': _readingCorrect.toList(),

      'mixedDone': _mixedDone.toList(),
      'mixedCorrect': _mixedCorrect.toList(),

      'speakingDone': _speakingDone.toList(),

      'audioPlayed': _audioPlayed.toList(),

      'typingValues':
          _typingControllers.map((e) => e.text).toList(),

      'errorValues':
          _errorControllers.map((e) => e.text).toList(),

      'transformValues':
          _transformControllers.map((e) => e.text).toList(),

      'writingValues':
          _writingControllers.map((e) => e.text).toList(),
    };

    await preferences.setString(
      progressKey,
      jsonEncode(data),
    );
  }

  bool _isStageComplete(int stage) {
    switch (stage) {
      case 0:
        return _vocabularyDone.length ==
            B1Lesson01Data.vocabulary.length;

      case 1:
        return true;

      case 2:
        return true;

      case 3:
        return _grammarDone.length ==
            B1Lesson01Data.grammarPractice.length;

      case 4:
        return _typingDone.length ==
            B1Lesson01Data.typingPractice.length;

      case 5:
        return _errorDone.length ==
            B1Lesson01Data.errorCorrection.length;

      case 6:
        return _transformDone.length ==
            B1Lesson01Data.transformations.length;

      case 7:
        return _listeningDone.length ==
            B1Lesson01Data.listening.length;

      case 8:
        return _readingDone.length ==
            B1Lesson01Data.reading.questions.length;

      case 9:
        return _speakingDone.length ==
            B1Lesson01Data.speaking.length;

      case 10:
        return _writingDone;

      case 11:
        return _mixedDone.length ==
            B1Lesson01Data.mixedPractice.length;

      case 12:
        return _challengeDone;

      case 13:
        return _reviewDone;

      default:
        return false;
    }
  }

  void _nextStage() {
    if (!_isStageComplete(_stage)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isPersian
                ? 'اول این مرحله را کامل کن 😼'
                : 'Complete this stage first 😼',
          ),
        ),
      );
      return;
    }

    if (_stage < 13) {
      setState(() {
        _stage++;
      });

      _saveProgress();
    } else {
      _finishLesson();
    }
  }

  void _previousStage() {
    if (_stage <= 0) return;

    setState(() {
      _stage--;
    });

    _saveProgress();
  }

  Future<void> _finishLesson() async {
    final preferences = await SharedPreferences.getInstance();

    final completed =
        preferences.getStringList(completedKey) ?? [];

    if (!completed.contains(B1Lesson01Data.id)) {
      completed.add(B1Lesson01Data.id);
    }

    await preferences.setStringList(
      completedKey,
      completed,
    );

    await _saveProgress();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isPersian
              ? 'درس با موفقیت کامل شد 🎉'
              : 'Lesson completed 🎉',
        ),
      ),
    );
  }

  void _showFeedback(
    bool correct,
    String explanation,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${correct ? '✓ Correct' : '✗ Not quite'}\n$explanation',
        ),
      ),
    );
  }

  void _answerGrammar(
    int index,
    String answer,
  ) {
    if (_grammarDone.contains(index)) return;

    final question =
        B1Lesson01Data.grammarPractice[index];

    final correct =
        answer == question.correctAnswer;

    _grammarDone.add(index);

    if (correct) {
      _grammarCorrect.add(index);
    }

    _showFeedback(
      correct,
      question.explanationFa,
    );

    _saveProgress();

    setState(() {});
  }

  void _answerTyping(int index) {
    if (_typingDone.contains(index)) return;

    final question =
        B1Lesson01Data.typingPractice[index];

    final correct = _matchesAccepted(
      _typingControllers[index].text,
      question.acceptedAnswers,
    );

    _typingDone.add(index);

    if (correct) {
      _typingCorrect.add(index);
    }

    _showFeedback(
      correct,
      correct
          ? 'درست بود! 👏'
          : 'Answer: ${question.acceptedAnswers.first}',
    );

    _saveProgress();

    setState(() {});
  }

  void _answerErrorCorrection(int index) {
    if (_errorDone.contains(index)) return;

    final question =
        B1Lesson01Data.errorCorrection[index];

    final correct =
        _normalize(_errorControllers[index].text) ==
            _normalize(question.correctSentence);

    _errorDone.add(index);

    if (correct) {
      _errorCorrect.add(index);
    }

    _showFeedback(
      correct,
      '${question.correctSentence}\n'
      '${question.explanationFa}',
    );

    _saveProgress();

    setState(() {});
  }

  void _answerTransformation(int index) {
    if (_transformDone.contains(index)) return;

    final question =
        B1Lesson01Data.transformations[index];

    final answer =
        _normalize(_transformControllers[index].text);

    final expected =
        _normalize(question.answer);

    final correct =
        answer == expected ||
        _isSimilar(answer, expected);

    _transformDone.add(index);

    if (correct) {
      _transformCorrect.add(index);
    }

    _showFeedback(
      correct,
      '${question.answer}\n'
      '${question.answerFa}',
    );

    _saveProgress();

    setState(() {});
  }

  bool _isSimilar(
    String first,
    String second,
  ) {
    if (first.isEmpty || second.isEmpty) {
      return false;
    }

    final firstWords = first.split(' ').toSet();
    final secondWords = second.split(' ').toSet();

    final common =
        firstWords.intersection(secondWords).length;

    return common / secondWords.length >= 0.75;
  }

  void _answerListening(
    int index,
    String answer,
  ) {
    if (_listeningDone.contains(index)) return;

    final question =
        B1Lesson01Data.listening[index];

    final correct =
        answer == question.correctAnswer;

    _listeningDone.add(index);

    if (correct) {
      _listeningCorrect.add(index);
    }

    _showFeedback(
      correct,
      'Answer: ${question.correctAnswer}',
    );

    _saveProgress();

    setState(() {});
  }

  void _answerReading(
    int index,
    String answer,
  ) {
    if (_readingDone.contains(index)) return;

    final question =
        B1Lesson01Data.reading.questions[index];

    final correct =
        answer == question.correctAnswer;

    _readingDone.add(index);

    if (correct) {
      _readingCorrect.add(index);
    }

    _showFeedback(
      correct,
      question.explanationFa,
    );

    _saveProgress();

    setState(() {});
  }

  void _answerMixed(
    int index,
    String answer,
  ) {
    if (_mixedDone.contains(index)) return;

    final question =
        B1Lesson01Data.mixedPractice[index];

    final correct =
        answer == question.correctAnswer;

    _mixedDone.add(index);

    if (correct) {
      _mixedCorrect.add(index);
    }

    _showFeedback(
      correct,
      question.explanationFa,
    );

    _saveProgress();

    setState(() {});
  }

  Future<void> _startSpeaking(
    int index,
  ) async {
    if (!_speechAvailable) {
      _showFeedback(
        false,
        _isPersian
            ? 'تشخیص صدا روی این دستگاه در دسترس نیست.'
            : 'Speech recognition is not available.',
      );
      return;
    }

    if (_isListening) {
      await _speech.stop();

      setState(() {
        _isListening = false;
      });

      return;
    }

    _recognizedText = '';
    _speakingIndex = index;

    setState(() {
      _isListening = true;
    });

    await _speech.listen(
      onResult: (SpeechRecognitionResult result) {
        if (!mounted) return;

        setState(() {
          _recognizedText = result.recognizedWords;
        });

        if (result.finalResult) {
          _finishSpeaking(index);
        }
      },
      localeId: 'en_US',
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 4),
      partialResults: true,
    );
  }

  Future<void> _finishSpeaking(
    int index,
  ) async {
    _isListening = false;

    final words = _normalize(_recognizedText)
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toSet();

    final targetWords = <String>{};

    for (final structure
        in B1Lesson01Data.speaking[index].targetStructures) {
      targetWords.addAll(
        _normalize(structure)
            .split(' ')
            .where((word) => word.isNotEmpty),
      );
    }

    final ratio = targetWords.isEmpty
        ? 0.0
        : targetWords.intersection(words).length /
            targetWords.length;

    if (words.length >= 5 || ratio >= 0.35) {
      _speakingDone.add(index);
    }

    await _saveProgress();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _startChallenge() async {
    if (!_speechAvailable) {
      _showFeedback(
        false,
        'Speech recognition is not available.',
      );
      return;
    }

    if (_isListening) {
      await _speech.stop();

      setState(() {
        _isListening = false;
      });

      return;
    }

    _recognizedText = '';

    setState(() {
      _isListening = true;
    });

    await _speech.listen(
      onResult: (SpeechRecognitionResult result) {
        if (!mounted) return;

        setState(() {
          _recognizedText = result.recognizedWords;
        });

        if (result.finalResult) {
          _isListening = false;

          final words = _recognizedText
              .trim()
              .split(RegExp(r'\s+'))
              .where((word) => word.isNotEmpty)
              .length;

          if (words >= 12) {
            _challengeDone = true;
          }

          _saveProgress();

          setState(() {});
        }
      },
      localeId: 'en_US',
      listenFor: const Duration(seconds: 90),
      pauseFor: const Duration(seconds: 5),
      partialResults: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final stages = [
      ['Vocabulary', 'واژگان'],
      ['Useful Expressions', 'عبارت‌های کاربردی'],
      ['Grammar', 'گرامر'],
      ['Grammar Practice', 'تمرین گرامر'],
      ['Recall Practice', 'تمرین یادآوری'],
      ['Error Correction', 'تصحیح اشتباه'],
      ['Transformation', 'تغییر جمله'],
      ['Listening', 'شنیداری'],
      ['Reading', 'خواندن'],
      ['Speaking', 'مکالمه'],
      ['Writing', 'نوشتن'],
      ['Mixed Practice', 'تمرین ترکیبی'],
      ['Meow Challenge', 'چالش میو'],
      ['Review', 'مرور نهایی'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isPersian
              ? B1Lesson01Data.titleFa
              : B1Lesson01Data.titleEn,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isPersian = !_isPersian;
              });
            },
            icon: const Icon(Icons.translate_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              8,
              16,
              10,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _isPersian
                            ? B1Lesson01Data.topicFa
                            : B1Lesson01Data.topicEn,
                      ),
                    ),
                    Text(
                      '${_stage + 1}/14',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: lavender,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (_stage + 1) / 14,
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(20),
                  color: lavender,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                16,
                4,
                16,
                120,
              ),
              children: [
                Text(
                  _isPersian
                      ? stages[_stage][1]
                      : stages[_stage][0],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isPersian
                      ? 'مرحله ${_stage + 1} از 14'
                      : 'Stage ${_stage + 1} of 14',
                ),
                const SizedBox(height: 12),
                _buildCurrentStage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            12,
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                      _stage == 0 ? null : _previousStage,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                  label: const Text('Previous'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        _isStageComplete(_stage)
                            ? lavender
                            : Colors.grey,
                    foregroundColor: Colors.black,
                  ),
                  onPressed:
                      _isStageComplete(_stage)
                          ? _nextStage
                          : null,
                  icon: Icon(
                    _stage == 13
                        ? Icons.check_rounded
                        : Icons.arrow_forward_rounded,
                  ),
                  label: Text(
                    _stage == 13
                        ? 'Finish lesson'
                        : 'Next',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStage() {
    switch (_stage) {
      case 0:
        return _vocabularyPage();

      case 1:
        return _expressionsPage();

      case 2:
        return _grammarPage();

      case 3:
        return _grammarPracticePage();

      case 4:
        return _typingPracticePage();

      case 5:
        return _errorCorrectionPage();

      case 6:
        return _transformationPage();

      case 7:
        return _listeningPage();

      case 8:
        return _readingPage();

      case 9:
        return _speakingPage();

      case 10:
        return _writingPage();

      case 11:
        return _mixedPracticePage();

      case 12:
        return _challengePage();

      case 13:
        return _reviewPage();

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _vocabularyPage() {
    return Column(
      children: [
        _infoCard(
          _isPersian
              ? 'معنی و کاربرد واژه‌ها را یاد بگیر، بعد خودت آن‌ها را به یاد بیاور.'
              : 'Learn the meaning and usage, then recall the words.',
        ),
        ...List.generate(
          B1Lesson01Data.vocabulary.length,
          (index) {
            final vocabulary =
                B1Lesson01Data.vocabulary[index];

            final done =
                _vocabularyDone.contains(index);

            return _contentCard(
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          vocabulary.word,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            _speak(vocabulary.word),
                        icon: const Icon(
                          Icons.volume_up_rounded,
                        ),
                      ),
                    ],
                  ),
                  Text(vocabulary.pronunciation),
                  const SizedBox(height: 6),
                  Text(
                    vocabulary.meaningFa,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(vocabulary.exampleEn),
                  Text(vocabulary.exampleFa),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: done
                        ? null
                        : () {
                            setState(() {
                              _vocabularyDone.add(index);
                            });
                            _saveProgress();
                          },
                    icon: const Icon(
                      Icons.check_rounded,
                    ),
                    label: Text(
                      done
                          ? 'Recalled ✓'
                          : (_isPersian
                              ? 'بلدم'
                              : 'I know it'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _expressionsPage() {
    return Column(
      children: [
        _infoCard(
          _isPersian
              ? 'این عبارت‌ها را مثل یک جمله آماده برای مکالمه واقعی یاد بگیر.'
              : 'Learn these as ready-to-use real-life expressions.',
        ),
        ...B1Lesson01Data.realEnglish.map(
          (item) => _contentCard(
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.expression,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          _speak(item.expression),
                      icon: const Icon(
                        Icons.volume_up_rounded,
                      ),
                    ),
                  ],
                ),
                Text(
                  item.meaningFa,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(item.usageEn),
                const SizedBox(height: 6),
                Text(
                  item.exampleEn,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(item.exampleFa),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _grammarPage() {
    final grammar = B1Lesson01Data.grammar;

    return Column(
      children: [
        _contentCard(
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                grammar.titleEn,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                grammar.titleFa,
                style: const TextStyle(
                  color: lavender,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(grammar.explanationEn),
              const SizedBox(height: 8),
              Text(grammar.explanationFa),
            ],
          ),
        ),
        _sectionLabel(
          _isPersian ? 'ساختار' : 'Formula',
        ),
        _contentCard(
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: grammar.formulaEn
                .map(
                  (formula) => Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Text(
                      formula,
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        _sectionLabel(
          _isPersian ? 'مثال‌ها' : 'Examples',
        ),
        ...grammar.examples.map(
          (example) => _contentCard(
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        example.english,
                        style: const TextStyle(
                          fontWeight:
                              FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          _speak(example.english),
                      icon: const Icon(
                        Icons.volume_up_rounded,
                      ),
                    ),
                  ],
                ),
                Text(example.persian),
                const SizedBox(height: 5),
                Text(example.explanation),
              ],
            ),
          ),
        ),
        _sectionLabel(
          _isPersian
              ? 'اشتباه‌های رایج'
              : 'Common mistakes',
        ),
        ...grammar.commonMistakes.map(
          (mistake) => _contentCard(
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  '✗ ${mistake.wrong}',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '✓ ${mistake.correct}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(mistake.explanationFa),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _grammarPracticePage() {
    return _multipleChoicePage(
      B1Lesson01Data.grammarPractice,
      _grammarDone,
      (index, answer) =>
          _answerGrammar(index, answer),
    );
  }

  Widget _typingPracticePage() {
    return Column(
      children: [
        _infoCard(
          _isPersian
              ? 'اینجا دیگر گزینه‌ای برای قایم‌شدن نداریم. خودت جواب را تولید کن.'
              : 'No hiding behind multiple-choice options here. Produce the answer yourself.',
        ),
        ...List.generate(
          B1Lesson01Data.typingPractice.length,
          (index) {
            final question =
                B1Lesson01Data.typingPractice[index];

            final done =
                _typingDone.contains(index);

            return _contentCard(
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    question.promptEn,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(question.promptFa),
                  const SizedBox(height: 10),
                  TextField(
                    controller:
                        _typingControllers[index],
                    enabled: !done,
                    textInputAction:
                        TextInputAction.done,
                    onSubmitted: (_) =>
                        _answerTyping(index),
                    decoration:
                        const InputDecoration(
                      border:
                          OutlineInputBorder(),
                      hintText:
                          'Type your answer...',
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: done
                        ? null
                        : () =>
                            _answerTyping(index),
                    child: Text(
                      done
                          ? 'Checked ✓'
                          : 'Check',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _errorCorrectionPage() {
    return Column(
      children: List.generate(
        B1Lesson01Data.errorCorrection.length,
        (index) {
          final question =
              B1Lesson01Data.errorCorrection[index];

          final done =
              _errorDone.contains(index);

          return _contentCard(
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Correct the sentence:',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  question.incorrectSentence,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller:
                      _errorControllers[index],
                  enabled: !done,
                  minLines: 2,
                  maxLines: 4,
                  decoration:
                      const InputDecoration(
                    border:
                        OutlineInputBorder(),
                    hintText:
                        'Write the correct sentence...',
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: done
                      ? null
                      : () =>
                          _answerErrorCorrection(
                            index,
                          ),
                  child: Text(
                    done
                        ? 'Checked ✓'
                        : 'Check',
                  ),
                ),
                if (done)
                  Text(
                    'Answer: ${question.correctSentence}\n'
                    '${question.explanationFa}',
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _transformationPage() {
    return Column(
      children: List.generate(
        B1Lesson01Data.transformations.length,
        (index) {
          final question =
              B1Lesson01Data.transformations[index];

          final done =
              _transformDone.contains(index);

          return _contentCard(
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  question.originalSentence,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(question.instruction),
                const SizedBox(height: 10),
                TextField(
                  controller:
                      _transformControllers[index],
                  enabled: !done,
                  minLines: 2,
                  maxLines: 4,
                  decoration:
                      const InputDecoration(
                    border:
                        OutlineInputBorder(),
                    hintText:
                        'Write your sentence...',
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: done
                      ? null
                      : () =>
                          _answerTransformation(
                            index,
                          ),
                  child: Text(
                    done
                        ? 'Checked ✓'
                        : 'Check',
                  ),
                ),
                if (done)
                  Text(
                    'Answer: ${question.answer}\n'
                    '${question.answerFa}',
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _listeningPage() {
    return Column(
      children: List.generate(
        B1Lesson01Data.listening.length,
        (index) {
          final question =
              B1Lesson01Data.listening[index];

          final played =
              _audioPlayed.contains(index);

          final done =
              _listeningDone.contains(index);

          return _contentCard(
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton.filledTonal(
                      onPressed: () {
                        _audioPlayed.add(index);
                        _saveProgress();
                        _speak(question.audioText);

                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.volume_up_rounded,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      played
                          ? 'Audio played ✓'
                          : 'Play audio',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  question.questionEn,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(question.questionFa),
                const SizedBox(height: 8),
                ...question.options.map(
                  (option) => _optionButton(
                    option,
                    played && !done,
                    () =>
                        _answerListening(
                          index,
                          option,
                        ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _readingPage() {
    final reading = B1Lesson01Data.reading;

    return Column(
      children: [
        _contentCard(
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                reading.titleEn,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                reading.titleFa,
                style: const TextStyle(
                  color: lavender,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                reading.passageEn,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                reading.passageFa,
                style: const TextStyle(
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        _multipleChoicePage(
          reading.questions,
          _readingDone,
          (index, answer) =>
              _answerReading(index, answer),
        ),
      ],
    );
  }

  Widget _speakingPage() {
    return Column(
      children: List.generate(
        B1Lesson01Data.speaking.length,
        (index) {
          final speaking =
              B1Lesson01Data.speaking[index];

          final done =
              _speakingDone.contains(index);

          return _contentCard(
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  speaking.promptEn,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(speaking.promptFa),
                const SizedBox(height: 8),
                Text(
                  'Suggested time: '
                  '${speaking.suggestedTimeSeconds} seconds',
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: speaking.targetStructures
                      .map(
                        (structure) => Chip(
                          label:
                              Text(structure),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  style:
                      FilledButton.styleFrom(
                    backgroundColor: lavender,
                    foregroundColor:
                        Colors.black,
                  ),
                  onPressed: done
                      ? null
                      : () =>
                          _startSpeaking(
                            index,
                          ),
                  icon: Icon(
                    _isListening &&
                            _speakingIndex ==
                                index
                        ? Icons.stop
                        : Icons.mic,
                  ),
                  label: Text(
                    done
                        ? 'Completed ✓'
                        : (_isListening
                            ? 'Listening...'
                            : 'Start speaking'),
                  ),
                ),
                if (_speakingIndex == index &&
                    _recognizedText.isNotEmpty)
                  _recognizedTextBox(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _writingPage() {
    return Column(
      children: List.generate(
        B1Lesson01Data.writing.length,
        (index) {
          final task =
              B1Lesson01Data.writing[index];

          final controller =
              _writingControllers[index];

          final wordCount = controller.text
              .trim()
              .split(RegExp(r'\s+'))
              .where((word) => word.isNotEmpty)
              .length;

          return _contentCard(
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  task.promptEn,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(task.promptFa),
                const SizedBox(height: 10),
                ...task.requirements.map(
                  (requirement) =>
                      Text('• $requirement'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Words: $wordCount',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: controller,
                  minLines: 8,
                  maxLines: 14,
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration:
                      const InputDecoration(
                    border:
                        OutlineInputBorder(),
                    hintText:
                        'Write your paragraph here...',
                  ),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  style:
                      FilledButton.styleFrom(
                    backgroundColor: lavender,
                    foregroundColor:
                        Colors.black,
                  ),
                  onPressed: wordCount >= 20
                      ? () {
                          _writingDone = true;
                          _saveProgress();

                          setState(() {});
                        }
                      : null,
                  child: Text(
                    _writingDone
                        ? 'Writing completed ✓'
                        : 'Complete',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _mixedPracticePage() {
    return _multipleChoicePage(
      B1Lesson01Data.mixedPractice,
      _mixedDone,
      (index, answer) =>
          _answerMixed(index, answer),
    );
  }

  Widget _challengePage() {
    final challenge =
        B1Lesson01Data.challenge;

    return _contentCard(
      Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            challenge.titleEn,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            challenge.titleFa,
            style: const TextStyle(
              color: lavender,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            challenge.promptEn,
            style: const TextStyle(
              fontSize: 17,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            challenge.promptFa,
            style: const TextStyle(
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Suggested time: '
            '${challenge.suggestedTimeSeconds} seconds',
          ),
          const SizedBox(height: 8),
          ...challenge.requirements.map(
            (requirement) =>
                Text('• $requirement'),
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            style:
                FilledButton.styleFrom(
              backgroundColor: lavender,
              foregroundColor: Colors.black,
            ),
            onPressed:
                _challengeDone ? null : _startChallenge,
            icon: Icon(
              _isListening
                  ? Icons.stop
                  : Icons.mic,
            ),
            label: Text(
              _challengeDone
                  ? 'Challenge completed ✓'
                  : (_isListening
                      ? 'Listening...'
                      : 'Start challenge'),
            ),
          ),
          if (_recognizedText.isNotEmpty)
            _recognizedTextBox(),
        ],
      ),
    );
  }

  Widget _reviewPage() {
    final correct =
        _grammarCorrect.length +
        _typingCorrect.length +
        _errorCorrect.length +
        _transformCorrect.length +
        _listeningCorrect.length +
        _readingCorrect.length +
        _mixedCorrect.length;

    final answered =
        _grammarDone.length +
        _typingDone.length +
        _errorDone.length +
        _transformDone.length +
        _listeningDone.length +
        _readingDone.length +
        _mixedDone.length;

    return Column(
      children: [
        _contentCard(
          Column(
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                size: 54,
                color: lavender,
              ),
              const SizedBox(height: 8),
              const Text(
                'Lesson Review',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isPersian
                    ? 'آفرین، درس را تا آخر رساندی.'
                    : 'Nice work. You made it through the lesson.',
              ),
              const SizedBox(height: 15),
              Text(
                '$correct / $answered',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: lavender,
                ),
              ),
              const Text(
                'correct answers',
              ),
            ],
          ),
        ),
        _contentCard(
          const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Key takeaways',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• Present Perfect = life experience / no specific finished time',
              ),
              Text(
                '• Past Simple = specific finished past time',
              ),
              Text(
                '• Have / has + past participle',
              ),
              Text(
                '• Have you ever...? / I have never...',
              ),
            ],
          ),
        ),
        FilledButton(
          style:
              FilledButton.styleFrom(
            backgroundColor: lavender,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            _reviewDone = true;
            _saveProgress();

            setState(() {});
          },
          child: Text(
            _reviewDone
                ? 'Review completed ✓'
                : 'Complete review',
          ),
        ),
      ],
    );
  }

  Widget _multipleChoicePage(
    List<B1Question> questions,
    Set<int> completed,
    void Function(int, String) onAnswer,
  ) {
    return Column(
      children: List.generate(
        questions.length,
        (index) {
          final question = questions[index];

          return _contentCard(
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. ${question.question}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                ...question.options.map(
                  (option) => _optionButton(
                    option,
                    !completed.contains(index),
                    () =>
                        onAnswer(index, option),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _optionButton(
    String text,
    bool enabled,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 7,
      ),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed:
              enabled ? onPressed : null,
          style:
              OutlinedButton.styleFrom(
            alignment:
                Alignment.centerLeft,
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  Widget _recognizedTextBox() {
    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.12),
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Text(
        'You said: $_recognizedText',
      ),
    );
  }

  Widget _contentCard(Widget child) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 12),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _infoCard(String text) {
    return _contentCard(
      Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline_rounded,
            color: lavender,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        4,
        6,
        4,
        6,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}