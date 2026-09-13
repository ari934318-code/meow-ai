import 'learning_engine.dart';
import 'learning_knowledge.dart';
import 'learning_storage.dart';
import 'learned_phrases.dart';
import 'learned_intents.dart';
import 'learned_vocabulary.dart';

/// مدیر اصلی سیستم یادگیری Meow.
///
/// این کلاس بخش‌های مختلف یادگیری را به هم وصل می‌کند:
///
/// LearningEngine
///       ↓
/// LearningKnowledge
///       ↓
/// LearningStorage
///
/// وظیفه این کلاس این است که:
/// - دانش قبلی را بارگذاری کند.
/// - جمله‌های جدید را به LearningEngine بدهد.
/// - دانش معتبر را نگهداری کند.
/// - دانش را ذخیره کند.
class MeowLearningManager {
  final LearningEngine engine;
  final LearningStorage storage;

  LearningKnowledge knowledge;

  MeowLearningManager({
    LearningEngine? engine,
    LearningStorage? storage,
    LearningKnowledge? knowledge,
  })  : engine = engine ?? LearningEngine(),
        storage = storage ?? const LearningStorage(),
        knowledge = knowledge ?? LearningKnowledge();

  /// بارگذاری دانش قبلی Meow.
  Future<void> initialize() async {
    knowledge = await storage.load();

    // دانش ذخیره‌شده را وارد Engine می‌کنیم.
    engine.learnedPhrases
      ..clear()
      ..addAll(knowledge.phrases);

    engine.learnedIntents
      ..clear()
      ..addAll(knowledge.intents);

    engine.learnedVocabulary
      ..clear()
      ..addAll(knowledge.vocabulary);
  }

  /// دریافت یک جمله جدید از کاربر.
  ///
  /// جمله ابتدا وارد LearningEngine می‌شود.
  /// سپس دانش جدید بررسی و ذخیره می‌شود.
  Future<void> observe(String phrase) async {
    final oldLearnedCount = engine.learnedPhraseCount;

    engine.observePhrase(phrase);

    // اگر دانش جدیدی ساخته شده باشد،
    // آن را وارد LearningKnowledge می‌کنیم.
    if (engine.learnedPhraseCount > oldLearnedCount) {
      final newPhrases =
          engine.learnedPhrases.skip(oldLearnedCount);

      for (final phrase in newPhrases) {
        knowledge.addPhrase(phrase);
      }

      await _save();
    }
  }

  /// اضافه کردن Intent جدید به دانش Meow.
  Future<void> addIntent(LearnedIntent intent) async {
    engine.learnedIntents.removeWhere(
      (item) => item.id == intent.id,
    );

    engine.learnedIntents.add(intent);

    knowledge.addIntent(intent);

    await _save();
  }

  /// اضافه کردن واژه جدید به دانش Meow.
  Future<void> addVocabulary(
    LearnedVocabulary vocabulary,
  ) async {
    engine.learnedVocabulary.removeWhere(
      (item) =>
          item.word.trim().toLowerCase() ==
          vocabulary.word.trim().toLowerCase(),
    );

    engine.learnedVocabulary.add(vocabulary);

    knowledge.addVocabulary(vocabulary);

    await _save();
  }

  /// ذخیره دانش فعلی.
  Future<void> _save() async {
    await storage.save(knowledge);
  }

  /// تعداد عبارت‌های یادگرفته‌شده.
  int get learnedPhraseCount {
    return knowledge.phraseCount;
  }

  /// تعداد Intentهای یادگرفته‌شده.
  int get learnedIntentCount {
    return knowledge.intentCount;
  }

  /// تعداد واژه‌های یادگرفته‌شده.
  int get learnedVocabularyCount {
    return knowledge.vocabularyCount;
  }
}