import 'package:flutter/material.dart';

import '../localization.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  static const Color lavender = Color(0xFFB9A7E8);

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${lang.progress} 📈',
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
                  ? 'پیشرفتت'
                  : 'Your Progress',
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              lang.isPersian
                  ? 'ادامه بده و ببین انگلیسیت چطور بهتر میشه 🚀'
                  : 'Keep learning and watch your English improve! 🚀',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            _levelCard(context, lang),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: _smallStatCard(
                    context,
                    icon: Icons.menu_book_rounded,
                    title: lang.isPersian ? 'درس‌ها' : 'Lessons',
                    value: '0',
                    subtitle: lang.isPersian
                        ? 'تکمیل‌شده'
                        : 'completed',
                    color: lavender,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _smallStatCard(
                    context,
                    icon: Icons.track_changes_rounded,
                    title: lang.isPersian ? 'تمرین' : 'Practice',
                    value: '0',
                    subtitle: lang.isPersian
                        ? 'جلسه'
                        : 'sessions',
                    color: const Color(0xFF5C8DDE),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _smallStatCard(
                    context,
                    icon: Icons.local_fire_department_rounded,
                    title: lang.isPersian ? 'استریک' : 'Streak',
                    value: '0',
                    subtitle: lang.isPersian
                        ? 'روز'
                        : 'days',
                    color: const Color(0xFFE98B5A),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _smallStatCard(
                    context,
                    icon: Icons.star_rounded,
                    title: 'XP',
                    value: '0',
                    subtitle: lang.isPersian
                        ? 'امتیاز'
                        : 'points',
                    color: const Color(0xFFF2B94B),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
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
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: lavender.withOpacity(0.13),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: lavender,
                      size: 25,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.isPersian
                              ? 'ادامه بده! 🐱'
                              : 'Keep going! 🐱',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          lang.isPersian
                              ? 'هر درس و تمرین تو رو یک قدم به انگلیسی بهتر نزدیک‌تر می‌کنه.'
                              : 'Every lesson and practice session gets you one step closer to better English.',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _levelCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.10),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: lavender.withOpacity(0.16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: lavender.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
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
                          ? 'سطح فعلی'
                          : 'Current Level',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'A1',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: lavender.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  '25%',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: lavender,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.25,
              minHeight: 9,
              backgroundColor: lavender.withOpacity(0.16),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(lavender),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            lang.isPersian
                ? '25٪ از سطح A1 تکمیل شده'
                : '25% of A1 completed',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: color.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 3),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}