import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/levels/a1/basics/a1_basics_data.dart';
import '../data/levels/a1/basics/a1_basics_models.dart';

class A1BasicsPage extends StatefulWidget {
  const A1BasicsPage({super.key});

  @override
  State<A1BasicsPage> createState() => _A1BasicsPageState();
}

class _A1BasicsPageState extends State<A1BasicsPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  static const String _completedKey =
      'a1_basics_completed_lessons';

  Set<String> completedLessons = {};
  bool basicsExamCompleted = false;
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

    final examCompleted =
        prefs.getBool('a1_basics_completed') ?? false;

    if (!mounted) return;

    setState(() {
      completedLessons = completed.toSet();
      basicsExamCompleted = examCompleted;
      isLoading = false;
    });
  }

  bool _isLessonCompleted(int index) {
    return completedLessons.contains(
      a1BasicsLessons[index].id,
    );
  }

  bool _isLessonUnlocked(int index) {
    if (index == 0) {
      return true;
    }

    return _isLessonCompleted(index - 1);
  }

  bool _areAllLessonsCompleted() {
    return a1BasicsLessons.every(
      (lesson) => completedLessons.contains(lesson.id),
    );
  }

  Future<void> _openLesson(
    A1BasicLesson lesson,
    int index,
  ) async {
    if (!_isLessonUnlocked(index)) {
      return;
    }

    /*
     * صفحه‌ی آموزش واقعی Basics را در قدم بعدی
     * به اینجا وصل می‌کنیم.
     *
     * فعلاً عمداً چیزی باز نمی‌کنیم تا جریان ناقص
     * وارد برنامه نشود.
     */
  }

  Future<void> _openBasicsExam() async {
    if (!_areAllLessonsCompleted()) {
      return;
    }

    /*
     * امتحان Basics در فایل فعلی پروژه وجود دارد.
     * بعد از ساخت صفحه‌ی آموزش، اینجا به Exam وصل می‌شود.
     */
  }

  Widget _buildLessonCard(
    BuildContext context,
    A1BasicLesson lesson,
    int index,
  ) {
    final completed = _isLessonCompleted(index);
    final unlocked = _isLessonUnlocked(index);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: unlocked
            ? () => _openLesson(lesson, index)
            : null,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: completed
                  ? lavender
                  : Theme.of(context)
                      .dividerColor
                      .withOpacity(0.25),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: completed
                      ? lavender
                      : unlocked
                          ? lavender.withOpacity(0.18)
                          : Theme.of(context)
                              .dividerColor
                              .withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  completed
                      ? Icons.check_rounded
                      : unlocked
                          ? Icons.play_arrow_rounded
                          : Icons.lock_rounded,
                  color: completed
                      ? Colors.white
                      : unlocked
                          ? lavender
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.35),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}. ${lesson.title}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.titleFa,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.65),
                      ),
                    ),
                  ],
                ),
              ),
              if (completed)
                const Text(
                  '✓',
                  style: TextStyle(
                    color: lavender,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else if (!unlocked)
                Icon(
                  Icons.lock_outline_rounded,
                  size: 20,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.3),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExamCard(BuildContext context) {
    final unlocked = _areAllLessonsCompleted();

    return InkWell(
      onTap: unlocked ? _openBasicsExam : null,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: unlocked
              ? LinearGradient(
                  colors: [
                    lavender,
                    lavender.withOpacity(0.65),
                  ],
                )
              : null,
          color: unlocked
              ? null
              : Theme.of(context)
                  .colorScheme
                  .surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: unlocked
                ? Colors.transparent
                : Theme.of(context)
                    .dividerColor
                    .withOpacity(0.25),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: unlocked
                    ? Colors.white.withOpacity(0.2)
                    : lavender.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                unlocked
                    ? Icons.assignment_rounded
                    : Icons.lock_rounded,
                color: unlocked
                    ? Colors.white
                    : lavender,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basics Exam',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: unlocked
                          ? Colors.white
                          : Theme.of(context)
                              .colorScheme
                              .onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    unlocked
                        ? 'همه‌ی درس‌ها را یاد گرفتی. وقت امتحانه! 🧠'
                        : 'اول هر ۱۱ درس Basics را کامل کن.',
                    style: TextStyle(
                      fontSize: 13,
                      color: unlocked
                          ? Colors.white.withOpacity(0.9)
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              unlocked
                  ? Icons.arrow_forward_ios_rounded
                  : Icons.lock_outline_rounded,
              size: 18,
              color: unlocked
                  ? Colors.white
                  : Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
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

    final completedCount = completedLessons.length;
    final totalCount = a1BasicsLessons.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'A1 Basics 🧠',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: lavender.withOpacity(0.14),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'پایه‌های انگلیسی',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'اول این ۱۱ درس را یاد بگیر، '
                    'بعد Basics Exam باز می‌شود.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: totalCount == 0
                          ? 0
                          : completedCount / totalCount,
                      minHeight: 9,
                      backgroundColor:
                          Theme.of(context)
                              .dividerColor
                              .withOpacity(0.15),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                        lavender,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$completedCount از $totalCount درس کامل شده',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              a1BasicsLessons.length,
              (index) => _buildLessonCard(
                context,
                a1BasicsLessons[index],
                index,
              ),
            ),
            _buildExamCard(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}