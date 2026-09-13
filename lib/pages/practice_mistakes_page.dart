import 'package:flutter/material.dart';

import '../services/practice_service.dart';
import '../localization.dart';
import 'practice_a1_mistake_review_page.dart';

class PracticeMistakesPage extends StatefulWidget {
  const PracticeMistakesPage({super.key});

  @override
  State<PracticeMistakesPage> createState() =>
      _PracticeMistakesPageState();
}

class _PracticeMistakesPageState
    extends State<PracticeMistakesPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  bool _loading = true;
  List<Map<String, dynamic>> _mistakes = [];

  @override
  void initState() {
    super.initState();
    _loadMistakes();
  }

  Future<void> _loadMistakes() async {
    final mistakes =
        await PracticeService.getBasicsWrongAnswers();

    if (!mounted) return;

    setState(() {
      _mistakes = mistakes;
      _loading = false;
    });
  }

  Future<void> _clearMistakes() async {
    await PracticeService.clearBasicsWrongAnswers();

    if (!mounted) return;

    setState(() {
      _mistakes = [];
    });
  }

  Future<void> _openMistakePractice() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const PracticeA1MistakeReviewPage(),
      ),
    );

    await _loadMistakes();
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);
    final isPersian = lang.isPersian;

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          isPersian
              ? 'اشتباهات من'
              : 'My Mistakes',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (_mistakes.isNotEmpty)
            IconButton(
              tooltip: isPersian
                  ? 'پاک کردن'
                  : 'Clear',
              icon: const Icon(
                Icons.delete_outline_rounded,
              ),
              onPressed: _clearMistakes,
            ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(
          context,
          isPersian,
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    bool isPersian,
  ) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_mistakes.isEmpty) {
      return _buildEmptyState(
        context,
        isPersian,
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        110,
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: lavender.withOpacity(0.10),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: lavender.withOpacity(0.16),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: lavender.withOpacity(0.14),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: lavender,
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
                      isPersian
                          ? '${_mistakes.length} اشتباه برای تمرین'
                          : '${_mistakes.length} mistakes to practice',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      isPersian
                          ? 'میو این‌ها رو نگه داشته تا دوباره تمرینشون کنی 🐱'
                          : 'Meow saved these so you can practice them again 🐱',
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

        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _openMistakePractice,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
            label: Text(
              isPersian
                  ? 'تمرین دوباره اشتباهات'
                  : 'Practice Mistakes Again',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: lavender,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(17),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'Basics Exam',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        ..._mistakes.asMap().entries.map(
          (entry) {
            final index = entry.key + 1;
            final mistake = entry.value;

            return _mistakeCard(
              context,
              index: index,
              mistake: mistake,
              isPersian: isPersian,
            );
          },
        ),
      ],
    );
  }

  Widget _mistakeCard(
    BuildContext context, {
    required int index,
    required Map<String, dynamic> mistake,
    required bool isPersian,
  }) {
    final question =
        mistake['question']?.toString() ?? '';

    final userAnswer =
        mistake['userAnswer']?.toString() ?? '';

    final correctAnswer =
        mistake['correctAnswer']?.toString() ?? '';

    final explanation =
        mistake['explanation']?.toString() ?? '';

    final topic =
        mistake['topic']?.toString() ?? '';

    final category =
        mistake['category']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.red.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  topic.isEmpty
                      ? (isPersian
                          ? 'موضوع'
                          : 'Topic')
                      : topic,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              if (category.isNotEmpty)
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color:
                        lavender.withOpacity(0.10),
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 11,
                      color: lavender,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 14),

          _answerRow(
            icon: Icons.close_rounded,
            label: isPersian
                ? 'جواب تو'
                : 'Your answer',
            value: userAnswer,
            color: Colors.red,
          ),

          const SizedBox(height: 8),

          _answerRow(
            icon: Icons.check_rounded,
            label: isPersian
                ? 'جواب درست'
                : 'Correct answer',
            value: correctAnswer,
            color: Colors.green,
          ),

          if (explanation.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: lavender.withOpacity(0.07),
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 19,
                    color: lavender,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      explanation,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _answerRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    bool isPersian,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: lavender.withOpacity(0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                size: 48,
                color: lavender,
              ),
            ),

            const SizedBox(height: 22),

            Text(
              isPersian
                  ? 'فعلاً اشتباهی نداری 🎉'
                  : 'No mistakes yet 🎉',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 9),

            Text(
              isPersian
                  ? 'اشتباهاتت از امتحان‌ها و تمرین‌ها اینجا جمع می‌شن.'
                  : 'Your mistakes from exams and practice will appear here.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}