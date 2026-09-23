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
      title: 'What Is the Regular Past?',
      titleFa: 'گذشته ساده با افعال باقاعده چیست؟',
      explanation:
          'Use the simple past to talk about finished actions in the past. Many regular verbs form the past with -ed.',
      explanationFa:
          'از گذشته ساده برای کارهایی استفاده می‌کنیم که در گذشته تمام شده‌اند. بسیاری از افعال باقاعده با افزودن -ed به گذشته تبدیل می‌شوند.',
      examples: [
        A1BasicExample(english: 'I worked yesterday.', persian: 'من دیروز کار کردم.'),
        A1BasicExample(english: 'She played last night.', persian: 'او دیشب بازی کرد.'),
      ],
    ),
    A1BasicSection(
      title: 'The -ed Rule',
      titleFa: 'قانون -ed',
      explanation:
          'For many regular verbs, add -ed to make the past form: work → worked, play → played, clean → cleaned.',
      explanationFa:
          'برای بسیاری از افعال باقاعده، برای ساختن گذشته -ed اضافه می‌کنیم؛ مثل work → worked و play → played.',
      examples: [
        A1BasicExample(english: 'work → worked', persian: 'کار کردن → کار کردم'),
        A1BasicExample(english: 'play → played', persian: 'بازی کردن → بازی کردم'),
        A1BasicExample(english: 'clean → cleaned', persian: 'تمیز کردن → تمیز کردم'),
      ],
    ),
    A1BasicSection(
      title: 'Spelling Changes',
      titleFa: 'تغییرات املایی',
      explanation:
          'Some regular verbs need spelling changes before -ed: live → lived, study → studied, stop → stopped.',
      explanationFa:
          'بعضی افعال باقاعده قبل از -ed تغییر املایی دارند؛ مثل live → lived، study → studied و stop → stopped.',
      examples: [
        A1BasicExample(english: 'live → lived', persian: 'زندگی کردن → زندگی کردم'),
        A1BasicExample(english: 'study → studied', persian: 'درس خواندن → درس خواندم'),
        A1BasicExample(english: 'stop → stopped', persian: 'متوقف شدن → متوقف شدم'),
      ],
    ),
    A1BasicSection(
      title: 'Positive Sentences',
      titleFa: 'جمله‌های مثبت',
      explanation:
          'In positive simple past sentences, use the past form. It does not change with the subject.',
      explanationFa:
          'در جمله‌های مثبت گذشته ساده از شکل گذشته فعل استفاده می‌کنیم و این شکل با فاعل تغییر نمی‌کند.',
      examples: [
        A1BasicExample(english: 'I worked yesterday.', persian: 'من دیروز کار کردم.'),
        A1BasicExample(english: 'She worked yesterday.', persian: 'او دیروز کار کرد.'),
        A1BasicExample(english: 'They played last night.', persian: 'آنها دیشب بازی کردند.'),
      ],
    ),
    A1BasicSection(
      title: 'Negative with Didn’t',
      titleFa: 'منفی با Didn’t',
      explanation:
          'Use didn’t + base verb. The past meaning is carried by didn’t, so do not use the past form after it.',
      explanationFa:
          'از didn’t + شکل پایه فعل استفاده می‌کنیم. معنی گذشته در didn’t وجود دارد، پس بعد از آن شکل گذشته فعل نمی‌آید.',
      examples: [
        A1BasicExample(english: 'I didn’t work yesterday.', persian: 'من دیروز کار نکردم.'),
        A1BasicExample(english: 'She didn’t play.', persian: 'او بازی نکرد.'),
      ],
    ),
    A1BasicSection(
      title: 'Questions with Did',
      titleFa: 'سؤال با Did',
      explanation:
          'Use did + subject + base verb. Do not use the -ed form after did.',
      explanationFa:
          'ساختار سؤال گذشته did + فاعل + شکل پایه فعل است. بعد از did از شکل گذشته استفاده نمی‌کنیم.',
      examples: [
        A1BasicExample(english: 'Did you work yesterday?', persian: 'آیا دیروز کار کردی؟'),
        A1BasicExample(english: 'Did she play?', persian: 'آیا او بازی کرد؟'),
      ],
    ),
    A1BasicSection(
      title: 'Positive, Negative, and Question',
      titleFa: 'مثبت، منفی و پرسشی',
      explanation:
          'Compare the three forms: worked, didn’t work, and did you work? The base verb returns after didn’t and did.',
      explanationFa:
          'سه شکل را مقایسه کن: worked، didn’t work و did you work؟ بعد از didn’t و did، فعل به شکل پایه برمی‌گردد.',
      examples: [
        A1BasicExample(english: 'She worked.', persian: 'او کار کرد.'),
        A1BasicExample(english: 'She didn’t work.', persian: 'او کار نکرد.'),
        A1BasicExample(english: 'Did she work?', persian: 'آیا او کار کرد؟'),
      ],
    ),
    A1BasicSection(
      title: 'Real-Life Use',
      titleFa: 'کاربرد واقعی',
      explanation:
          'Use regular past verbs to talk about what you did yesterday, last night, or last week.',
      explanationFa:
          'از افعال باقاعده گذشته برای صحبت درباره کارهایی که دیروز، دیشب یا هفته پیش انجام دادی استفاده کن.',
      examples: [
        A1BasicExample(english: 'I watched a movie last night.', persian: 'من دیشب یک فیلم تماشا کردم.'),
        A1BasicExample(english: 'We cleaned the room yesterday.', persian: 'ما دیروز اتاق را تمیز کردیم.'),
        A1BasicExample(english: 'They studied English last week.', persian: 'آنها هفته پیش انگلیسی خواندند.'),
      ],
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