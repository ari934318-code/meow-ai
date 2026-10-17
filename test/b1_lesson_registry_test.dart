import 'package:flutter_test/flutter_test.dart';
import 'package:meow_ai/data/levels/b1/b1_lesson_registry.dart';
import 'package:meow_ai/data/levels/b1/b1_practice_lessons_data.dart';

void main() {\n  practiceLessonDataIntegrity();
  group('B1 lesson registry', () {
    test('resolves stable IDs for catalog lessons', () {
      expect(B1LessonRegistry.idForNumber(1), 'b1_lesson_01');
      expect(B1LessonRegistry.findById('b1_lesson_02')?.id, 2);
      expect(B1LessonRegistry.findById('b1_lesson_30')?.id, 30);
    });

    test('only lessons with detailed player content are playable', () {
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_01'), isNotNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_02'), isNotNull);
      for (var number = 3; number <= 6; number++) {\n        final id = B1LessonRegistry.idForNumber(number);\n        expect(B1LessonRegistry.resolvePlayable(id), isNotNull);\n        expect(B1LessonRegistry.hasContent(id), isTrue);\n      }
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_07'), isNull);\n      expect(B1LessonRegistry.resolvePlayable('b1_lesson_30'), isNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_99'), isNull);
    });
  });
}
\n\nvoid practiceLessonDataIntegrity() {\n  group('B1 practice lesson content', () {\n    test('lessons 3–6 have stable IDs and complete exercise data', () {\n      expect(b1PracticeLessons.keys.toSet(), {\n        'b1_lesson_03', 'b1_lesson_04', 'b1_lesson_05', 'b1_lesson_06',\n      });\n      for (final entry in b1PracticeLessons.entries) {\n        expect(entry.value.id, entry.key);\n        expect(entry.value.vocabulary.length, greaterThanOrEqualTo(5));\n        expect(entry.value.questions.length, greaterThanOrEqualTo(5));\n        expect(entry.value.acceptedTranslations, isNotEmpty);\n        for (final question in entry.value.questions) {\n          expect(question.options, contains(question.answer));\n          expect(question.explanationFa, isNotEmpty);\n        }\n      }\n    });\n  });\n}\n