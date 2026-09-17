import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../localization.dart';
import 'a2_data.dart';
import 'a2_models.dart';
import 'a2_exam_page.dart';

class A2LessonsPage extends StatefulWidget {
  const A2LessonsPage({super.key});

  @override
  State<A2LessonsPage> createState() => _A2LessonsPageState();
}

class _A2LessonsPageState extends State<A2LessonsPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  final Set<int> _completedLessons = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCompletedLessons();
  }

  Future<void> _loadCompletedLessons() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = <int>{};

    for (int i = 0; i < a2Lessons.length; i++) {
      if (prefs.getBool('a2_lesson_completed_${a2Lessons[i].id}') == true) {
        completed.add(i);
      }
    }

    if (!mounted) return;
    setState(() {
      _completedLessons
        ..clear()
        ..addAll(completed);
      _loading = false;
    });
  }

  bool _isLessonUnlocked(int index) {
    if (index == 0) return true;
    return _completedLessons.contains(index - 1);
  }

  bool get _examUnlocked => _completedLessons.length >= a2Lessons.length;

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(lang.isPersian ? 'سطح A2' : 'A2 Level'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        children: [
          ...a2Lessons.asMap().entries.map((entry) {
            return _lessonCard(
              context,
              lang,
              entry.value,
              entry.key,
            );
          }),
          const SizedBox(height: 8),
          _examCard(context, lang),
        ],
      ),
    );
  }

  Widget _lessonCard(
    BuildContext context,
    MeowLocalizations lang,
    A2Lesson lesson,
    int index,
  ) {
    final unlocked = _isLessonUnlocked(index);
    final completed = _completedLessons.contains(index);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.withOpacity(0.12)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: unlocked
            ? () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => A2LessonDetailPage(lesson: lesson),
                  ),
                );
                if (result == true) await _loadCompletedLessons();
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed
                      ? Colors.green.withOpacity(0.12)
                      : unlocked
                          ? lavender.withOpacity(0.14)
                          : Colors.grey.withOpacity(0.10),
                ),
                child: Icon(
                  completed
                      ? Icons.check_rounded
                      : unlocked
                          ? Icons.play_arrow_rounded
                          : Icons.lock_outline_rounded,
                  color: completed
                      ? Colors.green
                      : unlocked
                          ? lavender
                          : Colors.grey,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.isPersian ? 'درس ${index + 1}' : 'Lesson ${index + 1}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _getLessonTitle(lang, lesson, index),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _getLessonTopic(lang, lesson, index),
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: unlocked ? Colors.grey : Colors.grey.withOpacity(0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLessonTitle(MeowLocalizations lang, A2Lesson lesson, int index) {
    const persianTitles = [
      'زندگی روزمره و برنامه‌ها',
      'اتفاقات و تجربه‌های گذشته',
      'برنامه‌های آینده و پیش‌بینی‌ها',
      'غذا، خرید و رستوران',
      'سفر و حمل‌ونقل',
      'سلامت و بدن',
      'کار و مدرسه',
      'خانواده و روابط',
      'خانه و محله',
      'سرگرمی و اوقات فراغت',
      'آب‌وهوا و طبیعت',
      'فناوری و ارتباطات',
      'مشکلات، درخواست‌ها و راه‌حل‌ها',
      'موقعیت‌های اجتماعی و گفت‌وگوی کوتاه',
      'انگلیسی واقعی و عبارت‌های رایج',
      'مرور A2 و آمادگی آزمون نهایی',
    ];

    if (lang.isPersian && index >= 0 && index < persianTitles.length) {
      return persianTitles[index];
    }
    return lesson.title;
  }

  String _getLessonTopic(MeowLocalizations lang, A2Lesson lesson, int index) {
    const persianTopics = [
      'صحبت درباره عادت‌ها، کارهای روزانه و برنامه‌های معمول.',
      'صحبت درباره اتفاقات گذشته و تجربه‌های شخصی.',
      'صحبت درباره برنامه‌های آینده، قصدها و پیش‌بینی‌ها.',
      'استفاده از انگلیسی در موقعیت‌های غذا خوردن، خرید و رستوران.',
      'صحبت درباره سفر، مسیرها و وسایل حمل‌ونقل.',
      'صحبت درباره بدن، بیماری‌ها، علائم و مراقبت از سلامتی.',
      'صحبت درباره کار، مدرسه و فعالیت‌های مرتبط با آن‌ها.',
      'صحبت درباره اعضای خانواده، روابط و ارتباط با دیگران.',
      'صحبت درباره خانه، محله و مکان‌های اطراف.',
      'صحبت درباره سرگرمی‌ها، علایق و فعالیت‌های اوقات فراغت.',
      'صحبت درباره آب‌وهوا، فصل‌ها و طبیعت.',
      'صحبت درباره فناوری، دستگاه‌ها و ارتباطات روزمره.',
      'بیان مشکل، درخواست کمک و پیدا کردن راه‌حل.',
      'تمرین گفت‌وگوی کوتاه و موقعیت‌های اجتماعی روزمره.',
      'یادگیری عبارت‌ها و اصطلاحات رایج در انگلیسی واقعی.',
      'مرور مطالب A2 و آماده شدن برای آزمون نهایی.',
    ];

    if (lang.isPersian && index >= 0 && index < persianTopics.length) {
      return persianTopics[index];
    }
    return lesson.topic;
  }

  Widget _examCard(BuildContext context, MeowLocalizations lang) {
    final unlocked = _examUnlocked;

    return Card(
      margin: const EdgeInsets.only(top: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: lavender.withOpacity(0.35)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: unlocked
            ? () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const A2ExamPage()),
                );
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: unlocked
                      ? lavender.withOpacity(0.14)
                      : Colors.grey.withOpacity(0.10),
                ),
                child: Icon(
                  unlocked ? Icons.school_rounded : Icons.lock_outline_rounded,
                  color: unlocked ? lavender : Colors.grey,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.isPersian ? 'امتحان نهایی A2' : 'A2 Final Exam',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      lang.isPersian
                          ? '۶۰ سؤال • حداقل نمره قبولی ۷۰٪'
                          : '60 questions • 70% passing score',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: unlocked ? Colors.grey : Colors.grey.withOpacity(0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class A2LessonDetailPage extends StatefulWidget {
  final A2Lesson lesson;

  const A2LessonDetailPage({super.key, required this.lesson});

  @override
  State<A2LessonDetailPage> createState() => _A2LessonDetailPageState();
}

class _A2LessonDetailPageState extends State<A2LessonDetailPage> {
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
  final Map<int, List<String>> _orderingSelections = {};
  final Map<int, List<String>> _buildingSelections = {};
  final Set<int> _completedOrderingItems = {};
  final Set<int> _completedBuildingItems = {};
  final Set<int> _matchedItems = {};
  bool _speechAvailable = false;
  bool _isListening = false;
  int? _listeningQuestionIndex;

  int? _selectedMatchingLeft;

  String get _progressPrefix => 'a2_lesson_progress_${widget.lesson.id}';
  String get _stageKey => '${_progressPrefix}_stage';
  String get _completedKey => '${_progressPrefix}_completed';
  String get _listenedKey => '${_progressPrefix}_listened';
  String get _questionsKey => '${_progressPrefix}_questions';
  String get _fillBlanksKey => '${_progressPrefix}_fillblanks';
  String get _recognizedKey => '${_progressPrefix}_recognized';
  String get _speakingKey => '${_progressPrefix}_speaking';
  String get _orderingKey => '${_progressPrefix}_ordering';
  String get _buildingKey => '${_progressPrefix}_building';
  String get _orderingCompletedKey => '${_progressPrefix}_ordering_completed';
  String get _buildingCompletedKey => '${_progressPrefix}_building_completed';
  String get _matchingKey => '${_progressPrefix}_matching';

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
    final savedStage = prefs.getInt(_stageKey) ?? 0;
    final completed = prefs.getStringList(_completedKey) ?? [];
    final listened = prefs.getStringList(_listenedKey) ?? [];
    final questionsJson = prefs.getString(_questionsKey);
    final fillBlanksJson = prefs.getString(_fillBlanksKey);
    final recognizedJson = prefs.getString(_recognizedKey);
    final speakingJson = prefs.getString(_speakingKey);
    final orderingJson = prefs.getString(_orderingKey);
    final buildingJson = prefs.getString(_buildingKey);
    final orderingCompleted = prefs.getStringList(_orderingCompletedKey) ?? [];
    final buildingCompleted = prefs.getStringList(_buildingCompletedKey) ?? [];
    final matchingJson = prefs.getString(_matchingKey);

    if (!mounted) return;

    setState(() {
      _currentStage = savedStage.clamp(0, totalStages - 1);
      _completedStages
        ..clear()
        ..addAll(completed.map(int.tryParse).whereType<int>());
      _listenedItems
        ..clear()
        ..addAll(listened.map(int.tryParse).whereType<int>());

      if (questionsJson != null) {
        try {
          final data = jsonDecode(questionsJson);
          if (data is Map) {
            _questionAnswers
              ..clear()
              ..addAll(data.map((key, value) => MapEntry(
                    int.parse(key.toString()),
                    int.parse(value.toString()),
                  )));
          }
        } catch (_) {}
      }

      if (fillBlanksJson != null) {
        try {
          final data = jsonDecode(fillBlanksJson);
          if (data is Map) {
            _fillBlankAnswers
              ..clear()
              ..addAll(data.map((key, value) => MapEntry(
                    int.parse(key.toString()),
                    int.parse(value.toString()),
                  )));
          }
        } catch (_) {}
      }

      if (recognizedJson != null) {
        try {
          final data = jsonDecode(recognizedJson);
          if (data is Map) {
            _recognizedTexts
              ..clear()
              ..addAll(data.map((key, value) => MapEntry(
                    int.parse(key.toString()),
                    value.toString(),
                  )));
          }
        } catch (_) {}
      }

      if (speakingJson != null) {
        try {
          final data = jsonDecode(speakingJson);
          if (data is Map) {
            _speakingResults.clear();
            data.forEach((key, value) {
              final index = int.tryParse(key.toString());
              if (index != null) _speakingResults[index] = value == true ? true : value == false ? false : null;
            });
          }
        } catch (_) {}
      }

      if (orderingJson != null) {
        try {
          final data = jsonDecode(orderingJson);
          if (data is Map) {
            _orderingSelections.clear();
            data.forEach((key, value) {
              final index = int.tryParse(key.toString());
              if (index != null && value is List) _orderingSelections[index] = value.map((item) => item.toString()).toList();
            });
          }
        } catch (_) {}
      }

      if (buildingJson != null) {
        try {
          final data = jsonDecode(buildingJson);
          if (data is Map) {
            _buildingSelections.clear();
            data.forEach((key, value) {
              final index = int.tryParse(key.toString());
              if (index != null && value is List) _buildingSelections[index] = value.map((item) => item.toString()).toList();
            });
          }
        } catch (_) {}
      }

      _completedOrderingItems
        ..clear()
        ..addAll(orderingCompleted.map(int.tryParse).whereType<int>());
      _completedBuildingItems
        ..clear()
        ..addAll(buildingCompleted.map(int.tryParse).whereType<int>());

      if (matchingJson != null) {
        try {
          final data = jsonDecode(matchingJson);
          if (data is List) _matchedItems..clear()..addAll(data.map((v) => int.tryParse(v.toString())).whereType<int>());
        } catch (_) {}
      }
    });
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_stageKey, _currentStage);
    await prefs.setStringList(_completedKey, _completedStages.map((v) => v.toString()).toList());
    await prefs.setStringList(_listenedKey, _listenedItems.map((v) => v.toString()).toList());
    await prefs.setString(_questionsKey, jsonEncode(_questionAnswers));
    await prefs.setString(_fillBlanksKey, jsonEncode(_fillBlankAnswers));
    await prefs.setString(_recognizedKey, jsonEncode(_recognizedTexts));
    await prefs.setString(_speakingKey, jsonEncode(_speakingResults));
    await prefs.setString(_orderingKey, jsonEncode(_orderingSelections));
    await prefs.setString(_buildingKey, jsonEncode(_buildingSelections));
    await prefs.setStringList(_orderingCompletedKey, _completedOrderingItems.map((v) => v.toString()).toList());
    await prefs.setStringList(_buildingCompletedKey, _completedBuildingItems.map((v) => v.toString()).toList());
    await prefs.setString(_matchingKey, jsonEncode(_matchedItems.toList()));
  }

  Future<void> _initializeSpeech() async {
    try {
      final available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            if (mounted) setState(() { _isListening = false; _listeningQuestionIndex = null; });
          }
        },
        onError: (error) {
          if (mounted) {
            setState(() { _isListening = false; _listeningQuestionIndex = null; });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطا در تشخیص صدا: ${error.errorMsg}')));
          }
        },
      );
      if (!mounted) return;
      setState(() => _speechAvailable = available);
    } catch (_) {
      if (mounted) setState(() => _speechAvailable = false);
    }
  }

  Future<void> _startListening(int questionIndex) async {
    if (!_speechAvailable) await _initializeSpeech();
    if (!_speechAvailable) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تشخیص صدا در این دستگاه در دسترس نیست.')));
      return;
    }
    if (_isListening) { await _stopListening(); return; }
    if (!mounted) return;
    setState(() {
      _isListening = true;
      _listeningQuestionIndex = questionIndex;
      _recognizedTexts[questionIndex] = '';
      _speakingResults[questionIndex] = null;
    });
    await _speech.listen(
      onResult: (result) {
        final text = result.recognizedWords;
        if (!mounted) return;
        setState(() => _recognizedTexts[questionIndex] = text);
        if (result.finalResult) _checkSpeakingAnswer(questionIndex, text);
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 4),
      partialResults: true,
      localeId: 'en_US',
      cancelOnError: true,
      listenMode: stt.ListenMode.dictation,
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    if (mounted) setState(() { _isListening = false; _listeningQuestionIndex = null; });
  }

  void _checkSpeakingAnswer(int questionIndex, String spokenText) {
    final normalizedSpoken = _normalizeText(spokenText);
    if (normalizedSpoken.isEmpty) return;
    final question = widget.lesson.speakingQuestions[questionIndex];
    final normalizedQuestion = _normalizeText(question.question);
    final questionWords = normalizedQuestion.split(' ');
    final spokenWords = normalizedSpoken.split(' ');
    int matchedWords = 0;
    for (final word in questionWords) {
      if (spokenWords.contains(word)) matchedWords++;
    }
    final ratio = questionWords.isEmpty ? 0.0 : matchedWords / questionWords.length;
    final isReasonablyRecognized = ratio >= 0.35;
    if (mounted) {
      setState(() {
        _speakingResults[questionIndex] = isReasonablyRecognized;
        _isListening = false;
        _listeningQuestionIndex = null;
      });
      _saveProgress();
    }
  }

  String _normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'''[.,!?;:'"()]'''), ' ')
        .replaceAll("'", '')
        .replaceAll(RegExp(r'\\s+'), ' ')
        .trim();
  }

  bool _allQuestionsAnswered() => widget.lesson.questions.isEmpty || Iterable<int>.generate(widget.lesson.questions.length).every(_questionAnswers.containsKey);
  bool _allFillBlanksAnswered() => widget.lesson.fillBlanks.isEmpty || Iterable<int>.generate(widget.lesson.fillBlanks.length).every(_fillBlankAnswers.containsKey);
  bool _allSpeakingAttempted() => widget.lesson.speakingQuestions.isEmpty || Iterable<int>.generate(widget.lesson.speakingQuestions.length).every(_speakingResults.containsKey);
  bool _allOrderingCompleted() => widget.lesson.sentenceOrdering.isEmpty || Iterable<int>.generate(widget.lesson.sentenceOrdering.length).every(_completedOrderingItems.contains);
  bool _allBuildingCompleted() => widget.lesson.sentenceBuilding.isEmpty || Iterable<int>.generate(widget.lesson.sentenceBuilding.length).every(_completedBuildingItems.contains);
  bool _allMatchingCompleted() => widget.lesson.matching.isEmpty || Iterable<int>.generate(widget.lesson.matching.length).every(_matchedItems.contains);
  bool _allListeningCompleted() => widget.lesson.sentences.isEmpty || Iterable<int>.generate(widget.lesson.sentences.length).every(_listenedItems.contains);

  bool _isPassiveStage(int stage) => stage == 0 || stage == 1 || stage == 2 || stage == 8 || stage == 11 || stage == 12;

  bool _canGoNext() {
    if (_currentStage == 3) return _allQuestionsAnswered();
    if (_currentStage == 4) return _allFillBlanksAnswered();
    if (_currentStage == 5) return _allOrderingCompleted();
    if (_currentStage == 6) return _allMatchingCompleted();
    if (_currentStage == 7) return _allBuildingCompleted();
    if (_currentStage == 9) return _allListeningCompleted();
    if (_currentStage == 10) return _allSpeakingAttempted();
    if (_completedStages.contains(_currentStage)) return true;
    if (_isPassiveStage(_currentStage)) return true;
    return false;
  }

  Future<void> _goNext() async {
    if (!_canGoNext()) return;
    _completedStages.add(_currentStage);
    if (_currentStage < totalStages - 1) {
      setState(() => _currentStage++);
      await _saveProgress();
      return;
    }
    await _saveProgress();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('a2_lesson_completed_${widget.lesson.id}', true);
    await prefs.setInt(_stageKey, totalStages - 1);
    if (!mounted) return;
    final lang = MeowLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(lang.isPersian ? '🎉 درس کامل شد! 😼💜' : '🎉 Lesson completed! 😼💜'),
      duration: const Duration(seconds: 1),
    ));
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  Future<void> _goPrevious() async {
    if (_currentStage <= 0) return;
    setState(() => _currentStage--);
    await _saveProgress();
  }

  String _stageTitle(MeowLocalizations lang) {
    const english = ['Words','Useful Sentences','Grammar','Multiple Choice','Fill in the Blank','Sentence Ordering','Matching','Build the Sentence','Real-Life Conversation','Listening','Speaking Practice','Meow Challenge','Review'];
    const persian = ['کلمات','جمله‌های کاربردی','گرامر','سؤالات چهارگزینه‌ای','جای خالی را پر کن','مرتب کردن جمله','وصل کردن','جمله را بساز','مکالمه واقعی','گوش دادن','تمرین مکالمه','چالش میو','مرور'];
    return lang.isPersian ? persian[_currentStage] : english[_currentStage];
  }

  String _stageInstruction(MeowLocalizations lang) {
    const english = ['Learn the important words for this lesson.','Practice useful everyday sentences.','Learn the grammar you need for this topic.','Answer all questions before continuing.','Complete all of the sentences.','Build every sentence in the correct order.','Match every item correctly.','Build every sentence by selecting the words.','Read and practice the conversation.','Listen to every sentence.','Speak and practice your pronunciation.','Complete the Meow challenge.','Review what you learned.'];
    const persian = ['کلمات مهم این درس را یاد بگیر.','جمله‌های کاربردی روزمره را تمرین کن.','گرامر موردنیاز این موضوع را یاد بگیر.','قبل از ادامه به همه سؤال‌ها پاسخ بده.','همه جمله‌ها را کامل کن.','همه جمله‌ها را به ترتیب درست بساز.','همه موارد را درست به هم وصل کن.','با انتخاب کلمات، همه جمله‌ها را بساز.','مکالمه را بخوان و تمرین کن.','به همه جمله‌ها گوش بده.','صحبت کن و تلفظت را تمرین کن.','چالش میو را کامل کن.','مطالبی را که یاد گرفتی مرور کن.'];
    return lang.isPersian ? persian[_currentStage] : english[_currentStage];
  }

  Widget _buildStage(BuildContext context, MeowLocalizations lang) {
    switch (_currentStage) {
      case 0: return _buildWords(context, lang);
      case 1: return _buildSentences(context, lang);
      case 2: return _buildGrammar(context, lang);
      case 3: return _buildQuestions(context, lang);
      case 4: return _buildFillBlanks(context, lang);
      case 5: return _buildSentenceOrdering(context, lang);
      case 6: return _buildMatching(context, lang);
      case 7: return _buildSentenceBuilding(context, lang);
      case 8: return _buildConversation(context, lang);
      case 9: return _buildListening(context, lang);
      case 10: return _buildSpeaking(context, lang);
      case 11: return _buildChallenge(context, lang);
      case 12: return _buildReview(context, lang);
      default: return const SizedBox();
    }
  }

  Widget _buildWords(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.words.map((word) => _card(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(word.word, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700)), const SizedBox(height: 5), if (lang.isPersian) Text(word.meaning), if (lang.isPersian) const SizedBox(height: 5), Text(word.pronunciation, style: const TextStyle(color: lavender)), const SizedBox(height: 8), Text(word.example, style: const TextStyle(fontStyle: FontStyle.italic)), if (lang.isPersian) ...[const SizedBox(height: 4), Text(word.exampleTranslation)] ])), IconButton(icon: const Icon(Icons.volume_up_rounded), onPressed: () => _speak(word.word)) ]))).toList());
  }

  Widget _buildSentences(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.sentences.map((sentence) => _card(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(sentence.english, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)), const SizedBox(height: 6), Text(sentence.pronunciation, style: const TextStyle(color: lavender)), if (lang.isPersian) ...[const SizedBox(height: 6), Text(sentence.translation)] ])), IconButton(icon: const Icon(Icons.volume_up_rounded), onPressed: () => _speak(sentence.english)) ]))).toList());
  }

  Widget _buildGrammar(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.grammar.map((grammar) => _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(grammar.title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700)), const SizedBox(height: 10), Text(grammar.explanation), if (lang.isPersian && grammar.explanationTranslation.isNotEmpty) ...[const SizedBox(height: 5), Text(grammar.explanationTranslation, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.72)))], const SizedBox(height: 14), ...grammar.examples.asMap().entries.map((entry) { final index = entry.key; final example = entry.value; final translation = index < grammar.exampleTranslations.length ? grammar.exampleTranslations[index] : null; return Padding(padding: const EdgeInsets.only(bottom: 10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(example, style: const TextStyle(fontStyle: FontStyle.italic))), IconButton(icon: const Icon(Icons.volume_up_rounded, size: 20), onPressed: () => _speak(example))]), if (lang.isPersian && translation != null && translation.isNotEmpty) ...[const SizedBox(height: 2), Text(translation, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.72)))] ])); }) ]))).toList());
  }

  Widget _buildQuestions(BuildContext context, MeowLocalizations lang) {
    final total = widget.lesson.questions.length;
    return Column(children: [
      _progressCard(context, lang, _questionAnswers.length, total, lang.isPersian ? 'همه سؤال‌ها را پاسخ بده.' : 'Answer every question before continuing.'),
      const SizedBox(height: 8),
      ...widget.lesson.questions.asMap().entries.map((entry) {
        final index = entry.key;
        final question = entry.value;
        final selected = _questionAnswers[index];
        final questionText = lang.isPersian && question.questionFa != null && question.questionFa!.trim().isNotEmpty ? question.questionFa! : question.question;
        final explanationText = lang.isPersian && question.explanationFa != null && question.explanationFa!.trim().isNotEmpty ? question.explanationFa! : question.explanation;
        return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${index + 1}. $questionText', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...question.options.asMap().entries.map((optionEntry) {
            final optionIndex = optionEntry.key;
            final option = optionEntry.value;
            final isSelected = selected == optionIndex;
            final isCorrect = optionIndex == question.correctIndex;
            Color? background;
            if (isSelected) background = isCorrect ? Colors.green.withOpacity(0.12) : Colors.red.withOpacity(0.12);
            return Padding(padding: const EdgeInsets.only(bottom: 8), child: SizedBox(width: double.infinity, child: OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: background),
              onPressed: selected != null ? null : () { setState(() { _questionAnswers[index] = optionIndex; }); _saveProgress(); },
              child: Align(alignment: Alignment.centerLeft, child: Text(option)),
            )));
          }),
          if (selected != null) ...[
            const SizedBox(height: 8),
            Text(selected == question.correctIndex ? (lang.isPersian ? '✅ درست! 😼💜' : '✅ Correct! 😼💜') : (lang.isPersian ? '❌ این جواب درست نیست.' : '❌ Not quite right.'), style: TextStyle(fontWeight: FontWeight.bold, color: selected == question.correctIndex ? Colors.green : Colors.red)),
            const SizedBox(height: 6),
            Text(explanationText),
          ],
        ]));
      }),
    ]);
  }

  Widget _buildFillBlanks(BuildContext context, MeowLocalizations lang) {
    final total = widget.lesson.fillBlanks.length;
    return Column(children: [
      _progressCard(context, lang, _fillBlankAnswers.length, total, lang.isPersian ? 'همه جای خالی‌ها را کامل کن.' : 'Complete every sentence before continuing.'),
      const SizedBox(height: 8),
      ...widget.lesson.fillBlanks.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final selected = _fillBlankAnswers[index];
        return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${index + 1}. ${item.sentence}', style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: item.options.asMap().entries.map((optionEntry) {
            final optionIndex = optionEntry.key;
            final option = optionEntry.value;
            final isSelected = selected == optionIndex;
            return OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: isSelected ? (optionIndex == item.correctIndex ? Colors.green.withOpacity(0.12) : Colors.red.withOpacity(0.12)) : null),
              onPressed: selected != null ? null : () { setState(() { _fillBlankAnswers[index] = optionIndex; }); _saveProgress(); },
              child: Text(option),
            );
          }).toList()),
          if (selected != null) ...[
            const SizedBox(height: 8),
            Text(selected == item.correctIndex ? (lang.isPersian ? '✅ درست!' : '✅ Correct!') : (lang.isPersian ? '❌ پاسخ نادرست' : '❌ Incorrect'), style: TextStyle(fontWeight: FontWeight.bold, color: selected == item.correctIndex ? Colors.green : Colors.red)),
          ],
        ]));
      }),
    ]);
  }

  Widget _buildSentenceOrdering(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.sentenceOrdering.asMap().entries.map((entry) { final index = entry.key; final item = entry.value; final selected = _orderingSelections[index] ?? []; return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.sentence, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 12), Wrap(spacing: 8, runSpacing: 8, children: item.shuffledWords.map((word) => OutlinedButton(onPressed: _completedOrderingItems.contains(index) ? null : () { setState(() { selected.add(word); }); }, child: Text(word))).toList()), if (selected.isNotEmpty) ...[const SizedBox(height: 10), Text(selected.join(' '))], if (_completedOrderingItems.contains(index)) const Text('✓') ])); }).toList());
  }

  Widget _buildMatching(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.matching.asMap().entries.map((entry) { final index = entry.key; final item = entry.value; final matched = _matchedItems.contains(index); return _card(child: ListTile(title: Text(item.left), subtitle: Text(item.right), trailing: Icon(matched ? Icons.check : Icons.link))); }).toList());
  }

  Widget _buildSentenceBuilding(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.sentenceBuilding.asMap().entries.map((entry) { final index = entry.key; final item = entry.value; final selected = _buildingSelections[index] ?? []; return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.meaning, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 10), Wrap(spacing: 8, children: item.words.map((word) => OutlinedButton(onPressed: _completedBuildingItems.contains(index) ? null : () { setState(() { selected.add(word); }); }, child: Text(word))).toList()), if (selected.isNotEmpty) Text(selected.join(' ')) ])); }).toList());
  }

  Widget _buildConversation(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.conversations.map((item) => _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${item.speaker}: ${item.english}', style: const TextStyle(fontWeight: FontWeight.w700)), Text(item.pronunciation, style: const TextStyle(color: lavender)), if (lang.isPersian) Text(item.translation)])).toList());
  }

  Widget _buildListening(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.sentences.asMap().entries.map((entry) { final index = entry.key; final item = entry.value; final listened = _listenedItems.contains(index); return _card(child: ListTile(title: Text(item.english), subtitle: lang.isPersian ? Text(item.translation) : null, trailing: IconButton(icon: Icon(listened ? Icons.check : Icons.volume_up), onPressed: () async { await _speak(item.english); setState(() => _listenedItems.add(index)); await _saveProgress(); }))); }).toList());
  }

  Widget _buildSpeaking(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.speakingQuestions.asMap().entries.map((entry) { final index = entry.key; final item = entry.value; final result = _speakingResults[index]; return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.question, style: const TextStyle(fontWeight: FontWeight.w700)), Text(item.pronunciation, style: const TextStyle(color: lavender)), const SizedBox(height: 8), Row(children: [Expanded(child: OutlinedButton.icon(onPressed: () => _startListening(index), icon: Icon(_isListening && _listeningQuestionIndex == index ? Icons.stop : Icons.mic), label: Text(_isListening && _listeningQuestionIndex == index ? 'Stop' : 'Speak'))), if (result != null) Padding(padding: const EdgeInsets.only(left: 8), child: Icon(result ? Icons.check_circle : Icons.cancel, color: result ? Colors.green : Colors.red)) ]), if (_recognizedTexts[index]?.isNotEmpty == true) Text(_recognizedTexts[index]!)])); }).toList());
  }

  Widget _buildChallenge(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.challenges.map((item) => _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)), const SizedBox(height: 8), Text(item.instruction), const SizedBox(height: 8), ...item.tasks.map(Text.new)])).toList());
  }

  Widget _buildReview(BuildContext context, MeowLocalizations lang) {
    return Column(children: widget.lesson.reviews.map((item) => _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)), ...item.points.map(Text.new)])).toList());
  }

  Widget _progressCard(BuildContext context, MeowLocalizations lang, int done, int total, String text) {
    return _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(text, style: const TextStyle(fontWeight: FontWeight.w600)), const SizedBox(height: 8), LinearProgressIndicator(value: total == 0 ? 1 : done / total), const SizedBox(height: 5), Text('$done / $total') ]));
  }

  Widget _card({required Widget child}) {
    return Card(elevation: 0, margin: const EdgeInsets.only(bottom: 10), child: Padding(padding: const EdgeInsets.all(16), child: child));
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.lesson.title} • ${_stageTitle(lang)}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Column(
                children: [
                  Text(_stageTitle(lang), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(_stageInstruction(lang), textAlign: TextAlign.center),
                ],
              ),
            ),
            Expanded(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 20), child: _buildStage(context, lang))),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
                child: Row(
                  children: [
                    Expanded(child: OutlinedButton(onPressed: _currentStage == 0 ? null : _goPrevious, child: Text(lang.isPersian ? 'قبلی' : 'Previous'))),
                    const SizedBox(width: 12),
                    Expanded(flex: 2, child: ElevatedButton(onPressed: _canGoNext() ? _goNext : null, child: Text(_currentStage == totalStages - 1 ? (lang.isPersian ? 'تکمیل درس' : 'Complete Lesson') : (lang.isPersian ? 'بعدی' : 'Next')))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}