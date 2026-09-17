import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/levels/a1/basics/a1_basics_models.dart';
import '../data/levels/a1/basics/a1_basics_ui_config.dart';
import '../localization.dart';

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
  final stt.SpeechToText _speech =
      stt.SpeechToText();

  final Set<int> _answeredQuestions = {};
  final Set<int> _completedSpeaking = {};
  final Set<int> _listenedExamples = {};

  final Map<int, String> _selectedAnswers = {};
  final Map<int, String> _typedAnswers = {};
  final Map<int, bool> _typingResults = {};
  final Map<int, bool> _speakingResults = {};

  final Map<int, TextEditingController>
      _answerControllers = {};

  late List<A1BasicQuestion> _questions;
  late final List<_A1Stage> _stages;

  bool _speechAvailable = false;
  bool _isListening = false;

  bool _learningMode = true;

  int? _currentSpeakingIndex;
  String _recognizedText = '';

  int _currentStage = 0;

  bool get _isPersian =>
      MeowLocalizations.of(context).isPersian;

  Color get _surface =>
      Theme.of(context).colorScheme.surface;

  Color get _outline =>
      Theme.of(context)
          .colorScheme
          .outline
          .withAlpha(36);

  String get progressKey =>
      'a1_basics_lesson_progress${widget.lesson.id}';

  String get stageKey =>
      'a1_basics_stage${widget.lesson.id}';

  @override
  void initState() {
    super.initState();

    _questions = List<A1BasicQuestion>.from(
      widget.lesson.questions,
    );

    _stages = _buildStages();

    _initSpeech();
    _initTts();
    _loadProgress();
  }

  // =========================================================
  // STAGES
  // =========================================================

  List<_A1Stage> _buildStages() {
    switch (widget.lesson.id) {
      case 'a1_01':
      case 'lesson_1':
      case '1':
        return [
          _stage('Stage 1', 'مرحله ۱', [0, 1, 12]),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [2, 3, 7, 8, 17, 18, 22],
          ),
          _stage('Stage 3', 'مرحله ۳', [4, 9]),
          _stage(
            'Stage 4',
            'مرحله ۴',
            [5, 6, 10, 11, 19, 20, 41, 42],
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            [21, 23, 24, 25, 26, 27, 28, 29],
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            [13, 14, 15, 16, 30, 31, 32, 33, 34],
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            [35, 36, 37, 38, 39, 40],
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_02':
      case 'lesson_2':
      case '2':
        return [
          _stage('Stage 1', 'مرحله ۱', [0, 7]),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [1, 4, 6, 8],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [2, 3, 5, 9],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            [10, 11, 12],
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            [13, 14, 15],
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            [16, 17, 18],
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            [19, 20, 21, 22],
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            [23, 24, 25, 26, 27],
          ),
          _stage(
            'Stage 9',
            'مرحله ۹',
            List.generate(
              11,
              (i) => i + 28,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_03':
      case 'lesson_3':
      case '3':
        return [
          _stage(
            'Stage 1',
            'مرحله ۱',
            [0, 2, 4, 6, 7, 9],
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [1, 3, 5, 8],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [10, 11],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            [12, 13, 14],
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            [15, 16, 17, 18],
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            [19, 20, 21, 22, 23],
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            [24, 25, 26, 27],
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            List.generate(
              10,
              (i) => i + 28,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_04':
      case 'lesson_4':
      case '4':
        return [
          _stage(
            'Stage 1',
            'مرحله ۱',
            [0, 2, 4],
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [1, 3, 5],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [6, 7, 8, 9],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            [10, 11, 12, 13],
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            [14, 15, 16, 17],
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            [18, 19, 20, 21, 22, 23],
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            [24, 25, 26, 27],
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            List.generate(
              11,
              (i) => i + 28,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_05':
      case 'lesson_5':
      case '5':
        return [
          _stage(
            'Stage 1',
            'مرحله ۱',
            [0, 2, 7],
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [1, 3, 5, 9],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [4, 6, 8],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            [10, 11, 12],
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            [13, 14, 15, 16, 17],
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            [18, 19, 20, 21, 22, 23],
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            [24, 25, 26, 27, 28],
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            List.generate(
              10,
              (i) => i + 29,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_06':
      case 'lesson_6':
      case '6':
        return [
          _stage(
            'Stage 1',
            'مرحله ۱',
            [0, 1, 2, 3],
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [4, 5, 6, 7],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [8, 9, 10, 11],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            [12, 13, 14, 15],
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            [16, 17, 18, 19, 20],
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            [21, 22, 23, 24, 25],
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            [26, 27, 28, 29],
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            [30, 31, 32, 33, 34, 35],
          ),
          _stage(
            'Stage 9',
            'مرحله ۹',
            [36, 37, 38, 39, 40, 41, 42, 43],
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_07':
      case 'lesson_7':
      case '7':
        return [
          _stage(
            'Stage 1',
            'مرحله ۱',
            List.generate(
              6,
              (i) => i,
            ),
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [6, 7],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            List.generate(
              6,
              (i) => i + 8,
            ),
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            List.generate(
              9,
              (i) => i + 14,
            ),
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            List.generate(
              6,
              (i) => i + 23,
            ),
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            List.generate(
              5,
              (i) => i + 29,
            ),
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            [34, 35, 36],
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            [37, 38, 39],
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_08':
      case 'lesson_8':
      case '8':
        return [
          _stage(
            'Stage 1',
            'مرحله ۱',
            List.generate(
              6,
              (i) => i,
            ),
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [6, 7],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [8, 9],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            List.generate(
              9,
              (i) => i + 10,
            ),
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            List.generate(
              6,
              (i) => i + 19,
            ),
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            List.generate(
              5,
              (i) => i + 25,
            ),
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            [30, 31, 32, 33],
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            List.generate(
              6,
              (i) => i + 34,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_09':
      case 'lesson_9':
      case '9':
        return [
          _stage(
            'Stage 1',
            'مرحله ۱',
            [0, 5, 10],
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [1, 2, 6, 7, 11],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [3, 4, 8, 9, 12, 13],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            List.generate(
              5,
              (i) => i + 14,
            ),
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            List.generate(
              5,
              (i) => i + 19,
            ),
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            List.generate(
              6,
              (i) => i + 24,
            ),
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            List.generate(
              10,
              (i) => i + 30,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_10':
      case 'lesson_10':
      case '10':
        return [
          _stage(
            'Stage 1',
            'مرحله ۱',
            [0, 1, 7, 8],
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [2, 3, 11, 12],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [4, 5, 13, 14, 18],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            [6, 15],
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            [
              9,
              10,
              16,
              17,
              19,
              20,
              21,
              22,
              23,
              24,
            ],
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            List.generate(
              5,
              (i) => i + 25,
            ),
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            List.generate(
              5,
              (i) => i + 30,
            ),
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            List.generate(
              5,
              (i) => i + 35,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_11':
      case 'lesson_11':
      case '11':
        return [
          _stage(
            'What Is the Present Simple?',
            'Present Simple چیست؟',
            [33],
          ),
          _stage(
            'I, You, We, They',
            'I, You, We, They',
            [0, 3, 5, 7, 10],
          ),
          _stage(
            'He, She, It',
            'He, She, It',
            [2, 4],
          ),
          _stage(
            'Adding -s',
            'اضافه کردن s',
            [8],
          ),
          _stage(
            'Adding -es',
            'اضافه کردن es',
            [6, 9, 11],
          ),
          _stage(
            'The -y to -ies Rule',
            'قانون تبدیل y به ies',
            [1, 27],
          ),
          _stage(
            'Positive Sentences',
            'جمله‌های مثبت',
            [24, 34],
          ),
          _stage(
            'Negative Sentences',
            'جمله‌های منفی',
            [12, 13, 14, 15, 26, 37],
          ),
          _stage(
            'Do and Does in Questions',
            'سؤال با Do و Does',
            [16, 17, 18, 19],
          ),
          _stage(
            'Common Mistakes',
            'اشتباهات رایج',
            [20, 21, 22, 23, 25, 35, 36],
          ),
          _stage(
            'Adverbs of Frequency',
            'قیدهای تکرار',
            [28, 29, 30, 31, 32],
          ),
          _stage(
            'Real-Life Present Simple',
            'Present Simple در انگلیسی واقعی',
            [38, 39, 40, 41, 42, 43, 44, 45, 46],
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      default:
        return _buildGenericStages(
          _questions.length,
          widget.lesson.speakingQuestions.length,
        );
    }
  }

  _A1Stage _stage(
    String title,
    String titleFa,
    List<int> questions,
  ) {
    return _A1Stage(
      title: title,
      titleFa: titleFa,
      description:
          'Learn this part and then complete its exercises.',
      descriptionFa:
          'این بخش را یاد بگیر و بعد تمرین‌های آن را انجام بده.',
      questionIndices: questions,
    );
  }

  _A1Stage _speakingStage(
    String title,
    String titleFa,
  ) {
    return _A1Stage(
      title: title,
      titleFa: titleFa,
      description:
          'Answer the questions using your voice.',
      descriptionFa:
          'با صدای خودت به سؤال‌ها پاسخ بده.',
      speakingIndices: List.generate(
        widget.lesson.speakingQuestions.length,
        (index) => index,
      ),
    );
  }

  List<_A1Stage> _buildGenericStages(
    int totalQuestions,
    int totalSpeaking,
  ) {
    if (totalQuestions == 0 && totalSpeaking == 0) {
      return [];
    }

    final stages = <_A1Stage>[];

    const stageCount = 5;

    for (int i = 0; i < stageCount; i++) {
      final start =
          ((totalQuestions * i) / stageCount).floor();

      final end =
          ((totalQuestions * (i + 1)) / stageCount)
              .floor();

      if (start == end && totalQuestions > 0) {
        continue;
      }

      stages.add(
        _A1Stage(
          title: 'Stage ${i + 1}',
          titleFa: 'مرحله ${i + 1}',
          description:
              'Learn this part and complete the exercises.',
          descriptionFa:
              'مفهوم این بخش را یاد بگیر و سپس تمرین‌ها را انجام بده.',
          questionIndices: List.generate(
            end - start,
            (index) => start + index,
          ),
        ),
      );
    }

    if (totalSpeaking > 0) {
      stages.add(
        _A1Stage(
          title: 'Speaking',
          titleFa: 'تمرین مکالمه',
          description:
              'Answer the questions using your voice.',
          descriptionFa:
              'با صدای خودت به سؤال‌ها پاسخ بده.',
          speakingIndices: List.generate(
            totalSpeaking,
            (index) => index,
          ),
        ),
      );
    }

    return stages;
  }

  // =========================================================
  // SECTION
  // =========================================================

  A1BasicSection? _getCurrentSection() {
    if (widget.lesson.sections.isEmpty ||
        _stages.isEmpty) {
      return null;
    }

    final stage = _stages[_currentStage];

    final normalizedStageTitle =
        _normalizeTitle(stage.title);

    final normalizedStageTitleFa =
        _normalizeTitle(stage.titleFa);

    for (final section in widget.lesson.sections) {
      if (_normalizeTitle(section.title) ==
              normalizedStageTitle ||
          _normalizeTitle(section.titleFa) ==
              normalizedStageTitleFa) {
        return section;
      }
    }

    if (_currentStage <
        widget.lesson.sections.length) {
      return widget.lesson.sections[_currentStage];
    }

    return null;
  }

  String _normalizeTitle(String value) {
    return value
        .toLowerCase()
        .replaceAll(
          RegExp(r'[^a-zA-Z0-9آ-ی]'),
          '',
        );
  }

  // =========================================================
  // TTS
  // =========================================================

  Future<void> _initTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);
  }

  Future<void> _speak(String text) async {
    if (!A1BasicsUIConfig.enableTextToSpeech) {
      return;
    }

    await _tts.stop();
    await _tts.speak(text);
  }

  // =========================================================
  // SPEECH
  // =========================================================

  Future<void> _initSpeech() async {
    _speechAvailable = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' ||
            status == 'notListening') {
          if (mounted) {
            setState(() {
              _isListening = false;
            });
          }
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

  Future<void> _startListening(int index) async {
    if (!_speechAvailable) {
      return;
    }

    if (_completedSpeaking.contains(index) &&
        !A1BasicsUIConfig.allowSpeakingRetry) {
      return;
    }

    await _speech.stop();

    setState(() {
      _currentSpeakingIndex = index;
      _recognizedText = '';
      _isListening = true;
    });

    await _speech.listen(
      onResult: _onSpeechResult,
      localeId: 'en_US',
      listenMode: stt.ListenMode.dictation,
      partialResults: true,
      listenFor: const Duration(seconds: 12),
      pauseFor: const Duration(seconds: 3),
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

  void _onSpeechResult(
    SpeechRecognitionResult result,
  ) {
    if (!mounted) {
      return;
    }

    setState(() {
      _recognizedText = result.recognizedWords;
    });

    if (result.finalResult &&
        _currentSpeakingIndex != null) {
      _checkSpeakingAnswer(
        _currentSpeakingIndex!,
        result.recognizedWords,
      );
    }
  }

  void _checkSpeakingAnswer(
    int index,
    String spokenText,
  ) {
    final text = _normalize(spokenText);

    if (text.isEmpty) {
      return;
    }

    final speaking =
        widget.lesson.speakingQuestions[index];

    double bestSimilarity = 0;

    for (final answer
        in speaking.acceptableAnswers) {
      final similarity = _similarity(
        text,
        _normalize(answer),
      );

      bestSimilarity =
          max(bestSimilarity, similarity);
    }

    final correct =
        bestSimilarity >= 0.78;

    if (A1BasicsUIConfig
        .speakingAttemptCountsAsComplete) {
      _completedSpeaking.add(index);
    } else if (correct) {
      _completedSpeaking.add(index);
    }

    _speakingResults[index] = correct;
    _isListening = false;

    setState(() {});

    _saveProgress();

    if (A1BasicsUIConfig.showSpeakingResult) {
      _showSpeakingResult(
        correct,
        speaking.acceptableAnswers.first,
      );
    }
  }

  void _showSpeakingResult(
    bool correct,
    String suggestedAnswer,
  ) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          correct
              ? (_isPersian
                  ? 'درست گفتی 😼✨'
                  : 'Correct! 😼✨')
              : (_isPersian
                  ? 'تقریباً! جمله پیشنهادی: $suggestedAnswer'
                  : 'Almost! Suggested answer: $suggestedAnswer'),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =========================================================
  // ANSWER NORMALIZATION
  // =========================================================

  String _normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll('ي', 'ی')
        .replaceAll('ى', 'ی')
        .replaceAll('ك', 'ک')
        .replaceAll('\u200c', ' ')
        .replaceAll('\u200f', '')
        .replaceAll('\u200e', '')
        .replaceAll(
          RegExp(r'[^\w\sآ-ی]'),
          '',
        )
        .replaceAll(
          RegExp(r'\s+'),
          ' ',
        )
        .trim();
  }

  bool _isAnswerCorrect(
    A1BasicQuestion question,
    String userAnswer,
  ) {
    final normalizedUser =
        _normalize(userAnswer);

    if (normalizedUser.isEmpty) {
      return false;
    }

    for (final accepted
        in question.allAcceptedAnswers) {
      if (_normalize(accepted) ==
          normalizedUser) {
        return true;
      }
    }

    return false;
  }

  double _similarity(String a, String b) {
    if (a.isEmpty || b.isEmpty) {
      return 0;
    }

    if (a == b) {
      return 1;
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
      (i) => i,
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

      for (int j = 0;
          j <= b.length;
          j++) {
        previous[j] = current[j];
      }
    }

    return previous[b.length];
  }

  // =========================================================
  // CONTROLLERS
  // =========================================================

  TextEditingController _controllerFor(
    int index,
  ) {
    return _answerControllers.putIfAbsent(
      index,
      () {
        final controller =
            TextEditingController(
          text: _typedAnswers[index] ?? '',
        );

        controller.addListener(() {
          _typedAnswers[index] =
              controller.text;
        });

        return controller;
      },
    );
  }

  // =========================================================
  // PROGRESS LOAD / SAVE
  // =========================================================

  Future<void> _loadProgress() async {
    if (!A1BasicsUIConfig.saveProgress ||
        !A1BasicsUIConfig.allowResume ||
        _stages.isEmpty) {
      return;
    }

    final prefs =
        await SharedPreferences.getInstance();

    final oldStage =
        prefs.getInt(stageKey) ?? 0;

    final raw =
        prefs.getString(progressKey);

    if (raw == null || raw.isEmpty) {
      if (!mounted) {
        return;
      }

      setState(() {
        _currentStage = oldStage
            .clamp(
              0,
              _stages.length - 1,
            )
            .toInt();

        _learningMode =
            A1BasicsUIConfig
                .teachBeforePractice;
      });

      return;
    }

    try {
      final data = jsonDecode(raw);

      if (data is! Map) {
        return;
      }

      final stage =
          data['currentStage'];

      final learning =
          data['learningMode'];

      final answered =
          data['answeredQuestions'];

      final selected =
          data['selectedAnswers'];

      final typed =
          data['typedAnswers'];

      final typingResults =
          data['typingResults'];

      final completedSpeaking =
          data['completedSpeaking'];

      final speakingResults =
          data['speakingResults'];

      final listenedExamples =
          data['listenedExamples'];

      if (!mounted) {
        return;
      }

      setState(() {
        if (stage is num) {
          _currentStage = stage
              .toInt()
              .clamp(
                0,
                _stages.length - 1,
              );
        } else {
          _currentStage = oldStage
              .clamp(
                0,
                _stages.length - 1,
              )
              .toInt();
        }

        if (learning is bool) {
          _learningMode = learning;
        } else {
          _learningMode =
              A1BasicsUIConfig
                  .teachBeforePractice;
        }

        _answeredQuestions.clear();

        if (answered is List) {
          for (final value in answered) {
            if (value is num) {
              _answeredQuestions
                  .add(value.toInt());
            }
          }
        }

        _selectedAnswers.clear();

        if (selected is Map) {
          selected.forEach(
            (key, value) {
              final index =
                  int.tryParse(
                key.toString(),
              );

              if (index != null &&
                  value is String) {
                _selectedAnswers[index] =
                    value;
              }
            },
          );
        }

        _typedAnswers.clear();

        if (typed is Map) {
          typed.forEach(
            (key, value) {
              final index =
                  int.tryParse(
                key.toString(),
              );

              if (index != null &&
                  value is String) {
                _typedAnswers[index] =
                    value;

                final controller =
                    _answerControllers
                        .putIfAbsent(
                  index,
                  () =>
                      TextEditingController(),
                );

                controller.text = value;
              }
            },
          );
        }

        _typingResults.clear();

        if (typingResults is Map) {
          typingResults.forEach(
            (key, value) {
              final index =
                  int.tryParse(
                key.toString(),
              );

              if (index != null &&
                  value is bool) {
                _typingResults[index] =
                    value;
              }
            },
          );
        }

        _completedSpeaking.clear();

        if (completedSpeaking is List) {
          for (final value
              in completedSpeaking) {
            if (value is num) {
              _completedSpeaking
                  .add(value.toInt());
            }
          }
        }

        _speakingResults.clear();

        if (speakingResults is Map) {
          speakingResults.forEach(
            (key, value) {
              final index =
                  int.tryParse(
                key.toString(),
              );

              if (index != null &&
                  value is bool) {
                _speakingResults[index] =
                    value;
              }
            },
          );
        }

        _listenedExamples.clear();

        if (listenedExamples is List) {
          for (final value
              in listenedExamples) {
            if (value is num) {
              _listenedExamples
                  .add(value.toInt());
            }
          }
        }
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _currentStage = oldStage
            .clamp(
              0,
              _stages.length - 1,
            )
            .toInt();

        _learningMode =
            A1BasicsUIConfig
                .teachBeforePractice;
      });
    }
  }

  Future<void> _saveProgress() async {
    if (!A1BasicsUIConfig.saveProgress) {
      return;
    }

    final prefs =
        await SharedPreferences.getInstance();

    final data = <String, dynamic>{
      'currentStage': _currentStage,
      'learningMode': _learningMode,

      'answeredQuestions':
          _answeredQuestions.toList(),

      'selectedAnswers':
          _selectedAnswers.map(
        (key, value) =>
            MapEntry(
          key.toString(),
          value,
        ),
      ),

      'typedAnswers':
          _typedAnswers.map(
        (key, value) =>
            MapEntry(
          key.toString(),
          value,
        ),
      ),

      'typingResults':
          _typingResults.map(
        (key, value) =>
            MapEntry(
          key.toString(),
          value,
        ),
      ),

      'completedSpeaking':
          _completedSpeaking.toList(),

      'speakingResults':
          _speakingResults.map(
        (key, value) =>
            MapEntry(
          key.toString(),
          value,
        ),
      ),

      'listenedExamples':
          _listenedExamples.toList(),
    };

    await prefs.setString(
      progressKey,
      jsonEncode(data),
    );

    await prefs.setInt(
      stageKey,
      _currentStage,
    );
  }

  Future<void> _saveStage(
    int stage,
  ) async {
    if (!A1BasicsUIConfig.saveProgress) {
      return;
    }

    await _saveProgress();
  }

  // =========================================================
  // LEARNING
  // =========================================================

  String _localizedSectionDescription(
    A1BasicSection? section,
  ) {
    if (section != null) {
      return _isPersian
          ? section.explanationFa
          : section.explanation;
    }

    return _isPersian
        ? _stages[_currentStage].descriptionFa
        : _stages[_currentStage].description;
  }

  Widget _buildLearningContent() {
    final section =
        _getCurrentSection();

    final examples =
        section != null &&
                section.examples.isNotEmpty
            ? section.examples
            : widget.lesson.examples
                .take(5)
                .toList();

    final sectionTitle =
        section == null
            ? (_isPersian
                ? _stages[_currentStage]
                    .titleFa
                : _stages[_currentStage]
                    .title)
            : (_isPersian
                ? section.titleFa
                : section.title);

    final sectionDescription =
        _localizedSectionDescription(section);

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle(
          sectionTitle,
          sectionDescription,
        ),
        SizedBox(
          height:
              A1BasicsUIConfig
                  .sectionSpacing,
        ),
        if (A1BasicsUIConfig
                .showExamplesBeforeQuestions &&
            examples.isNotEmpty) ...[
          Text(
            _isPersian
                ? 'مثال‌ها'
                : 'Examples',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                  fontWeight:
                      FontWeight.bold,
                ),
          ),
          SizedBox(
            height:
                A1BasicsUIConfig
                    .cardSpacing,
          ),
          ...examples.map(
            _buildExample,
          ),
          SizedBox(
            height:
                A1BasicsUIConfig
                    .sectionSpacing,
          ),
        ],
        if (A1BasicsUIConfig
            .showFeedbackAfterAnswer)
          _buildInfoCard(),
        SizedBox(
          height:
              A1BasicsUIConfig
                  .sectionSpacing,
        ),
        FilledButton(
          onPressed:
              _startPractice,
          style:
              FilledButton.styleFrom(
            backgroundColor:
                lavender,
            foregroundColor:
                Colors.black87,
            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                A1BasicsUIConfig
                    .buttonRadius,
              ),
            ),
          ),
          child: Text(
            _isPersian
                ? 'شروع تمرین'
                : 'Start Practice',
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(
        A1BasicsUIConfig.pagePadding,
      ),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: _outline,
        ),
      ),
      child: Text(
        _isPersian
            ? 'اول مفهوم را یاد بگیر و مثال‌ها را ببین. '
                'بعد وارد تمرین می‌شویم. '
                'اینجا قرار نیست با یک جواب غلط از زندگی اخراجت کنیم 😼'
            : 'Learn the concept and review the examples first. '
                'Then move on to practice. '
                'One wrong answer will not end civilization. 😼',
        style: const TextStyle(
          height: 1.5,
        ),
      ),
    );
  }

  Future<void> _startPractice() async {
    setState(() {
      _learningMode = false;
    });

    await _saveProgress();
  }

  Widget _buildSectionTitle(
    String title,
    String description,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: _outline,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(
                  fontWeight:
                      FontWeight.bold,
                  letterSpacing: -0.4,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
                  height: 1.45,
                ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // QUESTIONS
  // =========================================================

  Widget _buildQuestion(
    int index,
  ) {
    final question =
        _questions[index];

    switch (question.type) {
      case 'typing':
        return _buildTypingQuestion(
          index,
          question,
        );

      case 'fillInTheBlank':
        return _buildFillInTheBlankQuestion(
          index,
          question,
        );

      case 'multipleChoice':
      default:
        return _buildMultipleChoiceQuestion(
          index,
          question,
        );
    }
  }

  // =========================================================
  // MULTIPLE CHOICE
  // =========================================================

  Widget _buildMultipleChoiceQuestion(
    int index,
    A1BasicQuestion question,
  ) {
    final answered =
        _answeredQuestions.contains(index);

    final selected =
        _selectedAnswers[index];

    final isCorrect =
        selected != null &&
        _isAnswerCorrect(
          question,
          selected,
        );

    return Container(
      margin: EdgeInsets.only(
        bottom:
            A1BasicsUIConfig
                .cardSpacing,
      ),
      padding: EdgeInsets.all(
        A1BasicsUIConfig.pagePadding,
      ),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: answered
              ? (isCorrect
                  ? Colors.green
                      .withAlpha(55)
                  : Colors.red
                      .withAlpha(45))
              : _outline,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  question.question,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                ),
              ),
              if (A1BasicsUIConfig
                  .enableTextToSpeech)
                IconButton(
                  tooltip: _isPersian
                      ? 'تلفظ'
                      : 'Listen',
                  onPressed: () =>
                      _speak(
                    question.question,
                  ),
                  icon: const Icon(
                    Icons
                        .volume_up_rounded,
                  ),
                ),
            ],
          ),
          SizedBox(
            height:
                A1BasicsUIConfig
                    .cardSpacing,
          ),
          if (question.hint != null &&
              question.hint!.trim().isNotEmpty) ...[
            Text(
              _isPersian ? 'معنی' : 'Meaning',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(
                    color: lavender,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              question.hint!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(height: 1.45),
            ),
            SizedBox(
              height: A1BasicsUIConfig.cardSpacing,
            ),
          ],
          ...(List<String>.from(question.options)..shuffle()).map(
            (option) {
              final selectedThis =
                  selected == option;

              final correctOption =
                  _isAnswerCorrect(
                question,
                option,
              );

              final showCorrect =
                  answered &&
                      A1BasicsUIConfig
                          .showCorrectAnswerAfterMistake &&
                      correctOption;

              return Padding(
                padding:
                    EdgeInsets.only(
                  bottom:
                      A1BasicsUIConfig
                          .cardSpacing,
                ),
                child:
                    OutlinedButton(
                  // اولین انتخاب نهایی است، چه درست باشد چه غلط.
                  onPressed:
                      answered
                          ? null
                          : () =>
                              _answerQuestion(
                                index,
                                option,
                              ),
                  style:
                      OutlinedButton
                          .styleFrom(
                    alignment:
                        AlignmentDirectional
                            .centerStart,
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    side: BorderSide(
                      color:
                          showCorrect
                              ? Colors
                                  .green
                              : selectedThis
                                  ? lavender
                                  : Theme.of(
                                      context,
                                    )
                                      .colorScheme
                                      .outline,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        16,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option,
                        ),
                      ),
                      if (showCorrect)
                        const Icon(
                          Icons
                              .check_circle,
                          color:
                              Colors.green,
                        )
                      else if (selectedThis)
                        Icon(
                          isCorrect
                              ? Icons
                                  .check_circle
                              : Icons.cancel,
                          color:
                              isCorrect
                                  ? Colors
                                      .green
                                  : Colors
                                      .red,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (answered &&
              A1BasicsUIConfig
                  .showFeedbackAfterAnswer)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 4,
              ),
              child: Text(
                isCorrect
                    ? (_isPersian
                        ? 'درست! 😼✨'
                        : 'Correct! 😼✨')
                    : (_isPersian
                        ? 'جواب صحیح: ${question.answer}'
                        : 'Correct answer: ${question.answer}'),
                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  color: isCorrect
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          if (answered &&
              A1BasicsUIConfig
                  .showQuestionExplanation &&
              question.explanation !=
                  null &&
              question.explanation!
                  .trim()
                  .isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 12,
              ),
              child: Text(
                question.explanation!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _answerQuestion(
    int index,
    String answer,
  ) async {
    final question =
        _questions[index];

    final correct =
        _isAnswerCorrect(
      question,
      answer,
    );

    setState(() {
      _selectedAnswers[index] =
          answer;

      _answeredQuestions.add(index);
    });

    await _saveProgress();

    if (!correct &&
        A1BasicsUIConfig
            .showCorrectAnswerAfterMistake) {
      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            _isPersian
                ? 'جواب صحیح: ${question.answer}'
                : 'Correct answer: ${question.answer}',
          ),
          behavior:
              SnackBarBehavior.floating,
        ),
      );
    }
  }

  // =========================================================
  // TYPING
  // =========================================================

  Widget _buildTypingQuestion(
    int index,
    A1BasicQuestion question,
  ) {
    final answered =
        _answeredQuestions.contains(index);

    final result =
        _typingResults[index];

    final controller =
        _controllerFor(index);

    return Container(
      margin: EdgeInsets.only(
        bottom:
            A1BasicsUIConfig
                .cardSpacing,
      ),
      padding: EdgeInsets.all(
        A1BasicsUIConfig.pagePadding,
      ),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: !answered
              ? _outline
              : result == true
                  ? Colors.green
                      .withAlpha(55)
                  : Colors.red
                      .withAlpha(45),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          _buildQuestionHeader(
            question.question,
            allowTts: true,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            enabled: !answered ||
                (result == false &&
                    A1BasicsUIConfig
                        .allowRetry),
            textInputAction:
                TextInputAction.done,
            onChanged: (value) {
              _typedAnswers[index] =
                  value;
            },
            onSubmitted: (_) =>
                _submitTypedAnswer(
              index,
            ),
            decoration:
                InputDecoration(
              hintText: _isPersian
                  ? 'جوابت را بنویس...'
                  : 'Type your answer...',
              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),
              focusedBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
                borderSide:
                    const BorderSide(
                  color: lavender,
                  width: 2,
                ),
              ),
            ),
          ),
          if (question.hint != null &&
              question.hint!
                  .trim()
                  .isNotEmpty &&
              !answered)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                question.hint!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall,
              ),
            ),
          const SizedBox(height: 14),
          if (!answered ||
              (result == false &&
                  A1BasicsUIConfig
                      .allowRetry))
            FilledButton.icon(
              onPressed: () =>
                  _submitTypedAnswer(
                index,
              ),
              icon: const Icon(
                Icons.check_rounded,
              ),
              label: Text(
                _isPersian
                    ? 'بررسی جواب'
                    : 'Check Answer',
              ),
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    lavender,
                foregroundColor:
                    Colors.black87,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    A1BasicsUIConfig
                        .buttonRadius,
                  ),
                ),
              ),
            ),
          if (answered)
            _buildTypingFeedback(
              question,
              result == true,
            ),
        ],
      ),
    );
  }

  Future<void> _submitTypedAnswer(
    int index,
  ) async {
    final question =
        _questions[index];

    final controller =
        _controllerFor(index);

    final answer =
        controller.text.trim();

    if (answer.isEmpty) {
      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            _isPersian
                ? 'اول جوابت رو بنویس 😼'
                : 'Type an answer first 😼',
          ),
          behavior:
              SnackBarBehavior.floating,
        ),
      );

      return;
    }

    final correct =
        _isAnswerCorrect(
      question,
      answer,
    );

    setState(() {
      _typedAnswers[index] =
          answer;

      _typingResults[index] =
          correct;

      _answeredQuestions.add(index);
    });

    await _saveProgress();

    if (!correct &&
        A1BasicsUIConfig
            .showCorrectAnswerAfterMistake) {
      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            _isPersian
                ? 'جواب درست: ${question.answer}'
                : 'Correct answer: ${question.answer}',
          ),
          behavior:
              SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildTypingFeedback(
    A1BasicQuestion question,
    bool correct,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top: 14,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Text(
            correct
                ? (_isPersian
                    ? 'درست! 😼✨'
                    : 'Correct! 😼✨')
                : (_isPersian
                    ? 'جوابت درست نبود.'
                    : 'Your answer was not correct.'),
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
              color: correct
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          if (!correct)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 6,
              ),
              child: Text(
                _isPersian
                    ? 'جواب صحیح: ${question.answer}'
                    : 'Correct answer: ${question.answer}',
              ),
            ),
          if (A1BasicsUIConfig
                  .showQuestionExplanation &&
              question.explanation !=
                  null &&
              question.explanation!
                  .trim()
                  .isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                question.explanation!,
              ),
            ),
          if (!correct &&
              A1BasicsUIConfig.allowRetry)
            _buildRetryButton(
              _questions.indexOf(
                question,
              ),
            ),
        ],
      ),
    );
  }

  // =========================================================
  // FILL IN THE BLANK
  // =========================================================

  Widget _buildFillInTheBlankQuestion(
    int index,
    A1BasicQuestion question,
  ) {
    final answered =
        _answeredQuestions.contains(index);

    final result =
        _typingResults[index];

    final controller =
        _controllerFor(index);

    return Container(
      margin: EdgeInsets.only(
        bottom:
            A1BasicsUIConfig
                .cardSpacing,
      ),
      padding: EdgeInsets.all(
        A1BasicsUIConfig.pagePadding,
      ),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: !answered
              ? _outline
              : result == true
                  ? Colors.green
                      .withAlpha(55)
                  : Colors.red
                      .withAlpha(45),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Text(
            _isPersian
                ? 'جای خالی را کامل کن'
                : 'Fill in the blank',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(
                  color: lavender,
                  fontWeight:
                      FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          _buildQuestionHeader(
            question.question,
            allowTts: true,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            enabled: !answered ||
                (result == false &&
                    A1BasicsUIConfig
                        .allowRetry),
            textInputAction:
                TextInputAction.done,
            onChanged: (value) {
              _typedAnswers[index] =
                  value;
            },
            onSubmitted: (_) =>
                _submitTypedAnswer(
              index,
            ),
            decoration:
                InputDecoration(
              hintText: _isPersian
                  ? 'کلمه مناسب را بنویس...'
                  : 'Type the missing word...',
              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),
              focusedBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
                borderSide:
                    const BorderSide(
                  color: lavender,
                  width: 2,
                ),
              ),
            ),
          ),
          if (question.hint != null &&
              question.hint!
                  .trim()
                  .isNotEmpty &&
              !answered)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                question.hint!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall,
              ),
            ),
          const SizedBox(height: 14),
          if (!answered ||
              (result == false &&
                  A1BasicsUIConfig
                      .allowRetry))
            FilledButton.icon(
              onPressed: () =>
                  _submitTypedAnswer(
                index,
              ),
              icon: const Icon(
                Icons.check_rounded,
              ),
              label: Text(
                _isPersian
                    ? 'بررسی جواب'
                    : 'Check Answer',
              ),
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    lavender,
                foregroundColor:
                    Colors.black87,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    A1BasicsUIConfig
                        .buttonRadius,
                  ),
                ),
              ),
            ),
          if (answered)
            _buildTypingFeedback(
              question,
              result == true,
            ),
        ],
      ),
    );
  }

  // =========================================================
  // QUESTION HEADER
  // =========================================================

  Widget _buildQuestionHeader(
    String questionText, {
    bool allowTts = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            questionText,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                  fontWeight:
                      FontWeight.bold,
                ),
          ),
        ),
        if (allowTts &&
            A1BasicsUIConfig
                .enableTextToSpeech)
          IconButton(
            tooltip: _isPersian
                ? 'تلفظ'
                : 'Listen',
            onPressed: () =>
                _speak(questionText),
            icon: const Icon(
              Icons
                  .volume_up_rounded,
            ),
          ),
      ],
    );
  }

  // =========================================================
  // RETRY
  // =========================================================

  Widget _buildRetryButton(
    int index,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top: 8,
      ),
      child: TextButton.icon(
        onPressed: () async {
          setState(() {
            _selectedAnswers
                .remove(index);

            _typedAnswers
                .remove(index);

            _typingResults
                .remove(index);

            _answeredQuestions
                .remove(index);

            final controller =
                _answerControllers[
                    index];

            controller?.clear();
          });

          await _saveProgress();
        },
        icon: const Icon(
          Icons.refresh_rounded,
        ),
        label: Text(
          _isPersian
              ? 'دوباره امتحان کن'
              : 'Try Again',
        ),
      ),
    );
  }

  // =========================================================
  // SPEAKING
  // =========================================================

  Widget _buildSpeakingQuestion(
    int index,
  ) {
    final speaking =
        widget.lesson
            .speakingQuestions[index];

    final completed =
        _completedSpeaking
            .contains(index);

    final result =
        _speakingResults[index];

    final active =
        _isListening &&
            _currentSpeakingIndex ==
                index;

    return Container(
      margin: EdgeInsets.only(
        bottom:
            A1BasicsUIConfig
                .cardSpacing,
      ),
      padding: EdgeInsets.all(
        A1BasicsUIConfig.pagePadding,
      ),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: completed
              ? Colors.green
                  .withAlpha(55)
              : _outline,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Text(
            speaking.question,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                  fontWeight:
                      FontWeight.bold,
                ),
          ),
          if (_isPersian &&
              speaking.persian
                  .trim()
                  .isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 8,
              ),
              child: Text(
                speaking.persian,
              ),
            ),
          if (A1BasicsUIConfig
                  .showRecognizedText &&
              _recognizedText
                  .isNotEmpty &&
              _currentSpeakingIndex ==
                  index)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 12,
              ),
              child: Text(
                _isPersian
                    ? 'شنیده شد: $_recognizedText'
                    : 'Recognized: $_recognizedText',
                style: const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          if (A1BasicsUIConfig
                  .showSpeakingResult &&
              completed &&
              result != null)
            Padding(
              padding:
                  const EdgeInsets.only(
                top: 12,
              ),
              child: Text(
                result
                    ? (_isPersian
                        ? 'تلفظت قابل قبول بود 😼✨'
                        : 'Your pronunciation was acceptable 😼✨')
                    : (_isPersian
                        ? 'تلاش ثبت شد. جواب پیشنهادی: '
                            '${speaking.acceptableAnswers.first}'
                        : 'Attempt recorded. Suggested answer: '
                            '${speaking.acceptableAnswers.first}'),
                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  color: result
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
            ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed:
                completed &&
                        !A1BasicsUIConfig
                            .allowSpeakingRetry
                    ? null
                    : active
                        ? _stopListening
                        : () =>
                            _startListening(
                              index,
                            ),
            icon: Icon(
              active
                  ? Icons.stop_rounded
                  : Icons.mic_rounded,
            ),
            label: Text(
              active
                  ? (_isPersian
                      ? 'توقف'
                      : 'Stop')
                  : completed
                      ? (_isPersian
                          ? 'دوباره بگو'
                          : 'Try Again')
                      : (_isPersian
                          ? 'پاسخ بده'
                          : 'Answer'),
            ),
            style:
                FilledButton.styleFrom(
              backgroundColor:
                  lavender,
              foregroundColor:
                  Colors.black87,
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  A1BasicsUIConfig
                      .buttonRadius,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // EXAMPLES
  // =========================================================

  Widget _buildExample(
    A1BasicExample example,
  ) {
    final key =
        _exampleKey(example);

    final listened =
        _listenedExamples.contains(key);

    return Container(
      margin: EdgeInsets.only(
        bottom:
            A1BasicsUIConfig
                .cardSpacing,
      ),
      padding: EdgeInsets.all(
        A1BasicsUIConfig.pagePadding,
      ),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: _outline,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  example.english,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                ),
                if (_isPersian &&
                    example.persian
                        .trim()
                        .isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      top: 6,
                    ),
                    child: Text(
                      example.persian,
                    ),
                  ),
                if (example.pronunciation !=
                    null)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      top: 6,
                    ),
                    child: Text(
                      example.pronunciation!,
                      style: Theme.of(
                        context,
                      )
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            color:
                                Colors.grey,
                          ),
                    ),
                  ),
              ],
            ),
          ),
          if (A1BasicsUIConfig
                  .showPronunciationButton &&
              A1BasicsUIConfig
                  .enableTextToSpeech)
            IconButton(
              tooltip: _isPersian
                  ? 'تلفظ'
                  : 'Listen',
              onPressed: () async {
                await _speak(
                  example.english,
                );

                if (mounted) {
                  setState(() {
                    _listenedExamples
                        .add(key);
                  });

                  await _saveProgress();
                }
              },
              icon: Icon(
                listened
                    ? Icons
                        .check_circle_rounded
                    : Icons
                        .volume_up_rounded,
                color: listened
                    ? Colors.green
                    : lavender,
              ),
            ),
        ],
      ),
    );
  }

  int _exampleKey(
    A1BasicExample example,
  ) {
    return Object.hash(
      example.english,
      example.persian,
      example.pronunciation,
    );
  }

  // =========================================================
  // STAGE COMPLETION
  // =========================================================

  bool _isCurrentStageComplete() {
    final stage =
        _stages[_currentStage];

    final questionsComplete =
        stage.questionIndices.every(
      (index) =>
          _answeredQuestions
              .contains(index),
    );

    final speakingComplete =
        stage.speakingIndices.every(
      (index) =>
          _completedSpeaking
              .contains(index),
    );

    return questionsComplete &&
        speakingComplete;
  }

  Future<void> _goPreviousStage() async {
    if (_currentStage <= 0) return;

    if (_isListening) {
      await _stopListening();
    }

    setState(() {
      _currentStage--;
      _learningMode = A1BasicsUIConfig.teachBeforePractice;
      _currentSpeakingIndex = null;
      _recognizedText = '';
      _isListening = false;
    });

    await _saveProgress();
  }

  Future<void> _goNextStage() async {
    await _finishCurrentStage();
  }

  Future<void> _finishCurrentStage() async {
    if (A1BasicsUIConfig
            .requireStageCompletion &&
        !_isCurrentStageComplete()) {
      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            _isPersian
                ? 'اول تمرین‌های این مرحله را کامل کن 😼'
                : 'Complete the exercises in this stage first 😼',
          ),
          behavior:
              SnackBarBehavior.floating,
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

        _learningMode =
            A1BasicsUIConfig
                .teachBeforePractice;

        _currentSpeakingIndex =
            null;

        _recognizedText = '';

        _isListening = false;
      });

      await _saveProgress();

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              _isPersian
                  ? 'مرحله بعدی باز شد 😼✨'
                  : 'Next stage unlocked 😼✨',
            ),
            behavior:
                SnackBarBehavior
                    .floating,
          ),
        );
      }
    } else {
      await _completeLesson();
    }
  }

  Future<void> _completeLesson() async {
    if (A1BasicsUIConfig.saveProgress) {
      final prefs =
          await SharedPreferences
              .getInstance();

      final completed =
          prefs.getStringList(
                _completedLessonsKey,
              ) ??
              [];

      if (!completed.contains(
        widget.lesson.id,
      )) {
        completed.add(
          widget.lesson.id,
        );
      }

      await prefs.setStringList(
        _completedLessonsKey,
        completed,
      );

      await _saveProgress();
    }

    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(24),
          ),
          title: Text(
            _isPersian
                ? 'درس کامل شد 🎉'
                : 'Lesson Completed 🎉',
          ),
          content: Text(
            _isPersian
                ? 'این درس را با موفقیت تمام کردی. '
                    'یک قدم دیگر به انگلیسی بهتر نزدیک شدی 😼💜'
                : 'You completed this lesson successfully. '
                    'One more step toward better English 😼💜',
          ),
          actions: [
            FilledButton(
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    lavender,
                foregroundColor:
                    Colors.black87,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(
                  context,
                ).pop();
              },
              child: Text(
                _isPersian
                    ? 'باشه'
                    : 'Done',
              ),
            ),
          ],
        );
      },
    );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  // =========================================================
  // PROGRESS HEADER
  // =========================================================

  Widget _buildProgressHeader() {
    if (_stages.isEmpty) {
      return const SizedBox.shrink();
    }

    final progress =
        (_currentStage + 1) /
            _stages.length;

    return Container(
      margin: EdgeInsets.only(
        bottom:
            A1BasicsUIConfig
                .sectionSpacing,
      ),
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: _outline,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _isPersian
                      ? 'مرحله ${_currentStage + 1} از ${_stages.length}'
                      : 'Stage ${_currentStage + 1} of ${_stages.length}',
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  color: lavender,
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
              backgroundColor:
                  lavender.withAlpha(31),
              valueColor:
                  const AlwaysStoppedAnimation(
                lavender,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CURRENT STAGE
  // =========================================================

  Widget _buildCurrentStage() {
    if (_stages.isEmpty) {
      return Center(
        child: Text(
          _isPersian
              ? 'این درس هنوز محتوایی ندارد.'
              : 'This lesson has no content yet.',
        ),
      );
    }

    final stage =
        _stages[_currentStage];

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
        Container(
          padding:
              const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius:
                BorderRadius.circular(
              24,
            ),
            border: Border.all(
              color: _outline,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                _isPersian
                    ? stage.titleFa
                    : stage.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      fontWeight:
                          FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                _isPersian
                    ? stage.descriptionFa
                    : stage.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                      height: 1.45,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height:
              A1BasicsUIConfig
                  .sectionSpacing,
        ),
        if (_learningMode)
          _buildLearningContent()
        else ...[
          ...stage.questionIndices.map(
            _buildQuestion,
          ),
          ...stage.speakingIndices.map(
            _buildSpeakingQuestion,
          ),
          SizedBox(
            height:
                A1BasicsUIConfig
                    .sectionSpacing,
          ),
          FilledButton(
            onPressed:
                _finishCurrentStage,
            style:
                FilledButton.styleFrom(
              backgroundColor:
                  lavender,
              foregroundColor:
                  Colors.black87,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 14,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  A1BasicsUIConfig
                      .buttonRadius,
                ),
              ),
            ),
            child: Text(
              _currentStage ==
                      _stages.length - 1
                  ? (_isPersian
                      ? 'پایان درس'
                      : 'Finish Lesson')
                  : (_isPersian
                      ? 'تکمیل مرحله'
                      : 'Complete Stage'),
            ),
          ),
        ],
      ],
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final lessonTitle =
        _isPersian
            ? widget.lesson.titleFa
            : widget.lesson.title;

    return Scaffold(
      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lessonTitle,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child:
            SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            110,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.all(
                  20,
                ),
                decoration:
                    BoxDecoration(
                  color: _surface,
                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),
                  border:
                      Border.all(
                    color: _outline,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      lessonTitle,
                      style:
                          const TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                        letterSpacing:
                            -0.5,
                      ),
                    ),
                    if (widget.lesson.topic
                        .trim()
                        .isNotEmpty)
                      Padding(
                        padding:
                            const EdgeInsets
                                .only(
                          top: 6,
                        ),
                        child: Text(
                          widget.lesson
                              .topic,
                          style:
                              const TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color:
                                Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildProgressHeader(),
              _buildCurrentStage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _currentStage > 0 ? _goPreviousStage : null,
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: Text(_isPersian ? 'قبلی' : 'Previous'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: _goNextStage,
                  icon: Icon(
                    _currentStage == _stages.length - 1
                        ? Icons.check_rounded
                        : Icons.arrow_forward_rounded,
                  ),
                  label: Text(
                    _currentStage == _stages.length - 1
                        ? (_isPersian ? 'اتمام درس' : 'Finish Lesson')
                        : (_isPersian ? 'بعدی' : 'Next'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lavender,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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

  @override
  void dispose() {
    _tts.stop();
    _speech.stop();

    for (final controller
        in _answerControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }
}

// =========================================================
// STAGE MODEL
// =========================================================

class _A1Stage {
  final String title;
  final String titleFa;

  final String description;
  final String descriptionFa;

  final List<int> questionIndices;
  final List<int> speakingIndices;

  const _A1Stage({
    required this.title,
    required this.titleFa,
    required this.description,
    required this.descriptionFa,
    this.questionIndices =
        const [],
    this.speakingIndices =
        const [],
  });
}