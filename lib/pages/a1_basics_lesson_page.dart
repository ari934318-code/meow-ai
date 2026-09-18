import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/levels/a1/basics/a1_basics_models.dart';
import '../data/levels/a1/basics/a1_basics_listening_data.dart';
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
  final Set<int> _listeningAnswered = {};
  final Set<int> _listenedExamples = {};
  final Map<int, String> _selectedListeningAnswers = {};

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

  List<A1BasicListeningQuestion> get _listeningQuestions =>
      a1BasicsListeningQuestionsFor(widget.lesson.id);

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
      case 'a1_basic_01':
      case 'lesson_1':
      case '1':
        return [
          // Pronouns are cumulative: a stage may test only concepts
          // introduced in this stage or in earlier stages.
          _stage(
            'I',
            'I — من',
            [0, 16, 24],
          ),
          _stage(
            'You',
            'You — تو / شما',
            [0, 16, 24, 22, 25, 31],
          ),
          _stage(
            'He',
            'He — او، مذکر',
            [0, 16, 24, 22, 25, 31, 2, 6, 11, 18, 26, 33, 38],
          ),
          _stage(
            'She',
            'She — او، مؤنث',
            [
              0, 16, 24, 22, 25, 31,
              2, 6, 11, 18, 26, 33, 38,
              1, 7, 12, 17, 27, 32, 39,
            ],
          ),
          _stage(
            'It',
            'It — آن / این',
            [
              0, 16, 24, 22, 25, 31,
              2, 6, 11, 18, 26, 33, 38,
              1, 7, 12, 17, 27, 32, 39,
              3, 8, 13, 19, 28, 34, 41, 44,
            ],
          ),
          _stage(
            'We',
            'We — ما',
            [
              0, 16, 24, 22, 25, 31,
              2, 6, 11, 18, 26, 33, 38,
              1, 7, 12, 17, 27, 32, 39,
              3, 8, 13, 19, 28, 34, 41, 44,
              5, 10, 14, 21, 29, 36, 42,
            ],
          ),
          _stage(
            'They',
            'They — آن‌ها',
            [
              0, 16, 24, 22, 25, 31,
              2, 6, 11, 18, 26, 33, 38,
              1, 7, 12, 17, 27, 32, 39,
              3, 8, 13, 19, 28, 34, 41, 44,
              5, 10, 14, 21, 29, 36, 42,
              4, 9, 15, 20, 23, 30, 35, 37, 40, 43,
            ],
          ),
          _stage(
            'What Are Pronouns?',
            'ضمیر چیست؟',
            const [],
          ),
          _stage(
            'Pronoun Chart',
            'جدول ضمیرها',
            const [],
          ),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];
      case 'a1_basic_02':
      case 'lesson_2':
      case '2':
        return [
          // To Be is cumulative: every stage keeps everything learned
          // in the previous stages. A later concept must never appear
          // in an earlier stage, even as a distractor.
          _stage(
            'What is To Be?',
            'To Be یعنی چه؟',
            [0],
          ),
          _stage(
            'Am',
            'Am',
            [0, 7, 23],
          ),
          _stage(
            'Is',
            'Is',
            [0, 7, 23, 1, 4, 6, 8, 24],
          ),
          _stage(
            'Are',
            'Are',
            [0, 7, 23, 1, 4, 6, 8, 24, 2, 3, 5, 9, 25],
          ),
          _stage(
            'Am, Is, Are Review',
            'مرور Am، Is و Are',
            [0, 7, 23, 1, 4, 6, 8, 24, 2, 3, 5, 9, 25, 26, 27],
          ),
          _stage(
            'Negative Sentences',
            'جمله‌های منفی',
            [0, 7, 23, 1, 4, 6, 8, 24, 2, 3, 5, 9, 25, 26, 27, 10, 11, 12],
          ),
          _stage(
            'Negative Contractions',
            'شکل کوتاه جمله‌های منفی',
            [0, 7, 23, 1, 4, 6, 8, 24, 2, 3, 5, 9, 25, 26, 27, 10, 11, 12, 13, 14, 15],
          ),
          _stage(
            'Questions with To Be',
            'سؤال با To Be',
            [0, 7, 23, 1, 4, 6, 8, 24, 2, 3, 5, 9, 25, 26, 27, 10, 11, 12, 13, 14, 15, 16, 17, 18],
          ),
          _stage(
            'Short Answers',
            'جواب‌های کوتاه',
            [0, 7, 23, 1, 4, 6, 8, 24, 2, 3, 5, 9, 25, 26, 27, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22],
          ),
          _stage(
            'Translation and Word Order',
            'ترجمه و مرتب کردن جمله',
            [0, 7, 23, 1, 4, 6, 8, 24, 2, 3, 5, 9, 25, 26, 27, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 28, 29, 30, 31, 32, 33, 34, 35],
          ),
          _stage(
            'Common Contractions and Final Review',
            'شکل‌های کوتاه و مرور نهایی',
            [0, 7, 23, 1, 4, 6, 8, 24, 2, 3, 5, 9, 25, 26, 27, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
          ),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_basic_03':
      case 'lesson_3':
      case '3':
        return [
          // Have/Has is cumulative: each stage keeps everything already
          // taught. Later grammar must never leak into earlier stages.
          _stage(
            'What are Have and Has?',
            'Have و Has یعنی چه؟',
            [0],
          ),
          _stage(
            'Have',
            'Have',
            [0, 2, 4, 6, 7, 9],
          ),
          _stage(
            'Has',
            'Has',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8],
          ),
          _stage(
            'Have and Has Chart',
            'جدول Have و Has',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16],
          ),
          _stage(
            'Have for Possession',
            'Have برای مالکیت و داشتن',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33],
          ),
          _stage(
            'Have for Family and Relationships',
            'Have برای خانواده و روابط',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33, 40, 41, 51],
          ),
          _stage(
            'Have for Features and Characteristics',
            'Have برای ویژگی‌ها و مشخصات',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33, 40, 41, 51, 30, 32, 39, 42, 43, 50],
          ),
          _stage(
            'Negative: Don’t Have',
            'منفی: Don’t Have',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33, 40, 41, 51, 30, 32, 39, 42, 43, 50, 10, 17, 44],
          ),
          _stage(
            'Negative: Doesn’t Have',
            'منفی: Doesn’t Have',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33, 40, 41, 51, 30, 32, 39, 42, 43, 50, 10, 17, 44, 11, 45],
          ),
          _stage(
            'Important: Doesn’t + Have',
            'نکته مهم: Doesn’t + Have',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33, 40, 41, 51, 30, 32, 39, 42, 43, 50, 10, 17, 44, 11, 45, 18],
          ),
          _stage(
            'Questions with Have',
            'سوالی کردن با Have',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33, 40, 41, 51, 30, 32, 39, 42, 43, 50, 10, 17, 44, 11, 45, 18, 12, 13, 14, 19, 21, 22, 23, 24, 46, 47, 48],
          ),
          _stage(
            'Important: Does + Have',
            'نکته مهم: Does + Have',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33, 40, 41, 51, 30, 32, 39, 42, 43, 50, 10, 17, 44, 11, 45, 18, 12, 13, 14, 19, 21, 22, 23, 24, 46, 47, 48, 20],
          ),
          _stage(
            'Short Answers',
            'جواب‌های کوتاه',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33, 40, 41, 51, 30, 32, 39, 42, 43, 50, 10, 17, 44, 11, 45, 18, 12, 13, 14, 19, 21, 22, 23, 24, 46, 47, 48, 20, 25, 26, 27, 28],
          ),
          _stage(
            'Real-Life Expressions',
            'عبارت‌های واقعی و کاربردی',
            [0, 2, 4, 6, 7, 9, 1, 3, 5, 8, 15, 16, 29, 31, 33, 40, 41, 51, 30, 32, 39, 42, 43, 50, 10, 17, 44, 11, 45, 18, 12, 13, 14, 19, 21, 22, 23, 24, 46, 47, 48, 20, 25, 26, 27, 28, 34, 35, 36, 37, 38, 49],
          ),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_basic_04':
      case 'lesson_4':
      case '4':
        return [
          _stage(
            'What are Do and Does?',
            'Do و Does چیستند؟',
            [0, 18, 19],
          ),
          _stage(
            'Do',
            'Do',
            [0, 18, 19, 2, 4, 12, 24, 28],
          ),
          _stage(
            'Does',
            'Does',
            [0, 18, 19, 2, 4, 12, 24, 28, 1, 3, 5, 13, 25, 35],
          ),
          _stage(
            'Does + Base Verb',
            'Does + شکل ساده فعل',
            [0, 18, 19, 2, 4, 12, 24, 28, 1, 3, 5, 13, 25, 35, 10, 21, 22],
          ),
          _stage(
            'Negative: Don’t',
            'منفی: Don’t',
            [0, 18, 19, 2, 4, 12, 24, 28, 1, 3, 5, 13, 25, 35, 10, 21, 22, 6, 8, 26, 30, 32],
          ),
          _stage(
            'Negative: Doesn’t',
            'منفی: Doesn’t',
            [0, 18, 19, 2, 4, 12, 24, 28, 1, 3, 5, 13, 25, 35, 10, 21, 22, 6, 8, 26, 30, 32, 7, 9, 11, 27, 31, 33],
          ),
          _stage(
            'Don’t / Doesn’t + Base Verb',
            'Don’t / Doesn’t + شکل ساده فعل',
            [0, 18, 19, 2, 4, 12, 24, 28, 1, 3, 5, 13, 25, 35, 10, 21, 22, 6, 8, 26, 30, 32, 7, 9, 11, 27, 31, 33, 20, 23],
          ),
          _stage(
            'Short Answers',
            'جواب‌های کوتاه',
            [0, 18, 19, 2, 4, 12, 24, 28, 1, 3, 5, 13, 25, 35, 10, 21, 22, 6, 8, 26, 30, 32, 7, 9, 11, 27, 31, 33, 20, 23, 14, 15, 16, 17],
          ),
          _stage(
            'Do as a Main Verb',
            'Do به‌عنوان فعل اصلی',
            [0, 18, 19, 2, 4, 12, 24, 28, 1, 3, 5, 13, 25, 35, 10, 21, 22, 6, 8, 26, 30, 32, 7, 9, 11, 27, 31, 33, 20, 23, 14, 15, 16, 17, 34, 36],
          ),
          _stage(
            'Everyday Questions and Review',
            'سؤال‌های روزمره و مرور نهایی',
            [0, 18, 19, 2, 4, 12, 24, 28, 1, 3, 5, 13, 25, 35, 10, 21, 22, 6, 8, 26, 30, 32, 7, 9, 11, 27, 31, 33, 20, 23, 14, 15, 16, 17, 34, 36, 37],
          ),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_basic_12':
      case 'lesson_5':
      case '5':
        return [
          _stage('What Is a Regular Verb?', 'فعل باقاعده چیست؟', [0, 18, 19, 20]),
          _stage('Base Form: I/You/We/They', 'شکل پایه: I/You/We/They', [0, 18, 19, 20, 1, 2, 7, 11, 24, 26, 28]),
          _stage('He/She/It + S', 'He/She/It + S', [0, 18, 19, 20, 1, 2, 7, 11, 24, 26, 28, 3, 5, 8, 9, 10, 25, 30, 31, 32]),
          _stage('Adding ES', 'اضافه کردن ES', [0, 18, 19, 20, 1, 2, 7, 11, 24, 26, 28, 3, 5, 8, 9, 10, 25, 30, 31, 32, 4, 29]),
          _stage('Y → IES', 'تبدیل Y به IES', [0, 18, 19, 20, 1, 2, 7, 11, 24, 26, 28, 3, 5, 8, 9, 10, 25, 30, 31, 32, 4, 29, 6, 33]),
          _stage('Positive Sentences', 'جمله‌های مثبت', [0, 18, 19, 20, 1, 2, 7, 11, 24, 26, 28, 3, 5, 8, 9, 10, 25, 30, 31, 32, 4, 29, 6, 33, 12, 13]),
          _stage('Negative Sentences', 'جمله‌های منفی', [0, 18, 19, 20, 1, 2, 7, 11, 24, 26, 28, 3, 5, 8, 9, 10, 25, 30, 31, 32, 4, 29, 6, 33, 12, 13, 14, 16, 17, 23]),
          _stage('Questions', 'سؤال‌ها', [0, 18, 19, 20, 1, 2, 7, 11, 24, 26, 28, 3, 5, 8, 9, 10, 25, 30, 31, 32, 4, 29, 6, 33, 12, 13, 14, 16, 17, 23, 15, 27, 34]),
          _stage('Positive vs Negative vs Question', 'مثبت، منفی و سوالی', [0, 18, 19, 20, 1, 2, 7, 11, 24, 26, 28, 3, 5, 8, 9, 10, 25, 30, 31, 32, 4, 29, 6, 33, 12, 13, 14, 16, 17, 23, 15, 27, 34, 21, 22, 35]),
          _stage('Everyday Verbs and Review', 'افعال روزمره و مرور نهایی', List.generate(37, (i) => i)),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage('Speaking', 'تمرین مکالمه'),
        ];

      case 'a1_basic_13':
      case 'lesson_6':
      case '6':
        return [
          // Each stage keeps all previously taught material.
          _stage('Go and Goes', 'Go و Goes', [0, 1]),
          _stage('Have and Has', 'Have و Has', [0, 1, 2, 3]),
          _stage('Do and Does', 'Do و Does', [0, 1, 2, 3, 4, 5]),
          _stage(
            'Get and Gets',
            'Get و Gets',
            [0, 1, 2, 3, 4, 5, 6, 7],
          ),
          _stage(
            'Make and Makes',
            'Make و Makes',
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
          ),
          _stage(
            'Take and Takes',
            'Take و Takes',
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20],
          ),
          _stage(
            'Give and Gives',
            'Give و Gives',
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20, 12, 13],
          ),
          _stage(
            'See and Sees',
            'See و Sees',
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20, 12, 13, 14, 15],
          ),
          _stage(
            'Know and Knows',
            'Know و Knows',
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20, 12, 13, 14, 15, 16, 17],
          ),
          _stage(
            'Say and Says',
            'Say و Says',
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20, 12, 13, 14, 15, 16, 17, 18, 19],
          ),
          _stage(
            'Questions with Irregular Verbs',
            'سؤال با افعال بی‌قاعده',
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 25],
          ),
          _stage(
            'Negative Sentences',
            'جمله‌های منفی',
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29],
          ),
          _stage(
            'Common Mistakes',
            'اشتباهات رایج',
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35],
          ),
          _stage(
            'Translation and Word Order',
            'ترجمه و مرتب کردن جمله',
            List.generate(44, (i) => i),
          ),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage('Speaking', 'تمرین مکالمه'),
        ];

      case 'a1_basic_06':
      case 'a1_06_simple_wh':
        return [
          _stage('Think First', 'اول فکر کن', []),
          _stage('Introduction', 'معرفی', []),
          _stage('Simple Examples', 'مثال‌های ساده', [0, 1, 2]),
          _stage('What Are Wh-Questions?', 'Wh-Questions چیست؟', [0, 1, 2, 3, 4, 5]),
          _stage('Question Words', 'کلمه‌های پرسشی', [0, 1, 2, 3, 4, 5]),
          _stage('Wh + To Be', 'Wh + To Be', [6, 7, 12, 17]),
          _stage('Wh + Do / Does', 'Wh + Do / Does', [8, 9, 10, 11]),
          _stage('Important Who Rule', 'نکته مهم درباره Who', [13]),
          _stage('More Examples', 'مثال‌های بیشتر', [6, 8, 9, 13]),
          _stage('Recognition Practice', 'تمرین تشخیص', [6, 8, 9, 10]),
          _stage('Guided Practice', 'تمرین هدایت‌شده', [10, 11, 12, 13]),
          _stage('Translation Practice', 'تمرین ترجمه', [14, 15, 16, 17]),
          _stage('Real-World Use', 'کاربرد واقعی', [0, 1, 2, 8]),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage('Speaking', 'تمرین تلفظ و لهجه'),
        ];

      case 'a1_basic_07':
      case 'lesson_7':
      case '7':
        return [
          // Object pronouns are cumulative: each stage keeps everything
          // introduced before it. Later pronouns must never appear early.
          _stage(
            'Stage 1',
            'مرحله ۱',
            [0, 5, 10],
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [0, 5, 10, 1, 6, 11],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [0, 5, 10, 1, 6, 11, 2, 7, 12],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            [0, 5, 10, 1, 6, 11, 2, 7, 12, 3, 4, 8, 9, 13],
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            [0, 5, 10, 1, 6, 11, 2, 7, 12, 3, 4, 8, 9, 13, 14, 15, 16, 17, 18],
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            [0, 5, 10, 1, 6, 11, 2, 7, 12, 3, 4, 8, 9, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            List.generate(30, (i) => i),
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            List.generate(40, (i) => i),
          ),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_basic_08':
      case 'lesson_8':
      case '8':
        return [
          // Possessive adjectives are cumulative: every stage keeps
          // everything taught before it. Later forms must never leak
          // into an earlier stage.
          _stage(
            'Stage 1',
            'مرحله ۱',
            [0, 1, 7, 8],
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            [0, 1, 7, 8, 2, 3, 11, 12],
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            [0, 1, 7, 8, 2, 3, 11, 12, 4, 5, 13, 14, 18],
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            [0, 1, 7, 8, 2, 3, 11, 12, 4, 5, 13, 14, 18, 6, 15],
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            [
              0,
              1,
              7,
              8,
              2,
              3,
              11,
              12,
              4,
              5,
              13,
              14,
              18,
              6,
              15,
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
            List.generate(30, (i) => i),
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            List.generate(35, (i) => i),
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            List.generate(40, (i) => i),
          ),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_basic_09':
      case 'lesson_9':
      case '9':
      case 'a1_basic_10':
      case 'lesson_10':
      case '10':
        return _buildGenericStages(
          _questions.length,
          widget.lesson.speakingQuestions.length,
        );

      case 'a1_basic_11':
      case 'lesson_11':
      case '11':
        return [
          // Must/Mustn't is cumulative: every stage keeps all material
          // introduced earlier in this lesson. Later structures must never
          // leak into an earlier stage.
          _stage(
            'Stage 1',
            'مرحله ۱',
            List.generate(6, (i) => i),
          ),
          _stage(
            'Stage 2',
            'مرحله ۲',
            List.generate(8, (i) => i),
          ),
          _stage(
            'Stage 3',
            'مرحله ۳',
            List.generate(10, (i) => i),
          ),
          _stage(
            'Stage 4',
            'مرحله ۴',
            List.generate(19, (i) => i),
          ),
          _stage(
            'Stage 5',
            'مرحله ۵',
            List.generate(25, (i) => i),
          ),
          _stage(
            'Stage 6',
            'مرحله ۶',
            List.generate(30, (i) => i),
          ),
          _stage(
            'Stage 7',
            'مرحله ۷',
            List.generate(34, (i) => i),
          ),
          _stage(
            'Stage 8',
            'مرحله ۸',
            List.generate(40, (i) => i),
          ),
          _listeningStage(
            'Listening',
            'گوش دادن',
          ),
          _speakingStage(
            'Speaking',
            'تمرین مکالمه',
          ),
        ];

      case 'a1_basic_05':
      case 'lesson_11':
      case '11':
        return [
          // Present Simple is cumulative: each stage keeps every concept
          // taught earlier. A later grammar point must never appear in an
          // earlier stage, even as a multiple-choice distractor.
          _stage(
            'What Is the Present Simple?',
            'Present Simple چیست؟',
            [33],
          ),
          _stage(
            'I, You, We, They',
            'I, You, We, They',
            [33, 0, 3, 5, 7, 10],
          ),
          _stage(
            'He, She, It',
            'He, She, It',
            [33, 0, 3, 5, 7, 10, 2, 4],
          ),
          _stage(
            'Adding -s',
            'اضافه کردن s',
            [33, 0, 3, 5, 7, 10, 2, 4, 8],
          ),
          _stage(
            'Adding -es',
            'اضافه کردن es',
            [33, 0, 3, 5, 7, 10, 2, 4, 8, 6, 9, 11],
          ),
          _stage(
            'The -y to -ies Rule',
            'قانون تبدیل y به ies',
            [33, 0, 3, 5, 7, 10, 2, 4, 8, 6, 9, 11, 1, 27],
          ),
          _stage(
            'Positive Sentences',
            'جمله‌های مثبت',
            [33, 0, 3, 5, 7, 10, 2, 4, 8, 6, 9, 11, 1, 27, 24, 34],
          ),
          _stage(
            'Negative Sentences',
            'جمله‌های منفی',
            [33, 0, 3, 5, 7, 10, 2, 4, 8, 6, 9, 11, 1, 27, 24, 34, 12, 13, 14, 15, 26, 37],
          ),
          _stage(
            'Do and Does in Questions',
            'سؤال با Do و Does',
            [33, 0, 3, 5, 7, 10, 2, 4, 8, 6, 9, 11, 1, 27, 24, 34, 12, 13, 14, 15, 26, 37, 16, 17, 18, 19],
          ),
          _stage(
            'Common Mistakes',
            'اشتباهات رایج',
            [33, 0, 3, 5, 7, 10, 2, 4, 8, 6, 9, 11, 1, 27, 24, 34, 12, 13, 14, 15, 26, 37, 16, 17, 18, 19, 20, 21, 22, 23, 25, 35, 36],
          ),
          _stage(
            'Adverbs of Frequency',
            'قیدهای تکرار',
            [33, 0, 3, 5, 7, 10, 2, 4, 8, 6, 9, 11, 1, 27, 24, 34, 12, 13, 14, 15, 26, 37, 16, 17, 18, 19, 20, 21, 22, 23, 25, 35, 36, 28, 29, 30, 31, 32],
          ),
          _stage(
            'Real-Life Present Simple',
            'Present Simple در انگلیسی واقعی',
            List.generate(47, (i) => i),
          ),
          _listeningStage(
            'Listening',
            'گوش دادن',
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
      if (_listeningQuestions.isEmpty) {
        return [];
      }
      return [
        _listeningStage(
          'Listening',
          'گوش دادن',
        ),
      ];
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

    if (_listeningQuestions.isNotEmpty) {
      stages.add(
        _listeningStage(
          'Listening',
          'گوش دادن',
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

      final listeningAnswered =
          data['listeningAnswered'];

      final selectedListeningAnswers =
          data['selectedListeningAnswers'];

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

        _listeningAnswered.clear();

        if (listeningAnswered is List) {
          for (final value in listeningAnswered) {
            if (value is num) {
              _listeningAnswered.add(value.toInt());
            }
          }
        }

        _selectedListeningAnswers.clear();

        if (selectedListeningAnswers is Map) {
          selectedListeningAnswers.forEach((key, value) {
            final index = int.tryParse(key.toString());
            if (index != null && value is String) {
              _selectedListeningAnswers[index] = value;
            }
          });
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

      'listeningAnswered':
          _listeningAnswered.toList(),

      'selectedListeningAnswers':
          _selectedListeningAnswers.map(
        (key, value) => MapEntry(key.toString(), value),
      ),

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
  // Keep multiple-choice distractors inside the learner's current
  // knowledge scope. A question can be reused cumulatively, but it must
  // never reveal a pronoun that has not been taught yet.
  List<String> _safeOptionsForQuestion(
    A1BasicQuestion question,
  ) {
    // Pronoun lesson: only show pronouns already introduced.
    if (widget.lesson.id == 'a1_basic_01' ||
        widget.lesson.id == 'lesson_1' ||
        widget.lesson.id == '1') {
      final learnedPronouns = <String>[
        'I', 'You', 'He', 'She', 'It', 'We', 'They',
      ].take(_currentStage + 1).toSet();

      final pronouns = <String>{
        'i', 'you', 'he', 'she', 'it', 'we', 'they',
      };

      bool containsFuturePronoun(String value) {
        final words = value.toLowerCase()
            .split(RegExp(r'[^a-z]+'))
            .where((word) => word.isNotEmpty)
            .toSet();
        return words.any((word) =>
            pronouns.contains(word) &&
            !learnedPronouns.map((p) => p.toLowerCase()).contains(word));
      }

      final sentenceLike = question.options.any((o) => o.trim().contains(' '));
      final sentencePool = <String>[
        'I am a student.', 'You are my friend.', 'He is a teacher.',
        'She is my sister.', 'It is a book.', 'We are ready.',
        'They are students.',
      ];
      final wordPool = <String>[
        'student', 'teacher', 'friend', 'book', 'happy', 'ready', 'name',
      ];

      final result = <String>[];
      final used = <String>{};
      for (final option in question.options) {
        final value = option.trim();
        if (value.isEmpty || used.contains(value)) continue;
        if (!containsFuturePronoun(value)) {
          result.add(value);
          used.add(value);
        } else {
          final pool = sentenceLike ? sentencePool : wordPool;
          final replacement = pool.firstWhere(
            (candidate) => candidate != question.answer &&
                !used.contains(candidate) &&
                !containsFuturePronoun(candidate),
            orElse: () => '',
          );
          if (replacement.isNotEmpty) {
            result.add(replacement);
            used.add(replacement);
          }
        }
      }
      if (!result.contains(question.answer)) {
        result.insert(0, question.answer);
        used.add(question.answer);
      }
      final pool = sentenceLike ? sentencePool : wordPool;
      for (final candidate in pool) {
        if (result.length >= 4) break;
        if (candidate != question.answer && !used.contains(candidate) &&
            !containsFuturePronoun(candidate)) {
          result.add(candidate);
          used.add(candidate);
        }
      }
      return result;
    }

    // Object Pronouns lesson: only object pronouns introduced by the
    // current stage may appear. Possessive and reflexive pronouns are
    // intentionally excluded because they are taught later.
    if (widget.lesson.id == 'a1_basic_07' ||
        widget.lesson.id == 'lesson_9' ||
        widget.lesson.id == '9') {
      final learnedObjects = <String>{
        'me',
        'you',
        if (_currentStage >= 1) 'him',
        if (_currentStage >= 2) 'her',
        if (_currentStage >= 3) ...['it', 'us', 'them'],
      };

      const possessive = <String>{
        'my', 'mine', 'his', 'hers', 'our', 'ours',
        'their', 'theirs', 'your', 'yours', 'its',
      };
      const reflexive = <String>{
        'myself', 'yourself', 'himself', 'herself',
        'itself', 'ourselves', 'yourselves', 'themselves',
      };
      const objectPronouns = <String>{
        'me', 'you', 'him', 'her', 'it', 'us', 'them',
      };

      bool isAllowedOption(String value) {
        final words = value
            .toLowerCase()
            .split(RegExp(r'[^a-z]+'))
            .where((word) => word.isNotEmpty)
            .toSet();

        if (words.any(possessive.contains) ||
            words.any(reflexive.contains)) {
          return false;
        }

        for (final pronoun in objectPronouns) {
          if (words.contains(pronoun) &&
              !learnedObjects.contains(pronoun)) {
            return false;
          }
        }
        return true;
      }

      final result = <String>[];
      final used = <String>{};

      for (final option in question.options) {
        final value = option.trim();
        if (value.isEmpty || used.contains(value)) continue;
        if (!isAllowedOption(value)) continue;
        result.add(value);
        used.add(value);
      }

      if (!result.contains(question.answer)) {
        result.insert(0, question.answer);
        used.add(question.answer);
      }

      // Use already-known subject pronouns as neutral fallback distractors
      // instead of leaking future possessive/reflexive grammar.
      const safeWords = [
        'I', 'he', 'she', 'we', 'they',
        'student', 'friend', 'teacher', 'book',
      ];
      for (final candidate in safeWords) {
        if (result.length >= 4) break;
        if (candidate != question.answer &&
            !used.contains(candidate) &&
            isAllowedOption(candidate)) {
          result.add(candidate);
          used.add(candidate);
        }
      }
      return result;
    }

    // Possessive Adjectives lesson: only forms introduced by the
    // current stage may appear as distractors. Possessive pronouns
    // such as yours/hers/ours/theirs are not taught here, so they
    // must never leak into this lesson's choices.
    if (widget.lesson.id == 'a1_basic_08' ||
        widget.lesson.id == 'lesson_10' ||
        widget.lesson.id == '10') {
      final allowedAdjectives = <String>{
        'my',
        'your',
        if (_currentStage >= 1) ...['his', 'her'],
        if (_currentStage >= 2) ...['our', 'their'],
        if (_currentStage >= 3) 'its',
      };

      const allowedSpecial = <String>{
        'mine',
      };

      const possessiveAdjectives = <String>{
        'my', 'your', 'his', 'her', 'its', 'our', 'their',
      };

      const possessivePronouns = <String>{
        'mine', 'yours', 'hers', 'ours', 'theirs',
      };

      bool isAllowedOption(String value) {
        final words = value
            .toLowerCase()
            .split(RegExp(r'[^a-z]+'))
            .where((word) => word.isNotEmpty)
            .toSet();

        for (final word in possessivePronouns) {
          if (words.contains(word)) {
            if (word == 'mine' &&
                _currentStage >= 4 &&
                allowedSpecial.contains(word)) {
              continue;
            }
            return false;
          }
        }

        for (final adjective in possessiveAdjectives) {
          if (words.contains(adjective) &&
              !allowedAdjectives.contains(adjective)) {
            return false;
          }
        }

        // "it's" is explicitly taught together with its. Do not expose
        // the contraction before the Its / It's stage.
        if (words.contains('it') &&
            value.toLowerCase().contains("it's") &&
            _currentStage < 3) {
          return false;
        }

        return true;
      }

      final result = <String>[];
      final used = <String>{};

      for (final option in question.options) {
        final value = option.trim();
        if (value.isEmpty || used.contains(value)) continue;
        if (!isAllowedOption(value)) continue;
        result.add(value);
        used.add(value);
      }

      if (!result.contains(question.answer)) {
        result.insert(0, question.answer);
        used.add(question.answer);
      }

      // Already-taught pronouns/words are safe fallback distractors.
      // They prevent future possessive forms from being used just to
      // fill the four-option requirement.
      const safeWords = [
        'I', 'you', 'he', 'she', 'we', 'they',
        'me', 'him', 'her', 'us', 'them',
        'student', 'friend', 'teacher', 'book',
      ];

      for (final candidate in safeWords) {
        if (result.length >= 4) break;
        if (candidate != question.answer &&
            !used.contains(candidate) &&
            isAllowedOption(candidate)) {
          result.add(candidate);
          used.add(candidate);
        }
      }

      return result;
    }

    // Present Simple lesson: keep verb forms, negatives, questions, and
    // frequency adverbs inside the current teaching scope. A question may
    // be reused cumulatively, but future forms must not leak in early.
    if (widget.lesson.id == 'a1_basic_05' ||
        widget.lesson.id == 'lesson_11' ||
        widget.lesson.id == '11') {
      const thirdPersonForms = <String>{
        'studies', 'drinks', 'lives', 'watches', 'likes', 'goes',
        'studys', 'drinkes', 'livies', 'watchs', 'likees', 'gos',
      };
      const esForms = <String>{
        'watches', 'goes', 'watchs', 'gos',
        'drinkes', 'likees',
      };
      const yToIesForms = <String>{
        'studies', 'studys', 'livies',
      };
      const frequencyAdverbs = <String>{
        'always', 'usually', 'often', 'sometimes', 'never',
      };

      bool isAllowedOption(String value) {
        final words = value
            .toLowerCase()
            .split(RegExp(r'[^a-z]+'))
            .where((word) => word.isNotEmpty)
            .toSet();
