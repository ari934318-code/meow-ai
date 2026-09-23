import 'a1_basics_models.dart';

const A1BasicLesson a1BasicRegularVerbs = A1BasicLesson(
  id: 'a1_basic_12',
  title: 'Regular Past',
  titleFa: 'گذشته ساده با افعال باقاعده',
  topic: 'Regular past verbs: -ed, spelling rules, negatives, and questions',
  explanation:
      'Regular verbs form the simple past in a predictable way, usually by adding -ed. '
      'The simple past describes finished actions in the past. '
      'After did or did not, use the base form of the verb.',

  learningPhases: [
    A1BasicLearningPhase(
      type: 'curiosity',
      title: 'Think First',
      titleFa: 'اول یک لحظه فکر کن',
      body: 'Look at these sentences: I play today. I played yesterday. What changed?',
      bodyFa: 'این جمله‌ها را ببین: I play today. و I played yesterday. چه چیزی تغییر کرده؟',
      examples: [
        A1BasicExample(english: 'I play today.', persian: 'من امروز بازی می‌کنم.'),
        A1BasicExample(english: 'I played yesterday.', persian: 'من دیروز بازی کردم.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'introduction',
      title: 'What Is the Regular Past?',
      titleFa: 'گذشته باقاعده چیست؟',
      body: 'Use the past to talk about a finished action before now. Many regular verbs form the past with -ed.',
      bodyFa: 'برای صحبت درباره کاری که قبل از الان و تمام شده از گذشته استفاده می‌کنیم. بسیاری از فعل‌های باقاعده برای ساخت گذشته -ed می‌گیرند.',
      examples: [
        A1BasicExample(english: 'I worked yesterday.', persian: 'من دیروز کار کردم.'),
        A1BasicExample(english: 'She played last night.', persian: 'او دیشب بازی کرد.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'Simple Examples',
      titleFa: 'مثال‌های ساده',
      body: 'Start with common regular verbs.',
      bodyFa: 'با چند فعل باقاعده و پرکاربرد شروع کنیم.',
      examples: [
        A1BasicExample(english: 'work → worked', persian: 'کار کردن → کار کرد'),
        A1BasicExample(english: 'play → played', persian: 'بازی کردن → بازی کرد'),
        A1BasicExample(english: 'clean → cleaned', persian: 'تمیز کردن → تمیز کرد'),
        A1BasicExample(english: 'watch → watched', persian: 'تماشا کردن → تماشا کرد'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'The -ed Rule',
      titleFa: 'قانون -ed',
      body: 'For many regular verbs, add -ed to make the past form.',
      bodyFa: 'برای بسیاری از فعل‌های باقاعده، برای ساخت شکل گذشته -ed اضافه می‌کنیم.',
      examples: [
        A1BasicExample(english: 'work → worked', persian: 'کار کردن → کار کرد'),
        A1BasicExample(english: 'help → helped', persian: 'کمک کردن → کمک کرد'),
        A1BasicExample(english: 'open → opened', persian: 'باز کردن → باز کرد'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'Spelling Changes',
      titleFa: 'تغییرات املایی',
      body: 'Some common spelling patterns are: live → lived, study → studied, stop → stopped.',
      bodyFa: 'چند الگوی املایی مهم: live → lived، study → studied، stop → stopped.',
      examples: [
        A1BasicExample(english: 'live → lived', persian: 'زندگی کردن → زندگی کرد'),
        A1BasicExample(english: 'study → studied', persian: 'درس خواندن → درس خواند'),
        A1BasicExample(english: 'stop → stopped', persian: 'متوقف شدن → متوقف شد'),
        A1BasicExample(english: 'play → played', persian: 'بازی کردن → بازی کرد'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'positive',
      title: 'Positive Sentences',
      titleFa: 'جمله‌های مثبت',
      body: 'Use the past form directly in a positive sentence. The past form does not change for different subjects.',
      bodyFa: 'در جمله مثبت، شکل گذشته فعل را مستقیم استفاده می‌کنیم. شکل گذشته با فاعل‌های مختلف تغییر نمی‌کند.',
      examples: [
        A1BasicExample(english: 'I worked yesterday.', persian: 'من دیروز کار کردم.'),
        A1BasicExample(english: 'She worked yesterday.', persian: 'او دیروز کار کرد.'),
        A1BasicExample(english: 'They played last night.', persian: 'آنها دیشب بازی کردند.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'negative',
      title: 'Negative with Didn’t',
      titleFa: 'منفی با Didn’t',
      body: 'Use didn’t + the base verb. The past marker is carried by didn’t, so do not use the past form after it.',
      bodyFa: 'از didn’t + شکل پایه فعل استفاده کن. علامت گذشته در didn’t است، پس بعد از آن از شکل گذشته فعل استفاده نمی‌کنیم.',
      examples: [
        A1BasicExample(english: 'I didn’t work yesterday.', persian: 'من دیروز کار نکردم.'),
        A1BasicExample(english: 'She didn’t play.', persian: 'او بازی نکرد.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'questions',
      title: 'Questions with Did',
      titleFa: 'سؤال با Did',
      body: 'Use Did + subject + base verb. Do not use the -ed form after did.',
      bodyFa: 'از Did + فاعل + شکل پایه فعل استفاده کن. بعد از did از شکل -ed استفاده نمی‌کنیم.',
      examples: [
        A1BasicExample(english: 'Did you work yesterday?', persian: 'آیا دیروز کار کردی؟'),
        A1BasicExample(english: 'Did she play?', persian: 'آیا او بازی کرد؟'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'comparison',
      title: 'The Important Rule',
      titleFa: 'قانون مهم',
      body: 'Positive: worked. Negative: didn’t work. Question: Did you work? The base verb returns after didn’t and did.',
      bodyFa: 'مثبت: worked. منفی: didn’t work. سؤال: Did you work؟ بعد از didn’t و did، فعل به شکل پایه برمی‌گردد.',
      examples: [
        A1BasicExample(english: 'She worked.', persian: 'او کار کرد.'),
        A1BasicExample(english: 'She didn’t work.', persian: 'او کار نکرد.'),
        A1BasicExample(english: 'Did she work?', persian: 'آیا او کار کرد؟'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'more_examples',
      title: 'More Examples',
      titleFa: 'مثال‌های بیشتر',
      body: 'Notice the finished-time words and the verb forms.',
      bodyFa: 'به کلمه‌های مربوط به زمان گذشته و شکل فعل دقت کن.',
      examples: [
        A1BasicExample(english: 'We cleaned the room yesterday.', persian: 'ما دیروز اتاق را تمیز کردیم.'),
        A1BasicExample(english: 'He watched TV last night.', persian: 'او دیشب تلویزیون تماشا کرد.'),
        A1BasicExample(english: 'They studied English last week.', persian: 'آنها هفته پیش انگلیسی خواندند.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'guided_practice',
      title: 'Guided Practice',
      titleFa: 'تمرین هدایت‌شده',
      body: 'Change a present form into a regular past form, then make a negative or question.',
      bodyFa: 'یک فعل را از حال به گذشته باقاعده تبدیل کن، سپس آن را منفی یا سوالی کن.',
      examples: [
        A1BasicExample(english: 'play → played', persian: 'play → played'),
        A1BasicExample(english: 'study → studied', persian: 'study → studied'),
        A1BasicExample(english: 'stop → stopped', persian: 'stop → stopped'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'independent',
      title: 'Independent Production',
      titleFa: 'تولید مستقل',
      body: 'Make a sentence about something you did yesterday using a regular verb.',
      bodyFa: 'درباره کاری که دیروز انجام دادی با یک فعل باقاعده جمله بساز.',
      examples: [
        A1BasicExample(english: 'I cleaned my room yesterday.', persian: 'من دیروز اتاقم را تمیز کردم.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'real_world',
      title: 'Real-Life Use',
      titleFa: 'کاربرد در دنیای واقعی',
      body: 'Use regular past verbs when telling someone what you did yesterday or last week.',
      bodyFa: 'وقتی درباره کاری که دیروز یا هفته پیش انجام دادی حرف می‌زنی، از افعال باقاعده گذشته استفاده کن.',
      examples: [
        A1BasicExample(english: 'I watched a movie last night.', persian: 'من دیشب یک فیلم تماشا کردم.'),
        A1BasicExample(english: 'We visited our friend yesterday.', persian: 'ما دیروز به دیدن دوستم رفتیم.'),
      ],
    ),
  ],

  vocabulary: [
    A1BasicVocabulary(
      english: 'work',
      persian: 'کار کردن',
      pronunciation: 'وِرک',
      example: 'I work every day.',
    ),
    A1BasicVocabulary(
      english: 'play',
      persian: 'بازی کردن',
      pronunciation: 'پِلِی',
      example: 'They play football.',
    ),
    A1BasicVocabulary(
      english: 'live',
      persian: 'زندگی کردن',
      example: 'They live here.',
    ),
    A1BasicVocabulary(
      english: 'like',
      persian: 'دوست داشتن',
      example: 'I like pizza.',
    ),
    A1BasicVocabulary(
      english: 'study',
      persian: 'درس خواندن',
      example: 'I study English.',
    ),
    A1BasicVocabulary(
      english: 'watch',
      persian: 'تماشا کردن',
      example: 'I watch TV at night.',
    ),
    A1BasicVocabulary(
      english: 'read',
      persian: 'خواندن',
      example: 'He reads books.',
    ),
    A1BasicVocabulary(
      english: 'eat',
      persian: 'خوردن',
      example: 'He eats breakfast.',
    ),
    A1BasicVocabulary(
      english: 'drink',
      persian: 'نوشیدن',
      example: 'He drinks water.',
    ),
    A1BasicVocabulary(
      english: 'sleep',
      persian: 'خوابیدن',
      example: 'He sleeps at night.',
    ),
    A1BasicVocabulary(
      english: 'wash',
      persian: 'شستن',
      example: 'She washes her hands.',
    ),
    A1BasicVocabulary(
      english: 'go',
      persian: 'رفتن',
      example: 'She goes to school.',
    ),
    A1BasicVocabulary(
      english: 'fix',
      persian: 'تعمیر کردن',
      example: 'He fixes the car.',
    ),
    A1BasicVocabulary(
      english: 'pass',
      persian: 'عبور کردن',
      example: 'He passes the house.',
    ),
    A1BasicVocabulary(
      english: 'teach',
      persian: 'آموزش دادن',
      example: 'She teaches English.',
    ),
    A1BasicVocabulary(
      english: 'try',
      persian: 'تلاش کردن',
      example: 'She tries again.',
    ),
    A1BasicVocabulary(
      english: 'cry',
      persian: 'گریه کردن',
      example: 'The baby cries.',
    ),
    A1BasicVocabulary(
      english: 'carry',
      persian: 'حمل کردن',
      example: 'He carries a bag.',
    ),
    A1BasicVocabulary(
      english: 'enjoy',
      persian: 'لذت بردن',
      example: 'She enjoys music.',
    ),
    A1BasicVocabulary(
      english: 'stay',
      persian: 'ماندن',
      example: 'They stay here.',
    ),
    A1BasicVocabulary(
      english: 'clean',
      persian: 'تمیز کردن',
      example: 'She cleans her room every week.',
    ),
    A1BasicVocabulary(
      english: 'walk',
      persian: 'پیاده رفتن / راه رفتن',
      example: 'He walks to school.',
    ),
    A1BasicVocabulary(
      english: 'need',
      persian: 'نیاز داشتن',
      example: 'I need help.',
    ),
    A1BasicVocabulary(
      english: 'want',
      persian: 'خواستن',
      example: 'She wants water.',
    ),
    A1BasicVocabulary(
      english: 'help',
      persian: 'کمک',
      example: 'I need help.',
    ),
  ],

  sections: [
    A1BasicSection(
);