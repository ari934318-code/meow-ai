import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final bool isPersian;

  /// مسیر آزمون تعیین سطح
  final VoidCallback? onPlacementTest;

  /// مسیر شروع مستقیم از A1
  final VoidCallback? onStartFromA1;

  const WelcomePage({
    super.key,
    required this.isPersian,
    this.onPlacementTest,
    this.onStartFromA1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primary = const Color(0xFF9B7EDE);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 28,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 520,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // -------------------------------------------------
                  // Meow
                  // -------------------------------------------------
                  Container(
                    width: 118,
                    height: 118,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF24202D)
                          : const Color(0xFFF3EEFC),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '🐱',
                        style: const TextStyle(
                          fontSize: 62,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    isPersian
                        ? 'به Meow AI خوش اومدی!'
                        : 'Welcome to Meow AI!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: isPersian ? 0 : -0.3,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    isPersian
                        ? 'اینجا قراره انگلیسی رو قدم‌به‌قدم، کاربردی و بدون خسته‌کننده شدن یاد بگیری.'
                        : 'Learn English step by step, with real-life practice and a little help from Meow.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: theme.textTheme.bodyLarge?.color
                          ?.withValues(alpha: 0.72),
                    ),
                  ),

                  const SizedBox(height: 38),

                  // -------------------------------------------------
                  // Placement Test
                  // -------------------------------------------------
                  _ActionCard(
                    icon: Icons.assessment_outlined,
                    title: isPersian
                        ? 'تعیین سطح من'
                        : 'Find My Level',
                    description: isPersian
                        ? 'چند سؤال کوتاه جواب بده تا سطح مناسب خودت رو پیدا کنیم.'
                        : 'Answer a few questions to find the level that fits you best.',
                    primary: primary,
                    onTap: onPlacementTest,
                  ),

                  const SizedBox(height: 14),

                  // -------------------------------------------------
                  // Start from A1
                  // -------------------------------------------------
                  _ActionCard(
                    icon: Icons.school_outlined,
                    title: isPersian
                        ? 'شروع از A1'
                        : 'Start from A1',
                    description: isPersian
                        ? 'اگه می‌خوای انگلیسی رو از پایه شروع کنی، مستقیم از A1 شروع کن.'
                        : 'Start from the basics and build your English from A1.',
                    primary: primary,
                    outlined: true,
                    onTap: onStartFromA1,
                  ),

                  const SizedBox(height: 30),

                  Text(
                    isPersian
                        ? 'هر مسیری رو انتخاب کنی، Meow همراهته. 🐾'
                        : 'Whichever path you choose, Meow will be with you. 🐾',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color
                          ?.withValues(alpha: 0.55),
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (isDark)
                    const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color primary;
  final VoidCallback? onTap;
  final bool outlined;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.primary,
    required this.onTap,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: outlined
                ? Colors.transparent
                : primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: outlined
                  ? primary.withValues(alpha: 0.45)
                  : primary.withValues(alpha: 0.18),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: primary,
                  size: 27,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.45,
                        color: theme.textTheme.bodyMedium?.color
                            ?.withValues(alpha: 0.68),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.chevron_right_rounded,
                color: primary.withValues(alpha: 0.75),
              ),
            ],
          ),
        ),
      ),
    );
  }
}