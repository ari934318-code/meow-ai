/// یک عبارت که Meow آن را یاد گرفته و به یک مفهوم مرتبط کرده است.
///
/// این اطلاعات فقط شامل دانش زبانی عمومی است.
/// اطلاعات شخصی کاربران نباید در این بخش ذخیره شود.
class LearnedPhrase {
  final String phrase;
  final String intent;
  final double confidence;
  final int usageCount;
  final DateTime learnedAt;

  const LearnedPhrase({
    required this.phrase,
    required this.intent,
    this.confidence = 1.0,
    this.usageCount = 1,
    required this.learnedAt,
  });

  /// افزایش تعداد استفاده از این عبارت.
  LearnedPhrase incrementUsage() {
    return LearnedPhrase(
      phrase: phrase,
      intent: intent,
      confidence: confidence,
      usageCount: usageCount + 1,
      learnedAt: learnedAt,
    );
  }

  /// تبدیل دانش یادگرفته‌شده به Map برای ذخیره‌سازی.
  Map<String, dynamic> toMap() {
    return {
      'phrase': phrase,
      'intent': intent,
      'confidence': confidence,
      'usageCount': usageCount,
      'learnedAt': learnedAt.toIso8601String(),
    };
  }

  /// ساخت دانش یادگرفته‌شده از اطلاعات ذخیره‌شده.
  factory LearnedPhrase.fromMap(Map<String, dynamic> map) {
    return LearnedPhrase(
      phrase: map['phrase'] as String,
      intent: map['intent'] as String,
      confidence: (map['confidence'] as num?)?.toDouble() ?? 1.0,
      usageCount: map['usageCount'] as int? ?? 1,
      learnedAt: DateTime.parse(map['learnedAt'] as String),
    );
  }
}