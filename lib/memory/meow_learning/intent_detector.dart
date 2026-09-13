import 'learned_intents.dart';

/// مسئول تشخیص منظور یا Intent جمله.
///
/// هدف این کلاس این است که جمله‌های متفاوتی که
/// یک معنی یا منظور مشترک دارند، به یک Intent وصل شوند.
///
/// مثال:
///
/// "آب می‌خوام"
/// "تشنمه"
/// "یه چیزی برای نوشیدن می‌خوام"
/// "میشه یه لیوان آب بدی؟"
///
/// همگی می‌توانند به:
///
/// drink_request
///
/// مربوط باشند.
class IntentDetector {
  final List<LearnedIntent> intents;

  IntentDetector({
    List<LearnedIntent>? intents,
  }) : intents = intents ?? [];

  /// تلاش برای تشخیص Intent یک جمله.
  ///
  /// اگر Intent مناسبی پیدا نشود، null برمی‌گرداند.
  String? detect(String phrase) {
    final normalizedPhrase = _normalize(phrase);

    if (normalizedPhrase.isEmpty) {
      return null;
    }

    // ابتدا Intentهایی که قبلاً یاد گرفته شده‌اند بررسی می‌شوند.
    for (final intent in intents) {
      for (final example in intent.examplePhrases) {
        final normalizedExample = _normalize(example);

        if (normalizedExample.isEmpty) {
          continue;
        }

        if (_isSimilar(normalizedPhrase, normalizedExample)) {
          return intent.id;
        }
      }
    }

    // در این مرحله هنوز Intent جدیدی ساخته نمی‌شود.
    // اگر هیچ مفهوم شناخته‌شده‌ای پیدا نشد،
    // null برمی‌گردد تا LearningEngine آن را
    // به عنوان یک الگوی ناشناخته مدیریت کند.
    return null;
  }

  /// بررسی شباهت ساده بین دو عبارت.
  ///
  /// این نسخه اولیه است.
  /// بعداً می‌توانیم تشخیص معنایی بسیار دقیق‌تری
  /// به آن اضافه کنیم.
  bool _isSimilar(String phrase, String example) {
    if (phrase == example) {
      return true;
    }

    final phraseWords = phrase.split(' ');
    final exampleWords = example.split(' ');

    if (phraseWords.isEmpty || exampleWords.isEmpty) {
      return false;
    }

    int matchedWords = 0;

    for (final word in phraseWords) {
      if (exampleWords.contains(word)) {
        matchedWords++;
      }
    }

    final similarity = matchedWords / phraseWords.length;

    return similarity >= 0.6;
  }

  /// نرمال‌سازی متن برای مقایسه.
  String _normalize(String text) {
    return text
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .toLowerCase();
  }

  /// اضافه کردن یک Intent جدید.
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

  /// پیدا کردن یک Intent با شناسه آن.
  LearnedIntent? findIntent(String intentId) {
    for (final intent in intents) {
      if (intent.id == intentId) {
        return intent;
      }
    }

    return null;
  }

  /// تعداد Intentهای موجود.
  int get intentCount => intents.length;
}