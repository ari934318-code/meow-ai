import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PracticeService {
  static const String _basicsWrongAnswersKey =
      'a1_basics_wrong_answers';

  static Future<List<Map<String, dynamic>>>
      getBasicsWrongAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    final raw =
        prefs.getString(_basicsWrongAnswersKey);

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
            (item) => Map<String, dynamic>.from(item),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<int> getBasicsWrongAnswerCount() async {
    final mistakes = await getBasicsWrongAnswers();

    return mistakes.length;
  }

  static Future<void> clearBasicsWrongAnswers() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_basicsWrongAnswersKey);
  }

  static Future<List<Map<String, dynamic>>>
      getWrongAnswersByTopic(String topic) async {
    final mistakes = await getBasicsWrongAnswers();

    return mistakes.where((mistake) {
      return mistake['topic'] == topic;
    }).toList();
  }

  static Future<List<Map<String, dynamic>>>
      getWrongAnswersByCategory(String category) async {
    final mistakes = await getBasicsWrongAnswers();

    return mistakes.where((mistake) {
      return mistake['category'] == category;
    }).toList();
  }
}