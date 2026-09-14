import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
                    lesson.topic,
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
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _speechAvailable = false;
  bool _isListening = false;
  int? _listeningQuestionIndex;

  final Map<int, String> _recognizedTexts = {};
  final Map<int, bool?> _speakingResults = {};

  final Map<int, int> _questionAnswers = {};
  final Map<int, int> _fillBlankAnswers = {};

  @override
  void initState() {
    super.initState();
    _setupTts();
    _initializeSpeech();
  }

  Future<void> _setupTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
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

          ScaffoldMessenger.of(context).showSnackBar(
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
        ScaffoldMessenger.of(context).showSnackBar(
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
      _listeningQuestionIndex = questionIndex;
      _recognizedTexts[questionIndex] = '';
      _speakingResults[questionIndex] = null;
    });

    await _speech.listen(
      onResult: (result) {
        if (!mounted) return;

        final text = result.recognizedWords.trim();

        setState(() {
          _recognizedTexts[questionIndex] = text;
        });

        if (result.finalResult) {
          _checkSpeakingAnswer(
            questionIndex,
            text,
          );
        }
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
    final question =
        widget.lesson.speakingQuestions[questionIndex];

    final normalizedSpoken =
        _normalizeText(spokenText);

    if (normalizedSpoken.isEmpty) {
      return;
    }

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
        : matchedWords / questionWords.length;

    final isReasonablyRecognized =
        ratio >= 0.35;

    if (mounted) {
      setState(() {
        _speakingResults[questionIndex] =
            isReasonablyRecognized;

        _isListening = false;
        _listeningQuestionIndex = null;
      });
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

  @override
  void dispose() {
    _tts.stop();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            lesson.topic,
            style: Theme.of(context)
                .textTheme
                .headlineSmall,
          ),
          const SizedBox(height: 24),

          _sectionTitle(
            context,
            'Words',
            'کلمات',
          ),

          ...lesson.words.map(
            (word) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(14),
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(word.meaning),
                          const SizedBox(height: 4),
                          Text(
                            word.pronunciation,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            word.example,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            word.exampleTranslation,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up),
                      on