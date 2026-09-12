import 'package:flutter/material.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  int? selectedAnswer;

  final questions = const [
    {
      'question': 'How do you say "سلام" in English?',
      'answers': ['Hello', 'Goodbye', 'Thanks', 'Sorry'],
      'correct': 0,
    },
    {
      'question': 'What does "Good morning" mean?',
      'answers': ['شب بخیر', 'صبح بخیر', 'خداحافظ', 'ممنون'],
      'correct': 1,
    },
    {
      'question': 'How do you answer "How are you?"',
      'answers': [
        'I am good, thank you!',
        'Good morning!',
        'Goodbye!',
        'Hello!',
      ],
      'correct': 0,
    },
  ];

  void selectAnswer(int index) {
    if (answered) return;

    setState(() {
      selectedAnswer = index;
      answered = true;

      if (index == questions[currentQuestion]['correct']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        answered = false;
        selectedAnswer = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Lesson Complete! 🎉'),
          content: Text(
            'You got $score out of ${questions.length} correct.\n\n+20 XP ⭐',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Finish'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final answers = question['answers'] as List<String>;
    final correct = question['correct'] as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Greetings 👋'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          LinearProgressIndicator(
            value: (currentQuestion + 1) / questions.length,
          ),
          const SizedBox(height: 24),
          Text(
            'Question ${currentQuestion + 1} of ${questions.length}',
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 12),
          Text(
            question['question'] as String,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(
            answers.length,
            (index) {
              final isSelected = selectedAnswer == index;
              final isCorrect = index == correct;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    answers[index],
                    style: const TextStyle(fontSize: 17),
                  ),
                  trailing: answered
                      ? Icon(
                          isCorrect
                              ? Icons.check_circle
                              : isSelected
                                  ? Icons.cancel
                                  : Icons.circle_outlined,
                        )
                      : const Icon(Icons.arrow_forward_ios),
                  onTap: () => selectAnswer(index),
                ),
              );
            },
          ),
          if (answered) ...[
            const SizedBox(height: 10),
            Text(
              selectedAnswer == correct
                  ? 'Correct! 🎉'
                  : 'Not quite. Keep practicing! 💪',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: nextQuestion,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    currentQuestion == questions.length - 1
                        ? 'Finish Lesson'
                        : 'Next Question →',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
