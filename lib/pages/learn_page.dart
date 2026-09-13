import 'package:flutter/material.dart';

import '../localization.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  static const Color lavender = Color(0xFFB9A7E8);

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${lang.learn} 📚',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
          children: [
            Text(
              lang.isPersian
                  ? 'سطحت رو انتخاب کن'
                  : 'Choose your level',
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              lang.isPersian
                  ? 'با میو قدم‌به‌قدم انگلیسی یاد بگیر 🐱'
                  : 'Learn English step by step with Meow 🐱',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // A1
            _levelCard(
              context,
              level: 'A1',
              title: lang.beginner,
              description: lang.isPersian
                  ? 'کلمات پایه، سلام و احوالپرسی و جمله‌های ساده'
                  : 'Basic words, greetings and simple sentences',
              icon: Icons.eco_rounded,
              color: const Color(0xFF4CAF50),
              enabled: true,
              buttonText: lang.isPersian ? 'شروع' : 'START',
            ),

            // A2
            _levelCard(
              context,
              level: 'A2',
              title: lang.isPersian ? 'مقدماتی' : 'Elementary',
              description: lang.isPersian
                  ? 'مکالمه‌های روزمره و عبارت‌های کاربردی'
                  : 'Everyday conversations and useful phrases',
              icon: Icons.directions_walk_rounded,
              color: const Color(0xFFF2B94B),
            ),

            // B1
            _levelCard(
              context,
              level: 'B1',
              title: lang.isPersian ? 'متوسط' : 'Intermediate',
              description: lang.isPersian
                  ? 'انگلیسی واقعی و عبارت‌های رایج'
                  : 'Real-life English and common expressions',
              icon: Icons.trending_up_rounded,
              color: const Color(0xFF5C8DDE),
            ),

            // B2
            _levelCard(
              context,
              level: 'B2',
              title: lang.isPersian
                  ? 'متوسط رو به بالا'
                  : 'Upper-Intermediate',
              description: lang.isPersian
                  ? 'مکالمه‌های طبیعی‌تر و واژگان پیشرفته‌تر'
                  : 'More natural conversations and advanced vocabulary',
              icon: Icons.school_rounded,
              color: const Color(0xFF8C72D8),
            ),

            // C1
            _levelCard(
              context,
              level: 'C1',
              title: lang.isPersian ? 'پیشرفته' : 'Advanced',
              description: lang.isPersian
                  ? 'ارتباط روان و موضوعات پیچیده‌تر'
                  : 'Fluent communication and advanced vocabulary',
              icon: Icons.auto_awesome_rounded,
              color: const Color(0xFFE477A8),
            ),

            // C2
            _levelCard(
              context,
              level: 'C2',
              title: lang.isPersian ? 'تسلط کامل' : 'Proficiency',
              description: lang.isPersian
                  ? 'انگلیسی را در بالاترین سطح مسلط شو'
                  : 'Master English like a pro',
              icon: Icons.workspace_premium_rounded,
              color: const Color(0xFFB27A4C),
            ),
          ],
        ),
      ),
    );
  }

  Widget _levelCard(
    BuildContext context, {
    required String level,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    bool enabled = false,
    String? buttonText,
  }) {
    final isEnabled = enabled;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: isEnabled
            ? () {
                Navigator.pushNamed(
                  context,
                  '/a1-lessons',
                );
              }
            : null,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: color.withAlpha(36),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: color.withAlpha(31),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$level • $title',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (isEnabled)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: color.withAlpha(31),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              buttonText ?? 'START',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: color,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isEnabled
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.lock_outline_rounded,
                size: 17,
                color: isEnabled ? color : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}