import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const String _xpKey = 'total_xp';
  static const String _practiceSessionsKey = 'practice_sessions';
  static const String _speakingSessionsKey = 'speaking_sessions';
  static const String _studyDaysKey = 'study_days';
  static const String _currentStreakKey = 'current_streak';
  static const String _lastStudyDateKey = 'last_study_date';

  static Future<int> getTotalXp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_xpKey) ?? 0;
  }

  static Future<void> addXp(int amount) async {
    if (amount <= 0) return;

    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_xpKey) ?? 0;

    await prefs.setInt(_xpKey, current + amount);
  }

  static Future<int> getPracticeSessions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_practiceSessionsKey) ?? 0;
  }

  static Future<void> addPracticeSession() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_practiceSessionsKey) ?? 0;

    await prefs.setInt(
      _practiceSessionsKey,
      current + 1,
    );

    await recordStudyDay();
  }

  static Future<int> getSpeakingSessions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_speakingSessionsKey) ?? 0;
  }

  static Future<void> addSpeakingSession() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_speakingSessionsKey) ?? 0;

    await prefs.setInt(
      _speakingSessionsKey,
      current + 1,
    );

    await recordStudyDay();
  }

  static Future<int> getStudyDays() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_studyDaysKey) ?? 0;
  }

  static Future<int> getCurrentStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_currentStreakKey) ?? 0;
  }

  static Future<void> recordStudyDay() async {
    final prefs = await SharedPreferences.getInstance();

    final today = _dateKey(DateTime.now());
    final lastDate = prefs.getString(_lastStudyDateKey);

    if (lastDate == today) {
      return;
    }

    int streak = prefs.getInt(_currentStreakKey) ?? 0;
    int studyDays = prefs.getInt(_studyDaysKey) ?? 0;

    if (lastDate == null) {
      streak = 1;
    } else {
      final previous = DateTime.tryParse(lastDate);

      if (previous == null) {
        streak = 1;
      } else {
        final now = DateTime.now();

        final previousDay = DateTime(
          previous.year,
          previous.month,
          previous.day,
        );

        final currentDay = DateTime(
          now.year,
          now.month,
          now.day,
        );

        final difference =
            currentDay.difference(previousDay).inDays;

        if (difference == 1) {
          streak++;
        } else if (difference > 1) {
          streak = 1;
        }
      }
    }

    studyDays++;

    await prefs.setInt(
      _currentStreakKey,
      streak,
    );

    await prefs.setInt(
      _studyDaysKey,
      studyDays,
    );

    await prefs.setString(
      _lastStudyDateKey,
      today,
    );
  }

  static String _dateKey(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_xpKey);
    await prefs.remove(_practiceSessionsKey);
    await prefs.remove(_speakingSessionsKey);
    await prefs.remove(_studyDaysKey);
    await prefs.remove(_currentStreakKey);
    await prefs.remove(_lastStudyDateKey);
  }
}