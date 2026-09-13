import 'candidate_memory.dart';
import 'learned_phrases.dart';
import 'learned_intents.dart';
import 'learned_vocabulary.dart';
import 'privacy_filter.dart';
import 'learning_validator.dart';

/// موتور یادگیری Meow.
///
/// جریان اصلی یادگیری:
///
/// User Input
///     ↓
/// Privacy Filter
///     ↓
/// Normalization
///     ↓
/// Candidate Memory
///     ↓
/// Learning Validator
///     ↓
/// Learned Phrase
///
/// اطلاعات شخصی کاربران نباید وارد دانش عمومی Meow شود.
class LearningEngine {
  final List<CandidateMemory> candidates;
  final List<LearnedPhrase> learnedPhrases;
  final List<LearnedIntent> learnedIntents;
  final List<LearnedVocabulary> learnedVocabulary;

  final PrivacyFilter privacyFilter;
  final LearningValidator validator;

  LearningEngine({
    List<CandidateMemory>? candidates,
    List<LearnedPhrase>? learnedPhrases,
    List<LearnedIntent>? learnedIntents,
    List<LearnedVocabulary>? learnedVocabulary,
    PrivacyFilter? privacyFilter,
    LearningValidator? validator,
  })  : candidates = candidates ?? [],
        learnedPhrases = learnedPhrases ?? [],
        learnedIntents = learnedIntents ?? [],
        learnedVocabulary = learnedVocabulary ?? [],
        privacyFilter = privacyFilter ?? const PrivacyFilter(),
        validator = validator ?? const LearningValidator();

  /// دریافت جمله جدید از کاربر.
  ///
  /// ابتدا اطلاعات شخصی حذف می‌شود.
  /// سپس جمله به Candidate تبدیل می‌شود.
  /// اگر Candidate به اندازه کافی تکرار شده باشد،
  /// برای تبدیل شدن به دانش یادگرفته‌شده بررسی می‌شود.
  void observePhrase(String phrase) {
    final safePhrase = privacyFilter.prepareForLearning(phrase);

    if (safePhrase == null) {
      return;
    }

    final normalizedPhrase = _normalizePhrase(safePhrase);

    if (normalizedPhrase.isEmpty) {
      return;
    }

    // اگر قبلاً یاد گرفته شده، دوباره ذخیره نمی‌کنیم.
    final alreadyLearned = learnedPhrases.any(
      (item) => _normalizePhrase(item.phrase) == normalizedPhrase,
    );

    if (alreadyLearned) {
      return;
    }

    // بررسی اینکه Candidate قبلاً وجود دارد یا نه.
    final candidateIndex = candidates.indexWhere(
      (item) => _normalizePhrase(item.phrase) == normalizedPhrase,
    );

    if (candidateIndex != -1) {
      // Candidate قبلی دوباره دیده شده است.
      candidates[candidateIndex] =
          candidates[candidateIndex].incrementSeen();

      // بعد از افزایش تعداد مشاهده،
      // بررسی می‌کنیم که حالا قابل یادگیری هست یا نه.
      _tryPromoteCandidate(candidateIndex);

      return;
    }

    // ساخت Candidate جدید.
    final candidate = CandidateMemory(
      phrase: normalizedPhrase,
      possibleIntent: null,
      seenCount: 1,
      firstSeen: DateTime.now(),
      lastSeen: DateTime.now(),
    );

    candidates.add(candidate);

    // Candidate جدید هنوز معمولاً معتبر نیست،
    // ولی برای اطمینان آن را بررسی می‌کنیم.
    _tryPromoteCandidate(candidates.length - 1);
  }

  /// بررسی Candidate و تبدیل آن به LearnedPhrase
  /// در صورتی که شرایط لازم را داشته باشد.
  void _tryPromoteCandidate(int candidateIndex) {
    if (candidateIndex < 0 || candidateIndex >= candidates.length) {
      return;
    }

    final candidate = candidates[candidateIndex];

    // اگر Candidate هنوز اعتبار کافی ندارد،
    // هیچ کاری انجام نمی‌دهیم.
    if (!validator.isValid(candidate)) {
      return;
    }

    final confidence = validator.calculateConfidence(candidate);

    // در نسخه فعلی هنوز Intent را به صورت خودکار
    // حدس نمی‌زنیم.
    //
    // Intent در مرحله بعدی توسط سیستم تشخیص Intent
    // مشخص خواهد شد.
    final learnedPhrase = LearnedPhrase(
      phrase: candidate.phrase,
      intent: candidate.possibleIntent ?? 'unknown',
      confidence: confidence,
      usageCount: candidate.seenCount,
      learnedAt: DateTime.now(),
    );

    // جلوگیری از ثبت تکراری.
    final alreadyExists = learnedPhrases.any(
      (item) => _normalizePhrase(item.phrase) ==
          _normalizePhrase(learnedPhrase.phrase),
    );

    if (alreadyExists) {
      return;
    }

    learnedPhrases.add(learnedPhrase);

    // بعد از تبدیل شدن به دانش دائمی،
    // Candidate دیگر لازم نیست باقی بماند.
    candidates.removeAt(candidateIndex);
  }

  /// نرمال‌سازی جمله.
  String _normalizePhrase(String phrase) {
    return phrase
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .toLowerCase();
  }

  /// بررسی اینکه یک عبارت قبلاً یاد گرفته شده یا نه.
  bool hasLearnedPhrase(String phrase) {
    final normalizedPhrase = _normalizePhrase(phrase);

    return learnedPhrases.any(
      (item) => _normalizePhrase(item.phrase) == normalizedPhrase,
    );
  }

  /// پیدا کردن Candidate مربوط به یک جمله.
  CandidateMemory? findCandidate(String phrase) {
    final normalizedPhrase = _normalizePhrase(phrase);

    for (final candidate in candidates) {
      if (_normalizePhrase(candidate.phrase) == normalizedPhrase) {
        return candidate;
      }
    }

    return null;
  }

  /// تعداد Candidateهای فعلی.
  int get candidateCount => candidates.length;

  /// تعداد عبارت‌های یادگرفته‌شده.
  int get learnedPhraseCount => learnedPhrases.length;

  /// تعداد Intentهای یادگرفته‌شده.
  int get learnedIntentCount => learnedIntents.length;

  /// تعداد واژه‌های یادگرفته‌شده.
  int get learnedVocabularyCount => learnedVocabulary.length;
}