import 'package:flutter/material.dart';

import 'data/levels/a1/a1_data.dart';
import 'localization.dart';

class A1LessonsPage extends StatelessWidget {
  const A1LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lang.isPersian ? 'درس‌های A1 📚' : 'A1 Lessons 📚',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
          itemCount: a1Lessons.length,
          itemBuilder: (context, index) {
            final lesson = a1Lessons[index];

            return _lessonCard(
              context,
              lesson: lesson,
              number: index + 1,
              isPersian: lang.isPersian,
            );
          },
        ),
      ),
    );
  }

  Widget _lessonCard(
    BuildContext context, {
    required A1Lesson lesson,
    required int number,
    required bool isPersian,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => A1LessonDetailPage(
                lesson: lesson,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFB9A7E8).withOpacity(0.18),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFB9A7E8).withOpacity(0.14),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      color: Color(0xFF8C72D8),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
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
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      lesson.topic,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isPersian
                          ? '${lesson.words.length} واژه • '
                              '${lesson.sentences.length} جمله • '
                              '${lesson.questions.length} تمرین'
                          : '${lesson.words.length} words • '
                              '${lesson.sentences.length} sentences • '
                              '${lesson.questions.length} exercises',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: Color(0xFFB9A7E8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class A1LessonDetailPage extends StatelessWidget {
  final A1Lesson lesson;

  const A1LessonDetailPage({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lesson.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
          children: [
            Text(
              lesson.topic,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              lang.isPersian
                  ? 'با میو این درس رو یاد بگیر 🐱'
                  : 'Learn this lesson with Meow 🐱',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 28),

            // Words
            _sectionTitle(
              lang.isPersian ? 'واژه‌ها' : 'Words',
            ),
            const SizedBox(height: 12),
            ...lesson.words.map(
              (word) => _wordCard(
                context,
                word: word,
                isPersian: lang.isPersian,
              ),
            ),

            const SizedBox(height: 24),

            // Sentences
            _sectionTitle(
              lang.isPersian ? 'جمله‌ها' : 'Sentences',
            ),
            const SizedBox(height: 12),
            ...lesson.sentences.map(
              (sentence) => _sentenceCard(
                context,
                sentence: sentence,
              ),
            ),

            const SizedBox(height: 24),

            // Multiple choice
            _sectionTitle(
              lang.isPersian ? 'تمرین چهارگزینه‌ای' : 'Multiple Choice',
            ),
            const SizedBox(height: 12),
            ...lesson.questions.asMap().entries.map(
              (entry) => _questionCard(
                context,
                question: entry.value,
                number: entry.key + 1,
                isPersian: lang.isPersian,
              ),
            ),

            const SizedBox(height: 24),

            // Speaking
            _sectionTitle(
              lang.isPersian ? '🎤 تمرین مکالمه' : '🎤 Speaking Practice',
            ),
            const SizedBox(height: 8),

            Text(
              lang.isPersian
                  ? 'به سؤال جواب بده و با صدای بلند تمرین کن.'
                  : 'Answer the question and practice speaking out loud.',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            ...lesson.speakingQuestions.asMap().entries.map(
              (entry) => _speakingCard(
                context,
                question: entry.value,
                number: entry.key + 1,
                isPersian: lang.isPersian,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _wordCard(
    BuildContext context, {
    required A1Word word,
    required bool isPersian,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  word.english,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.volume_up_rounded,
                  color: Color(0xFFB9A7E8),
                ),
              ),
            ],
          ),
          Text(
            word.persian,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            word.pronunciation,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isPersian
                ? 'مثال: ${word.example}'
                : 'Example: ${word.example}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sentenceCard(
    BuildContext context, {
    required A1Sentence sentence,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sentence.english,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  sentence.persian,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.volume_up_rounded,
              color: Color(0xFFB9A7E8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionCard(
    BuildContext context, {
    required A1Question question,
    required int number,
    required bool isPersian,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ${question.question}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          ...question.options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    final correct = option == question.answer;

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            correct
                                ? (isPersian
                                    ? 'درسته! 😼💜'
                                    : 'Correct! 😼💜')
                                : (isPersian
                                    ? 'نههه، دوباره امتحان کن 😹'
                                    : 'Not quite! Try again 😹'),
                          ),
                        ),
                      );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    side: BorderSide(
                      color: const Color(0xFFB9A7E8).withOpacity(0.35),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(option),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _speakingCard(
    BuildContext context, {
    required A1SpeakingQuestion question,
    required int number,
    required bool isPersian,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFB9A7E8).withOpacity(0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number.',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8C72D8),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.persian,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        isPersian
                            ? '🎤 اینجا باید جواب رو با صدای بلند بگی! میو گوش می‌ده 😼'
                            : '🎤 Answer out loud! Meow is listening 😼',
                      ),
                    ),
                  );
              },
              icon: const Icon(Icons.mic_rounded),
              label: Text(
                isPersian ? 'پاسخ دادن با صدا' : 'Answer by speaking',
              ),
            ),
          ),
        ],
      ),
    );
  }
}