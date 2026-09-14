import 'package:flutter/material.dart';

class StudyTipPage extends StatelessWidget {
  final bool isPersian;

  /// ورود به برنامه بعد از این صفحه
  final VoidCallback? onContinue;

  const StudyTipPage({
    super.key,
    required this.isPersian,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const primary = Color(0xFF9B7EDE);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              24,
              32,
              24,
              30,
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
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF24202D)
                          : const Color(0xFFF3EEFC),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '🐱✏️',
                        style: TextStyle(
                          fontSize: 52,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    isPersian
                        ? 'یک پیشنهاد کوچیک از طرف Meow'
                        : 'A little tip from Meow',
                    textAlign: TextAlign.center,
                    style:
                        theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    isPersian
                        ? 'قبل از شروع درس‌ها، اگر می‌تونی یک دفتر و مداد کنار دستت داشته باش.'
                        : 'Before you start your lessons, try to keep a notebook and a pencil nearby.',
                    textAlign: TextAlign.center,
                    style:
                        theme.textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: theme
                          .textTheme.bodyLarge?.color
                          ?.withValues(alpha: 0.70),
                    ),
                  ),

                  const SizedBox(height: 26),

                  // ------------------------------------------------
                  // Notebook card
                  // ------------------------------------------------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.09),
                      borderRadius:
                          BorderRadius.circular(24),
                      border: Border.all(
                        color:
                            primary.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: 42,
                          color: primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isPersian
                              ? 'لازم نیست همه‌چیز رو بنویسی'
                              : 'You don’t need to write everything down',
                          textAlign: TextAlign.center,
                          style: theme
                              .textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isPersian
                              ? 'فقط کلمه‌های جدید، نکته‌های مهم، مثال‌های جالب و چیزهایی که فکر می‌کنی ممکنه یادت بره رو یادداشت کن.'
                              : 'Write down new words, useful notes, interesting examples, and anything you think you might forget.',
                          textAlign: TextAlign.center,
                          style: theme
                              .textTheme.bodyMedium
                              ?.copyWith(
                            height: 1.6,
                            color: theme
                                .textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.68),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ------------------------------------------------
                  // Brain card
                  // ------------------------------------------------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF201D26)
                          : const Color(0xFFF8F6FA),
                      borderRadius:
                          BorderRadius.circular(24),
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color:
                                primary.withValues(alpha: 0.12),
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.psychology_outlined,
                            color: primary,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            isPersian
                                ? 'وقتی چیزی رو می‌خونی، بهش فکر می‌کنی و بعد با دست خودت می‌نویسی، ذهنت فرصت بیشتری برای پردازش و تثبیت اون مطلب پیدا می‌کنه.'
                                : 'When you read something, think about it, and then write it down yourself, your brain gets more opportunities to process and reinforce what you learned.',
                            style: theme
                                .textTheme.bodyMedium
                                ?.copyWith(
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ------------------------------------------------
                  // Encouragement
                  // ------------------------------------------------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.06),
                      borderRadius:
                          BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Text(
                          isPersian
                              ? 'از اشتباه کردن نترس.'
                              : 'Don’t be afraid of making mistakes.',
                          textAlign: TextAlign.center,
                          style: theme
                              .textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isPersian
                              ? 'اشتباه کردن بخشی از یادگیریه. مهم اینه که ادامه بدی و هر روز یک قدم جلوتر بری.'
                              : 'Mistakes are part of learning. What matters is that you keep going and take one step forward each day.',
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

                  const SizedBox(height: 30),

                  // ------------------------------------------------
                  // Good luck
                  // ------------------------------------------------
                  Text(
                    isPersian
                        ? 'موفق باشی! 🐾'
                        : 'Good luck! 🐾',
                    textAlign: TextAlign.center,
                    style:
                        theme.textTheme.headlineSmall?.copyWith(
                      color: primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    isPersian
                        ? 'از اینجا به بعد، قدم‌به‌قدم با هم پیش می‌ریم.'
                        : 'From here on, we’ll take it step by step together.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      color: theme
                          .textTheme.bodyLarge?.color
                          ?.withValues(alpha: 0.65),
                    ),
                  ),

                  const SizedBox(height: 28),

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
                            ? 'بریم شروع کنیم 🚀'
                            : 'Let’s get started 🚀',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    isPersian
                        ? 'Meow اینجاست. 🐱💜'
                        : 'Meow is here. 🐱💜',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme
                          .textTheme.bodySmall?.color
                          ?.withValues(alpha: 0.48),
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
}