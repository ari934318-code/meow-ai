import 'package:flutter_test/flutter_test.dart';
import 'package:meow_ai/data/levels/b1/b1_lesson_registry.dart';

void main() {
  group('B1LessonRegistry', () {
    test('resolves stable IDs for catalog entries', () {
      expect(B1LessonRegistry.idForNumber(1), 'b1_lesson_01');
      expect(B1LessonRegistry.findById('b1_lesson_01')?.id, 1);
      expect(B1LessonRegistry.findById('b1_lesson_30')?.id, 30);
    });

    test('only reports lessons with real detailed content as playable', () {
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_01'), isNotNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_02'), isNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_30'), isNull);
      expect(B1LessonRegistry.resolvePlayable('b1_lesson_99'), isNull);
    });
  });
}
