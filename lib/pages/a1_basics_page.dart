import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/levels/a1/basics/a1_basics_data.dart';
import '../data/levels/a1/basics/a1_basics_models.dart';
import '../localization.dart';
import 'a1_basics_exam_page.dart';
import 'a1_basics_lesson_page.dart';

class A1BasicsPage extends StatefulWidget {
  const A1BasicsPage({super.key});

  @override
  State<A1BasicsPage> createState() => _A1BasicsPageState();
}

class _A1BasicsPageState extends State<A1BasicsPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  static const String _completedKey =
      'a1_basics_completed_lessons';

  static const String _examCompletedKey =
      'a1_basics_completed';

  Set<String> completedLessons = {};
  bool examCompleted = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();

    final completed =
        prefs.getStringList(_completedKey) ?? [];

    final exam =
        prefs.getBool(_examCompletedKey) ?? false;

    if (!mounted) return;

    setState(() {
      completedLessons = completed.toSet();
      examCompleted = exam;
      isLoading = false;
    });
  }

  bool _isLessonUnlocked(int index) {
    if (index == 0) {
      return true;
    }

    return completedLessons.contains(
      a1BasicsLessons[index - 1].id,
    );
  }

  bool _areAllLessonsCompleted() {
    return a1BasicsLessons.every(
      (lesson) => completedLessons.contains(
        lesson.id,
      ),
    );
  }

  Future<void> _openLesson(
    A1BasicLesson lesson,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => A1BasicsLessonPage(
          lesson: lesson,
        ),
      ),
    );

    await _loadProgress();
  }

  Future<void> _openBasicsExam() async {
    if (!_areAllLessonsCompleted()) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const A1BasicsExamPage(),
      ),
    );

    await _loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final lang = MeowLocalizations.of(context);

    final completedCount = completedLessons.length;
    final totalCount = a1BasicsLessons.length;

    final progress = totalCount == 0
        ? 0.0
        : completedCount / totalCount;

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'A1 Basics',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _loadProgress,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            110,
          ),
          children: [
            _buildHeader(
              lang,
              completedCount,
              totalCount,
              progress,
            ),
            const SizedBox(height: 20),
            _buildLessons(),
            const SizedBox(height: 8),
            _buildExamCard(lang),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    MeowLocalizations lang,
    int completedCount,
    int totalCount,
    double progress,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: lavender.withAlpha(36),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'A1 Basics 🐱',
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            lang.isPersian
                ? 'پایه‌های گرامری موردنیاز برای درس‌های سطح A1'
                : 'Grammar foundations you need before your A1 lessons.',
            style: const TextStyle(
              fontSize: 14,
              height: 1.45,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lang.isPersian ? 'پیشرفت' : 'Progress',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '$completedCount / $totalCount',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: lavender,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor:
                  lavender.withAlpha(31),
              valueColor:
                  const AlwaysStoppedAnimation(
                lavender,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessons() {
    return Column(
      children: List.generate(
        a1BasicsLessons.length,
        (index) {
          final lesson = a1BasicsLessons[index];

          final unlocked =
              _isLessonUnlocked(index);

          final completed =
              completedLessons.contains(lesson.id);

          return _buildLessonCard(
            lesson: lesson,
            index: index,
            unlocked: unlocked,
            completed: completed,
          );
        },
      ),
    );
  }

  Widget _buildLessonCard({
    required A1BasicLesson lesson,
    required int index,
    required bool unlocked,
    required bool completed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: unlocked
            ? () => _openLesson(lesson)
            : null,
        child: AnimatedOpacity(
          duration:
              const Duration(milliseconds: 200),
          opacity: unlocked ? 1.0 : 0.55,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surface,
              borderRadius:
                  BorderRadius.circular(24),
              border: Border.all(
                color: completed
                    ? Colors.green.withAlpha(56)
                    : lavender.withAlpha(36),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: completed
                        ? Colors.green.withAlpha(28)
                        : lavender.withAlpha(31),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    completed
                        ? Icons.check_circle_rounded
                        : unlocked
                            ? Icons.menu_book_rounded
                            : Icons.lock_rounded,
                    color: completed
                        ? Colors.green
                        : unlocked
                            ? lavender
                            : Colors.grey,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Basics ${index + 1}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: lavender,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson.titleFa,
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
                  completed
                      ? Icons.check_circle_rounded
                      : unlocked
                          ? Icons
                              .arrow_forward_ios_rounded
                          : Icons.lock_outline_rounded,
                  size: completed ? 23 : 17,
                  color: completed
                      ? Colors.green
                      : unlocked
                          ? lavender
                          : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamCard(MeowLocalizations lang) {
    final unlocked = _areAllLessonsCompleted();

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: unlocked
            ? _openBasicsExam
            : null,
        child: AnimatedOpacity(
          duration:
              const Duration(milliseconds: 200),
          opacity: unlocked ? 1.0 : 0.55,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surface,
              borderRadius:
                  BorderRadius.circular(24),
              border: Border.all(
                color: unlocked
                    ? lavender.withAlpha(64)
                    : Colors.grey.withAlpha(31),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: examCompleted
                        ? Colors.green.withAlpha(28)
                        : unlocked
                            ? lavender.withAlpha(31)
                            : Colors.grey.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    examCompleted
                        ? Icons.check_circle_rounded
                        : unlocked
                            ? Icons.quiz_rounded
                            : Icons.lock_rounded,
                    color: examCompleted
                        ? Colors.green
                        : unlocked
                            ? lavender
                            : Colors.grey,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        examCompleted
                            ? (lang.isPersian
                                ? 'آزمون Basics با موفقیت تمام شد 🎉'
                                : 'Basics Exam Completed 🎉')
                            : (lang.isPersian
                                ? 'آزمون Basics'
                                : 'Basics Exam'),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        examCompleted
                            ? (lang.isPersian
                                ? 'آفرین! همه درس‌های Basics را پشت سر گذاشتی.'
                                : 'Great job! You completed all the Basics lessons.')
                            : unlocked
                                ? (lang.isPersian
                                    ? 'آزمون Basics را کامل کن تا Lesson 1 سطح A1 باز شود.'
                                    : 'Complete the Basics exam to unlock A1 Lesson 1.')
                                : (lang.isPersian
                                    ? 'ابتدا هر 11 درس Basics را کامل کن.'
                                    : 'Complete all 11 Basics lessons first.'),
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  examCompleted
                      ? Icons.check_circle_rounded
                      : unlocked
                          ? Icons
                              .arrow_forward_ios_rounded
                          : Icons.lock_outline_rounded,
                  color: examCompleted
                      ? Colors.green
                      : unlocked
                          ? lavender
                          : Colors.grey,
                  size: examCompleted ? 23 : 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}