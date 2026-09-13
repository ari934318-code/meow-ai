import 'package:flutter/material.dart';

import '../lesson_localization.dart';
import '../localization.dart';
import '../models/lesson.dart';

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

  bool practiceStarted = false;
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  int? selectedAnswer;

  final List<Map<String, dynamic>> questions = const [
    {
      'question': 'How do you say "سلام" in English?',
      'answers': ['Hello', 'Goodbye', 'Thanks', 'Sorry'],
      'correct': 0,
    },
    {
      'question': 'What does "Good morning" mean?',
      'answers': ['شب بخیر', 'صبح بخیر', 'خداحافظ', 'ممنون'],
      'correct': 1,
    },
    {
      'question': 'How do you answer "How are you?"',
      'answers': [
        'I am good, thank you!',
        'Good morning!',
        'Goodbye!',
        'Hello!',
      ],
      'correct': 0,
    },
  ];

  void startPractice() {
    setState(() {
      practiceStarted = true;
      currentQuestion = 0;
      score = 0;
      answered = false;
      selectedAnswer = null;
    });
  }

  void selectAnswer(int index) {
    if (answered) return;

    final correct = questions[currentQuestion]['correct'] as int;

    setState(() {
      selectedAnswer = index;
      answered = true;

      if (index == correct) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        answered = false;
        selectedAnswer = null;
      });
    } else {
      _showResult();
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
              ? 'درس تموم شد! 🎉'
              : 'Lesson Complete! 🎉',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          lang.isPersian
              ? 'از ${questions.length} سؤال، $score تا رو درست جواب دادی.\n\n+${widget.lesson.xp} XP ⭐'
              : 'You got $score out of ${questions.length} correct.\n\n+${widget.lesson.xp} XP ⭐',
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
            onPressed: () {
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

    final lessonDescription = lessonLang.lessonDescription(
      widget.lesson.id,
      widget.lesson.description,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
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

        const SizedBox(height: 20),

        ...widget.lesson.sections.map(
          (section) => _buildSection(
            context,
            section,
            lang,
            lessonLang,
          ),
        ),

        const SizedBox(height: 4),

        _buildStartPracticeButton(
          context,
          lang,
        ),

        const SizedBox(height: 20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: lavender,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 17,
          ),
        ),
        onPressed: startPractice,
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
    final icon = _sectionIcon(section.type);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.grey.withOpacity(0.14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    icon,
                    color: lavender,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    lessonLang.sectionTitle(section.title),
                    style: const TextStyle(
                      fontSize: 17,
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

            if (section.items.isNotEmpty) ...[
              const SizedBox(height: 16),
              ...section.items.map(
                (item) => _buildLessonItem(
                  context,
                  item,
                  lang,
                  lessonLang,
                ),
              ),
            ],
          ],
        ),
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

      case 'practice':
      case 'final practice':
        return Icons.edit_rounded;

      case 'speaking':
      case 'mini conversation':
        return Icons.mic_rounded;

      case 'review':
        return Icons.refresh_rounded;

      default:
        return Icons.auto_stories_rounded;
    }
  }

  Widget _buildLessonItem(
    BuildContext context,
    LessonItem item,
    MeowLocalizations lang,
    LessonLocalization lessonLang,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: lavender.withOpacity(0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.english,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
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
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  size: 17,
                  color: lavender,
                ),
                const SizedBox(width: 6),
                Text(
                  item.pronunciation,
                  style: const TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],

          if (item.example.isNotEmpty) ...[
            const SizedBox(height: 9),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surface
                    .withOpacity(0.75),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text(
                lessonLang.exampleLabel(item.example),
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPractice(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    final question = questions[currentQuestion];
    final answers = question['answers'] as List<String>;
    final correct = question['correct'] as int;

    final progress =
        (currentQuestion + 1) / questions.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: lavender.withOpacity(0.10),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: lavender.withOpacity(0.14),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        ? 'تمرین با میو'
                        : 'Practice with Meow',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor:
                      lavender.withOpacity(0.16),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(
                    lavender,
                  ),
                ),
              ),
              const SizedBox(height: 9),
              Text(
                lang.isPersian
                    ? 'سؤال ${currentQuestion + 1} از ${questions.length}'
                    : 'Question ${currentQuestion + 1} of ${questions.length}',
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
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.grey.withOpacity(0.14),
            ),
          ),
          child: Text(
            question['question'] as String,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ),

        const SizedBox(height: 16),

        ...List.generate(
          answers.length,
          (index) {
            final isSelected = selectedAnswer == index;
            final isCorrect = index == correct;

            return Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => selectAnswer(index),
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: _answerBackground(
                      context,
                      index,
                      isSelected,
                      isCorrect,
                    ),
                    borderRadius: BorderRadius.circular(20),
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
                          answers[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: selectedAnswer == correct
                  ? const Color(0xFF4CAF50).withOpacity(0.10)
                  : const Color(0xFFFF9800).withOpacity(0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              selectedAnswer == correct
                  ? (lang.isPersian
                      ? 'درست گفتی! 🎉'
                      : 'Correct! 🎉')
                  : (lang.isPersian
                      ? 'تقریباً! دوباره تمرین کن 💪'
                      : 'Not quite. Keep practicing! 💪'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: lavender,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
              onPressed: nextQuestion,
              child: Text(
                currentQuestion == questions.length - 1
                    ? (lang.isPersian
                        ? 'پایان درس'
                        : 'Finish Lesson')
                    : (lang.isPersian
                        ? 'سؤال بعدی →'
                        : 'Next Question →'),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
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
      return Theme.of(context).colorScheme.surface;
    }

    if (isCorrect) {
      return const Color(0xFF4CAF50).withOpacity(0.10);
    }

    if (isSelected) {
      return const Color(0xFFE57373).withOpacity(0.10);
    }

    return Theme.of(context).colorScheme.surface;
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
      return const Color(0xFF4CAF50).withOpacity(0.30);
    }

    if (isSelected) {
      return const Color(0xFFE57373).withOpacity(0.30);
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
        color: Color(0xFF4CAF50),
      );
    }

    if (isSelected) {
      return const Icon(
        Icons.cancel_rounded,
        color: Color(0xFFE57373),
      );
    }

    return const Icon(
      Icons.circle_outlined,
      color: Colors.grey,
    );
  }
}