import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'learning_knowledge.dart';
import 'learned_phrases.dart';
import 'learned_intents.dart';
import 'learned_vocabulary.dart';

/// مسئول ذخیره و بازیابی دانش عمومی Meow.
///
/// این کلاس فعلاً از SharedPreferences استفاده می‌کند.
///
/// نکته مهم:
/// این حافظه فقط برای دانش عمومی Meow است.
/// اطلاعات شخصی کاربران نباید در این بخش ذخیره شود.
class LearningStorage {
  static const String _storageKey = 'meow_learning_knowledge';

  const LearningStorage();

  /// ذخیره کردن دانش Meow.
  Future<void> save(LearningKnowledge knowledge) async {
    final preferences = await SharedPreferences.getInstance();

    final data = jsonEncode(
      knowledge.toMap(),
    );

    await preferences.setString(
      _storageKey,
      data,
    );
  }

  /// بارگذاری دانش ذخیره‌شده Meow.
  ///
  /// اگر هنوز هیچ دانشی ذخیره نشده باشد،
  /// یک LearningKnowledge خالی برمی‌گرداند.
  Future<LearningKnowledge> load() async {
    final preferences = await SharedPreferences.getInstance();

    final data = preferences.getString(_storageKey);

    if (data == null || data.isEmpty) {
      return LearningKnowledge();
    }

    try {
      final decoded = jsonDecode(data);

      if (decoded is! Map<String, dynamic>) {
        return LearningKnowledge();
      }

      final phrasesData =
          decoded['phrases'] as List? ?? const [];

      final intentsData =
          decoded['intents'] as List? ?? const [];

      final vocabularyData =
          decoded['vocabulary'] as List? ?? const [];

      final phrases = phrasesData
          .whereType<Map>()
          .map(
            (item) => LearnedPhrase.fromMap(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      final intents = intentsData
          .whereType<Map>()
          .map(
            (item) => LearnedIntent.fromMap(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      final vocabulary = vocabularyData
          .whereType<Map>()
          .map(
            (item) => LearnedVocabulary.fromMap(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      return LearningKnowledge(
        phrases: phrases,
        intents: intents,
        vocabulary: vocabulary,
      );
    } catch (_) {
      // اگر اطلاعات ذخیره‌شده خراب یا ناسازگار باشد،
      // برنامه نباید Crash شود.
      return LearningKnowledge();
    }
  }

  /// پاک کردن کامل دانش ذخیره‌شده Meow.
  ///
  /// این متد برای توسعه و تست مفید است.
  Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_storageKey);
  }
}