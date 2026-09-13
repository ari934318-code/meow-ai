import 'candidate_memory.dart';
import 'learned_phrases.dart';
import 'learned_intents.dart';
import 'learned_vocabulary.dart';

/// موتور یادگیری Meow.
///
/// وظیفه این کلاس:
/// 1. دریافت جمله جدید
/// 2. نرمال‌سازی جمله
/// 3. بررسی اینکه جمله قبلاً دیده شده یا نه
/// 4. ساخت Candidate برای جمله‌های ناشناخته
/// 5. آماده‌سازی جمله برای اتصال به Intent و Vocabulary
///
/// نکته مهم:
/// اطلاعات شخصی کاربران نباید مستقیماً وارد دانش عمومی Meow شود.
class LearningEngine {
  final List<CandidateMemory> candidates;
  final List<LearnedPhrase> learnedPhrases;
  final List<LearnedIntent> learnedIntents;
  final List<LearnedVocabulary> learnedVocabulary;

  LearningEngine({
    List<CandidateMemory>? candidates,
    List<LearnedPhrase>? learnedPhrases,
    List<LearnedIntent>? learnedIntents,
    List<LearnedVocabulary>? learnedVocabulary,
  })  : candidates = candidates ?? [],
        learnedPhrases = learnedPhrases ?? [],
        learnedIntents = learnedIntents ?? [],
        learnedVocabulary = learnedVocabulary ?? [];

  /// دریافت یک جمله جدید از کاربر.
  ///
  /// جمله ابتدا نرمال می‌شود.
  /// اگر قبلاً یاد گرفته شده باشد، دوباره به عنوان Candidate ثبت نمی‌شود.
  /// اگر ناشناخته باشد، به صورت Candidate ذخیره می‌شود.
  void observePhrase(String phrase) {
    final normalizedPhrase = _normalizePhrase(phrase);

    if (normalizedPhrase.isEmpty) {
      return;
    }

    // اگر Meow قبلاً این عبارت را یاد گرفته، نیازی به Candidate جدید نیست.
    final alreadyLearned = learnedPhrases.any(
      (item) => _normalizePhrase(item.phrase) == normalizedPhrase,
    );

    if (alreadyLearned) {
      return;
    }

    // اگر قبلاً به عنوان Candidate دیده شده، تعداد مشاهده را افزایش می‌دهیم.
    final candidateIndex = candidates.indexWhere(
      (item) => _normalizePhrase(item.phrase) == normalizedPhrase,
    );

    if (candidateIndex != -1) {
      candidates[candidateIndex] =
          candidates[candidateIndex].incrementSeen();

      return;
    }

    // اگر کاملاً جدید است، یک Candidate جدید می‌سازیم.
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

  /// نرمال‌سازی جمله برای اینکه شکل‌های مختلف یک جمله
  /// به عنوان عبارت‌های کاملاً متفاوت ذخیره نشوند.
  ///
  /// مثال:
  /// "  آب می‌خوام  "
  /// "آب می‌خوام"
  ///
  /// هر دو به یک شکل تبدیل می‌شوند.
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