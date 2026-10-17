import 'package:flutter_test/flutter_test.dart';
import 'package:meow_ai/data/levels/b1/b1_lesson_registry.dart';
import 'package:meow_ai/data/levels/b1/b1_practice_lessons_data.dart';

void main() {
  practiceLessonDataIntegrity();
  group('B1 lesson registry', () {
    test('resolves stable IDs for catalog lessons', () {
      expect(B1LessonRegistry.idForNumber(1), 'b1_lesson_01');
      expect(B1LessonRegistry.findById('b1_lesson_02')?.id, 2);
      expect(B1LessonRegistry.findById('b1_lesson_30')?.id, 30);
    });

    test('only lessons with detailed player content are playable', () {
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_01'), isNotNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_02'), isNotNull);
      for (var number = 3; number <= 6; number++) {
        final id = B1LessonRegistry.idForNumber(number);
        expect(B1LessonRegistry.resolvePlayable(id), isNotNull);
        expect(B1LessonRegistry.hasContent(id), isTrue);
      }
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_07'), isNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_30'), isNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_99'), isNull);
    });
  });
}


void practiceLessonDataIntegrity() {
  group('B1 practice lesson content', () {
    test('lessons 3–6 have stable IDs and complete exercise data', () {
      expect(b1PracticeLessons.keys.toSet(), {
        'b1_lesson_03', 'b1_lesson_04', 'b1_lesson_05', 'b1_lesson_06',
      });
      for (final entry in b1PracticeLessons.entries) {
        expect(entry.value.id, entry.key);
        expect(entry.value.vocabulary.length, greaterThanOrEqualTo(5));
        expect(entry.value.questions.length, greaterThanOrEqualTo(5));
        expect(entry.value.acceptedTranslations, isNotEmpty);
        for (final question in entry.value.questions) {
          expect(question.options, contains(question.answer));
          expect(question.explanationFa, isNotEmpty);
        }
      }
    });
  });
}
