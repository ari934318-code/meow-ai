import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/levels/b1/b1_lessons.dart';
import '../data/levels/b1/b1_lesson_01_data.dart';
import '../localization.dart';

class B1Page extends StatefulWidget {
  const B1Page({super.key});

  @override
  State<B1Page> createState() => _B1PageState();
}

class _B1PageState extends State<B1Page> {
  static const Color lavender = Color(0xFFB9A7E8);

  static const String _completedKey =
      'b1_completed_lessons';

  Set<String> completedLessons = {};
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

    if (!mounted) return;

    setState(() {
      completedLessons = completed.toSet();
      isLoading = false;
    });
  }

  bool _isLessonUnlocked(int index) {
    if (index == 0) {
      return true;
    }

    return completedLessons.contains(
      b1Lessons[index - 1].id.toString(),
    );
  }

  Future<void> _openLesson(
    B1Lesson lesson,
  ) async {
    if (lesson.id == 1) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const B1Lesson01PreviewPage(),
        ),
      );

      await _loadProgress();
    }
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

    final completedCount =
        completedLessons.length;

    final totalCount =
        b1Lessons.length;

    final progress = totalCount == 0
        ? 0.0
        : completedCount / totalCount;

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lang.isPersian ? 'سطح B1' : 'B1 Level',
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
            _buildLessons(lang),
            const SizedBox(height: 8),
            _buildFinalTestCard(lang),
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
        color: Theme.of(context)
            .colorScheme
            .surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: lavender.withAlpha(36),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            lang.isPersian
                ? 'سطح B1 🐱'
                : 'B1 Level 🐱',
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            lang.isPersian
                ? 'انگلیسی واقعی برای موقعیت‌های روزمره، تجربه‌ها و ارتباط مؤثر'
                : 'Real English for everyday situations, experiences, and communication.',
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
                lang.isPersian
                    ? 'پیشرفت'
                    : 'Progress',
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
            borderRadius:
                BorderRadius.circular(20),
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

  Widget _buildLessons(
    MeowLocalizations lang,
  ) {
    return Column(
      children: List.generate(
        b1Lessons.length,
        (index) {
          final lesson =
              b1Lessons[index];

          final unlocked =
              _isLessonUnlocked(index);

          final completed =
              completedLessons.contains(
            lesson.id.toString(),
          );

          return _buildLessonCard(
            lang: lang,
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
    required MeowLocalizations lang,
    required B1Lesson lesson,
    required int index,
    required bool unlocked,
    required bool completed,
  }) {
    final lessonNumber =
        index + 1;

    final label = lang.isPersian
        ? 'درس $lessonNumber'
        : 'Lesson $lessonNumber';

    final title = lang.isPersian
        ? lesson.titleFa
        : lesson.titleEn;

    final topic = lang.isPersian
        ? lesson.topicFa
        : lesson.topicEn;

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(24),
        onTap: unlocked
            ? () => _openLesson(lesson)
            : null,
        child: AnimatedOpacity(
          duration:
              const Duration(milliseconds: 200),
          opacity:
              unlocked ? 1.0 : 0.55,
          child: Container(
            padding:
                const EdgeInsets.all(18),
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
                  width: 50,
                  height: 50,
                  decoration:
                      BoxDecoration(
                    color: completed
                        ? Colors.green
                            .withAlpha(28)
                        : lavender
                            .withAlpha(31),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    completed
                        ? Icons
                            .check_circle_rounded
                        : unlocked
                            ? Icons
                                .menu_book_rounded
                            : Icons
                                .lock_rounded,
                    color: completed
                        ? Colors.green
                        : unlocked
                            ? lavender
                            : Colors.grey,
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
                        label,
                        style:
                            const TextStyle(
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w700,
                          color: lavender,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style:
                            const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        topic,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style:
                            const TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  completed
                      ? Icons
                          .check_circle_rounded
                      : unlocked
                          ? Icons
                              .arrow_forward_ios_rounded
                          : Icons
                              .lock_outline_rounded,
                  size: completed
                      ? 23
                      : 17,
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

  Widget _buildFinalTestCard(
    MeowLocalizations lang,
  ) {
    final allCompleted =
        b1Lessons.every(
      (lesson) =>
          completedLessons.contains(
        lesson.id.toString(),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface,
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color: allCompleted
              ? lavender.withAlpha(64)
              : Colors.grey.withAlpha(31),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: allCompleted
                  ? lavender.withAlpha(31)
                  : Colors.grey.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              allCompleted
                  ? Icons.quiz_rounded
                  : Icons.lock_rounded,
              color: allCompleted
                  ? lavender
                  : Colors.grey,
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
                      ? 'آزمون نهایی B1'
                      : 'B1 Final Level Test',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  lang.isPersian
                      ? 'بعد از تکمیل هر ۳۰ درس باز می‌شود.'
                      : 'Unlocks after completing all 30 lessons.',
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
            allCompleted
                ? Icons.arrow_forward_ios_rounded
                : Icons.lock_outline_rounded,
            color: allCompleted
                ? lavender
                : Colors.grey,
            size: 17,
          ),
        ],
      ),
    );
  }
}

///
/// موقتاً فقط برای اینکه Lesson 01 را تست کنیم.
/// بعداً این صفحه را با صفحه اصلی B1 Lesson
/// که ساختار کامل Vocabulary / Grammar /
/// Listening / Reading / Speaking / Writing دارد
/// جایگزین می‌کنیم.
///
class B1Lesson01PreviewPage
    extends StatelessWidget {
  const B1Lesson01PreviewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lang =
        MeowLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.isPersian
              ? B1Lesson01Data.titleFa
              : B1Lesson01Data.titleEn,
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(20),
        children: [
          Text(
            lang.isPersian
                ? B1Lesson01Data.topicFa
                : B1Lesson01Data.topicEn,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            lang.isPersian
                ? B1Lesson01Data
                    .grammar
                    .titleFa
                : B1Lesson01Data
                    .grammar
                    .titleEn,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            lang.isPersian
                ? B1Lesson01Data
                    .grammar
                    .explanationFa
                : B1Lesson01Data
                    .grammar
                    .explanationEn,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}