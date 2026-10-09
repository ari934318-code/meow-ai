import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meow_ai/services/progress_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('ProgressService persisted statistics', () {
    test('XP is persisted and non-positive awards are ignored', () async {
      await ProgressService.addXp(15);
      await ProgressService.addXp(0);
      await ProgressService.addXp(-3);

      expect(await ProgressService.getTotalXp(), 15);
    });

    test('a study day is counted once even after multiple sessions', () async {
      await ProgressService.addPracticeSession();
      await ProgressService.addSpeakingSession();
      await ProgressService.recordStudyDay();

      expect(await ProgressService.getCurrentStreak(), 1);
      expect(await ProgressService.getStudyDays(), 1);
      expect(await ProgressService.getPracticeSessions(), 1);
      expect(await ProgressService.getSpeakingSessions(), 1);
    });

    test('reset clears XP and study statistics', () async {
      await ProgressService.addXp(25);
      await ProgressService.addPracticeSession();
      await ProgressService.resetProgress();

      expect(await ProgressService.getTotalXp(), 0);
      expect(await ProgressService.getCurrentStreak(), 0);
      expect(await ProgressService.getStudyDays(), 0);
      expect(await ProgressService.getPracticeSessions(), 0);
    });
  });
}
