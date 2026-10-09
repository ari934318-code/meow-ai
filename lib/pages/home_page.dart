import 'package:flutter/material.dart';
import '../localization.dart';
import '../real_english_page.dart';
import '../services/progress_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color lavender = Color(0xFFB9A7E8);

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Meow AI',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            tooltip: lang.profile,
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(Icons.person_outline_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
          children: [
            _greeting(lang),
            const SizedBox(height: 22),

            _meowCard(context, lang),
            const SizedBox(height: 18),

            _levelCard(lang),
            const SizedBox(height: 18),

            _continueLearning(context, lang),
            const SizedBox(height: 18),

            _realEnglishCard(context, lang),
            const SizedBox(height: 18),

            _HomeProgressStats(isPersian: lang.isPersian),

            const SizedBox(height: 18),

            _dailyGoal(lang),
            const SizedBox(height: 18),

            _smartReview(context, lang),
            const SizedBox(height: 18),

            _talkToMeow(context, lang),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigation(context, lang),
    );
  }

  Widget _greeting(MeowLocalizations lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lang.isPersian ? 'خوش برگشتی 👋' : 'Welcome back 👋',
          style: const TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          lang.isPersian
              ? 'آماده‌ای مسیر یادگیری انگلیسی‌ات رو ادامه بدی؟'
              : 'Ready to continue your English journey?',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _meowCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.16),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: lavender.withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.pets_rounded,
              size: 29,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Meow',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lang.isPersian
                      ? 'معلم انگلیسی تو آماده‌ست.'
                      : 'Your English teacher is ready.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _levelCard(MeowLocalizations lang) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF4CAF50).withOpacity(0.10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  lang.isPersian ? 'سطح فعلی' : 'Current level',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'A1',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            lang.isPersian ? 'مبتدی' : 'Beginner',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.25,
              minHeight: 8,
              backgroundColor: Color(0x224CAF50),
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF4CAF50),
              ),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            lang.isPersian ? '۲۵٪ تکمیل شده' : '25% completed',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _continueLearning(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return _sectionCard(
      context,
      icon: Icons.menu_book_outlined,
      title: lang.isPersian ? 'ادامه یادگیری' : 'Continue Learning',
      subtitle: lang.isPersian ? 'احوالپرسی' : 'Greetings',
      trailing: 'A1 • ${lang.isPersian ? 'درس ۱' : 'Lesson 1'}',
      onTap: () {
        Navigator.pushNamed(context, '/a1-lessons');
      },
    );
  }

  Widget _realEnglishCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return _sectionCard(
      context,
      icon: Icons.language_rounded,
      title: lang.isPersian ? 'انگلیسی واقعی' : 'Real English',
      subtitle: lang.isPersian
          ? 'اصطلاحات، اسلنگ، مخفف‌ها و شکل‌های کوتاه گفتاری'
          : 'Idioms, slang, abbreviations & spoken short forms',
      trailing: lang.isPersian ? 'ببین' : 'Explore',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const RealEnglishPage(),
          ),
        );
      },
    );
  }

  Widget _dailyGoal(MeowLocalizations lang) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: lavender.withOpacity(0.10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 62,
            height: 62,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.0,
                  strokeWidth: 6,
                  backgroundColor: lavender.withOpacity(0.20),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(lavender),
                ),
                Text(
                  lang.isPersian ? '۰٪' : '0%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.dailyGoal,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  lang.isPersian
                      ? 'امروز ۲۰ دقیقه'
                      : '20 minutes today',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }

  Widget _smartReview(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return _sectionCard(
      context,
      icon: Icons.auto_awesome_outlined,
      title: lang.isPersian ? 'مرور هوشمند' : 'Smart Review',
      subtitle: lang.isPersian
          ? 'کلمات و اشتباهاتی که نیاز به مرور دارند.'
          : 'Review words and mistakes that need attention.',
      trailing: lang.isPersian ? 'مرور' : 'Review',
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              lang.isPersian
                  ? 'مرور هوشمند به‌زودی میاد 🐱'
                  : 'Smart Review is coming soon 🐱',
            ),
          ),
        );
      },
    );
  }

  Widget _talkToMeow(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: lavender.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mic_none_rounded,
              color: lavender,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.meow,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lang.isPersian
                      ? 'با معلم هوش مصنوعی‌ات طبیعی انگلیسی تمرین کن.'
                      : 'Practice English naturally with your AI teacher.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/meow');
            },
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.grey.withOpacity(0.14),
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
              child: Icon(
                icon,
                color: lavender,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              trailing,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigation(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return NavigationBar(
      selectedIndex: 0,
      height: 70,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      indicatorColor: lavender.withOpacity(0.20),
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home_rounded),
          label: lang.home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.menu_book_outlined),
          selectedIcon: const Icon(Icons.menu_book_rounded),
          label: lang.learn,
        ),
        NavigationDestination(
          icon: const Icon(Icons.fitness_center_outlined),
          selectedIcon: const Icon(Icons.fitness_center_rounded),
          label: lang.practice,
        ),
        NavigationDestination(
          icon: const Icon(Icons.pets_outlined),
          selectedIcon: const Icon(Icons.pets_rounded),
          label: lang.meow,
        ),
        NavigationDestination(
          icon: const Icon(Icons.insights_outlined),
          selectedIcon: const Icon(Icons.insights_rounded),
          label: lang.progress,
        ),
      ],
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            break;
          case 1:
            Navigator.pushNamed(context, '/learn');
            break;
          case 2:
            Navigator.pushNamed(context, '/practice');
            break;
          case 3:
            Navigator.pushNamed(context, '/meow');
            break;
          case 4:
            Navigator.pushNamed(context, '/progress');
            break;
        }
      },
    );
  }
}

/// Displays persisted learning statistics rather than placeholder values.
class _HomeProgressStats extends StatefulWidget {
  const _HomeProgressStats({required this.isPersian});

  final bool isPersian;

  @override
  State<_HomeProgressStats> createState() => _HomeProgressStatsState();
}

class _HomeProgressStatsState extends State<_HomeProgressStats> {
  int _streak = 0;
  int _xp = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  @override
  void didUpdateWidget(covariant _HomeProgressStats oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The values are language-independent; no reload is needed on locale change.
  }

  Future<void> _loadStats() async {
    final values = await Future.wait<int>([
      ProgressService.getCurrentStreak(),
      ProgressService.getTotalXp(),
    ]);
    if (!mounted) return;
    setState(() {
      _streak = values[0];
      _xp = values[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    final streakValue = widget.isPersian
        ? '${_toPersianDigits(_streak)} روز'
        : '$_streak ${_streak == 1 ? 'day' : 'days'}';
    final xpValue = widget.isPersian
        ? '${_toPersianDigits(_xp)} XP'
        : '$_xp XP';

    return Row(
      children: [
        Expanded(
          child: _HomeStatCard(
            icon: Icons.local_fire_department_outlined,
            title: widget.isPersian ? 'روزهای پشت سر هم' : 'Streak',
            value: streakValue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _HomeStatCard(
            icon: Icons.star_outline_rounded,
            title: 'XP',
            value: xpValue,
          ),
        ),
      ],
    );
  }

  String _toPersianDigits(int value) {
    const digits = '۰۱۲۳۴۵۶۷۸۹';
    return value.toString().split('').map((character) {
      final digit = int.tryParse(character);
      return digit == null ? character : digits[digit];
    }).join();
  }
}

class _HomeStatCard extends StatelessWidget {
  const _HomeStatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return _HomePageStatWrapper(
      icon: icon,
      title: title,
      value: value,
    );
  }
}

class _HomePageStatWrapper extends StatelessWidget {
  const _HomePageStatWrapper({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.14)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB9A7E8)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
