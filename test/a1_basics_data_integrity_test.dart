import 'package:flutter_test/flutter_test.dart';

import '../lib/data/levels/a1/basics/a1_basics_data.dart';

void main() {
  group('A1 Basics data integrity', () {
    test('contains all 14 lessons in the official order', () {
      expect(a1BasicsLessons.length, 16);
      expect(
        a1BasicsLessons.map((lesson) => lesson.id).toList(),
        [
          'a1_basic_01',
          'a1_basic_02',
          'a1_basic_03',
          'a1_basic_04',
          'a1_basic_04_5',
          'a1_basic_05',
          'a1_basic_06',
          'a1_basic_07',
          'a1_basic_08',
          'a1_basic_09',
          'a1_basic_10',
          'a1_basic_11',
          'a1_basic_12',
          'a1_basic_13',
          'a1_basic_06',
          'a1_basic_14',
        ],
      );
    });

    for (final lesson in a1BasicsLessons) {
      test('${lesson.id}: questions are internally consistent', () {
        expect(lesson.questions, isNotEmpty);

        final seenQuestions = <String>{};
        for (final question in lesson.questions) {
          final normalizedQuestion = question.question.trim().toLowerCase();
          expect(normalizedQuestion, isNotEmpty);
          expect(
            seenQuestions.add(normalizedQuestion),
            isTrue,
            reason: 'Duplicate question in ${lesson.id}: ${question.question}',
          );

          expect(question.answer.trim(), isNotEmpty);
          expect(question.options, isNotEmpty);

          if (question.type == 'multipleChoice') {
            expect(
              question.options.contains(question.answer),
              isTrue,
              reason:
                  'Answer "${question.answer}" is not an option in ${lesson.id}: ${question.question}',
            );
            expect(question.options.toSet().length, question.options.length);
          }

          if (question.type == 'typing') {
            expect(question.allAcceptedAnswers, isNotEmpty);
          }
        }
      });

      test('${lesson.id}: every section has Persian guidance', () {
        expect(lesson.sections, isNotEmpty);
        for (final section in lesson.sections) {
          expect(section.title.trim(), isNotEmpty);
          expect(section.titleFa.trim(), isNotEmpty);
          expect(section.explanation.trim(), isNotEmpty);
          expect(section.explanationFa.trim(), isNotEmpty);
        }
      });
    }
  });
}
