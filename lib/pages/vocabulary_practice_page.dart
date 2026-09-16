import 'package:flutter/material.dart';

import 'a1_vocabulary_practice_data.dart';
import 'a2_vocabulary_practice_data.dart';
import 'vocabulary_practice_models.dart';
import 'vocabulary_practice_service.dart';

class VocabularyPracticePage extends StatefulWidget {
  /// If provided, only vocabulary belonging to this lesson is used.
  ///
  /// Keep it null when you want the old global A1 + A2 practice.
  final String? lessonTitle;

  const VocabularyPracticePage({
    super.key,
    this.lessonTitle,
  });

  @override
  State<VocabularyPracticePage> createState() =>
      _VocabularyPracticePageState();
}

class _VocabularyPracticePageState
    extends State<VocabularyPracticePage> {
  static const Color lavender = Color(0xFFB9A7E8);

  late List<VocabularyPracticeItem> _items;

  VocabularyPracticeQuestion? _question;

  int _questionNumber = 0;
  int _score = 0;
  int _totalQuestions = 10;

  bool _answered = false;
  String? _selectedAnswer;

  List<VocabularyPracticeQuestion> _session = [];

  @override
  void initState() {
    super.initState();

    final allItems = <VocabularyPracticeItem>[
      ...A1VocabularyPracticeData.all,
      ...A2VocabularyPracticeData.all,
    ];

    // When a lesson title is supplied, practice only that lesson's
    // vocabulary. When it is null, keep the original global behavior.
    if (widget.lessonTitle == null ||
        widget.lessonTitle!.trim().isEmpty) {
      _items = allItems;
    } else {
      final targetTitle = widget.lessonTitle!.trim();

      _items = allItems
          .where(
            (item) =>
                item.lessonTitle.trim().toLowerCase() ==
                targetTitle.toLowerCase(),
          )
          .toList();

      // Safe fallback: if the lesson title does not exactly match
      // the vocabulary data, do not show an empty practice page.
      if (_items.isEmpty) {
        _items = allItems;
      }
    }

    _startSession();
  }

  void _startSession() {
    if (_items.isEmpty) {
      return;
    }

    final questionCount = _items.length < _totalQuestions
        ? _items.length
        : _totalQuestions;

    final session = VocabularyPracticeService.createSession(
      items: _items,
      questionCount: questionCount,
    );

    if (session.isEmpty) {
      return;
    }

    setState(() {
      _session = session;
      _questionNumber = 0;
      _score = 0;
      _answered = false;
      _selectedAnswer = null;
      _question = session.first;
    });
  }

  void _selectAnswer(String answer) {
    if (_answered || _question == null) {
      return;
    }

    final isCorrect = answer == _question!.correctAnswer;

    setState(() {
      _answered = true;
      _selectedAnswer = answer;

      if (isCorrect) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (!_answered) {
      return;
    }

    final nextIndex = _questionNumber + 1;

    if (nextIndex >= _session.length) {
      _showResult();
      return;
    }

    setState(() {
      _questionNumber = nextIndex;
      _question = _session[nextIndex];
      _answered = false;
      _selectedAnswer = null;
    });
  }

  void _showResult() {
    final total = _session.length;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Practice Complete 🎉'),
          content: Text(
            'Your score: $_score / $total',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _startSession();
              },
              child: const Text('Practice Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  Color _optionColor(String option) {
    if (!_answered) {
      return Colors.transparent;
    }

    if (option == _question!.correctAnswer) {
      return Colors.green.withValues(alpha: 0.12);
    }

    if (option == _selectedAnswer) {
      return Colors.red.withValues(alpha: 0.12);
    }

    return Colors.transparent;
  }

  Color _borderColor(String option) {
    if (!_answered) {
      return Colors.grey.shade300;
    }

    if (option == _question!.correctAnswer) {
      return Colors.green;
    }

    if (option == _selectedAnswer) {
      return Colors.red;
    }

    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty || _question == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Vocabulary Practice'),
        ),
        body: const Center(
          child: Text('No vocabulary available.'),
        ),
      );
    }

    final question = _question!;
    final total = _session.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lessonTitle == null ||
                  widget.lessonTitle!.trim().isEmpty
              ? 'Vocabulary Practice'
              : 'Vocabulary Practice',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${_questionNumber + 1} / $total',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Score: $_score',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              LinearProgressIndicator(
                value: (_questionNumber + 1) / total,
                minHeight: 6,
                borderRadius: BorderRadius.circular(20),
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  lavender,
                ),
              ),

              const SizedBox(height: 28),

              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        question.item.level,
                        style: const TextStyle(
                          color: lavender,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        question.item.lessonTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        question.question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      if (question.type ==
                          VocabularyPracticeType.exampleToWord)
                        Text(
                          question.item.example,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey.shade700,
                          ),
                        ),

                      if (question.type ==
                          VocabularyPracticeType.wordToExample)
                        Text(
                          question.item.english,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: question.options.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final option = question.options[index];

                    return OutlinedButton(
                      onPressed: () => _selectAnswer(option),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 17,
                        ),
                        backgroundColor: _optionColor(option),
                        side: BorderSide(
                          color: _borderColor(option),
                          width: 1.3,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),

                          if (_answered &&
                              option == question.correctAnswer)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),

                          if (_answered &&
                              option == _selectedAnswer &&
                              option != question.correctAnswer)
                            const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              if (_answered) ...[
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _selectedAnswer ==
                            question.correctAnswer
                        ? Colors.green.withValues(alpha: 0.10)
                        : Colors.red.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    _selectedAnswer == question.correctAnswer
                        ? 'Correct! 🎉'
                        : 'Correct answer: ${question.correctAnswer}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lavender,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _questionNumber + 1 >= total
                          ? 'See Result'
                          : 'Next',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
