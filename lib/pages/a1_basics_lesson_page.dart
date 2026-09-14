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
  final Map<int, bool> _speakingResults = {};

  late List<A1BasicQuestion> _questions;
  late final List<_A1Stage> _stages;

  bool _speechAvailable = false;
  bool _isListening = false;

  // true = آموزش
  // false = تمرین
  bool _learningMode = true;

  int? _currentSpeakingIndex;
  String _recognizedText = '';

  int _currentStage = 0;

  @override
  void initState() {
    super.initState();

    _questions = List<A1BasicQuestion>.from(
      widget.lesson.questions,
    );

    _stages = _buildStages();

    _initializeSpeech();
    _initializeTts();
    _loadProgress();
  }

  // ============================================================
  // STAGES
  // ============================================================

  List<_A1Stage> _buildStages() {
    switch (widget.lesson.id) {
      case 'a1_basic_01':
        return _lesson01Stages();

      case 'a1_basic_02':
        return _lesson02Stages();

      case 'a1_basic_03':
        return _lesson03Stages();

      case 'a1_basic_04':
        return _lesson04Stages();

      case 'a1_basic_05':
        return _lesson05Stages();

      case 'a1_basic_06':
        return _lesson06Stages();

      case 'a1_basic_07':
        return _lesson07Stages();

      case 'a1_basic_08':
        return _lesson08Stages();

      case 'a1_basic_09':
        return _lesson09Stages();

      case 'a1_basic_10':
        return _lesson10Stages();

      case 'a1_basic_11':
        return _lesson11Stages();

      default:
        return _buildGenericStages(
          _questions.length,
          widget.lesson.speakingQuestions.length,
        );
    }
  }

  // ============================================================
  // LESSON 01
  // ============================================================

  List<_A1Stage> _lesson01Stages() {
    return [
      _A1Stage(
        title: 'I & You',
        titleFa: 'مرحله ۱: I و You',
        description:
            'اول با I و You آشنا شو و کاربردشان را یاد بگیر.',
        questionIndices: [0, 1, 12],
      ),
      _A1Stage(
        title: 'He & She',
        titleFa: 'مرحله ۲: He و She',
        description:
            'حالا He و She را برای افراد مختلف تمرین کن.',
        questionIndices: [2, 3, 7, 8, 17, 18, 22],
      ),
      _A1Stage(
        title: 'It',
        titleFa: 'مرحله ۳: It',
        description:
            'کاربرد It را برای چیزها و اشیا یاد بگیر.',
        questionIndices: [4, 9],
      ),
      _A1Stage(
        title: 'We & They',
        titleFa: 'مرحله ۴: We و They',
        description:
            'ضمیرهای مربوط به خودت با دیگران و گروه‌ها را تمرین کن.',
        questionIndices: [5, 6, 10, 11, 19, 20, 41, 42],
      ),
      _A1Stage(
        title: 'Pronoun Review',
        titleFa: 'مرحله ۵: مرور ضمیرها',
        description:
            'همه ضمیرها را در جمله‌های واقعی مرور کن.',
        questionIndices: [21, 23, 24, 25, 26, 27, 28, 29],
      ),
      _A1Stage(
        title: 'Pronouns in Sentences',
        titleFa: 'مرحله ۶: ضمیرها در جمله',
        description:
            'ضمیرها را با ترجمه و ساختار جمله تمرین کن.',
        questionIndices: [13, 14, 15, 16, 30, 31, 32, 33, 34],
      ),
      _A1Stage(
        title: 'Word Order & Usage',
        titleFa: 'مرحله ۷: جمله‌سازی و کاربرد',
        description:
            'ترتیب کلمات و کاربرد درست ضمیرها را جمع‌بندی کن.',
        questionIndices: [35, 36, 37, 38, 39, 40],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۸: مکالمه',
        description:
            'حالا با صدای خودت ضمیرها را در جمله استفاده کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 02
  // ============================================================

  List<_A1Stage> _lesson02Stages() {
    return [
      _A1Stage(
        title: 'Am',
        titleFa: 'مرحله ۱: Am',
        description: 'کاربرد am با I را یاد بگیر.',
        questionIndices: [0, 7],
      ),
      _A1Stage(
        title: 'Is',
        titleFa: 'مرحله ۲: Is',
        description: 'کاربرد is با he, she و it را تمرین کن.',
        questionIndices: [1, 4, 6, 8],
      ),
      _A1Stage(
        title: 'Are',
        titleFa: 'مرحله ۳: Are',
        description: 'کاربرد are با you, we و they را تمرین کن.',
        questionIndices: [2, 3, 5, 9],
      ),
      _A1Stage(
        title: 'Negative',
        titleFa: 'مرحله ۴: جمله‌های منفی',
        description: 'am not، is not و are not را یاد بگیر.',
        questionIndices: [10, 11, 12],
      ),
      _A1Stage(
        title: 'Contractions',
        titleFa: 'مرحله ۵: شکل کوتاه',
        description: 'شکل‌های کوتاه am, is و are را تمرین کن.',
        questionIndices: [13, 14, 15],
      ),
      _A1Stage(
        title: 'Questions',
        titleFa: 'مرحله ۶: سؤال‌ها',
        description: 'سؤال‌های ساده با am, is و are بساز.',
        questionIndices: [16, 17, 18],
      ),
      _A1Stage(
        title: 'Short Answers',
        titleFa: 'مرحله ۷: جواب کوتاه',
        description: 'به سؤال‌های To Be با جواب کوتاه پاسخ بده.',
        questionIndices: [19, 20, 21, 22],
      ),
      _A1Stage(
        title: 'Rules & Review',
        titleFa: 'مرحله ۸: قوانین و مرور',
        description: 'کاربرد درست am, is و are را بررسی کن.',
        questionIndices: [23, 24, 25, 26, 27],
      ),
      _A1Stage(
        title: 'Translation & Word Order',
        titleFa: 'مرحله ۹: ترجمه و جمله‌سازی',
        description: 'ترجمه و ترتیب کلمات را تمرین کن.',
        questionIndices: [
          28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38
        ],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۱۰: مکالمه',
        description: 'با صدای خودت از To Be استفاده کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 03
  // ============================================================

  List<_A1Stage> _lesson03Stages() {
    return [
      _A1Stage(
        title: 'Have',
        titleFa: 'مرحله ۱: Have',
        description: 'کاربرد have با I, you, we و they را یاد بگیر.',
        questionIndices: [0, 2, 4, 6, 7, 9],
      ),
      _A1Stage(
        title: 'Has',
        titleFa: 'مرحله ۲: Has',
        description: 'کاربرد has با he, she و it را تمرین کن.',
        questionIndices: [1, 3, 5, 8],
      ),
      _A1Stage(
        title: 'Negative',
        titleFa: 'مرحله ۳: جمله‌های منفی',
        description: 'don’t have و doesn’t have را یاد بگیر.',
        questionIndices: [10, 11],
      ),
      _A1Stage(
        title: 'Questions',
        titleFa: 'مرحله ۴: سؤال با Do و Does',
        description: 'سؤال‌های have و has را درست بساز.',
        questionIndices: [12, 13, 14],
      ),
      _A1Stage(
        title: 'Short Answers',
        titleFa: 'مرحله ۵: جواب کوتاه',
        description:
            'جواب‌های کوتاه do, don’t, does و doesn’t را تمرین کن.',
        questionIndices: [15, 16, 17, 18],
      ),
      _A1Stage(
        title: 'Common Mistakes',
        titleFa: 'مرحله ۶: اشتباهات رایج',
        description: 'اشتباهات مهم have و has را پیدا کن.',
        questionIndices: [19, 20, 21, 22, 23],
      ),
      _A1Stage(
        title: 'Translation',
        titleFa: 'مرحله ۷: ترجمه',
        description:
            'جمله‌های have و has را از فارسی به انگلیسی تبدیل کن.',
        questionIndices: [24, 25, 26, 27],
      ),
      _A1Stage(
        title: 'Word Order & Review',
        titleFa: 'مرحله ۸: جمله‌سازی و مرور',
        description:
            'ساختار جمله و کاربرد have و has را جمع‌بندی کن.',
        questionIndices: [28, 29, 30, 31, 32, 33, 34, 35, 36, 37],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۹: مکالمه',
        description: 'با صدای خودت از have و has استفاده کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 04
  // ============================================================

  List<_A1Stage> _lesson04Stages() {
    return [
      _A1Stage(
        title: 'Do',
        titleFa: 'مرحله ۱: Do',
        description: 'کاربرد do با I, you, we و they را یاد بگیر.',
        questionIndices: [0, 2, 4],
      ),
      _A1Stage(
        title: 'Does',
        titleFa: 'مرحله ۲: Does',
        description: 'کاربرد does با he, she و it را تمرین کن.',
        questionIndices: [1, 3, 5],
      ),
      _A1Stage(
        title: 'Don’t & Doesn’t',
        titleFa: 'مرحله ۳: Don’t و Doesn’t',
        description: 'جمله‌های منفی با do و does را یاد بگیر.',
        questionIndices: [6, 7, 8, 9],
      ),
      _A1Stage(
        title: 'Questions',
        titleFa: 'مرحله ۴: سؤال‌ها',
        description: 'سؤال‌های درست با do و does بساز.',
        questionIndices: [10, 11, 12, 13],
      ),
      _A1Stage(
        title: 'Short Answers',
        titleFa: 'مرحله ۵: جواب کوتاه',
        description:
            'جواب‌های کوتاه do, don’t, does و doesn’t را تمرین کن.',
        questionIndices: [14, 15, 16, 17],
      ),
      _A1Stage(
        title: 'Rules & Mistakes',
        titleFa: 'مرحله ۶: قوانین و اشتباهات',
        description: 'اشتباهات رایج do و does را پیدا کن.',
        questionIndices: [18, 19, 20, 21, 22, 23],
      ),
      _A1Stage(
        title: 'Translation',
        titleFa: 'مرحله ۷: ترجمه',
        description: 'جمله‌های روزمره را ترجمه کن.',
        questionIndices: [24, 25, 26, 27],
      ),
      _A1Stage(
        title: 'Word Order & Do',
        titleFa: 'مرحله ۸: جمله‌سازی و کاربرد Do',
        description:
            'ترتیب کلمات و تفاوت do به‌عنوان فعل اصلی و کمکی را تمرین کن.',
        questionIndices: [28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۹: مکالمه',
        description: 'با صدای خودت سؤال و جواب بساز.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 05
  // ============================================================

  List<_A1Stage> _lesson05Stages() {
    return [
      _A1Stage(
        title: 'Base Form',
        titleFa: 'مرحله ۱: شکل پایه فعل',
        description:
            'با I, you, we و they از شکل پایه فعل استفاده کن.',
        questionIndices: [0, 2, 7],
      ),
      _A1Stage(
        title: 'He / She / It',
        titleFa: 'مرحله ۲: He / She / It',
        description: 'تغییر فعل با he, she و it را یاد بگیر.',
        questionIndices: [1, 3, 5, 9],
      ),
      _A1Stage(
        title: 'S, ES & IES',
        titleFa: 'مرحله ۳: S، ES و IES',
        description:
            'قوانین اضافه کردن s، es و تغییر y به ies را تمرین کن.',
        questionIndices: [4, 6, 8],
      ),
      _A1Stage(
        title: 'Positive Sentences',
        titleFa: 'مرحله ۴: جمله‌های مثبت',
        description: 'جمله‌های مثبت حال ساده را بساز.',
        questionIndices: [10, 11, 12],
      ),
      _A1Stage(
        title: 'Negative & Questions',
        titleFa: 'مرحله ۵: منفی و سؤال',
        description:
            'جمله‌های منفی و سؤال‌های حال ساده را تمرین کن.',
        questionIndices: [13, 14, 15, 16, 17],
      ),
      _A1Stage(
        title: 'Common Mistakes',
        titleFa: 'مرحله ۶: اشتباهات رایج',
        description: 'اشتباهات مهم در s و do/does را پیدا کن.',
        questionIndices: [18, 19, 20, 21, 22, 23],
      ),
      _A1Stage(
        title: 'Translation',
        titleFa: 'مرحله ۷: ترجمه',
        description: 'جمله‌های روزمره را به انگلیسی ترجمه کن.',
        questionIndices: [24, 25, 26, 27, 28],
      ),
      _A1Stage(
        title: 'Word Order & Review',
        titleFa: 'مرحله ۸: جمله‌سازی و مرور',
        description:
            'ترتیب کلمات و قوانین s و es را جمع‌بندی کن.',
        questionIndices: [29, 30, 31, 32, 33, 34, 35, 36, 37, 38],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۹: مکالمه',
        description:
            'با صدای خودت از افعال باقاعده استفاده کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 06
  // ============================================================

  List<_A1Stage> _lesson06Stages() {
    return [
      _A1Stage(
        title: 'Go & Have',
        titleFa: 'مرحله ۱: Go و Have',
        description:
            'شکل‌های go/goes و have/has را تمرین کن.',
        questionIndices: [0, 1, 2, 3],
      ),
      _A1Stage(
        title: 'Do & Get',
        titleFa: 'مرحله ۲: Do و Get',
        description: 'do/does و get/gets را یاد بگیر.',
        questionIndices: [4, 5, 6, 7],
      ),
      _A1Stage(
        title: 'Make & Take',
        titleFa: 'مرحله ۳: Make و Take',
        description:
            'make/makes و take/takes را تمرین کن.',
        questionIndices: [8, 9, 10, 11],
      ),
      _A1Stage(
        title: 'Give & See',
        titleFa: 'مرحله ۴: Give و See',
        description:
            'give/gives و see/sees را یاد بگیر.',
        questionIndices: [12, 13, 14, 15],
      ),
      _A1Stage(
        title: 'Know & Say',
        titleFa: 'مرحله ۵: Know و Say',
        description:
            'know/knows و say/says را در جمله تمرین کن.',
        questionIndices: [16, 17, 18, 19, 20],
      ),
      _A1Stage(
        title: 'Questions',
        titleFa: 'مرحله ۶: سؤال‌ها',
        description:
            'بعد از does از شکل پایه فعل استفاده کن.',
        questionIndices: [21, 22, 23, 24, 25],
      ),
      _A1Stage(
        title: 'Negative',
        titleFa: 'مرحله ۷: جمله‌های منفی',
        description:
            'بعد از doesn’t همیشه شکل پایه فعل می‌آید.',
        questionIndices: [26, 27, 28, 29],
      ),
      _A1Stage(
        title: 'Rules & Mistakes',
        titleFa: 'مرحله ۸: قوانین و اشتباهات',
        description:
            'شکل درست افعال را در جمله تشخیص بده.',
        questionIndices: [30, 31, 32, 33, 34, 35],
      ),
      _A1Stage(
        title: 'Translation & Word Order',
        titleFa: 'مرحله ۹: ترجمه و جمله‌سازی',
        description:
            'ترجمه و ترتیب کلمات را تمرین کن.',
        questionIndices: [36, 37, 38, 39, 40, 41, 42, 43],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۱۰: مکالمه',
        description:
            'افعال روزمره را با صدای خودت استفاده کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 07
  // ============================================================

  List<_A1Stage> _lesson07Stages() {
    return [
      _A1Stage(
        title: 'Can + Ability',
        titleFa: 'مرحله ۱: Can و توانایی',
        description: 'Can را برای بیان توانایی یاد بگیر.',
        questionIndices: [0, 1, 2, 3, 4, 5],
      ),
      _A1Stage(
        title: 'Can’t',
        titleFa: 'مرحله ۲: Can’t',
        description: 'ناتوانی را با can’t بیان کن.',
        questionIndices: [6, 7],
      ),
      _A1Stage(
        title: 'Can Questions',
        titleFa: 'مرحله ۳: سؤال با Can',
        description: 'سؤال‌های Can را درست بساز.',
        questionIndices: [8, 9, 10, 11, 12, 13],
      ),
      _A1Stage(
        title: 'Correct Sentences',
        titleFa: 'مرحله ۴: جمله‌های درست',
        description:
            'جمله‌های مثبت، منفی و جواب‌های کوتاه را تمرین کن.',
        questionIndices: [14, 15, 16, 17, 18, 19, 20, 21, 22],
      ),
      _A1Stage(
        title: 'Rules & Mistakes',
        titleFa: 'مرحله ۵: قوانین و اشتباهات',
        description: 'اشتباهات رایج Can را پیدا کن.',
        questionIndices: [23, 24, 25, 26, 27, 28],
      ),
      _A1Stage(
        title: 'Translation',
        titleFa: 'مرحله ۶: ترجمه',
        description: 'جمله‌های Can و Can’t را ترجمه کن.',
        questionIndices: [29, 30, 31, 32, 33],
      ),
      _A1Stage(
        title: 'Word Order',
        titleFa: 'مرحله ۷: جمله‌سازی',
        description: 'ترتیب درست کلمات را تمرین کن.',
        questionIndices: [34, 35, 36],
      ),
      _A1Stage(
        title: 'Permission & Requests',
        titleFa: 'مرحله ۸: اجازه و درخواست',
        description:
            'تفاوت درخواست، اجازه و ناتوانی را یاد بگیر.',
        questionIndices: [37, 38, 39],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۹: مکالمه',
        description:
            'با صدای خودت از Can و Can’t استفاده کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 08
  // ============================================================

  List<_A1Stage> _lesson08Stages() {
    return [
      _A1Stage(
        title: 'Must',
        titleFa: 'مرحله ۱: Must',
        description:
            'Must را برای ضرورت و اجبار یاد بگیر.',
        questionIndices: [0, 1, 2, 3, 4, 5],
      ),
      _A1Stage(
        title: 'Mustn’t',
        titleFa: 'مرحله ۲: Mustn’t',
        description:
            'Mustn’t را برای ممنوعیت تمرین کن.',
        questionIndices: [6, 7],
      ),
      _A1Stage(
        title: 'Must Questions',
        titleFa: 'مرحله ۳: سؤال با Must',
        description: 'سؤال‌های Must را یاد بگیر.',
        questionIndices: [8, 9],
      ),
      _A1Stage(
        title: 'Rules & Meaning',
        titleFa: 'مرحله ۴: قوانین و معنی',
        description:
            'ضرورت، ممنوعیت و کاربرد Must را در جمله تشخیص بده.',
        questionIndices: [10, 11, 12, 13, 14, 15, 16, 17, 18],
      ),
      _A1Stage(
        title: 'Common Mistakes',
        titleFa: 'مرحله ۵: اشتباهات رایج',
        description:
            'اشتباهات مربوط به must و mustn’t را پیدا کن.',
        questionIndices: [19, 20, 21, 22, 23, 24],
      ),
      _A1Stage(
        title: 'Translation',
        titleFa: 'مرحله ۶: ترجمه',
        description:
            'جمله‌های Must و Mustn’t را ترجمه کن.',
        questionIndices: [25, 26, 27, 28, 29],
      ),
      _A1Stage(
        title: 'Word Order',
        titleFa: 'مرحله ۷: جمله‌سازی',
        description:
            'ترتیب درست جمله‌های Must را تمرین کن.',
        questionIndices: [30, 31, 32, 33],
      ),
      _A1Stage(
        title: 'Real-Life Review',
        titleFa: 'مرحله ۸: مرور واقعی',
        description:
            'Must و Mustn’t را در موقعیت‌های واقعی مرور کن.',
        questionIndices: [34, 35, 36, 37, 38, 39],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۹: مکالمه',
        description:
            'با صدای خودت درباره ضرورت و ممنوعیت صحبت کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 09
  // ============================================================

  List<_A1Stage> _lesson09Stages() {
    return [
      _A1Stage(
        title: 'Me & You',
        titleFa: 'مرحله ۱: Me و You',
        description:
            'Me و You را به‌عنوان ضمیر مفعولی یاد بگیر.',
        questionIndices: [0, 5, 10],
      ),
      _A1Stage(
        title: 'Him & Her',
        titleFa: 'مرحله ۲: Him و Her',
        description: 'Him و Her را در جمله تمرین کن.',
        questionIndices: [1, 2, 6, 7, 11],
      ),
      _A1Stage(
        title: 'It, Us & Them',
        titleFa: 'مرحله ۳: It، Us و Them',
        description:
            'سه ضمیر مفعولی دیگر را در موقعیت‌های واقعی استفاده کن.',
        questionIndices: [3, 4, 8, 9, 12, 13],
      ),
      _A1Stage(
        title: 'Object Pronouns',
        titleFa: 'مرحله ۴: ضمیر مفعولی در جمله',
        description:
            'ضمیرهای مفعولی را بعد از فعل‌ها تمرین کن.',
        questionIndices: [14, 15, 16, 17, 18],
      ),
      _A1Stage(
        title: 'Replacing Nouns',
        titleFa: 'مرحله ۵: جایگزین کردن اسم',
        description:
            'اسم‌ها را با ضمیر مفعولی مناسب جایگزین کن.',
        questionIndices: [19, 20, 21, 22, 23],
      ),
      _A1Stage(
        title: 'Common Mistakes',
        titleFa: 'مرحله ۶: اشتباهات رایج',
        description:
            'تفاوت ضمیر فاعلی و مفعولی را بررسی کن.',
        questionIndices: [24, 25, 26, 27, 28, 29],
      ),
      _A1Stage(
        title: 'Translation & Review',
        titleFa: 'مرحله ۷: ترجمه و مرور',
        description:
            'ضمیرهای مفعولی را در ترجمه و جمله‌سازی مرور کن.',
        questionIndices: [30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۸: مکالمه',
        description:
            'ضمیرهای مفعولی را با صدای خودت استفاده کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 10
  // ============================================================

  List<_A1Stage> _lesson10Stages() {
    return [
      _A1Stage(
        title: 'My & Your',
        titleFa: 'مرحله ۱: My و Your',
        description:
            'My و Your را قبل از اسم درست استفاده کن.',
        questionIndices: [0, 1, 7, 8],
      ),
      _A1Stage(
        title: 'His & Her',
        titleFa: 'مرحله ۲: His و Her',
        description:
            'His و Her را برای مالکیت تمرین کن.',
        questionIndices: [2, 3, 11, 12],
      ),
      _A1Stage(
        title: 'Our & Their',
        titleFa: 'مرحله ۳: Our و Their',
        description:
            'مالکیت برای ما و آنها را یاد بگیر.',
        questionIndices: [4, 5, 13, 14, 18],
      ),
      _A1Stage(
        title: 'Its',
        titleFa: 'مرحله ۴: Its',
        description:
            'Its را برای حیوانات و اشیا تمرین کن.',
        questionIndices: [6, 15],
      ),
      _A1Stage(
        title: 'Possession',
        titleFa: 'مرحله ۵: مفهوم مالکیت',
        description:
            'معنی و کاربرد صفت‌های ملکی را تشخیص بده.',
        questionIndices: [
          9, 10, 16, 17, 19, 20, 21, 22, 23, 24
        ],
      ),
      _A1Stage(
        title: 'Rules',
        titleFa: 'مرحله ۶: قوانین مهم',
        description:
            'قوانین My, Mine, His, Her و Their را مرور کن.',
        questionIndices: [25, 26, 27, 28, 29],
      ),
      _A1Stage(
        title: 'Its vs It’s',
        titleFa: 'مرحله ۷: Its و It’s + ترجمه',
        description:
            'تفاوت Its و It’s و کاربرد آنها را یاد بگیر.',
        questionIndices: [30, 31, 32, 33, 34],
      ),
      _A1Stage(
        title: 'Word Order & Review',
        titleFa: 'مرحله ۸: جمله‌سازی و مرور',
        description:
            'ساختار جمله و کاربرد صفت‌های ملکی را جمع‌بندی کن.',
        questionIndices: [35, 36, 37, 38, 39],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۹: مکالمه',
        description:
            'صفت‌های ملکی را با صدای خودت استفاده کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // LESSON 11
  // ============================================================

  List<_A1Stage> _lesson11Stages() {
    return [
      _A1Stage(
        title: 'I, You, We, They',
        titleFa: 'مرحله ۱: I، You، We، They',
        description:
            'در Present Simple با I, you, we و they از شکل پایه فعل استفاده کن.',
        questionIndices: [0, 3, 5, 7, 10],
      ),
      _A1Stage(
        title: 'He, She, It',
        titleFa: 'مرحله ۲: He، She، It',
        description:
            'تفاوت شکل فعل با he, she و it را یاد بگیر.',
        questionIndices: [1, 2, 4, 6, 8, 9, 11],
      ),
      _A1Stage(
        title: 'Negative',
        titleFa: 'مرحله ۳: جمله‌های منفی',
        description:
            'don’t و doesn’t را در جمله‌های منفی استفاده کن.',
        questionIndices: [12, 13, 14, 15],
      ),
      _A1Stage(
        title: 'Do & Does Questions',
        titleFa: 'مرحله ۴: سؤال با Do و Does',
        description:
            'سؤال‌های Present Simple را درست بساز.',
        questionIndices: [16, 17, 18, 19],
      ),
      _A1Stage(
        title: 'Base Verb',
        titleFa: 'مرحله ۵: شکل پایه بعد از Does و Doesn’t',
        description:
            'بعد از does و doesn’t دیگر به فعل s اضافه نکن.',
        questionIndices: [20, 21, 22, 23],
      ),
      _A1Stage(
        title: 'Common Mistakes',
        titleFa: 'مرحله ۶: اشتباهات رایج',
        description:
            'اشتباهات مهم Present Simple را تشخیص بده.',
        questionIndices: [24, 25, 26, 27, 33, 34, 35, 36, 37],
      ),
      _A1Stage(
        title: 'Frequency Adverbs',
        titleFa: 'مرحله ۷: قیدهای تکرار',
        description:
            'always، usually، often، sometimes و never را یاد بگیر.',
        questionIndices: [28, 29, 30, 31, 32],
      ),
      _A1Stage(
        title: 'Translation',
        titleFa: 'مرحله ۸: ترجمه',
        description:
            'جمله‌های Present Simple را ترجمه و مرور کن.',
        questionIndices: [38, 39, 40, 41, 42],
      ),
      _A1Stage(
        title: 'Word Order',
        titleFa: 'مرحله ۹: جمله‌سازی',
        description:
            'ترتیب درست کلمات در Present Simple را تمرین کن.',
        questionIndices: [43, 44, 45, 46],
      ),
      _A1Stage(
        title: 'Speaking',
        titleFa: 'مرحله ۱۰: مکالمه',
        description:
            'Present Simple را با صدای خودت تمرین کن.',
        speakingIndices: List.generate(10, (i) => i),
      ),
    ];
  }

  // ============================================================
  // GENERIC FALLBACK
  // ============================================================

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
          ((totalQuestions * (i + 1)) / stageCount).floor();

      if (start == end && totalQuestions > 0) {
        continue;
      }

      stages.add(
        _A1Stage(
          title: 'Stage ${i + 1}',
          titleFa: 'مرحله ${i + 1}',
          description:
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

  // ============================================================
  // SECTION / LEARNING CONTENT
  // ============================================================

  A1BasicSection? _getCurrentSection() {
    if (widget.lesson.sections.isEmpty) {
      return null;
    }

    final stage = _stages[_currentStage];

    // اول تلاش می‌کنیم خود عنوان Section با Stage هماهنگ باشد.
    for (final section in widget.lesson.sections) {
      if (_normalizeTitle(section.title) ==
              _normalizeTitle(stage.title) ||
          _normalizeTitle(section.titleFa) ==
              _normalizeTitle(stage.titleFa)) {
        return section;
      }
    }

    for (final section in widget.lesson.sections) {
      if (_normalizeTitle(section.title)
              .contains(_normalizeTitle(stage.title)) ||
          _normalizeTitle(stage.title)
              .contains(_normalizeTitle(section.title))) {
        return section;
      }
    }

    // اگر نام‌ها متفاوت بود، از ترتیب بخش‌ها استفاده می‌کنیم.
    if (_currentStage < widget.lesson.sections.length) {
      return widget.lesson.sections[_currentStage];
    }

    return null;
  }

  String _normalizeTitle(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\u0600-\u06ff]+'), '')
        .trim();
  }

  Widget _buildLearningContent() {
    final section = _getCurrentSection();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          'Learn',
          'اول یاد بگیریم',
        ),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.menu_book_outlined,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        section?.titleFa ??
                            _stages[_currentStage]
                                .titleFa,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  section?.explanation ??
                      widget.lesson.explanation,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
        ),

        if (section != null &&
            section.examples.isNotEmpty) ...[
          _buildSectionTitle(
            'Examples',
            'مثال‌ها',
          ),
          ...List.generate(
            section.examples.length,
            (index) => _buildExample(
              section.examples[index],
              index,
              section,
            ),
          ),
        ] else if (widget.lesson.examples.isNotEmpty) ...[
          _buildSectionTitle(
            'Examples',
            'مثال‌ها',
          ),
          ...List.generate(
            min(5, widget.lesson.examples.length),
            (index) => _buildExample(
              widget.lesson.examples[index],
              index,
              null,
            ),
          ),
        ],

        const SizedBox(height: 12),

        Card(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.07),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Theme.of(context)
                      .colorScheme
                      .primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'اول مفهوم را یاد بگیر و مثال‌ها را ببین. '
                    'بعد وارد تمرین می‌شویم. '
                    'اینجا قرار نیست با یک جواب غلط از زندگی اخراجت کنیم 😼',
                    style: const TextStyle(
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _startPractice,
            icon: const Icon(
              Icons.play_arrow_rounded,
            ),
            label: const Text(
              'شروع تمرین',
            ),
          ),
        ),
      ],
    );
  }

  void _startPractice() {
    setState(() {
      _learningMode = false;
    });
  }

  // ============================================================
  // PROGRESS
  // ============================================================

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

      _learningMode = true;
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

  // ============================================================
  // TTS
  // ============================================================

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

  // ============================================================
  // SPEECH
  // ============================================================

  Future<void> _initializeSpeech() async {
    _speechAvailable = await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening' && mounted) {
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

  Future<void> _startListening(int index) async {
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
      onResult: (SpeechRecognitionResult result) {
        if (!mounted) return;

        setState(() {
          _recognizedText = result.recognizedWords;
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
        widget.lesson
            .speakingQuestions[index]
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

        // حتی اگر غلط باشد، تلاش انجام شده محسوب می‌شود.
        _completedSpeaking.add(index);
        _speakingResults[index] = correct;
      });
    }

    _showSpeakingResult(
      correct,
      acceptable.isNotEmpty
          ? acceptable.first
          : null,
    );
  }

  void _showSpeakingResult(
    bool correct,
    String? correctAnswer,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          correct
              ? 'آفرین! درست گفتی 😼💜'
              : correctAnswer != null
                  ? 'این بار کامل نبود. جمله درست: $correctAnswer'
                  : 'این بار کامل نبود، ولی تمرین ثبت شد 😼',
        ),
        duration: const Duration(seconds: 3),
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

    final distance = _levenshtein(a, b);
    final maxLength = max(a.length, b.length);

    return 1 - (distance / maxLength);
  }

  int _levenshtein(
    String a,
    String b,
  ) {
    final previous = List<int>.generate(
      b.length + 1,
      (index) => index,
    );

    for (int i = 1; i <= a.length; i++) {
      final current = List<int>.filled(
        b.length + 1,
        0,
      );

      current[0] = i;

      for (int j = 1; j <= b.length; j++) {
        final cost =
            a[i - 1] == b[j - 1] ? 0 : 1;

        current[j] = min(
          min(
            current[j - 1] + 1,
            previous[j] + 1,
          ),
          previous[j - 1] + cost,
        );
      }

      for (int j = 0;
          j < current.length;
          j++) {
        previous[j] = current[j];
      }
    }

    return previous[b.length];
  }

  // ============================================================
  // QUESTION LOGIC
  // ============================================================

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
    if (_selectedAnswers.containsKey(index)) {
      return;
    }

    final isCorrect =
        _questionCorrect(
      question,
      option,
    );

    setState(() {
      _selectedAnswers[index] = option;

      // مهم:
      // درست یا غلط، سؤال انجام شده محسوب می‌شود.
      _answeredQuestions.add(index);
    });

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          isCorrect
              ? 'درست! 😼💜'
              : 'جواب درست: ${question.answer}',
        ),
        duration: Duration(
          seconds: isCorrect ? 1 : 3,
        ),
      ),
    );
  }

  // ============================================================
  // STAGE COMPLETION
  // ============================================================

  bool _stageCompleted(
    _A1Stage stage,
  ) {
    final questionDone =
        stage.questionIndices.every(
      (index) =>
          _answeredQuestions.contains(index),
    );

    final speakingDone =
        stage.speakingIndices.every(
      (index) =>
          _completedSpeaking.contains(index),
    );

    return questionDone && speakingDone;
  }

  Future<void> _finishCurrentStage() async {
    final stage =
        _stages[_currentStage];

    if (!_stageCompleted(stage)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'اول همه تمرین‌های این مرحله رو انجام بده 😼',
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
        _currentStage = nextStage;

        // هر مرحله جدید دوباره اول آموزش را نشان می‌دهد.
        _learningMode = true;

        _currentSpeakingIndex = null;
        _recognizedText = '';
      });

      await _saveStage(nextStage);

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

  Future<void> _completeLesson() async {
    final prefs =
        await SharedPreferences.getInstance();

    final completed =
        prefs.getStringList(
              _completedLessonsKey,
            ) ??
            [];

    if (!completed.contains(widget.lesson.id)) {
      completed.add(widget.lesson.id);
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
                Navigator.pop(context);
              },
              child: const Text('باشه'),
            ),
          ],
        );
      },
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  // ============================================================
  // UI
  // ============================================================

  Widget _buildProgressHeader() {
    if (_stages.isEmpty) {
      return const SizedBox.shrink();
    }

    final total = _stages.length;
    final progress =
        (_currentStage + 1) / total;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'مرحله ${_currentStage + 1} از $total',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: TextStyle(
                    color: Theme.of(context)
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
                  BorderRadius.circular(20),
              child: LinearProgressIndicator(
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
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            titleFa,
            style: Theme.of(context)
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
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.65),
                ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // QUESTION
  // ============================================================

  Widget _buildQuestion(
    A1BasicQuestion question,
    int index,
  ) {
    final answered =
        _answeredQuestions.contains(index);

    final selected =
        _selectedAnswers[index];

    final wasCorrect =
        selected == question.answer;

    return Card(
      margin:
          const EdgeInsets.only(bottom: 14),
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
                    style: const TextStyle(
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
                  icon: const Icon(
                    Icons.volume_up_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            ...question.options.map(
              (option) {
                final isSelected =
                    selected == option;

                final isCorrectOption =
                    answered &&
                        option ==
                            question.answer;

                return Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: answered
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
                            Alignment.centerLeft,
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(option),
                          ),
                          if (isCorrectOption)
                            const Icon(
                              Icons.check_circle,
                              size: 20,
                            )
                          else if (isSelected)
                            Icon(
                              wasCorrect
                                  ? Icons
                                      .check_circle
                                  : Icons
                                      .cancel,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            if (answered) ...[
              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(12),
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.07),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      wasCorrect
                          ? '✓ درست بود'
                          : '✗ جواب درست: ${question.answer}',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                    if (question.explanation !=
                        null) ...[
                      const SizedBox(height: 6),
                      Text(
                        question.explanation!,
                        style:
                            const TextStyle(
                          height: 1.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SPEAKING
  // ============================================================

  Widget _buildSpeakingQuestion(
    A1BasicSpeakingQuestion question,
    int index,
  ) {
    final completed =
        _completedSpeaking.contains(index);

    final active =
        _currentSpeakingIndex == index;

    final result =
        _speakingResults[index];

    return Card(
      margin:
          const EdgeInsets.only(bottom: 14),
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
                    style: const TextStyle(
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
                  icon: const Icon(
                    Icons.volume_up_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(question.persian),
            const SizedBox(height: 14),

            if (active &&
                _recognizedText.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  'شنیدم: $_recognizedText',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .primary,
                  ),
                ),
              ),

            if (completed &&
                result != null) ...[
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(12),
                margin:
                    const EdgeInsets.only(
                  bottom: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(12),
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.07),
                ),
                child: Text(
                  result
                      ? '✓ تلفظت قابل قبول بود 😼💜'
                      : question.acceptableAnswers
                              .isNotEmpty
                          ? 'جمله پیشنهادی: '
                              '${question.acceptableAnswers.first}'
                          : 'تلاش ثبت شد 😼',
                  style: const TextStyle(
                    height: 1.5,
                  ),
                ),
              ),
            ],

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: completed
                    ? null
                    : (_isListening && active
                        ? _stopListening
                        : () {
                            _startListening(
                              index,
                            );
                          }),
                icon: Icon(
                  _isListening && active
                      ? Icons.stop
                      : Icons.mic,
                ),
                label: Text(
                  completed
                      ? 'Completed ✓'
                      : (_isListening && active
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

  // ============================================================
  // CURRENT STAGE
  // ============================================================

  Widget _buildCurrentStage() {
    if (_stages.isEmpty) {
      return const SizedBox.shrink();
    }

    final stage =
        _stages[_currentStage];

    final completed =
        _stageCompleted(stage);

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        // --------------------------------------------------------
        // STAGE HEADER
        // --------------------------------------------------------

        Card(
          child: Padding(
            padding:
                const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration:
                          BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.12),
                        shape:
                            BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${_currentStage + 1}',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            )
                                .colorScheme
                                .primary,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
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
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            stage.title,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              )
                                  .colorScheme
                                  .primary,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  stage.description,
                  style: const TextStyle(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        // --------------------------------------------------------
        // LEARNING MODE
        // --------------------------------------------------------

        if (_learningMode)
          _buildLearningContent()

        // --------------------------------------------------------
        // PRACTICE MODE
        // --------------------------------------------------------

        else ...[
          if (stage.questionIndices.isNotEmpty) ...[
            _buildSectionTitle(
              'Practice',
              'تمرین',
            ),

            ...stage.questionIndices.map(
              (index) => _buildQuestion(
                _questions[index],
                index,
              ),
            ),
          ],

          if (stage.speakingIndices.isNotEmpty) ...[
            _buildSectionTitle(
              'Speaking',
              'تمرین مکالمه',
            ),

            ...stage.speakingIndices.map(
              (index) =>
                  _buildSpeakingQuestion(
                widget.lesson
                    .speakingQuestions[index],
                index,
              ),
            ),
          ],

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: completed
                  ? _finishCurrentStage
                  : null,
              icon: Icon(
                _currentStage ==
                        _stages.length - 1
                    ? Icons.check_circle
                    : Icons.arrow_forward,
              ),
              label: Text(
                _currentStage ==
                        _stages.length - 1
                    ? 'Complete Lesson'
                    : 'Complete Stage',
              ),
            ),
          ),

          const SizedBox(height: 8),

          if (!completed)
            Center(
              child: Text(
                'همه تمرین‌ها را انجام بده تا مرحله بعد باز شود.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.6),
                ),
              ),
            ),
        ],
      ],
    );
  }

  // ============================================================
  // EXAMPLE
  // ============================================================

  Widget _buildExample(
    A1BasicExample example,
    int index,
    A1BasicSection? section,
  ) {
    // برای Sectionها index محلی است.
    // برای مثال‌های کلی هم index محلی همان لیست است.
    final exampleKey =
        _exampleKey(section, index);

    final listened =
        _listenedExamples.contains(
      exampleKey,
    );

    return Card(
      margin:
          const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding:
            const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
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
                        _listenedExamples.add(
                          exampleKey,
                        );
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
            const SizedBox(height: 5),
            Text(example.persian),
            if (example.pronunciation != null) ...[
              const SizedBox(height: 5),
              Text(
                example.pronunciation!,
                style: TextStyle(
                  color: Theme.of(context)
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

  int _exampleKey(
    A1BasicSection? section,
    int index,
  ) {
    if (section == null) {
      return 10000 + index;
    }

    final sectionIndex =
        widget.lesson.sections.indexOf(section);

    return (sectionIndex + 1) * 1000 + index;
  }

  // ============================================================
  // BUILD
  // ============================================================

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
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            30,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                widget.lesson.title,
                style:
                    Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.lesson.topic,
                style:
                    Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color:
                              Theme.of(context)
                                  .colorScheme
                                  .primary,
                        ),
              ),
              const SizedBox(height: 18),
              _buildProgressHeader(),
              const SizedBox(height: 14),
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

  final List<int> questionIndices;
  final List<int> speakingIndices;

  const _A1Stage({
    required this.title,
    required this.titleFa,
    required this.description,
    this.questionIndices = const [],
    this.speakingIndices = const [],
  });
}