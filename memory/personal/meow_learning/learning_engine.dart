import 'candidate_memory.dart';
import 'learned_phrases.dart';
import 'learned_intents.dart';
import 'learned_vocabulary.dart';
import 'privacy_filter.dart';

/// موتور یادگیری Meow.
///
/// وظیفه این کلاس:
/// 1. دریافت جمله جدید
/// 2. بررسی حریم خصوصی
/// 3. پاک‌سازی اطلاعات شخصی
/// 4. نرمال‌سازی جمله
/// 5. بررسی دانش قبلی
/// 6. ساخت یا افزایش Candidate
///
/// اطلاعات شخصی کاربران نباید وارد دانش عمومی Meow شود.
class LearningEngine {
  final List<CandidateMemory> candidates;
  final List<LearnedPhrase> learnedPhrases;
  final List<LearnedIntent> learnedIntents;
  final List<LearnedVocabulary> learnedVocabulary;

  final PrivacyFilter privacyFilter;

  LearningEngine({
    List<CandidateMemory>? candidates,
    List<LearnedPhrase>? learnedPhrases,
    List<LearnedIntent>? learnedIntents,
    List<LearnedVocabulary>? learnedVocabulary,
    PrivacyFilter? privacyFilter,
  })  : candidates = candidates ?? [],
        learnedPhrases = learnedPhrases ?? [],
        learnedIntents = learnedIntents ?? [],
        learnedVocabulary = learnedVocabulary ?? [],
        privacyFilter = privacyFilter ?? const PrivacyFilter();

  /// دریافت یک جمله جدید از کاربر.
  ///
  /// قبل از اینکه جمله وارد سیستم یادگیری شود،
  /// اطلاعات شخصی احتمالی از آن حذف می‌شود.
  void observePhrase(String phrase) {
    // اول جمله را برای یادگیری امن آماده می‌کنیم.
    final safePhrase = privacyFilter.prepareForLearning(phrase);

    // اگر چیزی قابل یادگیری باقی نمانده باشد، متوقف می‌شویم.
    if (safePhrase == null) {
      return;
    }

    final normalizedPhrase = _normalizePhrase(safePhrase);

    if (normalizedPhrase.isEmpty) {
      return;
    }

    // اگر Meow قبلاً این عبارت را یاد گرفته،
    // دوباره Candidate نمی‌سازیم.
    final alreadyLearned = learnedPhrases.any(
      (item) => _normalizePhrase(item.phrase) == normalizedPhrase,
    );

    if (alreadyLearned) {
      return;
    }

    // اگر قبلاً Candidate مشابه وجود دارد،
    // تعداد مشاهده آن را افزایش می‌دهیم.
    final candidateIndex = candidates.indexWhere(
      (item) => _normalizePhrase(item.phrase) == normalizedPhrase,
    );

    if (candidateIndex != -1) {
      candidates[candidateIndex] =
          candidates[candidateIndex].incrementSeen();

      return;
    }

    // اگر جمله کاملاً جدید است،
    // آن را به عنوان Candidate ذخیره می‌کنیم.
    candidates.add(
      CandidateMemory(
        phrase: normalizedPhrase,
        possibleIntent: null,
        seenCount: 1,
        firstSeen: DateTime.now(),
        lastSeen: DateTime.now(),
      ),
    );
  }

  /// نرمال‌سازی جمله.
  ///
  /// فاصله‌های اضافی حذف می‌شوند و حروف انگلیسی
  /// به حالت کوچک تبدیل می‌شوند.
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