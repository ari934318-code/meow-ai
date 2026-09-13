import 'package:flutter/material.dart';

import '../lesson_localization.dart';
import '../localization.dart';
import '../services/lesson_service.dart';
import 'lesson_page.dart';
import 'a1_exam_page.dart';

class LessonListPage extends StatelessWidget {
  const LessonListPage({super.key});

  static const Color lavender = Color(0xFFB9A7E8);

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    final lessonLang = LessonLocalization(
      Localizations.localeOf(context),
    );

    final lessons = LessonService.a1Lessons;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lang.isPersian ? 'درس‌های A1 📚' : 'A1 Lessons 📚',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
          children: [
            Text(
              lang.isPersian
                  ? 'مسیر A1 تو'
                  : 'Your A1 journey',
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              lang.isPersian
                  ? 'درس‌ها رو یکی‌یکی جلو برو و انگلیسی واقعی یاد بگیر 🐱'
                  : 'Go lesson by lesson and learn real-life English 🐱',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 22),

            _progressCard(
              context,
              lang,
              lessons.length,
            ),

            const SizedBox(height: 20),

            ...List.generate(
              lessons.length,
              (index) {
                final lesson = lessons[index];

                final title = lessonLang.lessonTitle(
                  lesson.id,
                  lesson.title,
                );

                final description = lessonLang.lessonDescription(
                  lesson.id,
                  lesson.description,
                );

                return _lessonCard(
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

            const SizedBox(height: 8),

            _finalExamCard(context, lang),
          ],
        ),
      ),
    );
  }

  Widget _progressCard(
    BuildContext context,
    MeowLocalizations lang,
    int totalLessons,
  ) {
    return Container(
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
          SizedBox(
            width: 62,
            height: 62,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0,
                  strokeWidth: 6,
                  backgroundColor: lavender.withOpacity(0.18),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(lavender),
                ),
                const Text(
                  '0%',
                  style: TextStyle(
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
                  lang.isPersian
                      ? 'پیشرفت A1'
                      : 'A1 Progress',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  lang.isPersian
                      ? '$totalLessons درس برای یادگیری'
                      : '$totalLessons lessons to learn',
                  style: const TextStyle(
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

  Widget _lessonCard(
    BuildContext context,
    MeowLocalizations lang,
    int index,
    int xp,
    String title,
    String description,
    dynamic lesson,
  ) {
    final isFirst = index == 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LessonPage(
                lesson: lesson,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isFirst
                  ? lavender.withOpacity(0.28)
                  : Colors.grey.withOpacity(0.14),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: lavender.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: lavender,
                    ),
                  ),
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
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: lavender.withOpacity(0.11),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '+$xp XP',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: lavender,
                            ),
                          ),
                        ),

                        if (isFirst) ...[
                          const SizedBox(width: 7),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50)
                                  .withOpacity(0.10),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              lang.isPersian
                                  ? 'شروع'
                                  : 'START',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _finalExamCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const A1ExamPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: lavender.withOpacity(0.12),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: lavender.withOpacity(0.30),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: lavender.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.school_rounded,
                color: lavender,
                size: 29,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.isPersian
                        ? 'امتحان نهایی A1 🎓'
                        : 'A1 Final Exam 🎓',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    lang.isPersian
                        ? 'دانسته‌هات رو امتحان کن و نتیجه‌ات رو ببین'
                        : 'Test your knowledge and see your result',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}