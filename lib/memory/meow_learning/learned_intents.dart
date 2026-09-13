/// یک مفهوم یا Intent که Meow آن را یاد گرفته است.
///
/// Intent مشخص می‌کند کاربر «چه منظوری» دارد،
/// نه اینکه دقیقاً چه جمله‌ای گفته است.
///
/// مثال:
/// "آب می‌خوام"
/// "تشنمه"
/// "یه چیزی برای نوشیدن می‌خوام"
///
/// همگی می‌توانند به Intent زیر مربوط باشند:
/// drink_request
class LearnedIntent {
  final String id;
  final String name;
  final List<String> examplePhrases;
  final double confidence;
  final int usageCount;
  final DateTime learnedAt;

  const LearnedIntent({
    required this.id,
    required this.name,
    this.examplePhrases = const [],
    this.confidence = 1.0,
    this.usageCount = 1,
    required this.learnedAt,
  });

  /// اضافه کردن یک جمله جدید که به این مفهوم مربوط است.
  LearnedIntent addExample(String phrase) {
    final updatedExamples = List<String>.from(examplePhrases);

    if (!updatedExamples.contains(phrase)) {
      updatedExamples.add(phrase);
    }

    return LearnedIntent(
      id: id,
      name: name,
      examplePhrases: updatedExamples,
      confidence: confidence,
      usageCount: usageCount + 1,
      learnedAt: learnedAt,
    );
  }

  /// افزایش میزان اطمینان Meow نسبت به این Intent.
  LearnedIntent increaseConfidence(double amount) {
    final newConfidence = (confidence + amount).clamp(0.0, 1.0);

    return LearnedIntent(
      id: id,
      name: name,
      examplePhrases: examplePhrases,
      confidence: newConfidence,
      usageCount: usageCount,
      learnedAt: learnedAt,
    );
  }

  /// تبدیل Intent به Map برای ذخیره‌سازی.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'examplePhrases': examplePhrases,
      'confidence': confidence,
      'usageCount': usageCount,
      'learnedAt': learnedAt.toIso8601String(),
    };
  }

  /// ساخت Intent از اطلاعات ذخیره‌شده.
  factory LearnedIntent.fromMap(Map<String, dynamic> map) {
    return LearnedIntent(
      id: map['id'] as String,
      name: map['name'] as String,
      examplePhrases: List<String>.from(
        map['examplePhrases'] as List? ?? const [],
      ),
      confidence: (map['confidence'] as num?)?.toDouble() ?? 1.0,
      usageCount: map['usageCount'] as int? ?? 1,
      learnedAt: DateTime.parse(map['learnedAt'] as String),
    );
  }
}