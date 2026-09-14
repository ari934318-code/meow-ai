import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localization.dart';
import '../services/a1_progress_service.dart';
import '../services/progress_service.dart';
import '../data/levels/a2/a2_data.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  static const int a1TotalLessons = 12;

  bool _loading = true;

  int _a1CompletedLessons = 0;
  int _a2CompletedLessons = 0;

  bool _a2ExamCompleted = false;

  int _totalXp = 0;
  int _practiceSessions = 0;
  int _speakingSessions = 0;
  int _studyDays = 0;
  int _streak = 0;

  int get _a2TotalLessons => a2Lessons.length;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();

    // -----------------------------
    // A1
    // -----------------------------
    final a1Completed =
        await A1ProgressService.getCompletedLessons();

    // -----------------------------
    // A2
    // -----------------------------
    int a2Completed = 0;

    for (final lesson in a2Lessons) {
      final completed = prefs.getBool(
        'a2_lesson_completed_${lesson.id}',
      );

      if (completed == true) {
        a2Completed++;
      }
    }

    // A2 final exam
    final a2ExamCompleted =
        prefs.getBool('a2_completed') ?? false;

    // -----------------------------
    // General progress
    // -----------------------------
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
      _a1CompletedLessons = a1Completed.length;
      _a2CompletedLessons = a2Completed;
      _a2ExamCompleted = a2ExamCompleted;

      _totalXp = xp;
      _practiceSessions = practice;
      _speakingSessions = speaking;
      _studyDays = studyDays;
      _streak = streak;

      _loading = false;
    });
  }

  // -----------------------------
  // A1 Progress
  // -----------------------------

  double get _a1Progress {
    return (_a1CompletedLessons / a1TotalLessons)
        .clamp(0.0, 1.0);
  }

  int get _a1Percent {
    return (_a1Progress * 100).round();
  }

  // -----------------------------
  // A2 Progress
  // -----------------------------

  double get _a2Progress {
    final completedParts =
        _a2CompletedLessons +
        (_a2ExamCompleted ? 1 : 0);

    final totalParts = _a2TotalLessons + 1;

    return (completedParts / totalParts)
        .clamp(0.0, 1.0);
  }

  int get _a2Percent {
    return (_a2Progress * 100).round();
  }

  // -----------------------------
  // Current Level
  // -----------------------------

  String get _currentLevel {
    if (_a2ExamCompleted) {
      return 'B1';
    }

    if (_a1CompletedLessons >= a1TotalLessons) {
      return 'A2';
    }

    return 'A1';
  }

  int get _currentLevelPercent {
    if (_a2ExamCompleted) {
      return 0;
    }

    if (_a1CompletedLessons >= a1TotalLessons) {
      return _a2Percent;
    }

    return _a1Percent;
  }

  int get _totalCompletedLessons {
    return _a1CompletedLessons +
        _a2CompletedLessons;
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
                      value: '$_totalCompletedLessons',
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
                      title: 'Speaking',
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

              // A1
              _levelProgressCard(
                context,
                lang,
                level: 'A1',
                completedLessons:
                    _a1CompletedLessons,
                totalLessons: a1TotalLessons,
                percent: _a1Percent,
                progress: _a1Progress,
                examCompleted: false,
              ),

              const SizedBox(height: 14),

              // A2
              _levelProgressCard(
                context,
                lang,
                level: 'A2',
                completedLessons:
                    _a2CompletedLessons,
                totalLessons: _a2TotalLessons,
                percent: _a2Percent,
                progress: _a2Progress,
                examCompleted: _a2ExamCompleted,
              ),

              const SizedBox(height: 18),

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
                        color:
                            lavender.withOpacity(0.13),
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
                            _a2ExamCompleted
                                ? (lang.isPersian
                                    ? 'A2 کامل شد! 🎉'
                                    : 'A2 completed! 🎉')
                                : _a1CompletedLessons >=
                                          a1TotalLessons
                                    ? (lang.isPersian
                                        ? 'برو سراغ A2! 🐱'
                                        : 'Time for A2! 🐱')
                                    : (lang.isPersian
                                        ? 'ادامه بده! 🐱'
                                        : 'Keep going! 🐱'),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            _a2ExamCompleted
                                ? (lang.isPersian
                                    ? 'همه درس‌های A2 و امتحان نهایی را با موفقیت کامل کردی. 🔥'
                                    : 'You completed all A2 lessons and passed the final exam. 🔥')
                                : _a1CompletedLessons <
                                          a1TotalLessons
                                    ? (lang.isPersian
                                        ? '$_a1CompletedLessons از $a1TotalLessons درس A1 را کامل کردی.'
                                        : 'You completed $_a1CompletedLessons of $a1TotalLessons A1 lessons.')
                                    : (lang.isPersian
                                        ? '$_a2CompletedLessons از $_a2TotalLessons درس A2 را کامل کردی.'
                                        : 'You completed $_a2CompletedLessons of $_a2TotalLessons A2 lessons.'),
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
    final currentLevel = _currentLevel;
    final percent = _currentLevelPercent;

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
                    Text(
                      currentLevel,
                      style: const TextStyle(
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
                  '$percent%',
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
              value: percent / 100,
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
            currentLevel == 'B1'
                ? (lang.isPersian
                    ? 'A2 را کامل کردی و آماده B1 هستی 🎯'
                    : 'A2 completed. You are ready for B1 🎯')
                : lang.isPersian
                    ? '$percent٪ از سطح $currentLevel تکمیل شده'
                    : '$percent% of $currentLevel completed',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _levelProgressCard(
    BuildContext context,
    MeowLocalizations lang, {
    required String level,
    required int completedLessons,
    required int totalLessons,
    required int percent,
    required double progress,
    required bool examCompleted,
  }) {
    final isComplete =
        level == 'A1'
            ? completedLessons >= totalLessons
            : examCompleted;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isComplete
            ? Colors.green.withOpacity(0.07)
            : Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withOpacity(0.35),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isComplete
              ? Colors.green.withOpacity(0.18)
              : Colors.grey.withOpacity(0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                level,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(width: 8),

              if (isComplete)
                const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 20,
                ),

              const Spacer(),

              Text(
                '$percent%',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: lavender,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor:
                  lavender.withOpacity(0.12),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(
                lavender,
              ),
            ),
          ),

          const SizedBox(height: 9),

          Row(
            children: [
              Expanded(
                child: Text(
                  lang.isPersian
                      ? '$completedLessons از $totalLessons درس'
                      : '$completedLessons of $totalLessons lessons',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),

              if (level == 'A2')
                Text(
                  examCompleted
                      ? (lang.isPersian
                          ? 'امتحان ✓'
                          : 'Exam ✓')
                      : (lang.isPersian
                          ? 'امتحان باقی مانده'
                          : 'Exam remaining'),
                  style: TextStyle(
                    fontSize: 12,
                    color: examCompleted
                        ? Colors.green
                        : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _examCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    final a1Complete =
        _a1CompletedLessons >= a1TotalLessons;

    final a2Complete = _a2ExamCompleted;

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
            child: Icon(
              a2Complete
                  ? Icons.emoji_events_rounded
                  : Icons.assignment_rounded,
              color: a2Complete
                  ? Colors.green
                  : lavender,
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
                      ? 'وضعیت سطح A2'
                      : 'A2 Level Status',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  a2Complete
                      ? (lang.isPersian
                          ? 'A2 با موفقیت کامل شده و B1 باز است 🎯'
                          : 'A2 completed successfully. B1 is unlocked 🎯')
                      : a1Complete
                          ? (lang.isPersian
                              ? 'درس‌های A2 را کامل کن و بعد امتحان نهایی را بده.'
                              : 'Complete the A2 lessons, then take the final exam.')
                          : (lang.isPersian
                              ? 'ابتدا باید سطح A1 را کامل کنی.'
                              : 'Complete A1 first.'),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            a2Complete
                ? Icons.check_circle_rounded
                : a1Complete
                    ? Icons.school_rounded
                    : Icons.lock_outline_rounded,
            color: a2Complete
                ? Colors.green
                : a1Complete
                    ? lavender
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