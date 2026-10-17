/// Real B1 practice content for lessons 3–6.
/// Stable lesson IDs match the existing B1 catalog.
class B1PracticeLessonData {
  final String id;
  final String titleEn;
  final String titleFa;
  final String grammarEn;
  final String grammarFa;
  final List<B1PracticeWord> vocabulary;
  final List<B1PracticeQuestion> questions;
  final String translationPromptFa;
  final List<String> acceptedTranslations;

  const B1PracticeLessonData({
    required this.id,
    required this.titleEn,
    required this.titleFa,
    required this.grammarEn,
    required this.grammarFa,
    required this.vocabulary,
    required this.questions,
    required this.translationPromptFa,
    required this.acceptedTranslations,
  });
}

class B1PracticeWord {
  final String word;
  final String meaningFa;
  final String exampleEn;
  final String exampleFa;
  const B1PracticeWord(this.word, this.meaningFa, this.exampleEn, this.exampleFa);
}

class B1PracticeQuestion {
  final String prompt;
  final List<String> options;
  final String answer;
  final String explanationFa;
  const B1PracticeQuestion(this.prompt, this.options, this.answer, this.explanationFa);
}

const b1PracticeLessons = <String, B1PracticeLessonData>{
  'b1_lesson_03': B1PracticeLessonData(
    id: 'b1_lesson_03',
    titleEn: 'For and Since',
    titleFa: 'مدت زمان با For و Since',
    grammarEn: 'Use for + a period of time (for two years). Use since + a starting point (since 2022). With a situation that continues now, use have/has + past participle.',
    grammarFa: 'از for برای مدت زمان استفاده می‌کنیم (for two years = به مدت دو سال). از since برای نقطهٔ شروع استفاده می‌کنیم (since 2022 = از سال ۲۰۲۲). برای وضعیتی که تا الان ادامه دارد، معمولاً have/has + شکل سوم فعل می‌آید.',
    vocabulary: [
      B1PracticeWord('duration', 'مدت زمان', 'The duration of the course is six weeks.', 'مدت دوره شش هفته است.'),
      B1PracticeWord('temporary', 'موقت', 'I am staying here temporarily.', 'من موقتاً اینجا می‌مانم.'),
      B1PracticeWord('permanent', 'دائمی', 'She is looking for a permanent job.', 'او دنبال یک شغل دائمی است.'),
      B1PracticeWord('since', 'از زمانِ', 'We have lived here since May.', 'ما از ماه مه اینجا زندگی کرده‌ایم.'),
      B1PracticeWord('for', 'به مدتِ', 'He has worked here for five years.', 'او پنج سال است که اینجا کار می‌کند.'),
      B1PracticeWord('recently', 'اخیراً', 'I have recently moved to this city.', 'من اخیراً به این شهر نقل مکان کرده‌ام.'),
    ],
    questions: [
      B1PracticeQuestion('I have known Mina ___ 2021.', ['for', 'since', 'during'], 'since', 'سال ۲۰۲۱ نقطهٔ شروع است؛ پس since درست است.'),
      B1PracticeQuestion('They have been married ___ ten years.', ['since', 'for', 'from'], 'for', 'ten years یک بازهٔ زمانی است؛ پس for می‌آید.'),
      B1PracticeQuestion('How long ___ you lived here?', ['have', 'did', 'are'], 'have', 'برای وضعیتی که تا الان ادامه دارد از Present Perfect استفاده می‌کنیم.'),
      B1PracticeQuestion('He has worked at this school ___ September.', ['for', 'since', 'while'], 'since', 'September نقطهٔ شروع است.'),
      B1PracticeQuestion('We ___ each other for a long time.', ['know', 'have known', 'are knowing'], 'have known', 'know در این معنا معمولاً استمراری نمی‌شود و اینجا Present Perfect لازم است.'),
    ],
    translationPromptFa: 'ترجمه کن: «من سه سال است که انگلیسی یاد می‌گیرم.»',
    acceptedTranslations: ['i have been learning english for three years', 'i have learned english for three years', 'i have learnt english for three years'],
  ),
  'b1_lesson_04': B1PracticeLessonData(
    id: 'b1_lesson_04',
    titleEn: 'Past Stories',
    titleFa: 'داستان‌های گذشته',
    grammarEn: 'Use the Past Continuous for an action in progress at a past moment. Use the Past Simple for a completed event, often one that interrupts the longer action.',
    grammarFa: 'برای کاری که در لحظه‌ای از گذشته در جریان بود از Past Continuous استفاده می‌کنیم. برای اتفاق کامل‌شده، به‌ویژه اتفاقی که کار طولانی‌تر را قطع می‌کند، از Past Simple استفاده می‌کنیم.',
    vocabulary: [
      B1PracticeWord('suddenly', 'ناگهان', 'Suddenly, the lights went out.', 'ناگهان چراغ‌ها خاموش شدند.'),
      B1PracticeWord('while', 'درحالی‌که', 'I listened to music while I was studying.', 'وقتی درس می‌خواندم به موسیقی گوش می‌دادم.'),
      B1PracticeWord('interrupt', 'قطع کردن', 'The phone call interrupted our dinner.', 'تماس تلفنی شام ما را قطع کرد.'),
      B1PracticeWord('realize', 'متوجه شدن', 'I realized I had the wrong address.', 'متوجه شدم آدرس اشتباه را داشتم.'),
      B1PracticeWord('meanwhile', 'در همین حین', 'Meanwhile, the children were waiting outside.', 'در همین حین، بچه‌ها بیرون منتظر بودند.'),
      B1PracticeWord('fortunately', 'خوشبختانه', 'Fortunately, nobody was hurt.', 'خوشبختانه کسی آسیب ندید.'),
    ],
    questions: [
      B1PracticeQuestion('I ___ home when it started to rain.', ['walked', 'was walking', 'am walking'], 'was walking', 'کار در جریان بود و باران شروع شد؛ پس was walking.'),
      B1PracticeQuestion('While Sara ___, the doorbell rang.', ['cooked', 'was cooking', 'is cooking'], 'was cooking', 'بعد از while برای عمل در جریان از Past Continuous استفاده شده است.'),
      B1PracticeQuestion('The lights ___ out suddenly.', ['were going', 'go', 'went'], 'went', 'اتفاق کوتاه و کامل‌شده با Past Simple می‌آید.'),
      B1PracticeQuestion('What ___ you doing at nine last night?', ['did', 'were', 'are'], 'were', 'ساختار سؤال Past Continuous: What were you doing...?'),
      B1PracticeQuestion('He ___ his keys while he was running.', ['dropped', 'was dropping', 'drops'], 'dropped', 'افتادن کلیدها اتفاقی کامل‌شده در میان عمل طولانی‌تر است.'),
    ],
    translationPromptFa: 'ترجمه کن: «داشتم شام درست می‌کردم که دوستم زنگ زد.»',
    acceptedTranslations: ['i was cooking dinner when my friend called', 'i was making dinner when my friend called'],
  ),
  'b1_lesson_05': B1PracticeLessonData(
    id: 'b1_lesson_05',
    titleEn: 'What Happened?',
    titleFa: 'چه اتفاقی افتاد؟',
    grammarEn: 'Make a story easy to follow with sequence words: first, then, after that, later, and finally. Use the Past Simple for the main events and the Past Continuous for background actions.',
    grammarFa: 'برای قابل‌دنبال‌کردن شدن داستان از کلمات ترتیب مثل first، then، after that، later و finally استفاده کن. اتفاق‌های اصلی معمولاً با Past Simple و کارهای پس‌زمینه با Past Continuous بیان می‌شوند.',
    vocabulary: [
      B1PracticeWord('first', 'اول', 'First, we checked the map.', 'اول نقشه را بررسی کردیم.'),
      B1PracticeWord('afterwards', 'بعد از آن', 'Afterwards, we had lunch.', 'بعد از آن ناهار خوردیم.'),
      B1PracticeWord('eventually', 'سرانجام', 'We eventually found the hotel.', 'سرانجام هتل را پیدا کردیم.'),
      B1PracticeWord('unexpected', 'غیرمنتظره', 'We had an unexpected problem.', 'با یک مشکل غیرمنتظره روبه‌رو شدیم.'),
      B1PracticeWord('miss', 'از دست دادن', 'I missed the last bus.', 'آخرین اتوبوس را از دست دادم.'),
      B1PracticeWord('manage', 'موفق شدن / از پس چیزی برآمدن', 'We managed to get home safely.', 'موفق شدیم سالم به خانه برسیم.'),
    ],
    questions: [
      B1PracticeQuestion('___, we bought our tickets. Then we went to the platform.', ['Finally', 'First', 'Meanwhile'], 'First', 'جمله شروع روایت را بیان می‌کند؛ First مناسب است.'),
      B1PracticeQuestion('We missed the bus. ___, we took a taxi.', ['However', 'After that', 'Although'], 'After that', 'برای نشان دادن اتفاق بعدی از After that استفاده می‌کنیم.'),
      B1PracticeQuestion('The road was closed; ___, we arrived late.', ['as a result', 'first', 'meanwhile'], 'as a result', 'as a result نتیجهٔ اتفاق قبلی را نشان می‌دهد.'),
      B1PracticeQuestion('At last, we ___ to find the right building.', ['managed', 'manage', 'were manage'], 'managed', 'داستان در گذشته است؛ شکل گذشتهٔ manage برابر managed است.'),
      B1PracticeQuestion('Which phrase is best for the final event in a story?', ['To begin with', 'Finally', 'At the same time'], 'Finally', 'Finally برای آخرین مرحله یا اتفاق به کار می‌رود.'),
    ],
    translationPromptFa: 'ترجمه کن: «اول گم شدیم، اما سرانجام راه را پیدا کردیم.»',
    acceptedTranslations: ['first we got lost but eventually we found the way', 'first we got lost but finally we found the way'],
  ),
  'b1_lesson_06': B1PracticeLessonData(
    id: 'b1_lesson_06',
    titleEn: 'Memorable Moments',
    titleFa: 'لحظه‌های به‌یادماندنی',
    grammarEn: 'Use adjectives to describe experiences and Past Simple or Present Perfect according to the time reference. Add details about what happened and how you felt.',
    grammarFa: 'برای توصیف تجربه‌ها از صفت‌ها استفاده کن. بسته به اینکه زمان مشخصی در گذشته گفته شده یا دربارهٔ تجربه تا امروز حرف می‌زنیم، Past Simple یا Present Perfect را انتخاب کن. توضیح بده چه اتفاقی افتاد و چه احساسی داشتی.',
    vocabulary: [
      B1PracticeWord('unforgettable', 'فراموش‌نشدنی', 'It was an unforgettable evening.', 'آن شب فراموش‌نشدنی بود.'),
      B1PracticeWord('proud', 'مفتخر / سربلند', 'I felt proud of my team.', 'به تیمم افتخار کردم.'),
      B1PracticeWord('relieved', 'آسوده‌خاطر', 'I was relieved when I heard the news.', 'وقتی خبر را شنیدم آسوده‌خاطر شدم.'),
      B1PracticeWord('embarrassed', 'خجالت‌زده', 'He felt embarrassed after the mistake.', 'بعد از آن اشتباه خجالت‌زده شد.'),
      B1PracticeWord('achievement', 'دستاورد', 'Finishing the course was a real achievement.', 'تمام کردن دوره یک دستاورد واقعی بود.'),
      B1PracticeWord('incredible', 'باورنکردنی', 'The view from the mountain was incredible.', 'منظرهٔ کوه باورنکردنی بود.'),
    ],
    questions: [
      B1PracticeQuestion('Winning the prize was a great ___.', ['achievement', 'duration', 'delay'], 'achievement', 'achievement یعنی دستاورد یا موفقیت.'),
      B1PracticeQuestion('I felt ___ when I passed the difficult exam.', ['relieved', 'temporary', 'unexpected'], 'relieved', 'relieved یعنی آسوده‌خاطر، مخصوصاً پس از پایان نگرانی.'),
      B1PracticeQuestion('We ___ an unforgettable day last summer.', ['have', 'had', 'have had'], 'had', 'last summer زمان مشخص و تمام‌شده است؛ Past Simple می‌آید.'),
      B1PracticeQuestion('Have you ever ___ something incredible?', ['experienced', 'experience', 'experiencing'], 'experienced', 'بعد از have در Present Perfect شکل سوم فعل می‌آید.'),
      B1PracticeQuestion('Which adjective means “فراموش‌نشدنی”?', ['embarrassed', 'unforgettable', 'relieved'], 'unforgettable', 'unforgettable یعنی فراموش‌نشدنی.'),
    ],
    translationPromptFa: 'ترجمه کن: «این یکی از به‌یادماندنی‌ترین روزهای زندگی من بود.»',
    acceptedTranslations: ['this was one of the most memorable days of my life', 'it was one of the most memorable days of my life'],
  ),
};
