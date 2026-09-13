import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../lesson_localization.dart';
import '../localization.dart';
import '../models/lesson.dart';
import '../services/a1_progress_service.dart';
import '../services/progress_service.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;

  const LessonPage({
    super.key,
    required this.lesson,
  });

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final PageController _pageController = PageController();
  final Random _random = Random();

  bool practiceStarted = false;
  bool answered = false;
  int selectedAnswer = -1;
  int currentQuestion = 0;
  int score = 0;
  int currentSection = 0;

  bool speechAvailable = false;

  // فقط یک Speech-to-Text می‌تواند همزمان فعال باشد.
  LessonQuestion? _activeSpeechQuestion;

  // وضعیت Speaking هر سؤال جداگانه نگهداری می‌شود.
  final Map<LessonQuestion, bool> _isListeningByQuestion = {};
  final Map<LessonQuestion, String> _recognizedTextByQuestion = {};
  final Map<LessonQuestion, String> _speechMessageByQuestion = {};

  final Map<LessonQuestion, int> _sectionAnswers = {};

  // گزینه‌های تصادفی‌شده برای هر سؤال
  final Map<LessonQuestion, List<String>> _shuffledOptions = {};

  // محل جدید جواب درست بعد از تصادفی شدن گزینه‌ها
  final Map<LessonQuestion, int> _shuffledCorrectIndex = {};

  // سؤال‌های Speaking که قبلاً با موفقیت پاسخ داده شده‌اند.
  final Set<LessonQuestion> _completedSpeakingQuestions = {};

  List<LessonQuestion> get multipleChoiceQuestions {
    final result = <LessonQuestion>[];

    for (final section in widget.lesson.sections) {
      for (final question in section.questions) {
        if (question.type == LessonQuestionType.multipleChoice ||
            question.type == LessonQuestionType.fillBlank) {
          result.add(question);
        }
      }
    }

    return result;
  }

  @override
  void initState() {
    super.initState();

    _shuffleAllQuestionOptions();
    _setupTts();
    _setupSpeech();
  }

  void _shuffleAllQuestionOptions() {
    for (final section in widget.lesson.sections) {
      for (final question in section.questions) {
        if (question.type == LessonQuestionType.multipleChoice ||
            question.type == LessonQuestionType.fillBlank) {
          _createShuffledOptions(question);
        }
      }
    }
  }

  void _createShuffledOptions(LessonQuestion question) {
    final originalOptions = List<String>.from(question.options);

    if (originalOptions.isEmpty) {
      _shuffledOptions[question] = [];
      _shuffledCorrectIndex[question] = -1;
      return;
    }

    final correctAnswer = question.correctAnswer;

    originalOptions.shuffle(_random);

    _shuffledOptions[question] = originalOptions;

    _shuffledCorrectIndex[question] =
        originalOptions.indexOf(correctAnswer);
  }

  List<String> _optionsFor(LessonQuestion question) {
    return _shuffledOptions[question] ??
        List<String>.from(question.options);
  }

  int _correctIndexFor(LessonQuestion question) {
    return _shuffledCorrectIndex[question] ??
        question.correctIndex;
  }

  @override
  void dispose() {
    _speech.stop();
    _tts.stop();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _setupTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);
  }

  Future<void> _setupSpeech() async {
    try {
      final available = await _speech.initialize(
        onStatus: (status) {
          if (!mounted) return;

          if (status == 'done' || status == 'notListening') {
            final activeQuestion = _activeSpeechQuestion;

            if (activeQuestion != null) {
              setState(() {
                _isListeningByQuestion[activeQuestion] = false;
              });
            }

            _activeSpeechQuestion = null;
          }
        },
        onError: (error) {
          if (!mounted) return;

          final activeQuestion = _activeSpeechQuestion;

          if (activeQuestion != null) {
            setState(() {
              _isListeningByQuestion[activeQuestion] = false;
              _speechMessageByQuestion[activeQuestion] =
                  'Speech recognition error.';
            });
          }

          _activeSpeechQuestion = null;
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

  Future<void> _speak(String text) async {
    if (text.trim().isEmpty) return;

    await _tts.stop();
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);
    await _tts.speak(text);
  }

  Future<void> _startListening(LessonQuestion question) async {
    if (!speechAvailable) {
      await _setupSpeech();
    }

    if (!speechAvailable) {
      if (!mounted) return;

      setState(() {
        _speechMessageByQuestion[question] =
            'Speech recognition is not available on this device.';
      });

      return;
    }

    // اگر سؤال دیگری در حال گوش دادن است، همان را متوقف می‌کنیم.
    if (_activeSpeechQuestion != null &&
        _activeSpeechQuestion != question) {
      final previousQuestion = _activeSpeechQuestion;

      await _speech.stop();

      if (mounted && previousQuestion != null) {
        setState(() {
          _isListeningByQuestion[previousQuestion] = false;
        });
      }
    }

    // قبل از شروع ضبط، صدای TTS قطع می‌شود.
    await _tts.stop();

    _activeSpeechQuestion = question;

    if (!mounted) return;

    setState(() {
      _isListeningByQuestion[question] = true;
      _recognizedTextByQuestion[question] = '';
      _speechMessageByQuestion[question] = '';
    });

    await _speech.listen(
      onResult: (result) {
        if (!mounted) return;

        setState(() {
          _recognizedTextByQuestion[question] =
              result.recognizedWords;
        });

        if (result.finalResult) {
          _checkSpeechAnswer(question);
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

  Future<void> _stopListening(LessonQuestion question) async {
    await _speech.stop();

    if (_activeSpeechQuestion == question) {
      _activeSpeechQuestion = null;
    }

    if (!mounted) return;

    setState(() {
      _isListeningByQuestion[question] = false;
    });

    await _checkSpeechAnswer(question);
  }

  Future<void> _checkSpeechAnswer(
    LessonQuestion question,
  ) async {
    final spoken =
        _normalizeSpeech(_recognizedTextByQuestion[question] ?? '');

    final target =
        _normalizeSpeech(question.correctAnswer);

    if (spoken.isEmpty || target.isEmpty) {
      if (!mounted) return;

      setState(() {
        _speechMessageByQuestion[question] =
            'I could not understand your answer. Try again.';
      });

      return;
    }

    final similarity = _similarity(spoken, target);

    if (similarity >= 0.78) {
      if (mounted) {
        setState(() {
          _speechMessageByQuestion[question] =
              'Correct! 🎉';
        });
      }

      // میو بعد از جواب درست با صدا می‌گوید Correct.
      await _speak('Correct!');

      // هر سؤال فقط یک بار در Speaking Sessions ثبت می‌شود.
      if (!_completedSpeakingQuestions.contains(question)) {
        _completedSpeakingQuestions.add(question);

        await ProgressService.addSpeakingSession();
      }
    } else {
      if (!mounted) return;

      setState(() {
        _speechMessageByQuestion[question] =
            'Not quite. Try again and listen carefully.';
      });
    }
  }

  String _normalizeSpeech(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r"[^\w\s']"), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  double _similarity(String first, String second) {
    if (first == second) return 1.0;

    if (first.isEmpty || second.isEmpty) return 0.0;

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

  void startPractice() {
    if (multipleChoiceQuestions.isEmpty) {
      return;
    }

    for (final question in multipleChoiceQuestions) {
      _createShuffledOptions(question);
    }

    setState(() {
      practiceStarted = true;
      currentQuestion = 0;
      score = 0;
      answered = false;
      selectedAnswer = -1;
    });
  }

  void selectAnswer(int index) {
    if (answered) return;

    final question =
        multipleChoiceQuestions[currentQuestion];

    final correctIndex =
        _correctIndexFor(question);

    setState(() {
      selectedAnswer = index;
      answered = true;

      if (index == correctIndex) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestion <
        multipleChoiceQuestions.length - 1) {
      setState(() {
        currentQuestion++;
        answered = false;
        selectedAnswer = -1;
      });
    } else {
      _showResult();
    }
  }

  void nextSection() {
    if (currentSection <
        widget.lesson.sections.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void previousSection() {
    if (currentSection > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _showResult() {
    final lang = MeowLocalizations.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          lang.isPersian
              ? 'تمرین تموم شد! 🎉'
              : 'Practice Complete! 🎉',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          lang.isPersian
              ? 'از ${multipleChoiceQuestions.length} سؤال، '
                  '$score تا رو درست جواب دادی.\n\n'
                  '+${widget.lesson.xp} XP ⭐'
              : 'You got $score out of '
                  '${multipleChoiceQuestions.length} correct.\n\n'
                  '+${widget.lesson.xp} XP ⭐',
          style: const TextStyle(
            height: 1.5,
          ),
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: lavender,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
            ),
            onPressed: () async {
              await ProgressService.addPracticeSession();

              await A1ProgressService.completeLesson(
                widget.lesson.id,
              );

              if (!mounted) return;

              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              lang.isPersian ? 'پایان' : 'Finish',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    final lessonLang = LessonLocalization(
      Localizations.localeOf(context),
    );

    final lessonTitle = lessonLang.lessonTitle(
      widget.lesson.id,
      widget.lesson.title,
    );

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lessonTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: practiceStarted
          ? _buildPractice(context, lang)
          : _buildLessonContent(
              context,
              lang,
              lessonLang,
            ),
    );
  }

  Widget _buildLessonContent(
    BuildContext context,
    MeowLocalizations lang,
    LessonLocalization lessonLang,
  ) {
    final lessonTitle = lessonLang.lessonTitle(
      widget.lesson.id,
      widget.lesson.title,
    );

    final lessonDescription =
        lessonLang.lessonDescription(
      widget.lesson.id,
      widget.lesson.description,
    );

    final sections = widget.lesson.sections;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        110,
      ),
      children: [
        Text(
          lessonTitle,
          style: const TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          lessonDescription,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        _buildLessonInfoCard(
          context,
          lang,
        ),
        const SizedBox(height: 22),
        if (sections.isNotEmpty) ...[
          _buildSectionProgress(
            context,
            lang,
            lessonLang,
            sections,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 500,
            child: PageView.builder(
              controller: _pageController,
              itemCount: sections.length,
              onPageChanged: (index) {
                setState(() {
                  currentSection = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 4,
                  ),
                  child: _buildSection(
                    context,
                    sections[index],
                    lang,
                    lessonLang,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          _buildSectionNavigation(
            context,
            lang,
            sections.length,
          ),
          const SizedBox(height: 20),
        ],
        _buildStartPracticeButton(
          context,
          lang,
        ),
      ],
    );
  }

  Widget _buildSectionProgress(
    BuildContext context,
    MeowLocalizations lang,
    LessonLocalization lessonLang,
    List<LessonSection> sections,
  ) {
    final section = sections[currentSection];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: lavender.withOpacity(0.12),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: lavender.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _sectionIcon(section.type),
              color: lavender,
              size: 20,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  lessonLang.sectionTitle(
                    section.title,
                  ),
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  lang.isPersian
                      ? 'بخش ${currentSection + 1} از ${sections.length}'
                      : 'Section ${currentSection + 1} of ${sections.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionNavigation(
    BuildContext context,
    MeowLocalizations lang,
    int totalSections,
  ) {
    final isFirst = currentSection == 0;
    final isLast =
        currentSection == totalSections - 1;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed:
                isFirst ? null : previousSection,
            style: OutlinedButton.styleFrom(
              foregroundColor: lavender,
              disabledForegroundColor:
                  Colors.grey.withOpacity(0.35),
              side: BorderSide(
                color: isFirst
                    ? Colors.grey.withOpacity(0.12)
                    : lavender.withOpacity(0.30),
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),
              padding:
                  const EdgeInsets.symmetric(
                vertical: 14,
              ),
            ),
            icon: Icon(
              lang.isPersian
                  ? Icons.arrow_forward_rounded
                  : Icons.arrow_back_rounded,
            ),
            label: Text(
              lang.isPersian
                  ? 'قبلی'
                  : 'Previous',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.icon(
            onPressed:
                isLast ? null : nextSection,
            style: FilledButton.styleFrom(
              backgroundColor: lavender,
              foregroundColor: Colors.white,
              disabledBackgroundColor:
                  lavender.withOpacity(0.18),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),
              padding:
                  const EdgeInsets.symmetric(
                vertical: 14,
              ),
            ),
            icon: Icon(
              lang.isPersian
                  ? Icons.arrow_back_rounded
                  : Icons.arrow_forward_rounded,
            ),
            label: Text(
              lang.isPersian
                  ? 'بعدی'
                  : 'Next',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLessonInfoCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.10),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: lavender.withOpacity(0.14),
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
            child: const Icon(
              Icons.auto_stories_rounded,
              color: lavender,
              size: 27,
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
                      ? 'درس ${widget.lesson.id.replaceAll('a1_', '')}'
                      : 'Lesson ${widget.lesson.id.replaceAll('a1_', '')}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 17,
                      color: lavender,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${widget.lesson.xp} XP',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: lavender,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartPracticeButton(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    final hasQuestions =
        multipleChoiceQuestions.isNotEmpty;

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: lavender,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),
          padding:
              const EdgeInsets.symmetric(
            vertical: 17,
          ),
        ),
        onPressed:
            hasQuestions ? startPractice : null,
        child: Text(
          lang.isPersian
              ? 'شروع تمرین 🐱'
              : 'Start Practice 🐱',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    LessonSection section,
    MeowLocalizations lang,
    LessonLocalization lessonLang,
  ) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.withOpacity(0.14),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: lavender.withOpacity(0.13),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _sectionIcon(section.type),
                  color: lavender,
                  size: 25,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  lessonLang.sectionTitle(
                    section.title,
                  ),
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          if (section.explanation.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              lessonLang.sectionExplanation(
                section.explanation,
              ),
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.grey,
              ),
            ),
          ],
          const SizedBox(height: 15),
          ...section.items.map(
            (item) => _buildLessonItem(
              context,
              item,
              lang,
              lessonLang,
            ),
          ),
          ...section.questions.map(
            (question) => _buildSectionQuestion(
              context,
              question,
              lang,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonItem(
    BuildContext context,
    LessonItem item,
    MeowLocalizations lang,
    LessonLocalization lessonLang,
  ) {
    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.07),
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: lavender.withOpacity(0.10),
        ),
      ),
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
                  item.english,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Material(
                color:
                    lavender.withOpacity(0.12),
                shape: const CircleBorder(),
                child: IconButton(
                  tooltip: lang.isPersian
                      ? 'پخش تلفظ'
                      : 'Play pronunciation',
                  onPressed: () =>
                      _speak(item.english),
                  icon: const Icon(
                    Icons.volume_up_rounded,
                    color: lavender,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.persian,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          if (item.pronunciation.isNotEmpty) ...[
            const SizedBox(height: 9),
            Text(
              item.pronunciation,
              style: const TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
          if (item.example.isNotEmpty) ...[
            const SizedBox(height: 9),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surface
                    .withOpacity(0.75),
                borderRadius:
                    BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    item.example,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  if (item.examplePersian
                      .isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.examplePersian,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionQuestion(
    BuildContext context,
    LessonQuestion question,
    MeowLocalizations lang,
  ) {
    if (question.type ==
        LessonQuestionType.readAloud) {
      return _buildSpeakingCard(
        context,
        question,
        lang,
        readAloud: true,
      );
    }

    if (question.type ==
        LessonQuestionType.speaking) {
      return _buildSpeakingCard(
        context,
        question,
        lang,
        readAloud: false,
      );
    }

    return _buildSmallMultipleChoice(
      context,
      question,
      lang,
    );
  }

  Widget _buildSmallMultipleChoice(
    BuildContext context,
    LessonQuestion question,
    MeowLocalizations lang,
  ) {
    final selected = _sectionAnswers[question];
    final hasAnswered = selected != null;

    final options = _optionsFor(question);
    final correctIndex = _correctIndexFor(question);

    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.surface,
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: lavender.withOpacity(0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            question.prompt,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (question.promptPersian.isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.only(top: 4),
              child: Text(
                question.promptPersian,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          if (question.sentence.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              question.sentence,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const SizedBox(height: 12),
          ...List.generate(
            options.length,
            (index) {
              final isSelected = selected == index;
              final isCorrect = index == correctIndex;

              Color backgroundColor;
              Color borderColor;
              Color textColor;

              if (!hasAnswered) {
                backgroundColor =
                    Theme.of(context)
                        .colorScheme
                        .surface;
                borderColor =
                    Colors.grey.withOpacity(0.14);
                textColor =
                    Theme.of(context)
                        .colorScheme
                        .onSurface;
              } else if (isCorrect) {
                backgroundColor =
                    Colors.green.withOpacity(0.10);
                borderColor =
                    Colors.green.withOpacity(0.35);
                textColor =
                    Colors.green.shade700;
              } else if (isSelected) {
                backgroundColor =
                    Colors.redAccent
                        .withOpacity(0.10);
                borderColor =
                    Colors.redAccent
                        .withOpacity(0.35);
                textColor = Colors.redAccent;
              } else {
                backgroundColor =
                    Theme.of(context)
                        .colorScheme
                        .surface;
                borderColor =
                    Colors.grey.withOpacity(0.12);
                textColor =
                    Theme.of(context)
                        .colorScheme
                        .onSurface;
              }

              return Container(
                margin:
                    const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(14),
                  onTap: hasAnswered
                      ? null
                      : () {
                          setState(() {
                            _sectionAnswers[
                                question] = index;
                          });
                        },
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius:
                          BorderRadius.circular(14),
                      border: Border.all(
                        color: borderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            options[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        if (hasAnswered && isCorrect)
                          const Icon(
                            Icons
                                .check_circle_rounded,
                            color: Colors.green,
                            size: 20,
                          )
                        else if (hasAnswered &&
                            isSelected)
                          const Icon(
                            Icons.cancel_rounded,
                            color: Colors.redAccent,
                            size: 20,
                          )
                        else
                          const Icon(
                            Icons
                                .arrow_forward_ios_rounded,
                            size: 14,
                            color: Colors.grey,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (hasAnswered) ...[
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color:
                    selected == correctIndex
                        ? Colors.green
                            .withOpacity(0.08)
                        : Colors.orange
                            .withOpacity(0.08),
                borderRadius:
                    BorderRadius.circular(13),
              ),
              child: Text(
                selected == correctIndex
                    ? (lang.isPersian
                        ? 'درست گفتی! 🎉'
                        : 'Correct! 🎉')
                    : (lang.isPersian
                        ? 'جواب درست: ${question.correctAnswer}'
                        : 'Correct answer: ${question.correctAnswer}'),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      FontWeight.w700,
                  color:
                      selected == correctIndex
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSpeakingCard(
    BuildContext context,
    LessonQuestion question,
    MeowLocalizations lang, {
    required bool readAloud,
  }) {
    final isListening =
        _isListeningByQuestion[question] ?? false;

    final recognizedText =
        _recognizedTextByQuestion[question] ?? '';

    final speechResultMessage =
        _speechMessageByQuestion[question] ?? '';

    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.08),
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: lavender.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            question.prompt,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (question.promptPersian.isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.only(top: 4),
              child: Text(
                question.promptPersian,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          const SizedBox(height: 12),
          if (question.sentence.isNotEmpty)
            Text(
              question.sentence,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )
          else
            Text(
              question.correctAnswer,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _speak(
                    question.sentence.isNotEmpty
                        ? question.sentence
                        : question.correctAnswer,
                  ),
                  icon: const Icon(
                    Icons.volume_up_rounded,
                  ),
                  label: Text(
                    lang.isPersian
                        ? 'پخش صدا'
                        : 'Play',
                  ),
                  style:
                      OutlinedButton.styleFrom(
                    foregroundColor: lavender,
                    side: BorderSide(
                      color:
                          lavender.withOpacity(0.3),
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: isListening
                      ? () => _stopListening(
                            question,
                          )
                      : () => _startListening(
                            question,
                          ),
                  icon: Icon(
                    isListening
                        ? Icons.stop_rounded
                        : Icons.mic_rounded,
                  ),
                  label: Text(
                    isListening
                        ? (lang.isPersian
                            ? 'توقف'
                            : 'Stop')
                        : (lang.isPersian
                            ? 'بگو 🎤'
                            : 'Speak 🎤'),
                  ),
                  style:
                      FilledButton.styleFrom(
                    backgroundColor:
                        isListening
                            ? Colors.redAccent
                            : lavender,
                    foregroundColor:
                        Colors.white,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isListening) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration:
                      const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 7),
                Text(
                  lang.isPersian
                      ? 'دارم گوش می‌دم...'
                      : 'Listening...',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.redAccent,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          if (recognizedText.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surface,
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Text(
                recognizedText,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ],
          if (speechResultMessage.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              speechResultMessage,
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    FontWeight.w700,
                color:
                    speechResultMessage
                            .startsWith('Correct')
                        ? Colors.green
                        : Colors.orange,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _sectionIcon(String type) {
    switch (type.toLowerCase()) {
      case 'vocabulary':
      case 'numbers':
      case 'vocabulary review':
        return Icons.menu_book_rounded;

      case 'phrases':
      case 'useful phrases':
        return Icons.chat_bubble_outline_rounded;

      case 'grammar':
      case 'grammar review':
        return Icons.school_rounded;

      case 'examples':
      case 'real-life examples':
        return Icons.public_rounded;

      case 'real_english':
      case 'real english':
        return Icons.forum_rounded;

      case 'practice':
      case 'final practice':
        return Icons.edit_rounded;

      case 'speaking':
        return Icons.mic_rounded;

      case 'read_aloud':
      case 'read it':
        return Icons.record_voice_over_rounded;

      case 'conversation':
      case 'mini conversation':
        return Icons.forum_rounded;

      case 'review':
        return Icons.refresh_rounded;

      case 'mistakes':
      case 'common mistakes':
        return Icons.warning_amber_rounded;

      default:
        return Icons.auto_stories_rounded;
    }
  }

  Widget _buildPractice(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    final question =
        multipleChoiceQuestions[currentQuestion];

    final options = _optionsFor(question);
    final correctIndex = _correctIndexFor(question);

    final progress =
        (currentQuestion + 1) /
            multipleChoiceQuestions.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        20,
        8,
        20,
        110,
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: lavender.withOpacity(0.10),
            borderRadius:
                BorderRadius.circular(24),
            border: Border.all(
              color:
                  lavender.withOpacity(0.14),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.psychology_rounded,
                    color: lavender,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    lang.isPersian
                        ? 'تمرین چندگزینه‌ای'
                        : 'Multiple Choice',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),
                child:
                    LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor:
                      lavender.withOpacity(
                    0.16,
                  ),
                  valueColor:
                      const AlwaysStoppedAnimation<
                          Color>(
                    lavender,
                  ),
                ),
              ),
              const SizedBox(height: 9),
              Text(
                lang.isPersian
                    ? 'سؤال ${currentQuestion + 1} از ${multipleChoiceQuestions.length}'
                    : 'Question ${currentQuestion + 1} of ${multipleChoiceQuestions.length}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surface,
            borderRadius:
                BorderRadius.circular(24),
            border: Border.all(
              color:
                  Colors.grey.withOpacity(0.14),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                question.prompt,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight:
                      FontWeight.w700,
                  height: 1.35,
                ),
              ),
              if (question.promptPersian
                  .isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  question.promptPersian,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
              if (question.sentence
                  .isNotEmpty) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        question.sentence,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          _speak(
                        question.sentence,
                      ),
                      icon: const Icon(
                        Icons
                            .volume_up_rounded,
                        color: lavender,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          options.length,
          (index) {
            final isSelected =
                selectedAnswer == index;
            final isCorrect =
                index == correctIndex;

            return Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 11,
              ),
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(20),
                onTap: answered
                    ? null
                    : () => selectAnswer(index),
                child: Container(
                  padding:
                      const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color:
                        _answerBackground(
                      context,
                      index,
                      isSelected,
                      isCorrect,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                    border: Border.all(
                      color: _answerBorder(
                        index,
                        isSelected,
                        isCorrect,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          options[index],
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                      _answerIcon(
                        index,
                        isSelected,
                        isCorrect,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (answered) ...[
          const SizedBox(height: 4),
          Container(
            padding:
                const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  selectedAnswer ==
                          correctIndex
                      ? Colors.green
                          .withOpacity(0.10)
                      : Colors.orange
                          .withOpacity(0.10),
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Text(
              selectedAnswer ==
                      correctIndex
                  ? (lang.isPersian
                      ? 'درست گفتی! 🎉'
                      : 'Correct! 🎉')
                  : (lang.isPersian
                      ? 'جواب درست: ${question.correctAnswer}'
                      : 'Correct answer: ${question.correctAnswer}'),
              style: const TextStyle(
                fontSize: 15,
                fontWeight:
                    FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          if (question.explanation
              .isNotEmpty)
            Text(
              question.explanation,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                height: 1.4,
              ),
              textAlign:
                  TextAlign.center,
            ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    lavender,
                foregroundColor:
                    Colors.white,
                elevation: 0,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),
                padding:
                    const EdgeInsets
                        .symmetric(
                  vertical: 16,
                ),
              ),
              onPressed: nextQuestion,
              child: Text(
                currentQuestion ==
                        multipleChoiceQuestions
                                .length -
                            1
                    ? (lang.isPersian
                        ? 'پایان تمرین'
                        : 'Finish Practice')
                    : (lang.isPersian
                        ? 'سؤال بعدی →'
                        : 'Next Question →'),
                style:
                    const TextStyle(
                  fontSize: 17,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _answerBackground(
    BuildContext context,
    int index,
    bool isSelected,
    bool isCorrect,
  ) {
    if (!answered) {
      return Theme.of(context)
          .colorScheme
          .surface;
    }

    if (isCorrect) {
      return Colors.green.withOpacity(0.10);
    }

    if (isSelected) {
      return Colors.redAccent.withOpacity(0.10);
    }

    return Theme.of(context)
        .colorScheme
        .surface;
  }

  Color _answerBorder(
    int index,
    bool isSelected,
    bool isCorrect,
  ) {
    if (!answered) {
      return Colors.grey.withOpacity(0.14);
    }

    if (isCorrect) {
      return Colors.green.withOpacity(0.30);
    }

    if (isSelected) {
      return Colors.redAccent.withOpacity(0.30);
    }

    return Colors.grey.withOpacity(0.12);
  }

  Widget _answerIcon(
    int index,
    bool isSelected,
    bool isCorrect,
  ) {
    if (!answered) {
      return const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 17,
        color: Colors.grey,
      );
    }

    if (isCorrect) {
      return const Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
      );
    }

    if (isSelected) {
      return const Icon(
        Icons.cancel_rounded,
        color: Colors.redAccent,
      );
    }

    return const Icon(
      Icons.circle_outlined,
      color: Colors.grey,
    );
  }
}