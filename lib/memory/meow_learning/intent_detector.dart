import 'learned_intents.dart';
import 'base_intents.dart';

/// مسئول تشخیص منظور یا Intent جمله.
///
/// IntentDetector تلاش می‌کند جمله‌های مختلفی که
/// یک مفهوم مشترک دارند را به یک Intent وصل کند.
///
/// مثال:
///
/// "آب می‌خوام"
/// "تشنمه"
/// "یه چیزی برای نوشیدن می‌خوام"
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
  }) : intents = intents ?? BaseIntents.create();

  /// تلاش برای تشخیص Intent یک جمله.
  ///
  /// اگر Intent مناسبی پیدا نشود، null برمی‌گرداند.
  String? detect(String phrase) {
    final normalizedPhrase = _normalize(phrase);

    if (normalizedPhrase.isEmpty) {
      return null;
    }

    LearnedIntent? bestIntent;
    double bestScore = 0.0;

    for (final intent in intents) {
      for (final example in intent.examplePhrases) {
        final normalizedExample = _normalize(example);

        if (normalizedExample.isEmpty) {
          continue;
        }

        final score = _similarity(
          normalizedPhrase,
          normalizedExample,
        );

        if (score > bestScore) {
          bestScore = score;
          bestIntent = intent;
        }
      }
    }

    // برای جلوگیری از تشخیص‌های اشتباه،
    // فقط وقتی Intent را قبول می‌کنیم که شباهت کافی باشد.
    if (bestIntent != null && bestScore >= 0.6) {
      return bestIntent.id;
    }

    return null;
  }

  /// محاسبه میزان شباهت دو عبارت.
  ///
  /// این نسخه بر اساس کلمات مشترک کار می‌کند.
  /// بعداً می‌توانیم آن را با تشخیص معنایی پیشرفته‌تر
  /// جایگزین کنیم.
  double _similarity(String phrase, String example) {
    if (phrase == example) {
      return 1.0;
    }

    final phraseWords = phrase.split(' ');
    final exampleWords = example.split(' ');

    if (phraseWords.isEmpty || exampleWords.isEmpty) {
      return 0.0;
    }

    int matchedWords = 0;

    for (final word in phraseWords) {
      if (exampleWords.contains(word)) {
        matchedWords++;
      }
    }

    if (matchedWords == 0) {
      return 0.0;
    }

    final phraseScore =
        matchedWords / phraseWords.length;

    final exampleScore =
        matchedWords / exampleWords.length;

    // میانگین دو طرف باعث می‌شود
    // جمله‌های خیلی کوتاه یا خیلی بلند
    // امتیاز غیرمنطقی نگیرند.
    return (phraseScore + exampleScore) / 2;
  }

  /// نرمال‌سازی متن برای مقایسه.
  String _normalize(String text) {
    return text
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .toLowerCase();
  }

  /// اضافه کردن Intent جدید.
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

  /// پیدا کردن Intent با شناسه.
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