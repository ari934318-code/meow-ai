import 'package:flutter/material.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice 🎯'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Practice your English',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose a skill and start practicing with Meow 🐱',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          _practiceCard(
            '🗣️',
            'Speaking',
            'Practice conversations and pronunciation',
            Icons.mic,
          ),
          _practiceCard(
            '✍️',
            'Writing',
            'Write sentences and improve your grammar',
            Icons.edit,
          ),
          _practiceCard(
            '👂',
            'Listening',
            'Train your listening with real English',
            Icons.headphones,
          ),
          _practiceCard(
            '📖',
            'Vocabulary',
            'Learn useful everyday words and phrases',
            Icons.menu_book,
          ),
        ],
      ),
    );
  }

  Widget _practiceCard(
    String emoji,
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 27,
          child: Icon(icon),
        ),
        title: Text(
          '$emoji  $title',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(description),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }
}
