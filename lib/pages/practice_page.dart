import 'package:flutter/material.dart';

import '../localization.dart';
import '../services/practice_service.dart';
import 'practice_mistakes_page.dart';
import 'vocabulary_practice_page.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  static const Color lavender = Color(0xFFB9A7E8);

  int _mistakeCount = 0;
  bool _loadingMistakes = true;

  @override
  void initState() {
    super.initState();
    _loadMistakeCount();
  }

  Future<void> _loadMistakeCount() async {
    final count =
        await PracticeService.getBasicsWrongAnswerCount();

    if (!mounted) return;

    setState(() {
      _mistakeCount = count;
      _loadingMistakes = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${lang.practice} 🎯',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
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
                  ? 'مهارتت رو تمرین کن'
                  : 'Practice your English',
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              lang.isPersian
                  ? 'یک مهارت رو انتخاب کن و با میو تمرین کن 🐱'
                  : 'Choose a skill and start practicing with Meow 🐱',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            _mistakesCard(
              context,
              lang,
            ),

            const SizedBox(height: 14),

            _practiceCard(
              context,
              emoji: '🗣️',
              title: lang.isPersian
                  ? 'مکالمه'
                  : 'Speaking',
              description: lang.isPersian
                  ? 'مکالمه و تلفظت رو با میو تمرین کن'
                  : 'Practice conversations and pronunciation',
              icon: Icons.mic_rounded,
              color: lavender,
              onTap: () {},
            ),

            _practiceCard(
              context,
              emoji: '✍️',
              title: lang.isPersian
                  ? 'نوشتن'
                  : 'Writing',
              description: lang.isPersian
                  ? 'جمله بنویس و گرامرت رو بهتر کن'
                  : 'Write sentences and improve your grammar',
              icon: Icons.edit_rounded,
              color: const Color(0xFF5C8DDE),
              onTap: () {},
            ),

            _practiceCard(
              context,
              emoji: '👂',
              title: lang.isPersian
                  ? 'شنیداری'
                  : 'Listening',
              description: lang.isPersian
                  ? 'گوش دادنت رو با انگلیسی واقعی تقویت کن'
                  : 'Train your listening with real English',
              icon: Icons.headphones_rounded,
              color: const Color(0xFF8C72D8),
              onTap: () {},
            ),

            _practiceCard(
              context,
              emoji: '📖',
              title: lang.isPersian
                  ? 'واژگان'
                  : 'Vocabulary',
              description: lang.isPersian
                  ? 'کلمات و عبارت‌های کاربردی روزمره رو یاد بگیر'
                  : 'Learn useful everyday words and phrases',
              icon: Icons.menu_book_rounded,
              color: const Color(0xFF4CAF50),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const VocabularyPracticePage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

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
                      color: lavender.withOpacity(0.13),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: lavender,
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
                              ? 'تمرین‌های هوشمند میو'
                              : 'Meow Smart Practice',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          lang.isPersian
                              ? 'تمرین‌ها بر اساس سطح و اشتباهاتت شخصی‌سازی می‌شن ✨'
                              : 'Practice adapts to your level and mistakes ✨',
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
    );
  }

  Widget _mistakesCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    final hasMistakes = _mistakeCount > 0;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const PracticeMistakesPage(),
          ),
        );

        await _loadMistakeCount();
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: hasMistakes
              ? Colors.red.withOpacity(0.055)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: hasMistakes
                ? Colors.red.withOpacity(0.16)
                : lavender.withOpacity(0.14),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: hasMistakes
                    ? Colors.red.withOpacity(0.10)
                    : lavender.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                hasMistakes
                    ? Icons.error_outline_rounded
                    : Icons.check_circle_outline_rounded,
                color: hasMistakes
                    ? Colors.red
                    : lavender,
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
                        ? 'اشتباهات من'
                        : 'My Mistakes',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  if (_loadingMistakes)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  else
                    Text(
                      hasMistakes
                          ? (lang.isPersian
                              ? '$_mistakeCount اشتباه برای تمرین داری'
                              : '$_mistakeCount mistakes to practice')
                          : (lang.isPersian
                              ? 'فعلاً اشتباهی نداری 🎉'
                              : 'No mistakes yet 🎉'),
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
              Icons.arrow_forward_ios_rounded,
              size: 17,
              color: hasMistakes
                  ? Colors.red.withOpacity(0.75)
                  : lavender.withOpacity(0.75),
            ),
          ],
        ),
      ),
    );
  }

  Widget _practiceCard(
    BuildContext context, {
    required String emoji,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: color.withOpacity(0.14),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
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
                      '$emoji  $title',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
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
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: color.withOpacity(0.75),
              ),
            ],
          ),
        ),
      ),
    );
  }
}