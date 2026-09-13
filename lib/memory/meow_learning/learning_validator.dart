import 'candidate_memory.dart';

/// مسئول بررسی Candidateها قبل از تبدیل شدن به دانش دائمی Meow.
///
/// Meow نباید هر چیزی را که یک بار از یک کاربر شنید،
/// به عنوان حقیقت یا دانش عمومی یاد بگیرد.
///
/// در نسخه فعلی، اعتبارسنجی بر اساس:
/// - تعداد دفعات مشاهده
/// - طول مناسب جمله
/// - خالی نبودن جمله
/// انجام می‌شود.
///
/// بعداً می‌توانیم بررسی‌های زبانی و هوشمندانه‌تری
/// به این بخش اضافه کنیم.
class LearningValidator {
  /// حداقل تعداد دفعاتی که یک عبارت باید دیده شود
  /// تا بتواند وارد مرحله یادگیری شود.
  final int minimumSeenCount;

  const LearningValidator({
    this.minimumSeenCount = 3,
  });

  /// بررسی می‌کند که Candidate برای یادگیری آماده است یا نه.
  bool isValid(CandidateMemory candidate) {
    final phrase = candidate.phrase.trim();

    // جمله نباید خالی باشد.
    if (phrase.isEmpty) {
      return false;
    }

    // جمله‌های بسیار کوتاه معمولاً برای یادگیری
    // یک الگوی زبانی کافی نیستند.
    if (phrase.length < 2) {
      return false;
    }

    // عبارت باید چند بار مشاهده شده باشد.
    if (candidate.seenCount < minimumSeenCount) {
      return false;
    }

    return true;
  }

  /// محاسبه میزان اطمینان اولیه نسبت به Candidate.
  ///
  /// هرچه تعداد مشاهده بیشتر باشد،
  /// میزان اطمینان نیز بیشتر می‌شود.
  double calculateConfidence(CandidateMemory candidate) {
    if (candidate.seenCount <= 0) {
      return 0.0;
    }

    // سقف اطمینان 0.95 است.
    // Meow هیچ عبارتی را صرفاً به خاطر تکرار،
    // با اطمینان صددرصدی قبول نمی‌کند.
    final confidence = 0.50 + (candidate.seenCount * 0.05);

    return confidence.clamp(0.0, 0.95);
  }
}