import 'package:flutter/material.dart';

import '../localization.dart';
import '../models/lesson.dart';
import '../services/lesson_service.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
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

  Lesson get lesson => LessonService.a1Lessons.first;

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
        title: Text(
          lang.isPersian
              ? 'درس تموم شد! 🎉'
              : 'Lesson Complete! 🎉',
        ),
        content: Text(
          lang.isPersian
              ? 'از ${questions.length} سؤال، $score تا رو درست جواب دادی.\n\n+${lesson.xp} XP ⭐'
              : 'You got $score out of ${questions.length} correct.\n\n+${lesson.xp} XP ⭐',
        ),
        actions: [
          FilledButton(
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${lesson.title} 📚',
        ),
      ),
      body: practiceStarted
          ? _buildPractice(context, lang)
          : _buildLessonContent(context, lang),
    );
  }

  Widget _buildLessonContent(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          lesson.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          lesson.description,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.7),
          ),
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                '+${lesson.xp} XP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        ...lesson.sections.map(
          (section) => _buildSection(
            context,
            section,
            lang,
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: startPractice,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                lang.isPersian
                    ? 'شروع تمرین 🐱'
                    : 'Start Practice 🐱',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    LessonSection section,
    MeowLocalizations lang,
  ) {
    IconData icon;

    switch (section.type.toLowerCase()) {
      case 'vocabulary':
        icon = Icons.menu_book_rounded;
        break;
      case 'phrases':
      case 'useful phrases':
        icon = Icons.chat_bubble_outline_rounded;
        break;
      case 'grammar':
        icon = Icons.school_rounded;
        break;
      case 'examples':
      case 'real-life examples':
        icon = Icons.public_rounded;
        break;
      case 'practice':
        icon = Icons.edit_rounded;
        break;
      case 'speaking':
      case 'mini conversation':
        icon = Icons.mic_rounded;
        break;
      case 'review':
        icon = Icons.refresh_rounded;
        break;
      default:
        icon = Icons.auto_stories_rounded;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  child: Icon(icon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            if (section.explanation.isNotEmpty) ...[
              const SizedBox(height: 14),
              Text(
                section.explanation,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
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
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLessonItem(
    BuildContext context,
    LessonItem item,
    MeowLocalizations lang,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.english,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            item.persian,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
            ),
          ),

          if (item.pronunciation.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.volume_up_outlined,
                  size: 17,
                ),
                const SizedBox(width: 5),
                Text(
                  item.pronunciation,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],

          if (item.example.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              lang.isPersian
                  ? 'مثال: ${item.example}'
                  : 'Example: ${item.example}',
              style: const TextStyle(
                fontSize: 14,
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

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        LinearProgressIndicator(
          value: (currentQuestion + 1) / questions.length,
          minHeight: 7,
          borderRadius: BorderRadius.circular(10),
        ),

        const SizedBox(height: 20),

        Text(
          lang.isPersian
              ? 'سؤال ${currentQuestion + 1} از ${questions.length}'
              : 'Question ${currentQuestion + 1} of ${questions.length}',
          style: const TextStyle(
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          question['question'] as String,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 24),

        ...List.generate(
          answers.length,
          (index) {
            final isSelected = selectedAnswer == index;
            final isCorrect = index == correct;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  answers[index],
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                trailing: answered
                    ? Icon(
                        isCorrect
                            ? Icons.check_circle
                            : isSelected
                                ? Icons.cancel
                                : Icons.circle_outlined,
                      )
                    : const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                onTap: () => selectAnswer(index),
              ),
            );
          },
        ),

        if (answered) ...[
          const SizedBox(height: 10),

          Text(
            selectedAnswer == correct
                ? (lang.isPersian
                    ? 'درست گفتی! 🎉'
                    : 'Correct! 🎉')
                : (lang.isPersian
                    ? 'تقریباً! دوباره تمرین کن 💪'
                    : 'Not quite. Keep practicing! 💪'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: nextQuestion,
              child: Padding(
                padding: const EdgeInsets.all(14),
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}