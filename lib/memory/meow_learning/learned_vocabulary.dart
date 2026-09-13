/// یک واژه یا عبارت کوتاه که Meow یاد گرفته است.
///
/// این بخش برای دانش عمومی زبان است.
/// اطلاعات شخصی کاربران نباید در این قسمت ذخیره شود.
///
/// مثال:
/// word: "thirsty"
/// meaning: "تشنه"
/// type: "adjective"
class LearnedVocabulary {
  final String word;
  final String meaning;
  final String? pronunciation;
  final String? type;
  final List<String> examples;
  final double confidence;
  final int usageCount;
  final DateTime learnedAt;

  const LearnedVocabulary({
    required this.word,
    required this.meaning,
    this.pronunciation,
    this.type,
    this.examples = const [],
    this.confidence = 1.0,
    this.usageCount = 1,
    required this.learnedAt,
  });

  /// اضافه کردن یک مثال جدید برای این واژه.
  LearnedVocabulary addExample(String example) {
    final updatedExamples = List<String>.from(examples);

    if (!updatedExamples.contains(example)) {
      updatedExamples.add(example);
    }

    return LearnedVocabulary(
      word: word,
      meaning: meaning,
      pronunciation: pronunciation,
      type: type,
      examples: updatedExamples,
      confidence: confidence,
      usageCount: usageCount + 1,
      learnedAt: learnedAt,
    );
  }

  /// افزایش میزان اطمینان Meow نسبت به این واژه.
  LearnedVocabulary increaseConfidence(double amount) {
    final newConfidence = (confidence + amount).clamp(0.0, 1.0);

    return LearnedVocabulary(
      word: word,
      meaning: meaning,
      pronunciation: pronunciation,
      type: type,
      examples: examples,
      confidence: newConfidence,
      usageCount: usageCount,
      learnedAt: learnedAt,
    );
  }

  /// تبدیل اطلاعات واژه به Map برای ذخیره‌سازی.
  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'meaning': meaning,
      'pronunciation': pronunciation,
      'type': type,
      'examples': examples,
      'confidence': confidence,
      'usageCount': usageCount,
      'learnedAt': learnedAt.toIso8601String(),
    };
  }

  /// ساخت واژه از اطلاعات ذخیره‌شده.
  factory LearnedVocabulary.fromMap(Map<String, dynamic> map) {
    return LearnedVocabulary(
      word: map['word'] as String,
      meaning: map['meaning'] as String,
      pronunciation: map['pronunciation'] as String?,
      type: map['type'] as String?,
      examples: List<String>.from(
        map['examples'] as List? ?? const [],
      ),
      confidence: (map['confidence'] as num?)?.toDouble() ?? 1.0,
      usageCount: map['usageCount'] as int? ?? 1,
      learnedAt: DateTime.parse(map['learnedAt'] as String),
    );
  }
}