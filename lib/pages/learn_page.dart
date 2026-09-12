import 'package:flutter/material.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn 📚'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Choose your level',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Learn English step by step with Meow 🐱',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          _levelCard(
            context,
            'A1',
            'Beginner',
            'Basic words, greetings and simple sentences',
            Icons.eco,
          ),
          _levelCard(
            context,
            'A2',
            'Elementary',
            'Everyday conversations and useful phrases',
            Icons.directions_walk,
          ),
          _levelCard(
            context,
            'B1',
            'Intermediate',
            'Real-life English and common expressions',
            Icons.trending_up,
          ),
          _levelCard(
            context,
            'B2',
            'Upper-Intermediate',
            'More natural conversations and advanced vocabulary',
            Icons.school,
          ),
          _levelCard(
            context,
            'C1',
            'Advanced',
            'Fluent communication and complex topics',
            Icons.auto_awesome,
          ),
          _levelCard(
            context,
            'C2',
            'Proficiency',
            'Master English like a pro',
            Icons.workspace_premium,
          ),
        ],
      ),
    );
  }

  Widget _levelCard(
    BuildContext context,
    String level,
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
          '$level • $title',
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
        onTap: () {
          if (level == 'A1') {
            Navigator.pushNamed(context, '/a1-lessons');
          }
        },
      ),
    );
  }
}
