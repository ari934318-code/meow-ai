import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meow_ai/services/a2_progress_service.dart';
import 'package:meow_ai/services/progress_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('A2 completion awards XP once and persists completion', () async {
    await A2ProgressService.completeLesson('a2_lesson_01');
    await A2ProgressService.completeLesson('a2_lesson_01');

    expect(await ProgressService.getTotalXp(), 30);
    expect(await A2ProgressService.isLessonCompleted('a2_lesson_01'), isTrue);
    expect(await ProgressService.getStudyDays(), 1);
  });

  test('unknown A2 lesson does not earn XP but records eligible completion', () async {
    await A2ProgressService.completeLesson('unknown_a2_lesson');
    expect(await ProgressService.getTotalXp(), 0);
    expect(await A2ProgressService.getStudyDays(), 1);
  });

  test('A2 reset clears A2 state but preserves shared XP and unrelated keys', () async {
    SharedPreferences.setMockInitialValues({
      'a2_completed_lessons': ['a2_lesson_01'],
      'a2_exam_completed': true,
      'total_xp': 90,
      'a1_completed_lessons': ['a1_01'],
      'b1_completed_lessons': ['b1_lesson_01'],
    });
    final prefs = await SharedPreferences.getInstance();

    await A2ProgressService.resetProgress();

    expect(prefs.getStringList('a2_completed_lessons'), isNull);
    expect(prefs.getBool('a2_exam_completed'), isNull);
    expect(await ProgressService.getTotalXp(), 90);
    expect(prefs.getStringList('a1_completed_lessons'), ['a1_01']);
    expect(prefs.getStringList('b1_completed_lessons'), ['b1_lesson_01']);
  });
}
