import 'package:flutter_test/flutter_test.dart';
import 'package:meow_ai/data/levels/b1/b1_lesson_registry.dart';

void main() {
  group('B1 lesson registry', () {
    test('resolves stable IDs for catalog lessons', () {
      expect(B1LessonRegistry.idForNumber(1), 'b1_lesson_01');
      expect(B1LessonRegistry.findById('b1_lesson_02')?.id, 2);
      expect(B1LessonRegistry.findById('b1_lesson_30')?.id, 30);
    });

    test('only lessons with detailed player content are playable', () {
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_01'), isNotNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_02'), isNotNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_03'), isNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_30'), isNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_99'), isNull);
    });
  });
}
