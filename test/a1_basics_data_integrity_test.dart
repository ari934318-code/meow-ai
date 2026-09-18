import 'package:flutter_test/flutter_test.dart';

import '../lib/data/levels/a1/basics/a1_basics_data.dart';
import '../lib/data/levels/a1/basics/a1_basics_listening_data.dart';

void main() {
  group('A1 Basics data integrity', () {
    const expectedIds = [
      'a1_basic_01',
      'a1_basic_02',
      'a1_basic_03',
      'a1_basic_04',
      'a1_basic_05',
      'a1_basic_06',
      'a1_basic_07',
      'a1_basic_08',
      'a1_basic_09',
      'a1_basic_10',
      'a1_basic_11',
      'a1_basic_12',
      'a1_basic_13',
      'a1_basic_14',
      'a1_basic_15',
      'a1_basic_16',
    ];

    test('contains exactly 16 lessons in the official curriculum order', () {
      expect(a1BasicsLessons.length, expectedIds.length);
      expect(a1BasicsLessons.map((lesson) => lesson.id).toList(), expectedIds);
      expect(a1BasicsLessons.map((lesson) => lesson.id).toSet().length, expectedIds.length);
    });

    for (final lesson in a1BasicsLessons) {
      test(lesson.id + ': questions are internally consistent', () {
        expect(lesson.questions, isNotEmpty);
        final seenQuestions = <String>{};

        for (final question in lesson.questions) {
          final normalizedQuestion = question.question.trim().toLowerCase();
          expect(normalizedQuestion, isNotEmpty);
          expect(
            seenQuestions.add(normalizedQuestion),
            isTrue,
            reason: 'Duplicate question in ' + lesson.id + ': ' + question.question,
          );

          expect(question.answer.trim(), isNotEmpty);
          expect(question.options, isNotEmpty);

          if (question.type == 'multipleChoice') {
            expect(
              question.options.contains(question.answer),
              isTrue,
              reason: 'Answer "' + question.answer + '" is not an option in ' + lesson.id,
            );
            expect(
              question.options.toSet().length,
              question.options.length,
              reason: 'Duplicate options in ' + lesson.id,
            );
          }

          if (question.type == 'typing') {
            expect(question.allAcceptedAnswers, isNotEmpty);
          }

          if (question.questionFa != null) {
            expect(question.questionFa!.trim(), isNotEmpty);
          }
          if (question.explanationFa != null) {
            expect(question.explanationFa!.trim(), isNotEmpty);
          }
        }
      });

      test(lesson.id + ': lesson metadata and Persian guidance are complete', () {
        expect(lesson.title.trim(), isNotEmpty);
        expect(lesson.titleFa.trim(), isNotEmpty);
        expect(lesson.topic.trim(), isNotEmpty);
        expect(lesson.explanation.trim(), isNotEmpty);
        expect(lesson.sections, isNotEmpty);
        expect(lesson.examples, isNotEmpty);
        expect(lesson.learningPhases, isNotEmpty);
        expect(lesson.speakingQuestions, isNotEmpty);

        for (final phase in lesson.learningPhases) {
          expect(phase.title.trim(), isNotEmpty);
          expect(phase.titleFa.trim(), isNotEmpty);
          expect(phase.body.trim(), isNotEmpty);
          expect(phase.bodyFa.trim(), isNotEmpty);
        }
        for (final section in lesson.sections) {
          expect(section.title.trim(), isNotEmpty);
          expect(section.titleFa.trim(), isNotEmpty);
          expect(section.explanation.trim(), isNotEmpty);
          expect(section.explanationFa.trim(), isNotEmpty);
        }
      });

      test(lesson.id + ': listening data exists and is valid', () {
        final listening = a1BasicsListeningQuestionsFor(lesson.id);
        expect(listening, isNotEmpty);
        for (final item in listening) {
          expect(item.sentence.trim(), isNotEmpty);
          expect(item.sentenceFa.trim(), isNotEmpty);
          expect(item.options.length, greaterThanOrEqualTo(2));
          expect(item.options.contains(item.answer), isTrue);
          expect(item.options.toSet().length, item.options.length);
        }
      });
    }
  });
}
