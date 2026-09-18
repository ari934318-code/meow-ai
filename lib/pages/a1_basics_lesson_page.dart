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
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            [
              0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
              16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
              26, 27, 28, 29, 30, 31,
              36, 37, 38, 39, 40, 41, 42, 43, 44, 45,
            ],
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];
      case 'a1_02':
      case 'lesson_2':
      case '2':
        return [
          // The complete teaching path comes first. Practice only starts
          // after the learner has seen the full concept sequence.
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_03':
      case 'lesson_3':
      case '3':
        return [
          // The complete Have/Has teaching path comes first.
          // Practice starts only after every concept used by the questions
          // has already been introduced in the learning phases.
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_04':
      case 'lesson_4':
      case '4':
        return [
          // Basics 4 uses the structured teaching path in the lesson data.
          // Practice starts only after all introduced concepts have been taught.
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_basic_04_5':
      case 'a1_04_5':
      case 'lesson_4_5':
      case '4.5':
        return [
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_05':
      case 'lesson_5':
      case '5':
        return [
          // Basics 5 teaches the complete Present Simple path first.
          // Practice starts only after all concepts used by the questions
          // have already been introduced in the learning phases.
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_06':
      case 'lesson_6':
      case '6':
        return [
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_07':
      case 'lesson_7':
      case '7':
        return [
          // Basics 7 follows the structured learning path in the lesson data.
          // Practice comes after all introduced concepts, and speaking stays last.
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_08':
      case 'lesson_8':
      case '8':
        return [
          // Basics 8 now follows the same structured route as the other
          // revised Basics lessons: learn first, then cumulative practice,
          // then speaking as the final step.
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_09':
      case 'lesson_9':
      case '9':
        return [
          // Basics 9 uses the complete structured teaching path first.
          // All practice questions become available only after the lesson
          // has taught the concepts they use. Speaking remains last.
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_10':
      case 'lesson_10':
      case '10':
        return [
          // Basics 10 uses the complete structured teaching path first.
          // Practice starts only after the possessive-adjective concepts
          // have been taught. Speaking remains the final stage.
          _stage(
            'Learn',
            'یادگیری',
            const [],
          ),
          _stage(
            'Practice',
            'تمرین',
            List.generate(
              _questions.length,
              (index) => index,
            ),
          ),
          _speakingStage(
            'Speaking',
            'تمرین تلفظ و لهجه',
          ),
        ];

      case 'a1_11':
      case 'lesson_11':
      case '11':
        return [
          // Present Simple is cumulative: each stage keeps every concept
          // taught earlier. A later grammar point must never appear in an
          // earlier stage, even as a multiple-choice distractor.
          _stage('What Is the Present Simple?', 'Present Simple چیست؟', [0, 1, 2, 3]),
          _stage('I, You, We, They', 'I, You, We, They', [4, 5, 6, 7]),
          _stage('He, She, It', 'He, She, It', [8, 9, 10, 11]),
          _stage('Positive Sentences', 'جمله‌های مثبت', [12, 13, 14, 15]),
          _stage('Negative Sentences', 'جمله‌های منفی', [16, 17, 18, 19]),
          _stage('Do and Does in Questions', 'سؤال با Do و Does', [20, 21, 22, 23]),
          _stage('Common Mistakes', 'اشتباهات رایج', [24, 25, 26, 27]),
          _stage('Adverbs of Frequency', 'قیدهای تکرار', [28, 29, 30, 31, 32]),
          _stage('Real-Life Present Simple', 'Present Simple در انگلیسی واقعی', List.generate(_questions.length, (i) => i)),
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
      listenMode: stt.ListenMode.dictation,      partialResults: true,
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

      final learning =          data['learningMode'];

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

  Widget _buildStructuredLearningPath() {
    final phases = widget.lesson.learningPhases;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...phases.map((phase) {
          final title = _isPersian ? phase.titleFa : phase.title;
          final body = _isPersian ? phase.bodyFa : phase.body;
