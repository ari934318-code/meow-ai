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
      title: 'What Is a Regular Verb?',
      titleFa: 'فعل باقاعده چیست؟',
      explanation:
          'A regular verb follows a predictable pattern. '
          'In the present simple, the base verb is used with I, you, we, and they. '
          'With he, she, and it, the verb usually changes.',
      explanationFa:
          'فعل باقاعده فعلی است که در زمان حال ساده از الگوی قابل پیش‌بینی پیروی می‌کند. با I، you، we و they معمولاً شکل پایه فعل را استفاده می‌کنیم و با he، she و it معمولاً به فعل s، es اضافه می‌کنیم یا در بعضی حالت‌ها y را به ies تغییر می‌دهیم.',
      examples: [
        A1BasicExample(
          english: 'I work every day.',
          persian: 'من هر روز کار می‌کنم.',
          pronunciation: 'آی وِرک اِوری دِی',
        ),
        A1BasicExample(
          english: 'She works every day.',
          persian: 'او هر روز کار می‌کند.',
          pronunciation: 'شی وِرکس اِوری دِی',
        ),
        A1BasicExample(
          english: 'They play football.',
          persian: 'آنها فوتبال بازی می‌کنند.',
        ),
        A1BasicExample(
          english: 'He plays football.',
          persian: 'او فوتبال بازی می‌کند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Base Form',
      titleFa: 'شکل پایه فعل',
      explanation:
          'The base form is the simple dictionary form of a verb, such as work, play, live, like, and study.',
      explanationFa:
          'شکل پایه همان شکل ساده فعل است که معمولاً در فرهنگ لغت می‌بینی؛ مثل work، play، live، like و study. این شکل بعد از I، you، we، they و همچنین بعد از do، does، don’t و doesn’t استفاده می‌شود.',
      examples: [
        A1BasicExample(
          english: 'work',
          persian: 'کار کردن',
        ),
        A1BasicExample(
          english: 'play',
          persian: 'بازی کردن',
        ),
        A1BasicExample(
          english: 'live',
          persian: 'زندگی کردن',
        ),
        A1BasicExample(
          english: 'like',
          persian: 'دوست داشتن',
        ),
        A1BasicExample(
          english: 'study',
          persian: 'درس خواندن',
        ),
        A1BasicExample(
          english: 'watch',
          persian: 'تماشا کردن',
        ),
      ],
    ),

    A1BasicSection(
      title: 'I, You, We, They',
      titleFa: 'I، You، We، They',
      explanation:
          'With I, you, we, and they, use the base form of the verb.',
      explanationFa:
          'با I، you، we و they از شکل پایه فعل استفاده می‌کنیم. در این حالت معمولاً هیچ s یا es به پایان فعل اضافه نمی‌شود.',
      examples: [
        A1BasicExample(
          english: 'I work here.',
          persian: 'من اینجا کار می‌کنم.',
        ),
        A1BasicExample(
          english: 'You work here.',
          persian: 'تو اینجا کار می‌کنی.',
        ),
        A1BasicExample(
          english: 'We work here.',
          persian: 'ما اینجا کار می‌کنیم.',
        ),
        A1BasicExample(
          english: 'They work here.',
          persian: 'آنها اینجا کار می‌کنند.',
        ),
        A1BasicExample(
          english: 'I like pizza.',
          persian: 'من پیتزا دوست دارم.',
        ),
        A1BasicExample(
          english: 'They like pizza.',
          persian: 'آنها پیتزا دوست دارند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'He, She, It',
      titleFa: 'He، She، It',
      explanation:
          'With he, she, and it, the verb usually takes an ending.',
      explanationFa:
          'با he، she و it در جمله مثبت زمان حال ساده، فعل معمولاً یک پسوند می‌گیرد. بسته به پایان فعل، این تغییر می‌تواند s، es یا تغییر y به ies باشد.',
      examples: [
        A1BasicExample(
          english: 'He works here.',
          persian: 'او اینجا کار می‌کند.',
        ),
        A1BasicExample(
          english: 'She works here.',
          persian: 'او اینجا کار می‌کند.',
        ),
        A1BasicExample(
          english: 'It works well.',
          persian: 'آن خوب کار می‌کند.',
        ),
        A1BasicExample(
          english: 'He likes pizza.',
          persian: 'او پیتزا دوست دارد.',
        ),
        A1BasicExample(
          english: 'She plays tennis.',
          persian: 'او تنیس بازی می‌کند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Adding S',
      titleFa: 'اضافه کردن S',
      explanation:
          'For many regular verbs, simply add s with he, she, and it.',
      explanationFa:
          'برای بسیاری از فعل‌های باقاعده، فقط کافی است با he، she و it حرف s را به انتهای فعل اضافه کنیم؛ مثل work → works و play → plays.',
      examples: [
        A1BasicExample(
          english: 'work → works',
          persian: 'کار کردن → کار می‌کند',
        ),
        A1BasicExample(
          english: 'play → plays',
          persian: 'بازی کردن → بازی می‌کند',
        ),
        A1BasicExample(
          english: 'read → reads',
          persian: 'خواندن → می‌خواند',
        ),
        A1BasicExample(
          english: 'eat → eats',
          persian: 'خوردن → می‌خورد',
        ),
        A1BasicExample(
          english: 'drink → drinks',
          persian: 'نوشیدن → می‌نوشد',
        ),
        A1BasicExample(
          english: 'sleep → sleeps',
          persian: 'خوابیدن → می‌خوابد',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Adding ES',
      titleFa: 'اضافه کردن ES',
      explanation:
          'Some verbs ending in s, sh, ch, x, or o usually take es with he, she, and it.',
      explanationFa:
          'بعضی فعل‌ها که به s، sh، ch، x یا o ختم می‌شوند، با he، she و it معمولاً es می‌گیرند. بنابراین watch به watches و go به goes تبدیل می‌شود.',
      examples: [
        A1BasicExample(
          english: 'watch → watches',
          persian: 'تماشا کردن → تماشا می‌کند',
        ),
        A1BasicExample(
          english: 'wash → washes',
          persian: 'شستن → می‌شوید',
        ),
        A1BasicExample(
          english: 'go → goes',
          persian: 'رفتن → می‌رود',
        ),
        A1BasicExample(
          english: 'fix → fixes',
          persian: 'تعمیر کردن → تعمیر می‌کند',
        ),
        A1BasicExample(
          english: 'pass → passes',
          persian: 'عبور کردن → عبور می‌کند',
        ),
        A1BasicExample(
          english: 'teach → teaches',
          persian: 'آموزش دادن → آموزش می‌دهد',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Verbs Ending in Y',
      titleFa: 'فعل‌هایی که به Y ختم می‌شوند',
      explanation:
          'When a verb ends in consonant + y, y usually changes to ies with he, she, and it.',
      explanationFa:
          'اگر فعل به صامت + y ختم شود، در حالت he، she و it معمولاً y به ies تبدیل می‌شود؛ مثل study → studies و try → tries.',
      examples: [
        A1BasicExample(
          english: 'study → studies',
          persian: 'درس خواندن → درس می‌خواند',
        ),
        A1BasicExample(
          english: 'try → tries',
          persian: 'تلاش کردن → تلاش می‌کند',
        ),
        A1BasicExample(
          english: 'cry → cries',
          persian: 'گریه کردن → گریه می‌کند',
        ),
        A1BasicExample(
          english: 'carry → carries',
          persian: 'حمل کردن → حمل می‌کند',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Vowel + Y',
      titleFa: 'حالت مصوت + Y',
      explanation:
          'If a verb ends in a vowel + y, we normally just add s.',
      explanationFa:
          'اگر قبل از y یک حرف صدادار باشد، معمولاً y تغییر نمی‌کند و فقط s اضافه می‌کنیم؛ مثل play → plays و enjoy → enjoys.',
      examples: [
        A1BasicExample(
          english: 'play → plays',
          persian: 'بازی کردن → بازی می‌کند',
        ),
        A1BasicExample(
          english: 'enjoy → enjoys',
          persian: 'لذت بردن → لذت می‌برد',
        ),
        A1BasicExample(
          english: 'stay → stays',
          persian: 'ماندن → می‌ماند',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Positive Sentences',
      titleFa: 'جمله‌های مثبت',
      explanation:
          'A basic positive sentence usually follows subject + verb + object or extra information.',
      explanationFa:
          'جمله مثبت پایه معمولاً از فاعل، فعل و در صورت نیاز مفعول یا اطلاعات تکمیلی تشکیل می‌شود. در جمله مثبت با he، she و it باید شکل مناسب فعل را به کار ببریم.',
      examples: [
        A1BasicExample(
          english: 'I play football.',
          persian: 'من فوتبال بازی می‌کنم.',
        ),
        A1BasicExample(
          english: 'She plays football.',
          persian: 'او فوتبال بازی می‌کند.',
        ),
        A1BasicExample(
          english: 'We watch movies.',
          persian: 'ما فیلم تماشا می‌کنیم.',
        ),
        A1BasicExample(
          english: 'He watches movies.',
          persian: 'او فیلم تماشا می‌کند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Negative Sentences',
      titleFa: 'جمله‌های منفی',
      explanation:
          'Use don’t with I, you, we, and they. Use doesn’t with he, she, and it. '
          'After don’t and doesn’t, use the base form of the verb.',
      explanationFa:
          'برای ساختن جمله منفی در زمان حال ساده، با I، you، we و they از don’t و با he، she و it از doesn’t استفاده می‌کنیم. بعد از don’t و doesn’t، فعل اصلی همیشه به شکل پایه برمی‌گردد.',
      examples: [
        A1BasicExample(
          english: 'I don’t work here.',
          persian: 'من اینجا کار نمی‌کنم.',
        ),
        A1BasicExample(
          english: 'They don’t play tennis.',
          persian: 'آنها تنیس بازی نمی‌کنند.',
        ),
        A1BasicExample(
          english: 'She doesn’t work here.',
          persian: 'او اینجا کار نمی‌کند.',
        ),
        A1BasicExample(
          english: 'He doesn’t play tennis.',
          persian: 'او تنیس بازی نمی‌کند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Questions',
      titleFa: 'سؤال‌ها',
      explanation:
          'Use do with I, you, we, and they. Use does with he, she, and it. '
          'The main verb stays in the base form.',
      explanationFa:
          'برای ساختن سؤال در زمان حال ساده، با I، you، we و they از do و با he، she و it از does استفاده می‌کنیم. بعد از do یا does، فعل اصلی به شکل پایه می‌آید.',
      examples: [
        A1BasicExample(
          english: 'Do you work here?',
          persian: 'اینجا کار می‌کنی؟',
        ),
        A1BasicExample(
          english: 'Do they play football?',
          persian: 'آنها فوتبال بازی می‌کنند؟',
        ),
        A1BasicExample(
          english: 'Does she work here?',
          persian: 'او اینجا کار می‌کند؟',
        ),
        A1BasicExample(
          english: 'Does he play football?',
          persian: 'او فوتبال بازی می‌کند؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Positive vs Negative vs Question',
      titleFa: 'مثبت، منفی و سوالی',
      explanation:
          'Compare all three forms. Notice how the verb changes only in the positive sentence with he, she, or it.',
      explanationFa:
          'این سه شکل را کنار هم مقایسه کن: در جمله مثبت با he، she و it فعل تغییر می‌کند، اما در جمله منفی و سؤال به دلیل وجود doesn’t یا does، فعل اصلی به شکل پایه برمی‌گردد.',
      examples: [
        A1BasicExample(
          english: 'She works here.',
          persian: 'او اینجا کار می‌کند.',
        ),
        A1BasicExample(
          english: 'She doesn’t work here.',
          persian: 'او اینجا کار نمی‌کند.',
        ),
        A1BasicExample(
          english: 'Does she work here?',
          persian: 'آیا او اینجا کار می‌کند؟',
        ),
        A1BasicExample(
          english: 'They work here.',
          persian: 'آنها اینجا کار می‌کنند.',
        ),
        A1BasicExample(
          english: 'They don’t work here.',
          persian: 'آنها اینجا کار نمی‌کنند.',
        ),
        A1BasicExample(
          english: 'Do they work here?',
          persian: 'آیا آنها اینجا کار می‌کنند؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Everyday Regular Verbs',
      titleFa: 'افعال باقاعده روزمره',
      explanation:
          'These verbs are very common in everyday English.',
      explanationFa:
          'این فعل‌ها در مکالمات روزمره بسیار رایج هستند. کلماتی مثل work، study، watch، walk، play، like، need و want را مرتب در انگلیسی واقعی می‌شنوی.',
      examples: [
        A1BasicExample(
          english: 'I work every day.',
          persian: 'من هر روز کار می‌کنم.',
        ),
        A1BasicExample(
          english: 'She studies English.',
          persian: 'او انگلیسی می‌خواند.',
        ),
        A1BasicExample(
          english: 'We watch TV at night.',
          persian: 'ما شب‌ها تلویزیون تماشا می‌کنیم.',
        ),
        A1BasicExample(
          english: 'He walks to school.',
          persian: 'او پیاده به مدرسه می‌رود.',
        ),
        A1BasicExample(
          english: 'They play games.',
          persian: 'آنها بازی می‌کنند.',
        ),
        A1BasicExample(
          english: 'My sister likes music.',
          persian: 'خواهرم موسیقی دوست دارد.',
        ),
        A1BasicExample(
          english: 'I need help.',
          persian: 'من کمک لازم دارم.',
        ),
        A1BasicExample(
          english: 'She wants water.',
          persian: 'او آب می‌خواهد.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Common Mistakes',
      titleFa: 'اشتباهات رایج',
      explanation:
          'The most common mistakes are forgetting s with he, she, and it, '
          'or keeping s after does or doesn’t.',
      explanationFa:
          'اشتباه‌های رایج این بخش معمولاً شامل فراموش کردن s با he، she و it یا نگه داشتن s بعد از does و doesn’t هستند. همیشه بررسی کن فاعل چیست و آیا do، does، don’t یا doesn’t در جمله وجود دارد یا نه.',
      examples: [
        A1BasicExample(
          english: 'She works here. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'She work here. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'Does she work here? ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'Does she works here? ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'He doesn’t like coffee. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'He doesn’t likes coffee. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'They play football. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'They plays football. ✗',
          persian: 'غلط',
        ),
      ],
    ),
  ],

  examples: [
    A1BasicExample(
      english: 'I work every day.',
      persian: 'من هر روز کار می‌کنم.',
    ),
    A1BasicExample(
      english: 'She works every day.',
      persian: 'او هر روز کار می‌کند.',
    ),
    A1BasicExample(
      english: 'They play football.',
      persian: 'آنها فوتبال بازی می‌کنند.',
    ),
    A1BasicExample(
      english: 'He plays football.',
      persian: 'او فوتبال بازی می‌کند.',
    ),
    A1BasicExample(
      english: 'I watch TV at night.',
      persian: 'من شب‌ها تلویزیون تماشا می‌کنم.',
    ),
    A1BasicExample(
      english: 'She watches TV at night.',
      persian: 'او شب‌ها تلویزیون تماشا می‌کند.',
    ),
    A1BasicExample(
      english: 'I study English.',
      persian: 'من انگلیسی می‌خوانم.',
    ),
    A1BasicExample(
      english: 'He studies English.',
      persian: 'او انگلیسی می‌خواند.',
    ),
    A1BasicExample(
      english: 'We don’t work on Friday.',
      persian: 'ما جمعه کار نمی‌کنیم.',
    ),
    A1BasicExample(
      english: 'She doesn’t work on Friday.',
      persian: 'او جمعه کار نمی‌کند.',
    ),
    A1BasicExample(
      english: 'Do you play games?',
      persian: 'بازی می‌کنی؟',
    ),
    A1BasicExample(
      english: 'Does he play games?',
      persian: 'او بازی می‌کند؟',
    ),
  ],

  questions: [
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'I ___ every day.',
      options: ['work', 'works', 'working', 'workes'],
      answer: 'work',
      explanation: 'I uses the base form.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'She ___ every day.',
      options: ['works', 'work', 'working', 'workes'],
      answer: 'works',
      explanation: 'She takes the s form.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'They ___ football.',
      options: ['play', 'plays', 'playing', 'plaies'],
      answer: 'play',
      explanation: 'They uses the base form.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'He ___ football.',
      options: ['plays', 'play', 'playing', 'plaies'],
      answer: 'plays',
      explanation: 'He takes plays.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'She ___ TV at night.',
      options: ['watches', 'watch', 'watchs', 'watching'],
      answer: 'watches',
      explanation: 'Watch takes es with she.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'He ___ to school.',
      options: ['walks', 'walk', 'walkes', 'walking'],
      answer: 'walks',
      explanation: 'Walk simply takes s.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'She ___ English.',
      options: ['studies', 'studys', 'study', 'studyes'],
      answer: 'studies',
      explanation: 'Study changes y to ies.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'They ___ English.',
      options: ['study', 'studies', 'studys', 'studying'],
      answer: 'study',
      explanation: 'They uses the base form.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'He ___ TV.',
      options: ['watches', 'watch', 'watchs', 'watchies'],
      answer: 'watches',
      explanation: 'Watch takes es.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'She ___ her room every week.',
      options: ['cleans', 'clean', 'cleanes', 'cleaning'],
      answer: 'cleans',
      explanation: 'Clean simply takes s.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'She works here.',
        'She work here.',
        'She workes here.',
        'She working here.',
      ],
      answer: 'She works here.',
      explanation: 'She takes the third-person singular form works.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'They work here.',
        'They works here.',
        'They workes here.',
        'They working here.',
      ],
      answer: 'They work here.',
      explanation: 'They uses the base form.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'Does she work here?',
        'Does she works here?',
        'Do she work here?',
        'Does she working here?',
      ],
      answer: 'Does she work here?',
      explanation: 'After does, use the base form.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'He doesn’t like coffee.',
        'He doesn’t likes coffee.',
        'He don’t like coffee.',
        'He not likes coffee.',
      ],
      answer: 'He doesn’t like coffee.',
      explanation: 'After doesn’t, use the base form.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct question.',
      options: [
        'Do they play football?',
        'Does they play football?',
        'Do they plays football?',
        'They do plays football?',
      ],
      answer: 'Do they play football?',
      explanation: 'They uses do + base verb.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct question.',
      options: [
        'Does he watch TV?',
        'Does he watches TV?',
        'Do he watch TV?',
        'Does he watching TV?',
      ],
      answer: 'Does he watch TV?',
      explanation: 'Does + he + base verb is correct.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct negative.',
      options: [
        'She doesn’t study English.',
        'She doesn’t studies English.',
        'She don’t study English.',
        'She not studies English.',
      ],
      answer: 'She doesn’t study English.',
      explanation: 'After doesn’t, use study.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct negative.',
      options: [
        'They don’t play tennis.',
        'They doesn’t play tennis.',
        'They don’t plays tennis.',
        'They not plays tennis.',
      ],
      answer: 'They don’t play tennis.',
      explanation: 'They uses don’t + base verb.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'She works here is correct.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'She takes works.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'They works here is correct.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'They takes work, not works.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'Does he likes coffee? is correct.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'After does, use like.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'She studies English is correct.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'Study changes to studies with she.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'He watches TV is correct.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'Watch takes es.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'He doesn’t works here is correct.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'After doesn’t, use work.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «من هر روز کار می‌کنم.»',
      options: [
        'I work every day.',
        'I works every day.',
        'I working every day.',
        'I workes every day.',
      ],
      answer: 'I work every day.',
      explanation: 'I uses the base form.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «او هر روز کار می‌کند.»',
      options: [
        'She works every day.',
        'She work every day.',
        'She working every day.',
        'She workes every day.',
      ],
      answer: 'She works every day.',
      explanation: 'She takes works.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «او تلویزیون تماشا می‌کند.»',
      options: [
        'He watches TV.',
        'He watch TV.',
        'He watchs TV.',
        'He watching TV.',
      ],
      answer: 'He watches TV.',
      explanation: 'Watch takes es with he.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «او انگلیسی می‌خواند.»',
      options: [
        'She studies English.',
        'She study English.',
        'She studys English.',
        'She studying English.',
      ],
      answer: 'She studies English.',
      explanation: 'Study changes y to ies.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «او قهوه دوست ندارد.»',
      options: [
        'He doesn’t like coffee.',
        'He doesn’t likes coffee.',
        'He don’t like coffee.',
        'He not like coffee.',
      ],
      answer: 'He doesn’t like coffee.',
      explanation: 'After doesn’t, use the base form like.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "works / she / here"',
      options: [
        'She works here.',
        'Works she here.',
        'She here works.',
        'Here works she.',
      ],
      answer: 'She works here.',
      explanation: 'The normal order is subject + verb + extra information.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "football / they / play"',
      options: [
        'They play football.',
        'Play they football.',
        'They football play.',
        'Football play they.',
      ],
      answer: 'They play football.',
      explanation: 'They uses the base form play.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "does / she / work / here"',
      options: [
        'Does she work here?',
        'Does work she here?',
        'She does work here?',
        'Work does she here?',
      ],
      answer: 'Does she work here?',
      explanation: 'Question order is does + subject + base verb.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "doesn’t / he / like / tea"',
      options: [
        'He doesn’t like tea.',
        'Doesn’t he like tea.',
        'He like doesn’t tea.',
        'He doesn’t likes tea.',
      ],
      answer: 'He doesn’t like tea.',
      explanation: 'Negative order is subject + doesn’t + base verb.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which verb becomes "watches"?',
      options: ['watch', 'work', 'play', 'clean'],
      answer: 'watch',
      explanation: 'Watch takes es.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which verb becomes "studies"?',
      options: ['study', 'play', 'work', 'stay'],
      answer: 'study',
      explanation: 'Study changes y to ies.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which one is correct?',
      options: [
        'My sister likes music.',
        'My sister like music.',
        'My sister likeses music.',
        'My sister liking music.',
      ],
      answer: 'My sister likes music.',
      explanation: 'My sister is singular, so use likes.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which one is correct?',
      options: [
        'My friends like music.',
        'My friends likes music.',
        'My friends liking music.',
        'My friends likeses music.',
      ],
      answer: 'My friends like music.',
      explanation: 'Friends is plural, so use the base form.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which one is correct?',
      options: [
        'Does your brother play football?',
        'Does your brother plays football?',
        'Do your brother play football?',
        'Does your brother playing football?',
      ],
      answer: 'Does your brother play football?',
      explanation: 'Your brother is singular, so use does + base verb.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which one is correct?',
      options: [
        'She doesn’t watch TV.',
        'She doesn’t watches TV.',
        'She don’t watch TV.',
        'She not watches TV.',
      ],
      answer: 'She doesn’t watch TV.',
      explanation: 'After doesn’t, use watch.',
    ),
  ],

  speakingQuestions: [
    A1BasicSpeakingQuestion(
      question: 'Say: I work every day.',
      persian: 'بگو: من هر روز کار می‌کنم.',
      acceptableAnswers: [
        'i work every day',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: She works every day.',
      persian: 'بگو: او هر روز کار می‌کند.',
      acceptableAnswers: [
        'she works every day',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: They play football.',
      persian: 'بگو: آنها فوتبال بازی می‌کنند.',
      acceptableAnswers: [
        'they play football',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: He plays football.',
      persian: 'بگو: او فوتبال بازی می‌کند.',
      acceptableAnswers: [
        'he plays football',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: She watches TV.',
      persian: 'بگو: او تلویزیون تماشا می‌کند.',
      acceptableAnswers: [
        'she watches tv',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: He studies English.',
      persian: 'بگو: او انگلیسی می‌خواند.',
      acceptableAnswers: [
        'he studies english',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: I don’t work here.',
      persian: 'بگو: من اینجا کار نمی‌کنم.',
      acceptableAnswers: [
        'i dont work here',
        'i do not work here',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: She doesn’t like coffee.',
      persian: 'بگو: او قهوه دوست ندارد.',
      acceptableAnswers: [
        'she doesnt like coffee',
        'she does not like coffee',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Ask: Do you play football?',
      persian: 'بپرس: فوتبال بازی می‌کنی؟',
      acceptableAnswers: [
        'do you play football',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Ask: Does she work here?',
      persian: 'بپرس: آیا او اینجا کار می‌کند؟',
      acceptableAnswers: [
        'does she work here',
      ],
    ),
  ],
);