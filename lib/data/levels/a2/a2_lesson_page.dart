import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../localization.dart';
import 'a2_data.dart';
import 'a2_models.dart';
import 'a2_exam_page.dart';

class A2LessonsPage extends StatelessWidget {
  const A2LessonsPage({super.key});

  static const Color lavender = Color(0xFFB9A7E8);

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lang.isPersian ? 'سطح A2' : 'A2 Level',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            110,
          ),
          children: [
            Text(
              lang.isPersian
                  ? 'درس‌های A2'
                  : 'A2 Lessons',
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              lang.isPersian
                  ? 'انگلیسی روزمره را مرحله‌به‌مرحله یاد بگیر.'
                  : 'Learn practical English step by step.',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 22),

            ...List.generate(
              a2Lessons.length,
              (index) {
                final lesson = a2Lessons[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 14,
                  ),
                  child: _lessonCard(
                    context,
                    lang,
                    lesson,
                    index,
                  ),
                );
              },
            ),

            const SizedBox(height: 4),

            _examCard(
              context,
              lang,
            ),
          ],
        ),
      ),
    );
  }

  Widget _lessonCard(
    BuildContext context,
    MeowLocalizations lang,
    A2Lesson lesson,
    int index,
  ) {
    final lessonNumber = index + 1;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => A2LessonDetailPage(
              lesson: lesson,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.grey.withOpacity(0.14),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: lavender.withOpacity(0.14),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$lessonNumber',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: lavender,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.isPersian
                        ? 'درس $lessonNumber'
                        : 'Lesson $lessonNumber',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getLessonTitle(
                      lang,
                      lesson,
                      lessonNumber,
                    ),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _getLessonTopic(
                      lang,
                      lesson,
                      lessonNumber,
                    ),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  String _getLessonTitle(
    MeowLocalizations lang,
    A2Lesson lesson,
    int lessonNumber,
  ) {
    if (!lang.isPersian) {
      return lesson.title;
    }

    const persianTitles = [
      'برنامه‌های روزانه',
      'خرید و فروشگاه',
      'غذا و رستوران',
      'خانه و زندگی روزمره',
      'کار و شغل',
      'اوقات فراغت',
      'سلامتی و مراقبت از خود',
      'سفر و حمل‌ونقل',
      'آب‌وهوا',
      'دوستان و روابط',
      'برنامه‌ریزی و قرارها',
      'تجربه‌های گذشته',
      'زندگی شهری',
      'ارتباطات روزمره',
      'موقعیت‌های واقعی',
      'مرور A2',
    ];

    if (lessonNumber >= 1 &&
        lessonNumber <= persianTitles.length) {
      return persianTitles[lessonNumber - 1];
    }

    return lesson.title;
  }

  String _getLessonTopic(
    MeowLocalizations lang,
    A2Lesson lesson,
    int lessonNumber,
  ) {
    if (!lang.isPersian) {
      return lesson.topic;
    }

    const persianTopics = [
      'صحبت درباره برنامه‌های روزانه، عادت‌ها و فعالیت‌های روزمره',
      'یادگیری زبان انگلیسی برای خرید و موقعیت‌های فروشگاهی',
      'صحبت درباره غذا، نوشیدنی و موقعیت‌های رستوران',
      'صحبت درباره خانه و فعالیت‌های روزمره',
      'صحبت درباره کار، شغل و محیط کاری',
      'صحبت درباره اوقات فراغت، سرگرمی‌ها و فعالیت‌های آزاد',
      'صحبت درباره سلامتی و مراقبت از خود',
      'صحبت درباره سفر، مسیرها و وسایل حمل‌ونقل',
      'صحبت درباره آب‌وهوا و شرایط جوی',
      'صحبت درباره دوستان، روابط و تعاملات اجتماعی',
      'صحبت درباره برنامه‌ریزی، قرارها و زمان‌بندی',
      'صحبت درباره تجربه‌ها و اتفاقات گذشته',
      'صحبت درباره زندگی شهری و موقعیت‌های روزمره در شهر',
      'تمرین ارتباطات و گفت‌وگوهای روزمره',
      'تمرین زبان انگلیسی در موقعیت‌های واقعی زندگی',
      'مرور و جمع‌بندی مطالب سطح A2',
    ];

    if (lessonNumber >= 1 &&
        lessonNumber <= persianTopics.length) {
      return persianTopics[lessonNumber - 1];
    }

    return lesson.topic;
  }

  Widget _examCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const A2ExamPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: lavender.withOpacity(0.10),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: lavender.withOpacity(0.20),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: lavender.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.workspace_premium_rounded,
                color: lavender,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.isPersian
                        ? 'امتحان نهایی A2'
                        : 'A2 Final Exam',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    lang.isPersian
                        ? '۶۰ سؤال • حداقل نمره قبولی ۷۰٪'
                        : '60 questions • 70% passing score',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class A2LessonDetailPage extends StatefulWidget {
  final A2Lesson lesson;

  const A2LessonDetailPage({
    super.key,
    required this.lesson,
  });

  @override
  State<A2LessonDetailPage> createState() =>
      _A2LessonDetailPageState();
}

class _A2LessonDetailPageState
    extends State<A2LessonDetailPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  static const int totalStages = 13;

  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  int _currentStage = 0;

  final Set<int> _completedStages = {};

  final Map<int, int> _questionAnswers = {};
  final Map<int, int> _fillBlankAnswers = {};

  final Map<int, String> _recognizedTexts = {};
  final Map<int, bool?> _speakingResults = {};

  final Set<int> _listenedItems = {};

  bool _speechAvailable = false;
  bool _isListening = false;
  int? _listeningQuestionIndex;

  String get _progressPrefix =>
      'a2_lesson_progress_${widget.lesson.id}';

  String get _stageKey =>
      '${_progressPrefix}_stage';

  String get _completedKey =>
      '${_progressPrefix}_completed';

  String get _listenedKey =>
      '${_progressPrefix}_listened';

  String get _questionsKey =>
      '${_progressPrefix}_questions';

  String get _fillBlanksKey =>
      '${_progressPrefix}_fillblanks';

  String get _recognizedKey =>
      '${_progressPrefix}_recognized';

  String get _speakingKey =>
      '${_progressPrefix}_speaking';

  @override
  void initState() {
    super.initState();

    _setupTts();
    _initializeSpeech();
    _loadProgress();
  }

  Future<void> _setupTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await _tts.stop();

    await _tts.awaitSpeakCompletion(true);

    await _tts.speak(text);
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();

    final savedStage =
        prefs.getInt(_stageKey) ?? 0;

    final completed =
        prefs.getStringList(_completedKey) ?? [];

    final listened =
        prefs.getStringList(_listenedKey) ?? [];

    final questionsJson =
        prefs.getString(_questionsKey);

    final fillBlanksJson =
        prefs.getString(_fillBlanksKey);

    final recognizedJson =
        prefs.getString(_recognizedKey);

    final speakingJson =
        prefs.getString(_speakingKey);

    if (!mounted) return;

    setState(() {
      _currentStage =
          savedStage.clamp(0, totalStages - 1);

      _completedStages
        ..clear()
        ..addAll(
          completed
              .map(int.tryParse)
              .whereType<int>(),
        );

      _listenedItems
        ..clear()
        ..addAll(
          listened
              .map(int.tryParse)
              .whereType<int>(),
        );

      if (questionsJson != null) {
        final data =
            jsonDecode(questionsJson);

        if (data is Map) {
          _questionAnswers.clear();

          data.forEach((key, value) {
            final index = int.tryParse(
              key.toString(),
            );

            final answer =
                int.tryParse(value.toString());

            if (index != null &&
                answer != null) {
              _questionAnswers[index] =
                  answer;
            }
          });
        }
      }

      if (fillBlanksJson != null) {
        final data =
            jsonDecode(fillBlanksJson);

        if (data is Map) {
          _fillBlankAnswers.clear();

          data.forEach((key, value) {
            final index = int.tryParse(
              key.toString(),
            );

            final answer =
                int.tryParse(value.toString());

            if (index != null &&
                answer != null) {
              _fillBlankAnswers[index] =
                  answer;
            }
          }
        }
      }

      if (recognizedJson != null) {
        final data =
            jsonDecode(recognizedJson);

        if (data is Map) {
          _recognizedTexts.clear();

          data.forEach((key, value) {
            final index = int.tryParse(
              key.toString(),
            );

            if (index != null) {
              _recognizedTexts[index] =
                  value.toString();
            }
          });
        }
      }

      if (speakingJson != null) {
        final data =
            jsonDecode(speakingJson);

        if (data is Map) {
          _speakingResults.clear();

          data.forEach((key, value) {
            final index = int.tryParse(
              key.toString(),
            );

            if (index != null) {
              if (value == true) {
                _speakingResults[index] =
                    true;
              } else if (value == false) {
                _speakingResults[index] =
                    false;
              }
            }
          });
        }
      }
    });
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      _stageKey,
      _currentStage,
    );

    await prefs.setStringList(
      _completedKey,
      _completedStages
          .map((e) => e.toString())
          .toList(),
    );

    await prefs.setStringList(
      _listenedKey,
      _listenedItems
          .map((e) => e.toString())
          .toList(),
    );

    await prefs.setString(
      _questionsKey,
      jsonEncode(_questionAnswers),
    );

    await prefs.setString(
      _fillBlanksKey,
      jsonEncode(_fillBlankAnswers),
    );

    await prefs.setString(
      _recognizedKey,
      jsonEncode(_recognizedTexts),
    );

    await prefs.setString(
      _speakingKey,
      jsonEncode(_speakingResults),
    );
  }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' ||
            status == 'notListening') {
          if (mounted) {
            setState(() {
              _isListening = false;
              _listeningQuestionIndex = null;
            });
          }
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() {
            _isListening = false;
            _listeningQuestionIndex = null;
          });

          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(
                'مشکل در تشخیص صدا: ${error.errorMsg}',
              ),
            ),
          );
        }
      },
    );

    if (mounted) {
      setState(() {
        _speechAvailable = available;
      });
    }
  }

  Future<void> _startListening(
    int questionIndex,
  ) async {
    if (!_speechAvailable) {
      await _initializeSpeech();
    }

    if (!_speechAvailable) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'تشخیص صدا روی این دستگاه در دسترس نیست.',
            ),
          ),
        );
      }
      return;
    }

    if (_isListening) {
      await _stopListening();
    }

    setState(() {
      _isListening = true;
      _listeningQuestionIndex =
          questionIndex;
      _recognizedTexts[questionIndex] = '';
      _speakingResults[questionIndex] = null;
    });

    await _speech.listen(
      onResult: (result) {
        if (!mounted) return;

        final text =
            result.recognizedWords.trim();

        setState(() {
          _recognizedTexts[questionIndex] =
              text;
        });

        if (result.finalResult) {
          _checkSpeakingAnswer(
            questionIndex,
            text,
          );
        }
      },
      listenFor:
          const Duration(seconds: 30),
      pauseFor:
          const Duration(seconds: 4),
      partialResults: true,
      localeId: 'en_US',
      cancelOnError: true,
      listenMode: stt.ListenMode.dictation,
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();

    if (mounted) {
      setState(() {
        _isListening = false;
        _listeningQuestionIndex = null;
      });
    }
  }

  void _checkSpeakingAnswer(
    int questionIndex,
    String spokenText,
  ) {
    final normalizedSpoken =
        _normalizeText(spokenText);

    if (normalizedSpoken.isEmpty) {
      return;
    }

    final question =
        widget.lesson.speakingQuestions[
            questionIndex];

    final normalizedQuestion =
        _normalizeText(question.question);

    final questionWords =
        normalizedQuestion.split(' ');

    final spokenWords =
        normalizedSpoken.split(' ');

    int matchedWords = 0;

    for (final word in questionWords) {
      if (spokenWords.contains(word)) {
        matchedWords++;
      }
    }

    final ratio = questionWords.isEmpty
        ? 0.0
        : matchedWords /
            questionWords.length;

    final isReasonablyRecognized =
        ratio >= 0.35;

    if (mounted) {
      setState(() {
        _speakingResults[questionIndex] =
            isReasonablyRecognized;

        _isListening = false;
        _listeningQuestionIndex = null;
      });

      _completedStages.add(10);
      _saveProgress();
    }
  }

  String _normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(
          RegExp(r'''[.,!?;:'"()]'''),
          ' ',
        )
        .replaceAll(
          RegExp(r'\s+'),
          ' ',
        )
        .trim();
  }

  bool _isPassiveStage(int stage) {
    return stage == 0 ||
        stage == 1 ||
        stage == 2 ||
        stage == 5 ||
        stage == 6 ||
        stage == 7 ||
        stage == 8 ||
        stage == 11 ||
        stage == 12;
  }

  bool _canGoNext() {
    if (_currentStage == 9) {
      final total =
          widget.lesson.sentences.length;

      if (total == 0) {
        return true;
      }

      return _listenedItems.length >= total;
    }

    if (_completedStages.contains(
      _currentStage,
    )) {
      return true;
    }

    if (_isPassiveStage(_currentStage)) {
      return true;
    }

    if (_currentStage == 3) {
      return _questionAnswers.isNotEmpty;
    }

    if (_currentStage == 4) {
      return _fillBlankAnswers.isNotEmpty;
    }

    if (_currentStage == 10) {
      return _speakingResults.isNotEmpty;
    }

    return false;
  }

  Future<void> _goNext() async {
    if (!_canGoNext()) return;

    _completedStages.add(_currentStage);

    if (_currentStage <
        totalStages - 1) {
      setState(() {
        _currentStage++;
      });

      await _saveProgress();
    } else {
      await _saveProgress();

      final prefs =
          await SharedPreferences.getInstance();

      await prefs.setBool(
        'a2_lesson_completed_${widget.lesson.id}',
        true,
      );

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              '🎉 این درس را کامل کردی! 😼💜',
            ),
          ),
        );
      }
    }
  }

  Future<void> _goPrevious() async {
    if (_currentStage <= 0) return;

    setState(() {
      _currentStage--;
    });

    await _saveProgress();
  }

  String _stageTitle(
    MeowLocalizations lang,
  ) {
    const english = [
      'Words',
      'Useful Sentences',
      'Grammar',
      'Multiple Choice',
      'Fill in the Blank',
      'Sentence Ordering',
      'Matching',
      'Build the Sentence',
      'Real-Life Conversation',
      'Listening',
      'Speaking Practice',
      'Meow Challenge',
      'Review',
    ];

    const persian = [
      'کلمات',
      'جمله‌های کاربردی',
      'گرامر',
      'سؤالات چهارگزینه‌ای',
      'جای خالی را پر کن',
      'مرتب کردن جمله',
      'وصل کردن',
      'جمله را بساز',
      'مکالمه واقعی',
      'Listening',
      'تمرین مکالمه',
      'چالش میو',
      'مرور',
    ];

    return lang.isPersian
        ? persian[_currentStage]
        : english[_currentStage];
  }

  String _stageInstruction(
    MeowLocalizations lang,
  ) {
    const english = [
      'Learn the important words for this lesson.',
      'Practice useful everyday sentences.',
      'Learn the grammar you need for this topic.',
      'Choose the best answer.',
      'Choose the correct word for each sentence.',
      'Look at the words and learn the correct order.',
      'Connect the related items.',
      'Study how the sentence is built.',
      'Read and practice a realistic conversation.',
      'Listen to all the sentences.',
      'Speak and practice your pronunciation.',
      'Complete Meow’s challenge.',
      'Review what you learned.',
    ];

    const persian = [
      'کلمات مهم این درس را یاد بگیر.',
      'جمله‌های کاربردی روزمره را تمرین کن.',
      'گرامر موردنیاز این موضوع را یاد بگیر.',
      'بهترین پاسخ را انتخاب کن.',
      'کلمه درست را برای هر جمله انتخاب کن.',
      'ترتیب درست کلمات را یاد بگیر.',
      'موارد مرتبط را به هم وصل کن.',
      'ساختار جمله را بررسی کن.',
      'یک مکالمه واقعی را بخوان و تمرین کن.',
      'به همه جمله‌ها گوش بده.',
      'صحبت کن و تلفظت را تمرین کن.',
      'چالش میو را انجام بده.',
      'چیزهایی را که یاد گرفتی مرور کن.',
    ];

    return lang.isPersian
        ? persian[_currentStage]
        : english[_currentStage];
  }

  @override
  void dispose() {
    _tts.stop();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang =
        MeowLocalizations.of(context);

    final progress =
        (_currentStage + 1) /
            totalStages;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lang.isPersian
              ? 'درس ${_lessonNumber()}'
              : 'Lesson ${_lessonNumber()}',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              12,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _stageTitle(lang),
                        style:
                            const TextStyle(
                          fontSize: 19,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      '${_currentStage + 1}/$totalStages',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor:
                        Colors.grey
                            .withOpacity(0.12),
                    valueColor:
                        const AlwaysStoppedAnimation<
                            Color>(
                      lavender,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment:
                      Alignment.centerLeft,
                  child: Text(
                    _stageInstruction(lang),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.fromLTRB(
                20,
                4,
                20,
                120,
              ),
              children: [
                _buildCurrentStage(
                  context,
                  lang,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.fromLTRB(
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
                      _currentStage > 0
                          ? _goPrevious
                          : null,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                  label: Text(
                    lang.isPersian
                        ? 'قبلی'
                        : 'Previous',
                  ),
                  style:
                      OutlinedButton.styleFrom(
                    minimumSize:
                        const Size(
                      0,
                      52,
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
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed:
                      _canGoNext()
                          ? _goNext
                          : null,
                  icon: Icon(
                    _currentStage ==
                            totalStages - 1
                        ? Icons.check_rounded
                        : Icons
                            .arrow_forward_rounded,
                  ),
                  label: Text(
                    _currentStage ==
                            totalStages - 1
                        ? (lang.isPersian
                            ? 'اتمام درس'
                            : 'Finish Lesson')
                        : (lang.isPersian
                            ? 'بعدی'
                            : 'Next'),
                  ),
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        lavender,
                    foregroundColor:
                        Colors.white,
                    disabledBackgroundColor:
                        lavender.withOpacity(
                      0.25,
                    ),
                    minimumSize:
                        const Size(
                      0,
                      52,
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
        ),
      ),
    );
  }

  int _lessonNumber() {
    final index =
        a2Lessons.indexWhere(
      (lesson) =>
          lesson.id == widget.lesson.id,
    );

    return index >= 0 ? index + 1 : 1;
  }

  Widget _buildCurrentStage(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    switch (_currentStage) {
      case 0:
        return _buildWords(
          context,
          lang,
        );

      case 1:
        return _buildSentences(
          context,
          lang,
        );

      case 2:
        return _buildGrammar(
          context,
          lang,
        );

      case 3:
        return _buildQuestions(
          context,
          lang,
        );

      case 4:
        return _buildFillBlanks(
          context,
          lang,
        );

      case 5:
        return _buildSentenceOrdering(
          context,
          lang,
        );

      case 6:
        return _buildMatching(
          context,
          lang,
        );

      case 7:
        return _buildSentenceBuilding(
          context,
          lang,
        );

      case 8:
        return _buildConversation(
          context,
          lang,
        );

      case 9:
        return _buildListening(
          context,
          lang,
        );

      case 10:
        return _buildSpeaking(
          context,
          lang,
        );

      case 11:
        return _buildChallenge(
          context,
          lang,
        );

      case 12:
        return _buildReview(
          context,
          lang,
        );

      default:
        return const SizedBox();
    }
  }

  Widget _buildWords(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.words
          .map(
            (word) => _card(
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
                          word.word,
                          style:
                              const TextStyle(
                            fontSize: 19,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        if (lang.isPersian)
                          Text(word.meaning),
                        if (lang.isPersian)
                          const SizedBox(height: 5),
                        Text(
                          word.pronunciation,
                          style:
                              const TextStyle(
                            color: lavender,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          word.example,
                          style:
                              const TextStyle(
                            fontStyle:
                                FontStyle.italic,
                          ),
                        ),
                        if (lang.isPersian) ...[
                          const SizedBox(height: 4),
                          Text(
                            word.exampleTranslation,
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.volume_up_rounded,
                    ),
                    onPressed: () =>
                        _speak(word.word),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSentences(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.sentences
          .map(
            (sentence) => _card(
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
                          sentence.english,
                          style:
                              const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          sentence.pronunciation,
                          style:
                              const TextStyle(
                            color: lavender,
                          ),
                        ),
                        if (lang.isPersian) ...[
                          const SizedBox(height: 6),
                          Text(
                            sentence.translation,
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.volume_up_rounded,
                    ),
                    onPressed: () =>
                        _speak(
                      sentence.english,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildGrammar(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.grammar
          .map(
            (grammar) => _card(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    grammar.title,
                    style:
                        const TextStyle(
                      fontSize: 19,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    grammar.explanation,
                  ),
                  const SizedBox(height: 14),
                  ...grammar.examples.map(
                    (example) => Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              example,
                              style:
                                  const TextStyle(
                                fontStyle:
                                    FontStyle.italic,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons
                                  .volume_up_rounded,
                              size: 20,
                            ),
                            onPressed: () =>
                                _speak(
                              example,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildQuestions(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.questions
          .asMap()
          .entries
          .map(
            (entry) {
              final index = entry.key;
              final question = entry.value;
              final selected =
                  _questionAnswers[index];

              return _card(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}. ${question.question}',
                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...question.options
                        .asMap()
                        .entries
                        .map(
                      (optionEntry) {
                        final optionIndex =
                            optionEntry.key;
                        final option =
                            optionEntry.value;

                        final isSelected =
                            selected ==
                                optionIndex;

                        final isCorrect =
                            optionIndex ==
                                question
                                    .correctIndex;

                        Color? background;

                        if (isSelected) {
                          background =
                              isCorrect
                                  ? Colors.green
                                      .withOpacity(
                                      0.12,
                                    )
                                  : Colors.red
                                      .withOpacity(
                                      0.12,
                                    );
                        }

                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child:
                                OutlinedButton(
                              style:
                                  OutlinedButton
                                      .styleFrom(
                                backgroundColor:
                                    background,
                              ),
                              onPressed: () {
                                setState(() {
                                  _questionAnswers[
                                          index] =
                                      optionIndex;

                                  _completedStages
                                      .add(3);
                                });

                                _saveProgress();
                              },
                              child: Align(
                                alignment:
                                    Alignment
                                        .centerLeft,
                                child:
                                    Text(option),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    if (selected != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        selected ==
                                question
                                    .correctIndex
                            ? (lang.isPersian
                                ? '✅ درست! 😼💜'
                                : '✅ Correct! 😼💜')
                            : (lang.isPersian
                                ? '❌ این جواب درست نیست.'
                                : '❌ Not quite right.'),
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          color: selected ==
                                  question
                                      .correctIndex
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        question.explanation,
                      ),
                    ],
                  ],
                ),
              );
            },
          )
          .toList(),
    );
  }

  Widget _buildFillBlanks(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.fillBlanks
          .asMap()
          .entries
          .map(
            (entry) {
              final index = entry.key;
              final item = entry.value;

              final selected =
                  _fillBlankAnswers[index];

              return _card(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}. ${item.sentence}',
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: item.options
                          .asMap()
                          .entries
                          .map(
                        (optionEntry) {
                          final optionIndex =
                              optionEntry.key;
                          final option =
                              optionEntry.value;

                          return OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _fillBlankAnswers[
                                        index] =
                                    optionIndex;

                                _completedStages
                                    .add(4);
                              });

                              _saveProgress();
                            },
                            child:
                                Text(option),
                          );
                        },
                      ).toList(),
                    ),
                    if (selected != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        selected ==
                                item.correctIndex
                            ? (lang.isPersian
                                ? '✅ درست!'
                                : '✅ Correct!')
                            : (lang.isPersian
                                ? '❌ جواب درست نیست.'
                                : '❌ Not correct.'),
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          color: selected ==
                                  item.correctIndex
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          )
          .toList(),
    );
  }

  Widget _buildSentenceOrdering(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.sentenceOrdering
          .map(
            (item) => _card(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.isPersian
                        ? 'کلمات را به ترتیب درست بچین:'
                        : 'Put the words in the correct order:',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: item.shuffledWords
                        .map(
                          (word) => Chip(
                            label: Text(word),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    lang.isPersian
                        ? 'جمله صحیح: ${item.sentence}'
                        : 'Correct sentence: ${item.sentence}',
                    style:
                        const TextStyle(
                      color: lavender,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.volume_up_rounded,
                    ),
                    onPressed: () =>
                        _speak(item.sentence),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMatching(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return _card(
      child: Column(
        children: widget.lesson.matching
            .map(
              (item) => Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.left,
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.right,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSentenceBuilding(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.sentenceBuilding
          .map(
            (item) => _card(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    item.meaning,
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: item.words
                        .map(
                          (word) => Chip(
                            label:
                                Text(word),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.correctSentence,
                    style:
                        const TextStyle(
                      color: lavender,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.pronunciation,
                    style:
                        const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.volume_up_rounded,
                    ),
                    onPressed: () =>
                        _speak(
                      item.correctSentence,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildConversation(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.conversations
          .map(
            (line) => _card(
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration:
                        BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                        8,
                      ),
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                    ),
                    child: Text(
                      line.speaker,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          line.english,
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          line.pronunciation,
                          style:
                              const TextStyle(
                            color: lavender,
                          ),
                        ),
                        if (lang.isPersian) ...[
                          const SizedBox(height: 5),
                          Text(line.translation),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.volume_up_rounded,
                    ),
                    onPressed: () =>
                        _speak(line.english),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildListening(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    final total =
        widget.lesson.sentences.length;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _card(
          child: Row(
            children: [
              const Icon(
                Icons.headphones_rounded,
                color: lavender,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  lang.isPersian
                      ? 'برای عبور از این مرحله باید به همه جمله‌ها گوش بدهی.'
                      : 'Listen to every sentence before continuing.',
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...widget.lesson.sentences
            .asMap()
            .entries
            .map(
          (entry) {
            final index = entry.key;
            final sentence = entry.value;
            final listened =
                _listenedItems.contains(index);

            return _card(
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration:
                        BoxDecoration(
                      shape: BoxShape.circle,
                      color: listened
                          ? Colors.green
                              .withOpacity(
                              0.12,
                            )
                          : lavender.withOpacity(
                              0.12,
                            ),
                    ),
                    child: Icon(
                      listened
                          ? Icons.check_rounded
                          : Icons.volume_up_rounded,
                      color: listened
                          ? Colors.green
                          : lavender,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      sentence.english,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      listened
                          ? Icons.replay_rounded
                          : Icons
                              .play_arrow_rounded,
                    ),
                    onPressed: () async {
                      await _speak(
                        sentence.english,
                      );

                      if (!mounted) return;

                      setState(() {
                        _listenedItems.add(index);
                      });

                      await _saveProgress();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        if (total > 0) ...[
          const SizedBox(height: 8),
          Center(
            child: Text(
              lang.isPersian
                  ? '${_listenedItems.length} از $total جمله شنیده شد'
                  : '${_listenedItems.length} of $total sentences listened',
              style:
                  const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSpeaking(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.speakingQuestions
          .asMap()
          .entries
          .map(
            (entry) {
              final index = entry.key;
              final question = entry.value;

              final recognized =
                  _recognizedTexts[index] ??
                      '';

              final result =
                  _speakingResults[index];

              final listening =
                  _isListening &&
                      _listeningQuestionIndex ==
                          index;

              return _card(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.question,
                      style:
                          const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      question.pronunciation,
                      style:
                          const TextStyle(
                        color: lavender,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child:
                          ElevatedButton.icon(
                        onPressed: listening
                            ? _stopListening
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
                              ? (lang.isPersian
                                  ? 'توقف'
                                  : 'Stop')
                              : (lang.isPersian
                                  ? 'صحبت کن'
                                  : 'Speak'),
                        ),
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              lavender,
                          foregroundColor:
                              Colors.white,
                        ),
                      ),
                    ),
                    if (listening) ...[
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          lang.isPersian
                              ? '🎤 میو داره گوش می‌ده... 😼'
                              : '🎤 Meow is listening... 😼',
                          style:
                              const TextStyle(
                            color: lavender,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    if (recognized.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.all(
                          12,
                        ),
                        decoration:
                            BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                        ),
                        child: Text(
                          lang.isPersian
                              ? 'میو شنید:\n$recognized'
                              : 'Meow heard:\n$recognized',
                        ),
                      ),
                    ],
                    if (result != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        result
                            ? (lang.isPersian
                                ? '✅ خوب بود! 😼💜'
                                : '✅ Good job! 😼💜')
                            : (lang.isPersian
                                ? '❌ هنوز دقیق نیست، ولی مرحله ثبت شد.'
                                : '❌ Not quite, but the attempt is recorded.'),
                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          color: result
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          )
          .toList(),
    );
  }

  Widget _buildChallenge(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.challenges
          .map(
            (challenge) => _card(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    challenge.title,
                    style:
                        const TextStyle(
                      fontSize: 19,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    challenge.instruction,
                  ),
                  const SizedBox(height: 12),
                  ...challenge.tasks.map(
                    (task) => Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text('• '),
                          Expanded(
                            child: Text(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildReview(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Column(
      children: widget.lesson.reviews
          .map(
            (review) => _card(
              child: ExpansionTile(
                tilePadding:
                    EdgeInsets.zero,
                title: Text(
                  review.title,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
                children: review.points
                    .map(
                      (point) => ListTile(
                        contentPadding:
                            EdgeInsets.zero,
                        leading:
                            const Icon(
                          Icons
                              .check_circle_outline_rounded,
                          color: lavender,
                        ),
                        title:
                            Text(point),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _card({
    required Widget child,
  }) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey
              .withOpacity(0.12),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
