import 'package:flutter/material.dart';

import '../localization.dart';
import '../services/a1_progress_service.dart';
import '../services/progress_service.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  bool _loading = true;

  int _completedLessons = 0;
  int _totalXp = 0;
  int _practiceSessions = 0;
  int _speakingSessions = 0;
  int _studyDays = 0;
  int _streak = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completed =
        await A1ProgressService.getCompletedLessons();

    final xp = await ProgressService.getTotalXp();
    final practice =
        await ProgressService.getPracticeSessions();
    final speaking =
        await ProgressService.getSpeakingSessions();
    final studyDays =
        await ProgressService.getStudyDays();
    final streak =
        await ProgressService.getCurrentStreak();

    if (!mounted) return;

    setState(() {
      _completedLessons = completed.length;
      _totalXp = xp;
      _practiceSessions = practice;
      _speakingSessions = speaking;
      _studyDays = studyDays;
      _streak = streak;
      _loading = false;
    });
  }

  double get _a1Progress {
    return (_completedLessons / 12).clamp(0.0, 1.0);
  }

  int get _a1Percent {
    return (_a1Progress * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    if (_loading) {
      return Scaffold(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
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
        body: const Center(
          child: CircularProgressIndicator(
            color: lavender,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
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
      body: RefreshIndicator(
        color: lavender,
        onRefresh: _loadProgress,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              110,
            ),
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
                    ? 'هر کاری که انجام میدی اینجا ثبت میشه 🚀'
                    : 'Everything you do is tracked here 🚀',
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
                      title: lang.isPersian
                          ? 'درس‌ها'
                          : 'Lessons',
                      value: '$_completedLessons',
                      subtitle: lang.isPersian
                          ? 'از ۱۲'
                          : 'of 12',
                      color: lavender,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _smallStatCard(
                      context,
                      icon: Icons.track_changes_rounded,
                      title: lang.isPersian
                          ? 'تمرین'
                          : 'Practice',
                      value: '$_practiceSessions',
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
                      icon:
                          Icons.local_fire_department_rounded,
                      title: lang.isPersian
                          ? 'استریک'
                          : 'Streak',
                      value: '$_streak',
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
                      value: '$_totalXp',
                      subtitle: lang.isPersian
                          ? 'امتیاز'
                          : 'points',
                      color: const Color(0xFFF2B94B),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: _smallStatCard(
                      context,
                      icon: Icons.mic_rounded,
                      title: lang.isPersian
                          ? 'Speaking'
                          : 'Speaking',
                      value: '$_speakingSessions',
                      subtitle: lang.isPersian
                          ? 'جلسه'
                          : 'sessions',
                      color: const Color(0xFF8B78D8),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _smallStatCard(
                      context,
                      icon: Icons.calendar_month_rounded,
                      title: lang.isPersian
                          ? 'روزهای مطالعه'
                          : 'Study Days',
                      value: '$_studyDays',
                      subtitle: lang.isPersian
                          ? 'روز'
                          : 'days',
                      color: const Color(0xFF65A77A),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _examCard(context, lang),

              const SizedBox(height: 18),

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
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                            _completedLessons == 0
                                ? (lang.isPersian
                                    ? 'اولین درست رو شروع کن و میو پیشرفتت رو ثبت می‌کنه.'
                                    : 'Start your first lesson and Meow will track your progress.')
                                : (lang.isPersian
                                    ? '$_completedLessons درس رو کامل کردی. داری جلو می‌ری! 🔥'
                                    : 'You completed $_completedLessons lessons. Keep going! 🔥'),
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
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
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: lavender.withOpacity(0.13),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Text(
                  '$_a1Percent%',
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
              value: _a1Progress,
              minHeight: 9,
              backgroundColor:
                  lavender.withOpacity(0.16),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(
                lavender,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            lang.isPersian
                ? '$_a1Percent٪ از سطح A1 تکمیل شده'
                : '$_a1Percent% of A1 completed',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _examCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.35),
        borderRadius: BorderRadius.circular(24),
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
              Icons.assignment_rounded,
              color: lavender,
              size: 25,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  lang.isPersian
                      ? 'امتحان A1'
                      : 'A1 Exam',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _completedLessons == 12
                      ? (lang.isPersian
                          ? 'تمام درس‌ها کامل شده. امتحان آماده است! 🎯'
                          : 'All lessons completed. The exam is ready! 🎯')
                      : (lang.isPersian
                          ? '$_completedLessons از ۱۲ درس کامل شده'
                          : '$_completedLessons of 12 lessons completed'),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            _completedLessons == 12
                ? Icons.check_circle_rounded
                : Icons.lock_outline_rounded,
            color: _completedLessons == 12
                ? const Color(0xFF65A77A)
                : Colors.grey,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 3),
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