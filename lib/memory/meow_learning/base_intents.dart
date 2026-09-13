import 'learned_intents.dart';

/// Intentهای پایه و عمومی Meow.
///
/// این‌ها مفاهیم اصلی زبان روزمره هستند که Meow
/// از همان ابتدا باید بتواند تشخیص دهد.
///
/// این اطلاعات عمومی هستند و به هیچ کاربر خاصی
/// وابسته نیستند.
class BaseIntents {
  const BaseIntents._();

  static List<LearnedIntent> create() {
    final now = DateTime.now();

    return [
      LearnedIntent(
        id: 'drink_request',
        name: 'درخواست نوشیدنی',
        examplePhrases: const [
          'آب می‌خوام',
          'یه آب می‌خوام',
          'تشنمه',
          'خیلی تشنمه',
          'یه چیزی برای نوشیدن می‌خوام',
          'می‌خوام آب بخورم',
          'میشه آب بدی',
          'میشه یه لیوان آب بدی',
          'آب لازم دارم',
          'آب می‌خواستم',
        ],
        confidence: 0.98,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'food_request',
        name: 'درخواست غذا',
        examplePhrases: const [
          'غذا می‌خوام',
          'گرسنه‌ام',
          'خیلی گرسنه‌ام',
          'یه چیزی برای خوردن می‌خوام',
          'می‌خوام غذا بخورم',
          'میشه یه چیزی بخورم',
          'غذا لازم دارم',
        ],
        confidence: 0.98,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'help_request',
        name: 'درخواست کمک',
        examplePhrases: const [
          'کمک می‌خوام',
          'کمکم کن',
          'میشه کمکم کنی',
          'کمک لازم دارم',
          'میشه کمک کنی',
          'من به کمک نیاز دارم',
        ],
        confidence: 0.98,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'bathroom_request',
        name: 'درخواست دستشویی',
        examplePhrases: const [
          'دستشویی کجاست',
          'دستشویی می‌خوام',
          'می‌تونم برم دستشویی',
          'حمام کجاست',
          'باید برم دستشویی',
          'دستشویی لازم دارم',
        ],
        confidence: 0.97,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'meaning_request',
        name: 'درخواست معنی',
        examplePhrases: const [
          'این یعنی چی',
          'معنی این چیه',
          'معنی این کلمه چیه',
          'این کلمه یعنی چی',
          'what does this mean',
          'what does it mean',
          'meaning of this word',
          'این یعنی چه',
        ],
        confidence: 0.99,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'pronunciation_request',
        name: 'درخواست تلفظ',
        examplePhrases: const [
          'تلفظ این چیه',
          'این چطور تلفظ میشه',
          'چطور خونده میشه',
          'تلفظ این کلمه',
          'تلفظش چطوره',
          'how do you pronounce this',
          'how is this pronounced',
          'pronunciation of this',
        ],
        confidence: 0.99,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'translation_request',
        name: 'درخواست ترجمه',
        examplePhrases: const [
          'این رو ترجمه کن',
          'ترجمه این چیه',
          'این جمله رو ترجمه کن',
          'به انگلیسی چی میشه',
          'به فارسی چی میشه',
          'how do you say this in english',
          'translate this',
          'translate this sentence',
        ],
        confidence: 0.99,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'greeting',
        name: 'سلام و احوالپرسی',
        examplePhrases: const [
          'سلام',
          'سلام میو',
          'سلام خوبی',
          'خوبی',
          'چه خبر',
          'hello',
          'hi',
          'hey',
          'how are you',
        ],
        confidence: 0.99,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'not_understood',
        name: 'متوجه نشدن',
        examplePhrases: const [
          'نفهمیدم',
          'متوجه نشدم',
          'نمی‌فهمم',
          'منظورت چیه',
          'چی گفتی',
          'دوباره بگو',
          'I do not understand',
          'I dont understand',
          'I did not understand',
          'what do you mean',
          'say that again',
        ],
        confidence: 0.98,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'self_introduction',
        name: 'معرفی خود',
        examplePhrases: const [
          'من کی هستم',
          'می‌خوام خودمو معرفی کنم',
          'اسم من',
          'من هستم',
          'my name is',
          'I am',
          'I am from',
          'let me introduce myself',
        ],
        confidence: 0.95,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'thanks',
        name: 'تشکر',
        examplePhrases: const [
          'ممنون',
          'مرسی',
          'خیلی ممنون',
          'دستت درد نکنه',
          'thanks',
          'thank you',
          'thanks a lot',
        ],
        confidence: 0.99,
        usageCount: 100,
        learnedAt: now,
      ),

      LearnedIntent(
        id: 'goodbye',
        name: 'خداحافظی',
        examplePhrases: const [
          'خداحافظ',
          'فعلا',
          'می‌بینمت',
          'بای',
          'bye',
          'goodbye',
          'see you',
          'see you later',
        ],
        confidence: 0.99,
        usageCount: 100,
        learnedAt: now,
      ),
    ];
  }
}