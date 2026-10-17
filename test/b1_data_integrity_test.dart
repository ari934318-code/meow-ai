import 'package:flutter_test/flutter_test.dart';

import '../lib/data/levels/b1/b1_lessons.dart';
import '../lib/data/levels/b1/b1_lesson_01_data.dart';
import '../lib/data/levels/b1/b1_lesson_data.dart';

void main() {
  group('B1 data integrity', () {
    test('catalog contains exactly 30 lessons with unique sequential IDs', () {
      expect(b1Lessons, hasLength(30));

      final ids = b1Lessons.map((lesson) => lesson.id).toList();
      expect(ids.toSet(), hasLength(30));
      expect(ids, List<int>.generate(30, (index) => index + 1));
    });

    test('lesson 1 is registered through the existing data interface', () {
      expect(B1LessonData.lesson01, same(B1Lesson01Data));
      expect(B1Lesson01Data.id, 'b1_lesson_01');

      final catalogLesson = b1Lessons.singleWhere((lesson) => lesson.id == 1);
      expect(catalogLesson.titleEn, B1Lesson01Data.titleEn);
      expect(catalogLesson.titleFa, B1Lesson01Data.titleFa);
    });

    test('catalog metadata for lessons 2-30 is not lesson 1 detailed content', () {
      final laterLessons = b1Lessons.where((lesson) => lesson.id >= 2).toList();

      expect(laterLessons, hasLength(29));
      expect(laterLessons.every((lesson) => lesson.id != 1), isTrue);
      expect(
        laterLessons.any((lesson) => lesson.titleEn == B1Lesson01Data.titleEn),
        isFalse,
        reason: 'Later catalog entries must not be represented by lesson 1 metadata.',
      );

      // The current B1LessonData interface explicitly registers lesson 1 only.
      // Dart's static type API cannot assert that other static members/files do
      // not exist. When a generic lesson resolver is introduced, extend this
      // test to assert that IDs 2-30 resolve as unavailable until registered.
    });
  });
}
