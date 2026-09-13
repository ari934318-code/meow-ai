import 'learned_phrases.dart';
import 'learned_intents.dart';
import 'learned_vocabulary.dart';

/// حافظه‌ی دانش عمومی Meow.
///
/// این کلاس دانش یادگرفته‌شده را یکجا نگهداری می‌کند.
///
/// شامل:
/// - عبارت‌های یادگرفته‌شده
/// - Intentهای یادگرفته‌شده
/// - واژه‌های یادگرفته‌شده
///
/// این بخش نباید شامل اطلاعات شخصی کاربران باشد.
class LearningKnowledge {
  final List<LearnedPhrase> phrases;
  final List<LearnedIntent> intents;
  final List<LearnedVocabulary> vocabulary;

  LearningKnowledge({
    List<LearnedPhrase>? phrases,
    List<LearnedIntent>? intents,
    List<LearnedVocabulary>? vocabulary,
  })  : phrases = phrases ?? [],
        intents = intents ?? [],
        vocabulary = vocabulary ?? [];

  /// اضافه کردن یک عبارت یادگرفته‌شده.
  void addPhrase(LearnedPhrase phrase) {
    final existingIndex = phrases.indexWhere(
      (item) =>
          item.phrase.trim().toLowerCase() ==
          phrase.phrase.trim().toLowerCase(),
    );

    if (existingIndex == -1) {
      phrases.add(phrase);
      return;
    }

    // اگر قبلاً وجود داشته، نسخه‌ی جدیدتر جایگزین می‌شود.
    phrases[existingIndex] = phrase;
  }

  /// اضافه کردن یک Intent.
  void addIntent(LearnedIntent intent) {
    final existingIndex = intents.indexWhere(
      (item) => item.id == intent.id,
    );

    if (existingIndex == -1) {
      intents.add(intent);
      return;
    }

    intents[existingIndex] = intent;
  }

  /// اضافه کردن یک واژه.
  void addVocabulary(LearnedVocabulary word) {
    final existingIndex = vocabulary.indexWhere(
      (item) =>
          item.word.trim().toLowerCase() ==
          word.word.trim().toLowerCase(),
    );

    if (existingIndex == -1) {
      vocabulary.add(word);
      return;
    }

    vocabulary[existingIndex] = word;
  }

  /// پیدا کردن عبارت یادگرفته‌شده.
  LearnedPhrase? findPhrase(String phrase) {
    final normalized = phrase.trim().toLowerCase();

    for (final item in phrases) {
      if (item.phrase.trim().toLowerCase() == normalized) {
        return item;
      }
    }

    return null;
  }

  /// پیدا کردن Intent.
  LearnedIntent? findIntent(String intentId) {
    for (final intent in intents) {
      if (intent.id == intentId) {
        return intent;
      }
    }

    return null;
  }

  /// پیدا کردن واژه.
  LearnedVocabulary? findVocabulary(String word) {
    final normalized = word.trim().toLowerCase();

    for (final item in vocabulary) {
      if (item.word.trim().toLowerCase() == normalized) {
        return item;
      }
    }

    return null;
  }

  /// تبدیل کل دانش به Map برای ذخیره‌سازی.
  Map<String, dynamic> toMap() {
    return {
      'phrases': phrases.map((item) => item.toMap()).toList(),
      'intents': intents.map((item) => item.toMap()).toList(),
      'vocabulary': vocabulary.map((item) => item.toMap()).toList(),
    };
  }

  /// تعداد کل عبارت‌های یادگرفته‌شده.
  int get phraseCount => phrases.length;

  /// تعداد کل Intentها.
  int get intentCount => intents.length;

  /// تعداد کل واژه‌ها.
  int get vocabularyCount => vocabulary.length;
}