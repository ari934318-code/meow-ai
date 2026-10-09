import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../lib/data/levels/b1/b1_lessons.dart';
import '../lib/data/levels/b1/b1_lesson_data.dart';
import '../lib/data/levels/b1/b1_lesson_01_data.dart';

void main() {
  group('B1 data integrity', () {
    test('catalog contains exactly 30 lessons', () {
      expect(b1Lessons, hasLength(30));
    });

    test('numeric lesson IDs are unique and sequential', () {
      final ids = b1Lessons.map((lesson) => lesson.id).toList();

      expect(ids.toSet(), hasLength(ids.length));
      expect(ids, List<int>.generate(30, (index) => index + 1));
    });

    test('lesson 1 is exposed through the existing lesson01 interface', () {
      expect(B1LessonData.lesson01, B1Lesson01Data);
    });

    test("lesson 1 keeps the stable ID 'b1_lesson_01'", () {
      expect(B1Lesson01Data.id, 'b1_lesson_01');
    });

    test('lessons 2-30 have no registered detailed data files', () {
      // The aggregator currently exposes lesson 1 only. Detailed lesson files
      // follow the b1_lesson_NN_data.dart naming convention, so this guards
      // against mistaking catalog metadata for complete lesson content.
      final directory = Directory('lib/data/levels/b1');
      expect(directory.existsSync(), isTrue);

      final detailedDataFiles = directory
          .listSync()
          .whereType<File>()
          .map((file) => file.uri.pathSegments.last)
          .where(
            (name) => RegExp(r'^b1_lesson_\d{2}_data\.dart$').hasMatch(name),
          )
          .toList()
        ..sort();

      expect(
        detailedDataFiles,
        ['b1_lesson_01_data.dart'],
        reason:
            'Only lesson 1 currently has detailed data; lessons 2-30 must '
            'not be considered complete based on catalog metadata alone.',
      );
    });
  });
}
