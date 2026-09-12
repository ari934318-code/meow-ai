import 'package:flutter/material.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Practice your English',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Choose what you want to practice today.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),

          _PracticeCard(
            icon: Icons.translate_outlined,
            title: 'Vocabulary',
            subtitle: 'Review words you have learned',
          ),

          _PracticeCard(
            icon: Icons.edit_outlined,
            title: 'Grammar',
            subtitle: 'Practice your grammar skills',
          ),

          _PracticeCard(
            icon: Icons.headphones_outlined,
            title: 'Listening',
            subtitle: 'Train your listening skills',
          ),

          _PracticeCard(
            icon: Icons.record_voice_over_outlined,
            title: 'Speaking',
            subtitle: 'Practice speaking naturally',
          ),

          _PracticeCard(
            icon: Icons.auto_awesome_outlined,
            title: 'Smart Review',
            subtitle: 'Practice what Meow thinks you need',
          ),
        ],
      ),
    );
  }
}

class _PracticeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PracticeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 25,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}