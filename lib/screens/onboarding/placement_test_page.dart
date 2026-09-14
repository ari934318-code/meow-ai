import 'package:flutter/material.dart';

class PlacementTestPage extends StatefulWidget {
  final bool isPersian;

  /// بعد از پایان آزمون، سطح محاسبه‌شده را برمی‌گرداند.
  final void Function(String level)? onFinished;

  const PlacementTestPage({
    super.key,
    required this.isPersian,
    this.onFinished,
  });

  @override
  State<PlacementTestPage> createState() =>
      _PlacementTestPageState();
}

class _PlacementTestPageState
    extends State<PlacementTestPage> {
  int _currentQuestion = 0;
  int? _selectedAnswer;

  final List<int> _answers = [];

  final List<_PlacementQuestion> _questions = [
    // ------------------------------------------------------------
    // A1
    // ------------------------------------------------------------
    _PlacementQuestion(
      level: 'A1',
      questionEn: 'My name ___ Sara.',
      questionFa: 'نام من ___ سارا است.',
      options: ['am', 'is', 'are', 'be'],
      correctIndex: 1,
    ),

    _PlacementQuestion(
      level: 'A1',
      questionEn: 'I ___ coffee every morning.',
      questionFa: 'من هر صبح قهوه ___ .',
      options: ['drink', 'drinks', 'drinking', 'drank'],
      correctIndex: 0,
    ),

    _PlacementQuestion(
      level: 'A1',
      questionEn: 'Where ___ you from?',
      questionFa: 'اهل کجا ___؟',
      options: ['am', 'is', 'are', 'be'],
      correctIndex: 2,
    ),

    // ------------------------------------------------------------
    // A2
    // ------------------------------------------------------------
    _PlacementQuestion(
      level: 'A2',
      questionEn: 'She ___ to London last year.',
      questionFa: 'او سال گذشته به لندن ___ .',
      options: ['go', 'goes', 'went', 'going'],
      correctIndex: 2,
    ),

    _PlacementQuestion(
      level: 'A2',
      questionEn: 'I have lived here ___ 2022.',
      questionFa: 'من از سال ۲۰۲۲ اینجا زندگی کرده‌ام.',
      options: ['for', 'since', 'during', 'from'],
      correctIndex: 1,
    ),

    _PlacementQuestion(
      level: 'A2',
      questionEn: 'There ___ two books on the table.',
      questionFa: 'دو کتاب روی میز ___ .',
      options: ['is', 'are', 'was', 'be'],
      correctIndex: 1,
    ),

    // ------------------------------------------------------------
    // B1
    // ------------------------------------------------------------
    _PlacementQuestion(
      level: 'B1',
      questionEn:
          'If it rains tomorrow, we ___ at home.',
      questionFa:
          'اگر فردا باران ببارد، ما در خانه ___ .',
      options: [
        'stay',
        'stayed',
        'will stay',
        'would stay',
      ],
      correctIndex: 2,
    ),

    _PlacementQuestion(
      level: 'B1',
      questionEn:
          'I was tired, ___ I decided to go home.',
      questionFa:
          'خسته بودم، ___ تصمیم گرفتم به خانه بروم.',
      options: [
        'because',
        'so',
        'although',
        'unless',
      ],
      correctIndex: 1,
    ),

    _PlacementQuestion(
      level: 'B1',
      questionEn:
          'She has already ___ her homework.',
      questionFa:
          'او قبلاً تکالیفش را ___ .',
      options: [
        'finish',
        'finished',
        'finishing',
        'finishes',
      ],
      correctIndex: 1,
    ),

    // ------------------------------------------------------------
    // B2
    // ------------------------------------------------------------
    _PlacementQuestion(
      level: 'B2',
      questionEn:
          'By the time I arrived, they ___ dinner.',
      questionFa:
          'وقتی من رسیدم، آن‌ها شام را ___ .',
      options: [
        'finish',
        'have finished',
        'had finished',
        'were finishing',
      ],
      correctIndex: 2,
    ),

    _PlacementQuestion(
      level: 'B2',
      questionEn:
          'If I ___ you, I would accept the offer.',
      questionFa:
          'اگر جای تو بودم، پیشنهاد را قبول می‌کردم.',
      options: [
        'am',
        'was',
        'were',
        'be',
      ],
      correctIndex: 2,
    ),

    _PlacementQuestion(
      level: 'B2',
      questionEn:
          'The project needs to be completed ___ Friday.',
      questionFa:
          'پروژه باید ___ جمعه تکمیل شود.',
      options: [
        'by',
        'at',
        'on',
        'during',
      ],
      correctIndex: 0,
    ),

    // ------------------------------------------------------------
    // C1
    // ------------------------------------------------------------
    _PlacementQuestion(
      level: 'C1',
      questionEn:
          'Had I known about the problem, I ___ differently.',
      questionFa:
          'اگر از مشکل خبر داشتم، طور دیگری ___ .',
      options: [
        'would act',
        'would have acted',
        'will act',
        'acted',
      ],
      correctIndex: 1,
    ),

    _PlacementQuestion(
      level: 'C1',
      questionEn:
          'The proposal was rejected, ___ its potential benefits.',
      questionFa:
          'پیشنهاد با وجود مزایای احتمالی آن رد شد.',
      options: [
        'despite',
        'because',
        'unless',
        'whereas',
      ],
      correctIndex: 0,
    ),

    _PlacementQuestion(
      level: 'C1',
      questionEn:
          'Her explanation was so ___ that nobody questioned it.',
      questionFa:
          'توضیح او آن‌قدر ___ بود که هیچ‌کس آن را زیر سؤال نبرد.',
      options: [
        'convincing',
        'convince',
        'convinced',
        'convincingly',
      ],
      correctIndex: 0,
    ),

    // ------------------------------------------------------------
    // C2
    // ------------------------------------------------------------
    _PlacementQuestion(
      level: 'C2',
      questionEn:
          'His argument was so ___ that it was difficult to challenge.',
      questionFa:
          'استدلال او آن‌قدر ___ بود که به چالش کشیدن آن دشوار بود.',
      options: [
        'compelling',
        'compelled',
        'compel',
        'compellingly',
      ],
      correctIndex: 0,
    ),

    _PlacementQuestion(
      level: 'C2',
      questionEn:
          'The report provides a ___ analysis of the issue.',
      questionFa:
          'این گزارش تحلیلی ___ از موضوع ارائه می‌دهد.',
      options: [
        'superficial',
        'nuanced',
        'casual',
        'ordinary',
      ],
      correctIndex: 1,
    ),

    _PlacementQuestion(
      level: 'C2',
      questionEn:
          'She remained calm, ___ the severity of the situation.',
      questionFa:
          'او با وجود شدت شرایط، آرام ماند.',
      options: [
        'notwithstanding',
        'because of',
        'instead of',
        'in addition to',
      ],
      correctIndex: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final question = _questions[_currentQuestion];
    final progress =
        (_currentQuestion + 1) / _questions.length;

    const primary = Color(0xFF9B7EDE);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          widget.isPersian
              ? 'تعیین سطح'
              : 'Placement Test',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ------------------------------------------------------
            // Progress
            // ------------------------------------------------------
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(24, 4, 24, 18),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.isPersian
                            ? 'سؤال ${_currentQuestion + 1} از ${_questions.length}'
                            : 'Question ${_currentQuestion + 1} of ${_questions.length}',
                        style:
                            theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${(progress * 100).round()}%',
                        style:
                            theme.textTheme.bodyMedium?.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 7,
                      backgroundColor:
                          primary.withValues(alpha: 0.10),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                        primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ------------------------------------------------------
            // Question
            // ------------------------------------------------------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  10,
                  24,
                  24,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF201D26)
                            : const Color(0xFFF7F4FB),
                        borderRadius:
                            BorderRadius.circular(24),
                        border: Border.all(
                          color:
                              primary.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.isPersian
                                ? 'گزینه درست را انتخاب کن:'
                                : 'Choose the correct answer:',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(
                              color: theme
                                  .textTheme.bodyMedium?.color
                                  ?.withValues(alpha: 0.65),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            question.questionEn,
                            style: theme.textTheme.headlineSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            question.questionFa,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(
                              height: 1.5,
                              color: theme
                                  .textTheme.bodyLarge?.color
                                  ?.withValues(alpha: 0.65),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ------------------------------------------------
                    // Options
                    // ------------------------------------------------
                    ...List.generate(
                      question.options.length,
                      (index) {
                        final selected =
                            _selectedAnswer == index;

                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12),
                          child: _AnswerButton(
                            text: question.options[index],
                            selected: selected,
                            primary: primary,
                            onTap: () {
                              setState(() {
                                _selectedAnswer = index;
                              });
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    Text(
                      widget.isPersian
                          ? 'اگر جواب را نمی‌دانی، حدس نزن و فقط بهترین گزینه‌ای که فکر می‌کنی درست است را انتخاب کن.'
                          : 'If you are unsure, choose the option you think is the best answer.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        height: 1.5,
                        color: theme.textTheme.bodySmall?.color
                            ?.withValues(alpha: 0.50),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --------------------------------------------------------
            // Bottom button
            // --------------------------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                8,
                24,
                20,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed:
                      _selectedAnswer == null
                          ? null
                          : _nextQuestion,
                  style: FilledButton.styleFrom(
                    backgroundColor: primary,
                    disabledBackgroundColor:
                        primary.withValues(alpha: 0.25),
                    foregroundColor: Colors.white,
                    disabledForegroundColor:
                        Colors.white.withValues(alpha: 0.65),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentQuestion ==
                            _questions.length - 1
                        ? (widget.isPersian
                            ? 'دیدن نتیجه'
                            : 'See My Result')
                        : (widget.isPersian
                            ? 'سؤال بعدی'
                            : 'Next Question'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextQuestion() {
    if (_selectedAnswer == null) return;

    _answers.add(_selectedAnswer!);

    if (_currentQuestion ==
        _questions.length - 1) {
      final level = _calculateLevel();

      widget.onFinished?.call(level);
      return;
    }

    setState(() {
      _currentQuestion++;
      _selectedAnswer = null;
    });
  }

  String _calculateLevel() {
    final levelScores = <String, int>{
      'A1': 0,
      'A2': 0,
      'B1': 0,
      'B2': 0,
      'C1': 0,
      'C2': 0,
    };

    for (int i = 0; i < _answers.length; i++) {
      final question = _questions[i];

      if (_answers[i] == question.correctIndex) {
        levelScores[question.level] =
            (levelScores[question.level] ?? 0) + 1;
      }
    }

    if (levelScores['C2']! >= 2) {
      return 'C2';
    }

    if (levelScores['C1']! >= 2) {
      return 'C1';
    }

    if (levelScores['B2']! >= 2) {
      return 'B2';
    }

    if (levelScores['B1']! >= 2) {
      return 'B1';
    }

    if (levelScores['A2']! >= 2) {
      return 'A2';
    }

    return 'A1';
  }
}

class _AnswerButton extends StatelessWidget {
  final String text;
  final bool selected;
  final Color primary;
  final VoidCallback onTap;

  const _AnswerButton({
    required this.text,
    required this.selected,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          decoration: BoxDecoration(
            color: selected
                ? primary.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? primary
                  : theme.dividerColor.withValues(alpha: 0.45),
              width: selected ? 1.6 : 1.1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration:
                    const Duration(milliseconds: 160),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? primary
                      : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? primary
                        : theme.dividerColor,
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: selected
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlacementQuestion {
  final String level;
  final String questionEn;
  final String questionFa;
  final List<String> options;
  final int correctIndex;

  const _PlacementQuestion({
    required this.level,
    required this.questionEn,
    required this.questionFa,
    required this.options,
    required this.correctIndex,
  });
}