import 'package:flutter/material.dart';
import '../localization.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${lang.learn} 📚'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            lang.isPersian ? 'سطحت رو انتخاب کن' : 'Choose your level',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            lang.isPersian
                ? 'با میو قدم‌به‌قدم انگلیسی یاد بگیر 🐱'
                : 'Learn English step by step with Meow 🐱',
            style: const TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 24),

          _levelCard(
            context,
            'A1',
            lang.beginner,
            lang.isPersian
                ? 'کلمات پایه، سلام و احوالپرسی و جمله‌های ساده'
                : 'Basic words, greetings and simple sentences',
            Icons.eco,
          ),

          _levelCard(
            context,
            'A2',
            lang.isPersian ? 'مقدماتی' : 'Elementary',
            lang.isPersian
                ? 'مکالمه‌های روزمره و عبارت‌های کاربردی'
                : 'Everyday conversations and useful phrases',
            Icons.directions_walk,
          ),

          _levelCard(
            context,
            'B1',
            lang.isPersian ? 'متوسط' : 'Intermediate',
            lang.isPersian
                ? 'انگلیسی واقعی و عبارت‌های رایج'
                : 'Real-life English and common expressions',
            Icons.trending_up,
          ),

          _levelCard(
            context,
            'B2',
            lang.isPersian ? 'متوسط رو به بالا' : 'Upper-Intermediate',
            lang.isPersian
                ? 'مکالمه‌های طبیعی‌تر و واژگان پیشرفته‌تر'
                : 'More natural conversations and advanced vocabulary',
            Icons.school,
          ),

          _levelCard(
            context,
            'C1',
            lang.isPersian ? 'پیشرفته' : 'Advanced',
            lang.isPersian
                ? 'ارتباط روان و موضوعات پیچیده‌تر'
                : 'Fluent communication and complex topics',
            Icons.auto_awesome,
          ),

          _levelCard(
            context,
            'C2',
            lang.isPersian ? 'تسلط کامل' : 'Proficiency',
            lang.isPersian
                ? 'انگلیسی را در بالاترین سطح مسلط شو'
                : 'Master English like a pro',
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

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),

        onTap: () {
          if (level == 'A1') {
            Navigator.pushNamed(
              context,
              '/a1-lessons',
            );
          }
        },
      ),
    );
  }
}