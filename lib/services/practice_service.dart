import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PracticeService {
  // =========================================================
  // STORAGE KEYS
  // =========================================================

  static const String _basicsWrongAnswersKey =
      'a1_basics_wrong_answers';

  static const String _a2WrongAnswersKey =
      'a2_wrong_answers';

  // =========================================================
  // A1
  // =========================================================

  static Future<List<Map<String, dynamic>>>
      getBasicsWrongAnswers() async {
    return _getWrongAnswers(
      _basicsWrongAnswersKey,
    );
  }

  static Future<int> getBasicsWrongAnswerCount() async {
    final mistakes = await getBasicsWrongAnswers();

    return mistakes.length;
  }

  static Future<void> clearBasicsWrongAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_basicsWrongAnswersKey);
  }

  // =========================================================
  // A2
  // =========================================================

  static Future<List<Map<String, dynamic>>>
      getA2WrongAnswers() async {
    return _getWrongAnswers(
      _a2WrongAnswersKey,
    );
  }

  static Future<int> getA2WrongAnswerCount() async {
    final mistakes = await getA2WrongAnswers();

    return mistakes.length;
  }

  static Future<void> clearA2WrongAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_a2WrongAnswersKey);
  }

  // =========================================================
  // ALL MISTAKES
  // =========================================================

  static Future<List<Map<String, dynamic>>>
      getAllWrongAnswers() async {
    final a1Mistakes =
        await getBasicsWrongAnswers();

    final a2Mistakes =
        await getA2WrongAnswers();

    return [
      ...a1Mistakes,
      ...a2Mistakes,
    ];
  }

  static Future<int> getAllWrongAnswerCount() async {
    final mistakes =
        await getAllWrongAnswers();

    return mistakes.length;
  }

  static Future<void> clearAllWrongAnswers() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove(_basicsWrongAnswersKey);
    await prefs.remove(_a2WrongAnswersKey);
  }

  // =========================================================
  // FILTERS
  // =========================================================

  static Future<List<Map<String, dynamic>>>
      getWrongAnswersByTopic(
    String topic,
  ) async {
    final mistakes =
        await getAllWrongAnswers();

    return mistakes.where((mistake) {
      return mistake['topic'] == topic;
    }).toList();
  }

  static Future<List<Map<String, dynamic>>>
      getWrongAnswersByCategory(
    String category,
  ) async {
    final mistakes =
        await getAllWrongAnswers();

    return mistakes.where((mistake) {
      return mistake['category'] == category;
    }).toList();
  }

  // =========================================================
  // INTERNAL STORAGE READER
  // =========================================================

  static Future<List<Map<String, dynamic>>>
      _getWrongAnswers(
    String key,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    final raw = prefs.getString(key);

    if (raw == null || raw.isEmpty) {
      return [];
    }

    try {
      final decoded = jsonDecode(raw);

      if (decoded is! List) {
        return [];
      }

      return decoded
          .whereType<Map>()
          .map(
            (item) =>
                Map<String, dynamic>.from(item),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }
}
