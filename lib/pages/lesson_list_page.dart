import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lesson_localization.dart';
import '../localization.dart';
import '../services/a1_progress_service.dart';
import '../services/lesson_service.dart';
import 'lesson_page.dart';
import 'a1_exam_page.dart';
import 'a1_basics_exam_page.dart';

class LessonListPage extends StatefulWidget {
  const LessonListPage({super.key});

  @override
  State<LessonListPage> createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  Set<String> completedLessons = {};
  bool basicsCompleted = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completed =
        await A1ProgressService.getCompletedLessons();

    final prefs = await SharedPreferences.getInstance();

    final basicsPassed =
        prefs.getBool('a1_basics_completed') ?? false;

    if (!mounted) return;

    setState(() {
      completedLessons = completed;
      basicsCompleted = basicsPassed;
      isLoading = false;
    });
  }

  bool _isUnlocked(int index) {
    // Lesson 1 requires passing the Basics Exam.
    if (index == 0) {
      return basicsCompleted;
    }

    // Every other lesson requires the previous lesson.
    final previousLesson =
        LessonService.a1Lessons[index - 1];

    return completedLessons.contains(
      previousLesson.id,
    );
  }

  bool _isCompleted(int index) {
    final lesson =
        LessonService.a1Lessons[index];

    return completedLessons.contains(
      lesson.id,
    );
  }

  Future<void> _openBasicsExam() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const A1BasicsExamPage(),
      ),
    );

    await _loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    final lessonLang = LessonLocalization(
      Localizations.localeOf(context),
    );

    final lessons = LessonService.a1Lessons;

    final completedCount = lessons
        .where(
          (lesson) =>
              completedLessons.contains(
            lesson.id,
          ),
        )
        .length;

    final progress =
        lessons.isEmpty
            ? 0.0
            : completedCount /
                lessons.length;

    return Scaffold(
      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lang.isPersian
              ? 'مسیر A1 📚'
              : 'A1 Journey 📚',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child:
                    CircularProgressIndicator(
                  color: lavender,
                ),
              )
            : ListView(
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  40,
                ),
                children: [
                  Text(
                    lang.isPersian
                        ? 'مسیر A1 تو'
                        : 'Your A1 journey',
                    style:
                        const TextStyle(
                      fontSize: 29,
                      fontWeight:
                          FontWeight.w700,
                      letterSpacing: -0.8,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    lang.isPersian
                        ? 'مرحله‌به‌مرحله جلو برو و انگلیسی واقعی یاد بگیر 🐱'
                        : 'Move through each stage and learn real-life English 🐱',
                    style:
                        const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  _progressCard(
                    context,
                    lang,
                    completedCount,
                    lessons.length,
                    progress,
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  // A1 Basics
                  _basicsCard(
                    context,
                    lang,
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  ...List.generate(
                    lessons.length,
                    (index) {
                      final lesson =
                          lessons[index];

                      final title =
                          lessonLang
                              .lessonTitle(
                        lesson.id,
                        lesson.title,
                      );

                      final description =
                          lessonLang
                              .lessonDescription(
                        lesson.id,
                        lesson.description,
                      );

                      return _stageCard(
                        context,
                        lang,
                        index,
                        lesson.xp,
                        title,
                        description,
                        lesson,
                      );
                    },
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  _finalExamCard(
                    context,
                    lang,
                    completedCount ==
                        lessons.length,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _basicsCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(24),
      onTap: _openBasicsExam,
      child: Container(
        padding:
            const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: basicsCompleted
              ? Colors.green
                  .withOpacity(0.10)
              : lavender
                  .withOpacity(0.12),
          borderRadius:
              BorderRadius.circular(24),
          border: Border.all(
            color: basicsCompleted
                ? Colors.green
                    .withOpacity(0.25)
                : lavender
                    .withOpacity(0.30),
            width: 1.4,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration:
                  BoxDecoration(
                color: basicsCompleted
                    ? Colors.green
                        .withOpacity(0.12)
                    : lavender
                        .withOpacity(0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(
                basicsCompleted
                    ? Icons
                        .check_circle_rounded
                    : Icons
                        .auto_stories_rounded,
                color: basicsCompleted
                    ? Colors.green
                    : lavender,
                size: 30,
              ),
            ),

            const SizedBox(
              width: 16,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.isPersian
                        ? 'A1 Basics 🧠'
                        : 'A1 Basics 🧠',
                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    basicsCompleted
                        ? lang.isPersian
                            ? 'آماده‌ای! Basics رو با موفقیت گذروندی.'
                            : 'Completed! You passed the Basics Exam.'
                        : lang.isPersian
                            ? 'اول پایه‌های انگلیسی رو یاد بگیر و بعد امتحان بده.'
                            : 'Learn the foundations, then pass the Basics Exam.',
                    style:
                        const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration:
                        BoxDecoration(
                      color: basicsCompleted
                          ? Colors.green
                              .withOpacity(
                              0.10,
                            )
                          : lavender
                              .withOpacity(
                              0.10,
                            ),
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Text(
                      basicsCompleted
                          ? lang.isPersian
                              ? 'تکمیل شد ✓'
                              : 'COMPLETED ✓'
                          : lang.isPersian
                              ? 'امتحان Basics'
                              : 'Basics Exam',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w800,
                        color:
                            basicsCompleted
                                ? Colors.green
                                : lavender,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            Icon(
              basicsCompleted
                  ? Icons
                      .check_circle_outline_rounded
                  : Icons
                      .arrow_forward_ios_rounded,
              size: 18,
              color: basicsCompleted
                  ? Colors.green
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressCard(
    BuildContext context,
    MeowLocalizations lang,
    int completedCount,
    int totalLessons,
    double progress,
  ) {
    final percent =
        (progress * 100).round();

    return Container(
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            lavender.withOpacity(0.10),
        borderRadius:
            BorderRadius.circular(24),
        border: Border.all(
          color:
              lavender.withOpacity(0.14),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 62,
            height: 62,
            child: Stack(
              alignment:
                  Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor:
                      lavender.withOpacity(
                    0.18,
                  ),
                  valueColor:
                      const AlwaysStoppedAnimation<
                          Color>(
                    lavender,
                  ),
                ),
                Text(
                  lang.isPersian
                      ? '$percent٪'
                      : '$percent%',
                  style:
                      const TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 16,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  lang.isPersian
                      ? 'پیشرفت A1'
                      : 'A1 Progress',
                  style:
                      const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  lang.isPersian
                      ? '$completedCount از $totalLessons مرحله کامل شده'
                      : '$completedCount of $totalLessons stages completed',
                  style:
                      const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stageCard(
    BuildContext context,
    MeowLocalizations lang,
    int index,
    int xp,
    String title,
    String description,
    dynamic lesson,
  ) {
    final completed =
        _isCompleted(index);

    final unlocked =
        _isUnlocked(index);

    final stageNumber =
        index + 1;

    Color borderColor;
    Color circleColor;
    Color numberColor;

    if (completed) {
      borderColor =
          const Color(0xFF4CAF50)
              .withOpacity(0.30);
      circleColor =
          const Color(0xFF4CAF50)
              .withOpacity(0.12);
      numberColor =
          const Color(0xFF4CAF50);
    } else if (unlocked) {
      borderColor =
          lavender.withOpacity(0.30);
      circleColor =
          lavender.withOpacity(0.13);
      numberColor = lavender;
    } else {
      borderColor =
          Colors.grey.withOpacity(0.12);
      circleColor =
          Colors.grey.withOpacity(0.10);
      numberColor = Colors.grey;
    }

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(24),
        onTap: unlocked
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        LessonPage(
                      lesson: lesson,
                    ),
                  ),
                ).then((_) {
                  _loadProgress();
                });
              }
            : null,
        child: Opacity(
          opacity:
              unlocked ? 1.0 : 0.58,
          child: Container(
            padding:
                const EdgeInsets.all(18),
            decoration:
                BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surface,
              borderRadius:
                  BorderRadius.circular(
                24,
              ),
              border: Border.all(
                color: borderColor,
                width:
                    completed ||
                            unlocked
                        ? 1.3
                        : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration:
                      BoxDecoration(
                    color:
                        circleColor,
                    shape:
                        BoxShape.circle,
                  ),
                  child: Center(
                    child: completed
                        ? const Icon(
                            Icons
                                .check_rounded,
                            color:
                                Color(
                              0xFF4CAF50,
                            ),
                            size: 27,
                          )
                        : unlocked
                            ? Text(
                                '$stageNumber',
                                style:
                                    TextStyle(
                                  fontSize:
                                      18,
                                  fontWeight:
                                      FontWeight
                                          .w800,
                                  color:
                                      numberColor,
                                ),
                              )
                            : const Icon(
                                Icons
                                    .lock_outline_rounded,
                                color:
                                    Colors
                                        .grey,
                                size: 24,
                              ),
                  ),
                ),

                const SizedBox(
                  width: 14,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        lang.isPersian
                            ? 'مرحله $stageNumber'
                            : 'Stage $stageNumber',
                        style:
                            TextStyle(
                          fontSize: 12,
                          fontWeight:
                              FontWeight
                                  .w700,
                          color: completed
                              ? const Color(
                                  0xFF4CAF50,
                                )
                              : unlocked
                                  ? lavender
                                  : Colors
                                      .grey,
                        ),
                      ),

                      const SizedBox(
                        height: 3,
                      ),

                      Text(
                        title,
                        style:
                            const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight
                                  .w700,
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Text(
                        description,
                        maxLines: 2,
                        overflow:
                            TextOverflow
                                .ellipsis,
                        style:
                            const TextStyle(
                          fontSize: 13,
                          color:
                              Colors.grey,
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal:
                                  9,
                              vertical:
                                  5,
                            ),
                            decoration:
                                BoxDecoration(
                              color: lavender
                                  .withOpacity(
                                0.11,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),
                            child: Text(
                              '+$xp XP',
                              style:
                                  const TextStyle(
                                fontSize:
                                    11,
                                fontWeight:
                                    FontWeight
                                        .w800,
                                color:
                                    lavender,
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 7,
                          ),

                          if (completed)
                            _statusChip(
                              lang.isPersian
                                  ? 'تکمیل شد ✓'
                                  : 'COMPLETED ✓',
                              const Color(
                                0xFF4CAF50,
                              ),
                            )
                          else if (unlocked)
                            _statusChip(
                              lang.isPersian
                                  ? 'باز است'
                                  : 'UNLOCKED',
                              lavender,
                            )
                          else
                            _statusChip(
                              lang.isPersian
                                  ? 'قفل'
                                  : 'LOCKED',
                              Colors.grey,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 8,
                ),

                Icon(
                  completed
                      ? Icons
                          .check_circle_outline_rounded
                      : unlocked
                          ? Icons
                              .arrow_forward_ios_rounded
                          : Icons
                              .lock_outline_rounded,
                  size: 18,
                  color: completed
                      ? const Color(
                          0xFF4CAF50,
                        )
                      : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusChip(
    String text,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration:
          BoxDecoration(
        color:
            color.withOpacity(0.10),
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight:
              FontWeight.w800,
          color: color,
        ),
      ),
    );
  }

  Widget _finalExamCard(
    BuildContext context,
    MeowLocalizations lang,
    bool allLessonsCompleted,
  ) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(24),
      onTap: allLessonsCompleted
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const A1ExamPage(),
                ),
              );
            }
          : null,
      child: Opacity(
        opacity:
            allLessonsCompleted
                ? 1.0
                : 0.55,
        child: Container(
          padding:
              const EdgeInsets.all(20),
          decoration:
              BoxDecoration(
            color:
                lavender.withOpacity(
              0.12,
            ),
            borderRadius:
                BorderRadius.circular(
              24,
            ),
            border: Border.all(
              color:
                  lavender.withOpacity(
                0.30,
              ),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration:
                    BoxDecoration(
                  color:
                      lavender.withOpacity(
                    0.18,
                  ),
                  shape:
                      BoxShape.circle,
                ),
                child: Icon(
                  allLessonsCompleted
                      ? Icons
                          .school_rounded
                      : Icons
                          .lock_outline_rounded,
                  color: lavender,
                  size: 29,
                ),
              ),

              const SizedBox(
                width: 16,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      lang.isPersian
                          ? 'امتحان نهایی A1 🎓'
                          : 'A1 Final Exam 🎓',
                      style:
                          const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight
                                .w800,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      allLessonsCompleted
                          ? lang.isPersian
                              ? 'همه مراحل رو کامل کردی! وقت امتحانه.'
                              : 'You completed all stages! Time for the exam.'
                          : lang.isPersian
                              ? 'اول هر ۱۲ مرحله رو کامل کن'
                              : 'Complete all 12 stages first',
                      style:
                          const TextStyle(
                        fontSize: 13,
                        color:
                            Colors.grey,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                allLessonsCompleted
                    ? Icons
                        .arrow_forward_ios_rounded
                    : Icons
                        .lock_outline_rounded,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}