/// یک عبارت جدید که Meow هنوز به صورت قطعی یاد نگرفته است.
///
/// Candidate یعنی «مورد پیشنهادی برای یادگیری».
/// این اطلاعات هنوز دانش قطعی Meow محسوب نمی‌شوند.
class CandidateMemory {
  final String phrase;
  final String? possibleIntent;
  final int seenCount;
  final DateTime firstSeen;
  final DateTime lastSeen;

  const CandidateMemory({
    required this.phrase,
    this.possibleIntent,
    this.seenCount = 1,
    required this.firstSeen,
    required this.lastSeen,
  });

  /// یک نسخه جدید از Candidate با تعداد مشاهده بیشتر می‌سازد.
  CandidateMemory incrementSeen() {
    return CandidateMemory(
      phrase: phrase,
      possibleIntent: possibleIntent,
      seenCount: seenCount + 1,
      firstSeen: firstSeen,
      lastSeen: DateTime.now(),
    );
  }

  /// تبدیل Candidate به Map برای ذخیره‌سازی.
  Map<String, dynamic> toMap() {
    return {
      'phrase': phrase,
      'possibleIntent': possibleIntent,
      'seenCount': seenCount,
      'firstSeen': firstSeen.toIso8601String(),
      'lastSeen': lastSeen.toIso8601String(),
    };
  }

  /// ساخت Candidate از اطلاعات ذخیره‌شده.
  factory CandidateMemory.fromMap(Map<String, dynamic> map) {
    return CandidateMemory(
      phrase: map['phrase'] as String,
      possibleIntent: map['possibleIntent'] as String?,
      seenCount: map['seenCount'] as int? ?? 1,
      firstSeen: DateTime.parse(map['firstSeen'] as String),
      lastSeen: DateTime.parse(map['lastSeen'] as String),
    );
  }
}