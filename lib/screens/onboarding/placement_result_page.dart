import 'package:flutter/material.dart';

class PlacementResultPage extends StatelessWidget {
  final bool isPersian;
  final String level;

  /// رفتن به درس‌های سطح پیشنهادی
  final VoidCallback? onContinue;

  /// کاربر ترجیح می‌دهد از A1 شروع کند
  final VoidCallback? onStartFromA1;

  const PlacementResultPage({
    super.key,
    required this.isPersian,
    required this.level,
    this.onContinue,
    this.onStartFromA1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const primary = Color(0xFF9B7EDE);

    final levelInfo = _getLevelInfo();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              24,
              10,
              24,
              32,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 520,
              ),
              child: Column(
                children: [
                  // ------------------------------------------------
                  // Meow
                  // ------------------------------------------------
                  Container(
                    width: 118,
                    height: 118,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF24202D)
                          : const Color(0xFFF3EEFC),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '🐱',
                        style: TextStyle(
                          fontSize: 64,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 26),

                  Text(
                    isPersian
                        ? 'نتیجه آماده‌ست! 🎉'
                        : 'Your result is ready! 🎉',
                    textAlign: TextAlign.center,
                    style:
                        theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    isPersian
                        ? 'Meow با توجه به پاسخ‌هات، این سطح رو برای شروع پیشنهاد می‌کنه:'
                        : 'Based on your answers, Meow recommends starting at this level:',
                    textAlign: TextAlign.center,
                    style:
                        theme.textTheme.bodyLarge?.copyWith(
                      height: 1.55,
                      color: theme
                          .textTheme.bodyLarge?.color
                          ?.withValues(alpha: 0.68),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ------------------------------------------------
                  // Level Card
                  // ------------------------------------------------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.10),
                      borderRadius:
                          BorderRadius.circular(26),
                      border: Border.all(
                        color:
                            primary.withValues(alpha: 0.22),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          level,
                          style:
                              theme.textTheme.displaySmall
                                  ?.copyWith(
                            color: primary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          levelInfo.title,
                          textAlign: TextAlign.center,
                          style: theme
                              .textTheme.titleLarge
                              ?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          levelInfo.description,
                          textAlign: TextAlign.center,
                          style: theme
                              .textTheme.bodyMedium
                              ?.copyWith(
                            height: 1.55,
                            color: theme
                                .textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.68),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ------------------------------------------------
                  // Important note
                  // ------------------------------------------------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF201D26)
                          : const Color(0xFFF8F6FA),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lightbulb_outline_rounded,
                          color: primary,
                          size: 25,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            isPersian
                                ? 'این نتیجه فقط یک نقطه شروعه. با پیشرفتت، سطح مناسب می‌تونه تغییر کنه.'
                                : 'This result is only a starting point. Your recommended level can change as you improve.',
                            style: theme
                                .textTheme.bodyMedium
                                ?.copyWith(
                              height: 1.55,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ------------------------------------------------
                  // Continue
                  // ------------------------------------------------
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: onContinue,
                      style: FilledButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        isPersian
                            ? 'شروع ${level} 🚀'
                            : 'Start $level 🚀',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ------------------------------------------------
                  // Start from A1
                  // ------------------------------------------------
                  TextButton(
                    onPressed: onStartFromA1,
                    child: Text(
                      isPersian
                          ? 'ترجیح می‌دم از A1 شروع کنم'
                          : 'I prefer to start from A1',
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    isPersian
                        ? 'هر سطحی که شروع کنی، مهم اینه که ادامه بدی. 🐾'
                        : 'Whatever level you start at, what matters is keeping going. 🐾',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(
                      height: 1.5,
                      color: theme
                          .textTheme.bodySmall?.color
                          ?.withValues(alpha: 0.52),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _LevelInfo _getLevelInfo() {
    switch (level.toUpperCase()) {
      case 'A2':
        return _LevelInfo(
          title: isPersian
              ? 'پایه رو داری، حالا وقت قوی‌تر شدنه!'
              : 'You have the basics. Now let’s build on them!',
          description: isPersian
              ? 'می‌تونی از A2 شروع کنی و کم‌کم مکالمه، واژگان و گرامرت رو قوی‌تر کنی.'
              : 'You can start at A2 and gradually strengthen your grammar, vocabulary, and communication skills.',
        );

      case 'B1':
        return _LevelInfo(
          title: isPersian
              ? 'به سطح متوسط رسیدی!'
              : 'You’re at an intermediate level!',
          description: isPersian
              ? 'می‌تونی وارد B1 بشی و روی انگلیسی واقعی، مکالمه و ساختارهای پیچیده‌تر کار کنی.'
              : 'You can start at B1 and work on real English, communication, and more advanced structures.',
        );

      case 'B2':
        return _LevelInfo(
          title: isPersian
              ? 'انگلیسیت داره جدی می‌شه!'
              : 'Your English is getting serious!',
          description: isPersian
              ? 'B2 جای خوبیه برای قوی‌تر کردن روانی، دقت و درک انگلیسی واقعی.'
              : 'B2 is a great place to improve fluency, accuracy, and real-world English comprehension.',
        );

      case 'C1':
        return _LevelInfo(
          title: isPersian
              ? 'سطح پیشرفته!'
              : 'Advanced level!',
          description: isPersian
              ? 'می‌تونی روی ظرافت‌های زبان، واژگان پیشرفته و بیان طبیعی‌تر کار کنی.'
              : 'You can focus on nuance, advanced vocabulary, and more natural expression.',
        );

      case 'C2':
        return _LevelInfo(
          title: isPersian
              ? 'تقریباً در بالاترین سطح!'
              : 'Near the highest level!',
          description: isPersian
              ? 'C2 یعنی می‌تونی روی ظرافت، دقت و استفاده بسیار طبیعی از زبان کار کنی.'
              : 'C2 means you can focus on precision, nuance, and highly natural language use.',
        );

      case 'A1':
      default:
        return _LevelInfo(
          title: isPersian
              ? 'از پایه شروع می‌کنیم!'
              : 'We’ll start from the basics!',
          description: isPersian
              ? 'A1 نقطه شروع خوبیه برای ساختن یک پایه محکم در انگلیسی.'
              : 'A1 is a great starting point for building a strong foundation in English.',
        );
    }
  }
}

class _LevelInfo {
  final String title;
  final String description;

  const _LevelInfo({
    required this.title,
    required this.description,
  });
}