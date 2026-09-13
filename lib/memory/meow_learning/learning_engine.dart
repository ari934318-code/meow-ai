import 'candidate_memory.dart';
import 'learned_phrases.dart';
import 'learned_intents.dart';
import 'learned_vocabulary.dart';
import 'privacy_filter.dart';
import 'learning_validator.dart';
import 'intent_detector.dart';

/// موتور یادگیری Meow.
///
/// جریان اصلی:
///
/// User Input
///     ↓
/// Privacy Filter
///     ↓
/// Normalization
///     ↓
/// Intent Detector
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
  final IntentDetector intentDetector;

  LearningEngine({
    List<CandidateMemory>? candidates,
    List<LearnedPhrase>? learnedPhrases,
    List<LearnedIntent>? learnedIntents,
    List<LearnedVocabulary>? learnedVocabulary,
    PrivacyFilter? privacyFilter,
    LearningValidator? validator,
    IntentDetector? intentDetector,
  })  : candidates = candidates ?? [],
        learnedPhrases = learnedPhrases ?? [],
        learnedIntents = learnedIntents ?? [],
        learnedVocabulary = learnedVocabulary ?? [],
        privacyFilter = privacyFilter ?? const PrivacyFilter(),
        validator = validator ?? const LearningValidator(),
        intentDetector = intentDetector ?? IntentDetector();

  /// دریافت جمله جدید از کاربر.
  void observePhrase(String phrase) {
    final safePhrase = privacyFilter.prepareForLearning(phrase);

    if (safePhrase == null) {
      return;
    }

    final normalizedPhrase = _normalizePhrase(safePhrase);

    if (normalizedPhrase.isEmpty) {
      return;
    }

    // بررسی می‌کنیم که جمله به یک Intent شناخته‌شده مربوط است یا نه.
    final detectedIntent = intentDetector.detect(normalizedPhrase);

    // اگر قبلاً این عبارت یاد گرفته شده باشد،
    // دوباره آن را ثبت نمی‌کنیم.
    final learnedIndex = learnedPhrases.indexWhere(
      (item) => _normalizePhrase(item.phrase) == normalizedPhrase,
    );

    if (learnedIndex != -1) {
      return;
    }

    // بررسی Candidateهای قبلی.
    final candidateIndex = candidates.indexWhere(
      (item) => _normalizePhrase(item.phrase) == normalizedPhrase,
    );

    if (candidateIndex != -1) {
      final oldCandidate = candidates[candidateIndex];

      candidates[candidateIndex] = CandidateMemory(
        phrase: oldCandidate.phrase,
        possibleIntent:
            detectedIntent ?? oldCandidate.possibleIntent,
        seenCount: oldCandidate.seenCount + 1,
        firstSeen: oldCandidate.firstSeen,
        lastSeen: DateTime.now(),
      );

      _tryPromoteCandidate(candidateIndex);

      return;
    }

    // ساخت Candidate جدید.
    final candidate = CandidateMemory(
      phrase: normalizedPhrase,
      possibleIntent: detectedIntent,
      seenCount: 1,
      firstSeen: DateTime.now(),
      lastSeen: DateTime.now(),
    );

    candidates.add(candidate);

    _tryPromoteCandidate(candidates.length - 1);
  }

  /// بررسی Candidate و تبدیل آن به LearnedPhrase
  /// در صورتی که شرایط لازم را داشته باشد.
  void _tryPromoteCandidate(int candidateIndex) {
    if (candidateIndex < 0 ||
        candidateIndex >= candidates.length) {
      return;
    }

    final candidate = candidates[candidateIndex];

    if (!validator.isValid(candidate)) {
      return;
    }

    final confidence = validator.calculateConfidence(candidate);

    final learnedPhrase = LearnedPhrase(
      phrase: candidate.phrase,
      intent: candidate.possibleIntent ?? 'unknown',
      confidence: confidence,
      usageCount: candidate.seenCount,
      learnedAt: DateTime.now(),
    );

    final alreadyExists = learnedPhrases.any(
      (item) =>
          _normalizePhrase(item.phrase) ==
          _normalizePhrase(learnedPhrase.phrase),
    );

    if (alreadyExists) {
      return;
    }

    learnedPhrases.add(learnedPhrase);

    // Candidate بعد از یادگیری دیگر لازم نیست باقی بماند.
    candidates.removeAt(candidateIndex);
  }

  /// نرمال‌سازی جمله.
  String _normalizePhrase(String phrase) {
    return phrase
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .toLowerCase();
  }

  /// بررسی اینکه عبارت قبلاً یاد گرفته شده یا نه.
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