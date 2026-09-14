import 'package:flutter/material.dart';

class PlacementIntroPage extends StatelessWidget {
  final bool isPersian;
  final VoidCallback? onStart;

  const PlacementIntroPage({
    super.key,
    required this.isPersian,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const primary = Color(0xFF9B7EDE);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          isPersian ? 'تعیین سطح' : 'Placement Test',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 520,
              ),
              child: Column(
                children: [
                  Container(
                    width: 108,
                    height: 108,
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
                          fontSize: 58,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    isPersian
                        ? 'ببینیم سطح انگلیسیت کجاست!'
                        : 'Let’s find your English level!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    isPersian
                        ? 'این آزمون به Meow کمک می‌کنه بفهمه از کدوم سطح بهتره شروع کنی.'
                        : 'This test helps Meow figure out which level is the best place for you to start.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: theme.textTheme.bodyLarge?.color
                          ?.withValues(alpha: 0.72),
                    ),
                  ),

                  const SizedBox(height: 30),

                  _InfoCard(
                    icon: Icons.timer_outlined,
                    title: isPersian ? 'کوتاه و ساده' : 'Short and simple',
                    text: isPersian
                        ? 'سؤال‌ها مرحله‌به‌مرحله سخت‌تر می‌شن.'
                        : 'The questions gradually become more challenging.',
                    primary: primary,
                  ),

                  const SizedBox(height: 12),

                  _InfoCard(
                    icon: Icons.psychology_outlined,
                    title: isPersian ? 'بدون استرس' : 'No pressure',
                    text: isPersian
                        ? 'اگر جواب بعضی سؤال‌ها رو نمی‌دونی، اشکالی نداره.'
                        : 'If you don’t know some answers, that’s completely okay.',
                    primary: primary,
                  ),

                  const SizedBox(height: 12),

                  _InfoCard(
                    icon: Icons.auto_graph_outlined,
                    title: isPersian ? 'سطح مناسب تو' : 'Your best level',
                    text: isPersian
                        ? 'در پایان، Meow سطح پیشنهادی تو رو مشخص می‌کنه.'
                        : 'At the end, Meow will recommend the most suitable level for you.',
                    primary: primary,
                  ),

                  const SizedBox(height: 34),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: onStart,
                      style: FilledButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        isPersian
                            ? 'شروع آزمون'
                            : 'Start Test',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    isPersian
                        ? 'تقلب ممنوع 😼 جواب واقعی خودت رو بده تا سطح دقیق‌تری پیدا کنیم.'
                        : 'No cheating 😼 Give your honest answers so we can find a more accurate level.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      height: 1.5,
                      color: theme.textTheme.bodySmall?.color
                          ?.withValues(alpha: 0.55),
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

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Color primary;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: primary.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: primary,
              size: 23,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.45,
                    color: theme.textTheme.bodyMedium?.color
                        ?.withValues(alpha: 0.68),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}