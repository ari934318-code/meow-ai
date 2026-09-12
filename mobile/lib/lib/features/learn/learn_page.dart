import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  String _selectedLevel = 'A1';

  final Map<String, List<Lesson>> _lessons = {
    'A1': const [
      Lesson(
        title: 'Greetings & Introductions',
        subtitle: 'Say hello and introduce yourself',
        progress: 1.0,
        icon: Icons.waving_hand_outlined,
      ),
      Lesson(
        title: 'Present Simple',
        subtitle: 'Talk about routines and habits',
        progress: 0.35,
        icon: Icons.schedule_outlined,
      ),
      Lesson(
        title: 'Everyday Vocabulary',
        subtitle: 'Learn useful daily words',
        progress: 0.0,
        icon: Icons.menu_book_outlined,
      ),
    ],
    'A2': const [
      Lesson(
        title: 'Past Simple',
        subtitle: 'Talk about things that happened',
        progress: 0.0,
        icon: Icons.history,
      ),
      Lesson(
        title: 'Future Plans',
        subtitle: 'Talk about plans and predictions',
        progress: 0.0,
        icon: Icons.event_outlined,
      ),
    ],
    'B1': const [
      Lesson(
        title: 'Expressing Opinions',
        subtitle: 'Explain what you think and why',
        progress: 0.0,
        icon: Icons.forum_outlined,
      ),
      Lesson(
        title: 'Storytelling',
        subtitle: 'Tell clear and interesting stories',
        progress: 0.0,
        icon: Icons.auto_stories_outlined,
      ),
    ],
    'B2': const [
      Lesson(
        title: 'Advanced Conversations',
        subtitle: 'Handle longer real-world conversations',
        progress: 0.0,
        icon: Icons.chat_outlined,
      ),
      Lesson(
        title: 'Natural Expressions',
        subtitle: 'Sound more natural in English',
        progress: 0.0,
        icon: Icons.auto_awesome_outlined,
      ),
    ],
    'C1': const [
      Lesson(
        title: 'Advanced Grammar',
        subtitle: 'Master complex grammatical structures',
        progress: 0.0,
        icon: Icons.school_outlined,
      ),
      Lesson(
        title: 'Academic English',
        subtitle: 'Understand formal and academic language',
        progress: 0.0,
        icon: Icons.library_books_outlined,
      ),
    ],
    'C2': const [
      Lesson(
        title: 'Mastery',
        subtitle: 'Refine advanced English skills',
        progress: 0.0,
        icon: Icons.workspace_premium_outlined,
      ),
      Lesson(
        title: 'Real World English',
        subtitle: 'Use English naturally in real situations',
        progress: 0.0,
        icon: Icons.public_outlined,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final lessons = _lessons[_selectedLevel] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(
            'Choose your level',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final level = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'][index];
                final selected = level == _selectedLevel;

                return ChoiceChip(
                  label: Text(level),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      _selectedLevel = level;
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Text(
                      _selectedLevel,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_selectedLevel English',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${lessons.length} lessons available',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Lessons',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 12),

          ...lessons.map(
            (lesson) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _LessonCard(lesson: lesson),
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final Lesson lesson;

  const _LessonCard({
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    final completed = lesson.progress >= 1.0;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: Icon(lesson.icon),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: lesson.progress,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Icon(
                completed
                    ? Icons.check_circle_outline
                    : Icons.chevron_right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Lesson {
  final String title;
  final String subtitle;
  final double progress;
  final IconData icon;

  const Lesson({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.icon,
  });
}