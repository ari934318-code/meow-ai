import 'a1_basics_models.dart';

const A1BasicLesson a1BasicToBe = A1BasicLesson(
  id: 'a1_basic_02',
  title: 'To Be: Am, Is, Are',
  titleFa: 'فعل To Be: am, is, are',
  topic: 'am, is, are',
  explanation:
      'The verb "to be" is one of the most important verbs in English. '
      'At A1 level, we mainly use three forms: am, is, and are. '
      'We use them to talk about identity, age, feelings, locations, descriptions, '
      'and many other basic situations.',


  learningPhases: [
    A1BasicLearningPhase(
      type: 'curiosity',
      title: 'Think First',
      titleFa: 'اول یک لحظه فکر کن',
      body: 'Look at this sentence: I ___ happy. What do you think belongs in the blank?\n\nNow notice something important: in English, a sentence like “I happy” is not complete. We need a form of to be.',
      bodyFa: 'این جمله را ببین: I ___ happy. فکر می‌کنی جای خالی با چه کلمه‌ای پر می‌شود؟\n\nیک نکته مهم: در انگلیسی جمله‌ای مثل «I happy» کامل نیست. برای ساختن این جمله به یکی از شکل‌های فعل to be نیاز داریم.',
      examples: [
        A1BasicExample(
          english: 'I ___ happy.',
          persian: 'من خوشحالم.',
          pronunciation: 'آی ... هَپی',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'introduction',
      title: 'What Is To Be?',
      titleFa: 'To Be چیست؟',
      body: 'To be is a basic English verb. In the present tense, it appears as am, is, or are. We use it to connect the subject to information about a person, thing, feeling, or place.',
      bodyFa: 'to be یکی از فعل‌های پایه و بسیار مهم انگلیسی است. در زمان حال، شکل‌های اصلی آن am، is و are هستند. از آن برای وصل کردن فاعل به اطلاعاتی درباره یک شخص، چیز، احساس یا مکان استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'I am happy.',
          persian: 'من خوشحالم.',
          pronunciation: 'آی اَم هَپی',
        ),
        A1BasicExample(
          english: 'He is tall.',
          persian: 'او قدبلند است.',
          pronunciation: 'هی ایز تال',
        ),
        A1BasicExample(
          english: 'They are here.',
          persian: 'آنها اینجا هستند.',
          pronunciation: 'ذِی آر هیر',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'Simple Examples',
      titleFa: 'مثال‌های ساده',
      body: 'First, notice the pattern in complete sentences. The subject comes first, then the correct form of to be.',
      bodyFa: 'اول الگو را در جمله‌های کامل ببین. ابتدا فاعل می‌آید و بعد شکل مناسب فعل to be قرار می‌گیرد.',
      examples: [
        A1BasicExample(english: 'I am a student.', persian: 'من دانش‌آموز / دانشجو هستم.', pronunciation: 'آی اَم ا اِستودِنت'),
        A1BasicExample(english: 'She is happy.', persian: 'او خوشحال است.', pronunciation: 'شی ایز هَپی'),
        A1BasicExample(english: 'We are friends.', persian: 'ما دوست هستیم.', pronunciation: 'وی آر فِرِندز'),
        A1BasicExample(english: 'It is cold.', persian: 'هوا سرد است.', pronunciation: 'اِت ایز کُلد'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'why',
      title: 'Why Do We Need To Be?',
      titleFa: 'چرا به To Be نیاز داریم؟',
      body: 'English normally needs a verb in a complete sentence. Persian can say «من خوشحالم» without a separate word that looks like am, but English needs it: I am happy.',
      bodyFa: 'در انگلیسی معمولاً یک جمله کامل به فعل نیاز دارد. فارسی می‌تواند «من خوشحالم» را بدون کلمه‌ای شبیه am بنویسد، اما انگلیسی به آن نیاز دارد: I am happy.',
      examples: [
        A1BasicExample(english: 'I happy. ✗', persian: 'غلط'),
        A1BasicExample(english: 'I am happy. ✓', persian: 'درست'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'chart',
      title: 'The Am, Is, Are Chart',
      titleFa: 'جدول Am، Is و Are',
      body: 'Learn the core pattern. You will use it again and again when building basic English sentences.',
      bodyFa: 'این الگوی اصلی را یاد بگیر. هنگام ساختن جمله‌های پایه انگلیسی بارها از آن استفاده می‌کنی.',
      tableRows: [
        ['I', 'am'],
        ['You', 'are'],
        ['He', 'is'],
        ['She', 'is'],
        ['It', 'is'],
        ['We', 'are'],
        ['They', 'are'],
      ],
    ),
    A1BasicLearningPhase(
      type: 'persian_note',
      title: 'A Persian Contrast',
      titleFa: 'نکته مهم برای فارسی‌زبان‌ها',
      body: 'Persian and English do not build these sentences in exactly the same way. Persian often hides the present form of “to be” inside the ending, but English keeps am, is, or are visible.',
      bodyFa: 'فارسی و انگلیسی این جمله‌ها را دقیقاً به یک شکل نمی‌سازند. در فارسی «هستم، هستی، است...» معمولاً در پایان یا ساختار جمله می‌آید، اما در انگلیسی am، is یا are باید در جمله دیده شود.',
      examples: [
        A1BasicExample(english: 'من خوشحالم → I am happy.', persian: 'در انگلیسی am را حذف نمی‌کنیم.'),
        A1BasicExample(english: 'او پزشک است → He is a doctor.', persian: 'برای یک شخص مذکر از he + is استفاده می‌کنیم.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'more_examples',
      title: 'More Sentence Patterns',
      titleFa: 'الگوهای بیشتر',
      body: 'To be can be followed by a noun, an adjective, or location information.',
      bodyFa: 'بعد از to be می‌توانیم اطلاعاتی درباره اسم، صفت یا مکان بیاوریم.',
      examples: [
        A1BasicExample(english: 'I am a student.', persian: 'من دانش‌آموز / دانشجو هستم.'),
        A1BasicExample(english: 'She is a teacher.', persian: 'او معلم است.'),
        A1BasicExample(english: 'He is tall.', persian: 'او قدبلند است.'),
        A1BasicExample(english: 'We are at home.', persian: 'ما در خانه هستیم.'),
        A1BasicExample(english: 'They are outside.', persian: 'آنها بیرون هستند.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'negative',
      title: 'Making Negative Sentences',
      titleFa: 'ساختن جمله‌های منفی',
      body: 'To make a negative sentence, put not after am, is, or are.',
      bodyFa: 'برای منفی کردن جمله، کلمه not را بعد از am، is یا are می‌آوریم.',
      examples: [
        A1BasicExample(english: 'I am not tired.', persian: 'من خسته نیستم.', pronunciation: 'آی اَم نات تایِرد'),
        A1BasicExample(english: 'She is not busy.', persian: 'او مشغول نیست.', pronunciation: 'شی ایز نات بیزی'),
        A1BasicExample(english: 'They are not ready.', persian: 'آنها آماده نیستند.', pronunciation: 'ذِی آر نات رِدی'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'contractions',
      title: 'Everyday Short Forms',
      titleFa: 'شکل‌های کوتاه روزمره',
      body: 'In everyday English, contractions are very common. I am becomes I’m, she is becomes she’s, and they are becomes they’re. Negative contractions are common too.',
      bodyFa: 'در انگلیسی روزمره شکل‌های کوتاه بسیار رایج‌اند. I am به I’m، she is به she’s و they are به they’re تبدیل می‌شود. شکل‌های کوتاه منفی هم در مکالمه زیاد استفاده می‌شوند.',
      examples: [
        A1BasicExample(english: 'I am → I’m', persian: 'من هستم', pronunciation: 'آی اَم → آیم'),
        A1BasicExample(english: 'She is → She’s', persian: 'او است', pronunciation: 'شی ایز → شیز'),
        A1BasicExample(english: 'They are → They’re', persian: 'آنها هستند', pronunciation: 'ذِی آر → ذِیر'),
        A1BasicExample(english: 'I am not → I’m not', persian: 'من نیستم', pronunciation: 'آی اَم نات → آیم نات'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'questions',
      title: 'Questions with To Be',
      titleFa: 'سؤال ساختن با To Be',
      body: 'To make a question, move am, is, or are before the subject: You are okay. → Are you okay?',
      bodyFa: 'برای ساختن سؤال، am، is یا are را قبل از فاعل می‌آوریم: You are okay. → Are you okay?',
      examples: [
        A1BasicExample(english: 'Are you okay?', persian: 'خوبی؟', pronunciation: 'آر یو اوکِی'),
        A1BasicExample(english: 'Is she at home?', persian: 'آیا او در خانه است؟', pronunciation: 'ایز شی اَت هوم'),
        A1BasicExample(english: 'Are they ready?', persian: 'آیا آنها آماده‌اند؟', pronunciation: 'آر ذِی رِدی'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'short_answers',
      title: 'Short Answers',
      titleFa: 'جواب‌های کوتاه',
      body: 'Short answers keep the correct form of to be. For example: Are you tired? → Yes, I am. / No, I’m not.',
      bodyFa: 'در جواب‌های کوتاه، شکل درست to be حفظ می‌شود. مثلاً: Are you tired? → Yes, I am. / No, I’m not.',
      examples: [
        A1BasicExample(english: 'Are you tired? — Yes, I am.', persian: 'خسته‌ای؟ — بله.'),
        A1BasicExample(english: 'Are you tired? — No, I’m not.', persian: 'خسته‌ای؟ — نه.'),
        A1BasicExample(english: 'Is she your sister? — Yes, she is.', persian: 'او خواهرت است؟ — بله.'),
        A1BasicExample(english: 'Are they ready? — Yes, they are.', persian: 'آنها آماده‌اند؟ — بله.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'guided_practice',
      title: 'Guided Practice',
      titleFa: 'تمرین هدایت‌شده',
      body: 'Before you build sentences alone, complete the pattern with the correct form of to be.',
      bodyFa: 'قبل از اینکه خودت جمله بسازی، الگو را با شکل درست فعل to be کامل کن.',
      examples: [
        A1BasicExample(english: 'I ___ happy. → am', persian: 'من خوشحالم.'),
        A1BasicExample(english: 'She ___ a teacher. → is', persian: 'او معلم است.'),
        A1BasicExample(english: 'They ___ friends. → are', persian: 'آنها دوست هستند.'),
        A1BasicExample(english: 'It ___ cold. → is', persian: 'هوا سرد است.'),
        A1BasicExample(english: 'You ___ kind. → are', persian: 'تو مهربانی.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'independent',
      title: 'Independent Production',
      titleFa: 'تولید مستقل',
      body: 'Now make your own sentences. Start with a simple subject and choose am, is, or are yourself.',
      bodyFa: 'حالا خودت جمله بساز. با یک فاعل ساده شروع کن و خودت am، is یا are مناسب را انتخاب کن.',
      examples: [
        A1BasicExample(english: 'I am ______.', persian: 'مثلاً: I am happy.'),
        A1BasicExample(english: 'She is ______.', persian: 'مثلاً: She is tired.'),
        A1BasicExample(english: 'They are ______.', persian: 'مثلاً: They are ready.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'real_world',
      title: 'Real-Life Use',
      titleFa: 'کاربرد واقعی',
      body: 'Now notice how to be appears in everyday English. These are useful phrases you will actually hear and use.',
      bodyFa: 'حالا ببین to be در انگلیسی روزمره چطور استفاده می‌شود. این‌ها عبارت‌هایی هستند که واقعاً زیاد می‌شنوی و استفاده می‌کنی.',
      examples: [
        A1BasicExample(english: 'I’m hungry.', persian: 'گرسنه‌ام.', pronunciation: 'آیم هانگری'),
        A1BasicExample(english: 'I’m tired.', persian: 'خسته‌ام.', pronunciation: 'آیم تایِرد'),
        A1BasicExample(english: 'Are you okay?', persian: 'خوبی؟', pronunciation: 'آر یو اوکِی'),
        A1BasicExample(english: 'I’m fine.', persian: 'خوبم.', pronunciation: 'آیم فاین'),
        A1BasicExample(english: 'We’re late.', persian: 'ما دیر کرده‌ایم.', pronunciation: 'ویر لِیت'),
      ],
    ),
  ],

  vocabulary: [
    A1BasicVocabulary(
      english: 'happy',
      persian: 'خوشحال',
      pronunciation: 'هَپی',
      example: 'I am happy.',
    ),
    A1BasicVocabulary(
      english: 'tired',
      persian: 'خسته',
      pronunciation: 'تایِرد',
      example: 'I am tired.',
    ),
    A1BasicVocabulary(
      english: 'student',
      persian: 'دانش‌آموز / دانشجو',
      pronunciation: 'اِستودِنت',
      example: 'I am a student.',
    ),
    A1BasicVocabulary(
      english: 'home',
      persian: 'خانه',
      pronunciation: 'هوم',
      example: 'I am at home.',
    ),
    A1BasicVocabulary(
      english: 'Iran',
      persian: 'ایران',
      pronunciation: 'ایران',
      example: 'I am from Iran.',
    ),
    A1BasicVocabulary(
      english: 'tall',
      persian: 'قدبلند',
      pronunciation: 'تال',
      example: 'He is tall.',
    ),
    A1BasicVocabulary(
      english: 'doctor',
      persian: 'پزشک',
      pronunciation: 'داکتِر',
      example: 'He is a doctor.',
    ),
    A1BasicVocabulary(
      english: 'phone',
      persian: 'گوشی / تلفن',
      pronunciation: 'فون',
      example: 'The phone is new.',
    ),
    A1BasicVocabulary(
      english: 'new',
      persian: 'جدید',
      pronunciation: 'نیو',
      example: 'The phone is new.',
    ),
    A1BasicVocabulary(
      english: 'nice',
      persian: 'مهربان / خوب',
      pronunciation: 'نایس',
      example: 'You are nice.',
    ),
    A1BasicVocabulary(
      english: 'friends',
      persian: 'دوستان',
      pronunciation: 'فِرِندز',
      example: 'We are friends.',
    ),
    A1BasicVocabulary(
      english: 'busy',
      persian: 'مشغول / سرشلوغ',
      pronunciation: 'بیزی',
      example: 'They are busy.',
    ),
    A1BasicVocabulary(
      english: 'late',
      persian: 'دیر',
      pronunciation: 'لِیت',
      example: 'You are late.',
    ),
    A1BasicVocabulary(
      english: 'ready',
      persian: 'آماده',
      pronunciation: 'رِدی',
      example: 'We are ready.',
    ),
    A1BasicVocabulary(
      english: 'teacher',
      persian: 'معلم',
      pronunciation: 'تیچِر',
      example: 'She is a teacher.',
    ),
    A1BasicVocabulary(
      english: 'sister',
      persian: 'خواهر',
      pronunciation: 'سیستِر',
      example: 'She is my sister.',
    ),
    A1BasicVocabulary(
      english: 'beautiful',
      persian: 'زیبا',
      pronunciation: 'بیوتیفُل',
      example: 'She is beautiful.',
    ),
    A1BasicVocabulary(
      english: 'expensive',
      persian: 'گران',
      pronunciation: 'اِکسپِنسیو',
      example: 'It is expensive.',
    ),
    A1BasicVocabulary(
      english: 'school',
      persian: 'مدرسه',
      pronunciation: 'اسکول',
      example: 'He is at school.',
    ),
    A1BasicVocabulary(
      english: 'work',
      persian: 'محل کار / کار',
      pronunciation: 'وِرک',
      example: 'She is at work.',
    ),
    A1BasicVocabulary(
      english: 'kitchen',
      persian: 'آشپزخانه',
      pronunciation: 'کیچِن',
      example: 'We are in the kitchen.',
    ),
    A1BasicVocabulary(
      english: 'outside',
      persian: 'بیرون',
      pronunciation: 'اَوتساید',
      example: 'They are outside.',
    ),
    A1BasicVocabulary(
      english: 'hungry',
      persian: 'گرسنه',
      pronunciation: 'هانگری',
      example: 'I’m hungry.',
    ),
    A1BasicVocabulary(
      english: 'okay',
      persian: 'خوب / اوکی',
      pronunciation: 'اوکِی',
      example: 'Are you okay?',
    ),
    A1BasicVocabulary(
      english: 'fine',
      persian: 'خوب',
      pronunciation: 'فاین',
      example: 'I’m fine.',
    ),
  ],

  sections: [
    A1BasicSection(
      title: 'What is To Be?',
      titleFa: 'To Be یعنی چه؟',
      explanation:
          'To be is a basic English verb. In the present tense, it changes depending '
          'on the subject. The three forms are am, is, and are.',
      explanationFa:
          'فعل to be یکی از مهم‌ترین فعل‌های پایه در انگلیسی است. در زمان حال، بسته به فاعل به سه شکل am، is و are استفاده می‌شود. در این درس یاد می‌گیری چه زمانی از هرکدام استفاده کنی.',
      examples: [
        A1BasicExample(
          english: 'I am a student.',
          persian: 'من دانش‌آموز / دانشجو هستم.',
          pronunciation: 'آی اَم ا اِستودِنت',
        ),
        A1BasicExample(
          english: 'She is happy.',
          persian: 'او خوشحال است.',
          pronunciation: 'شی ایز هَپی',
        ),
        A1BasicExample(
          english: 'They are ready.',
          persian: 'آنها آماده هستند.',
          pronunciation: 'ذِی آر رِدی',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Am',
      titleFa: 'Am',
      explanation:
          'We use am only with the subject I. '
          'Never use am with he, she, it, we, you, or they.',
      explanationFa:
          'از am فقط با فاعل I استفاده می‌کنیم. یعنی می‌گوییم I am، اما با he، she، it، we، you و they از am استفاده نمی‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'I am happy.',
          persian: 'من خوشحالم.',
          pronunciation: 'آی اَم هَپی',
        ),
        A1BasicExample(
          english: 'I am tired.',
          persian: 'من خسته‌ام.',
          pronunciation: 'آی اَم تایِرد',
        ),
        A1BasicExample(
          english: 'I am a student.',
          persian: 'من دانش‌آموز / دانشجو هستم.',
          pronunciation: 'آی اَم ا اِستودِنت',
        ),
        A1BasicExample(
          english: 'I am at home.',
          persian: 'من در خانه هستم.',
          pronunciation: 'آی اَم اَت هوم',
        ),
        A1BasicExample(
          english: 'I am from Iran.',
          persian: 'من اهل ایران هستم.',
          pronunciation: 'آی اَم فرام ایران',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Is',
      titleFa: 'Is',
      explanation:
          'We use is with he, she, and it. '
          'We also use is with one person, one thing, or one name.',
      explanationFa:
          'از is با he، she و it استفاده می‌کنیم. همچنین وقتی درباره یک نفر، یک چیز یا یک اسم مفرد صحبت می‌کنیم، معمولاً از is استفاده می‌شود.',
      examples: [
        A1BasicExample(
          english: 'He is tall.',
          persian: 'او قدبلند است.',
          pronunciation: 'هی ایز تال',
        ),
        A1BasicExample(
          english: 'She is happy.',
          persian: 'او خوشحال است.',
          pronunciation: 'شی ایز هَپی',
        ),
        A1BasicExample(
          english: 'It is cold.',
          persian: 'هوا سرد است.',
          pronunciation: 'اِت ایز کُلد',
        ),
        A1BasicExample(
          english: 'Ali is my brother.',
          persian: 'علی برادر من است.',
          pronunciation: 'علی ایز مای برادِر',
        ),
        A1BasicExample(
          english: 'The phone is new.',
          persian: 'گوشی جدید است.',
          pronunciation: 'دِ فون ایز نیو',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Are',
      titleFa: 'Are',
      explanation:
          'We use are with you, we, and they. '
          'We also use are with plural nouns, meaning two or more people or things.',
      explanationFa:
          'از are با you، we و they استفاده می‌کنیم. همچنین برای اسم‌های جمع، یعنی دو یا چند نفر یا چیز، از are استفاده می‌شود.',
      examples: [
        A1BasicExample(
          english: 'You are nice.',
          persian: 'تو مهربانی.',
          pronunciation: 'یو آر نایس',
        ),
        A1BasicExample(
          english: 'We are friends.',
          persian: 'ما دوست هستیم.',
          pronunciation: 'وی آر فِرِندز',
        ),
        A1BasicExample(
          english: 'They are busy.',
          persian: 'آنها سرشان شلوغ است.',
          pronunciation: 'ذِی آر بیزی',
        ),
        A1BasicExample(
          english: 'The books are new.',
          persian: 'کتاب‌ها جدید هستند.',
          pronunciation: 'دِ بوکس آر نیو',
        ),
        A1BasicExample(
          english: 'You are late.',
          persian: 'تو دیر کردی.',
          pronunciation: 'یو آر لِیت',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Am, Is, Are Chart',
      titleFa: 'جدول Am، Is و Are',
      explanation:
          'Memorize this basic pattern. It will help you build many English sentences.',
      explanationFa:
          'این الگوی پایه را خوب یاد بگیر، چون یکی از مهم‌ترین الگوهای ساخت جمله در انگلیسی است. با یاد گرفتن ارتباط فاعل و am، is و are می‌توانی جمله‌های زیادی بسازی.',
      examples: [
        A1BasicExample(
          english: 'I → am',
          persian: 'من → هستم',
        ),
        A1BasicExample(
          english: 'He → is',
          persian: 'او، مذکر → است',
        ),
        A1BasicExample(
          english: 'She → is',
          persian: 'او، مؤنث → است',
        ),
        A1BasicExample(
          english: 'It → is',
          persian: 'آن / این → است',
        ),
        A1BasicExample(
          english: 'You → are',
          persian: 'تو / شما → هستی / هستید',
        ),
        A1BasicExample(
          english: 'We → are',
          persian: 'ما → هستیم',
        ),
        A1BasicExample(
          english: 'They → are',
          persian: 'آنها → هستند',
        ),
      ],
    ),

    A1BasicSection(
      title: 'To Be + Noun',
      titleFa: 'To Be + اسم',
      explanation:
          'We can use am, is, or are before a noun to say who someone is or what something is.',
      explanationFa:
          'می‌توانیم am، is یا are را قبل از اسم بیاوریم تا بگوییم یک نفر چه کسی است یا یک چیز چیست. در این ساختار، اسم بعد از فعل to be اطلاعاتی درباره فاعل می‌دهد.',
      examples: [
        A1BasicExample(
          english: 'I am a student.',
          persian: 'من دانش‌آموز / دانشجو هستم.',
        ),
        A1BasicExample(
          english: 'He is a doctor.',
          persian: 'او پزشک است.',
        ),
        A1BasicExample(
          english: 'She is my sister.',
          persian: 'او خواهر من است.',
        ),
        A1BasicExample(
          english: 'We are friends.',
          persian: 'ما دوست هستیم.',
        ),
        A1BasicExample(
          english: 'They are teachers.',
          persian: 'آنها معلم هستند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'To Be + Adjective',
      titleFa: 'To Be + صفت',
      explanation:
          'We use to be before an adjective to describe a person, thing, or situation.',
      explanationFa:
          'وقتی می‌خواهیم یک شخص، چیز یا موقعیت را توصیف کنیم، می‌توانیم از to be قبل از صفت استفاده کنیم؛ مثل happy، tired، tall یا expensive.',
      examples: [
        A1BasicExample(
          english: 'I am tired.',
          persian: 'من خسته‌ام.',
        ),
        A1BasicExample(
          english: 'You are kind.',
          persian: 'تو مهربانی.',
        ),
        A1BasicExample(
          english: 'He is tall.',
          persian: 'او قدبلند است.',
        ),
        A1BasicExample(
          english: 'She is beautiful.',
          persian: 'او زیباست.',
        ),
        A1BasicExample(
          english: 'It is expensive.',
          persian: 'آن گران است.',
        ),
        A1BasicExample(
          english: 'We are ready.',
          persian: 'ما آماده‌ایم.',
        ),
        A1BasicExample(
          english: 'They are busy.',
          persian: 'آنها مشغول هستند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'To Be + Location',
      titleFa: 'To Be + مکان',
      explanation:
          'We use am, is, and are to say where someone or something is.',
      explanationFa:
          'از am، is و are می‌توانیم برای گفتن محل قرار داشتن یک شخص یا چیز استفاده کنیم. بعد از to be معمولاً اطلاعات مربوط به مکان می‌آید.',
      examples: [
        A1BasicExample(
          english: 'I am at home.',
          persian: 'من خانه هستم.',
        ),
        A1BasicExample(
          english: 'He is at school.',
          persian: 'او در مدرسه است.',
        ),
        A1BasicExample(
          english: 'She is at work.',
          persian: 'او سر کار است.',
        ),
        A1BasicExample(
          english: 'We are in the kitchen.',
          persian: 'ما در آشپزخانه هستیم.',
        ),
        A1BasicExample(
          english: 'They are outside.',
          persian: 'آنها بیرون هستند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Negative Sentences',
      titleFa: 'جمله‌های منفی',
      explanation:
          'To make a negative sentence with to be, put "not" after am, is, or are.',
      explanationFa:
          'برای منفی کردن جمله با to be، کلمه not را بعد از am، is یا are قرار می‌دهیم. مثلاً I am not tired یعنی «من خسته نیستم».',
      examples: [
        A1BasicExample(
          english: 'I am not tired.',
          persian: 'من خسته نیستم.',
          pronunciation: 'آی اَم نات تایِرد',
        ),
        A1BasicExample(
          english: 'He is not here.',
          persian: 'او اینجا نیست.',
          pronunciation: 'هی ایز نات هیر',
        ),
        A1BasicExample(
          english: 'She is not busy.',
          persian: 'او مشغول نیست.',
          pronunciation: 'شی ایز نات بیزی',
        ),
        A1BasicExample(
          english: 'We are not ready.',
          persian: 'ما آماده نیستیم.',
          pronunciation: 'وی آر نات رِدی',
        ),
        A1BasicExample(
          english: 'They are not at home.',
          persian: 'آنها خانه نیستند.',
          pronunciation: 'ذِی آر نات اَت هوم',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Negative Contractions',
      titleFa: 'شکل کوتاه جمله‌های منفی',
      explanation:
          'In everyday English, native speakers often use contractions.',
      explanationFa:
          'در انگلیسی روزمره، شکل‌های کوتاه بسیار رایج هستند. مثلاً is not به isn’t و are not به aren’t تبدیل می‌شود. این شکل‌ها مخصوصاً در مکالمه زیاد استفاده می‌شوند.',
      examples: [
        A1BasicExample(
          english: 'I am not → I’m not',
          persian: 'من نیستم',
          pronunciation: 'آیم نات',
        ),
        A1BasicExample(
          english: 'He is not → He isn’t',
          persian: 'او نیست',
          pronunciation: 'هی ایزِنت',
        ),
        A1BasicExample(
          english: 'She is not → She isn’t',
          persian: 'او نیست',
          pronunciation: 'شی ایزِنت',
        ),
        A1BasicExample(
          english: 'It is not → It isn’t',
          persian: 'آن / این نیست',
          pronunciation: 'اِت ایزِنت',
        ),
        A1BasicExample(
          english: 'You are not → You aren’t',
          persian: 'تو / شما نیستی / نیستید',
          pronunciation: 'یو آرِنت',
        ),
        A1BasicExample(
          english: 'We are not → We aren’t',
          persian: 'ما نیستیم',
          pronunciation: 'وی آرِنت',
        ),
        A1BasicExample(
          english: 'They are not → They aren’t',
          persian: 'آنها نیستند',
          pronunciation: 'ذِی آرِنت',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Questions with To Be',
      titleFa: 'سوالی کردن با To Be',
      explanation:
          'To make a question with am, is, or are, move the verb before the subject.',
      explanationFa:
          'برای ساختن سؤال با to be، am، is یا are را قبل از فاعل می‌آوریم. مثلاً You are okay به Are you okay? تبدیل می‌شود.',
      examples: [
        A1BasicExample(
          english: 'Am I late?',
          persian: 'آیا من دیر کرده‌ام؟',
        ),
        A1BasicExample(
          english: 'Are you okay?',
          persian: 'خوبی؟',
        ),
        A1BasicExample(
          english: 'Is he your brother?',
          persian: 'آیا او برادر توست؟',
        ),
        A1BasicExample(
          english: 'Is she at home?',
          persian: 'آیا او خانه است؟',
        ),
        A1BasicExample(
          english: 'Is it expensive?',
          persian: 'آیا آن گران است؟',
        ),
        A1BasicExample(
          english: 'Are we ready?',
          persian: 'آیا ما آماده‌ایم؟',
        ),
        A1BasicExample(
          english: 'Are they busy?',
          persian: 'آیا آنها مشغول هستند؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Short Answers',
      titleFa: 'جواب‌های کوتاه',
      explanation:
          'Questions with to be often have short answers. '
          'Remember that positive and negative answers use different forms.',
      explanationFa:
          'سؤال‌هایی که با to be ساخته می‌شوند، معمولاً جواب کوتاه دارند. در جواب مثبت و منفی باید شکل مناسب فعل to be را حفظ کنیم؛ مثلاً Yes, I am و No, I’m not.',
      examples: [
        A1BasicExample(
          english: 'Are you tired? — Yes, I am.',
          persian: 'خسته‌ای؟ — بله.',
        ),
        A1BasicExample(
          english: 'Are you tired? — No, I’m not.',
          persian: 'خسته‌ای؟ — نه، نیستم.',
        ),
        A1BasicExample(
          english: 'Is she your sister? — Yes, she is.',
          persian: 'او خواهرت است؟ — بله.',
        ),
        A1BasicExample(
          english: 'Is he at home? — No, he isn’t.',
          persian: 'او خانه است؟ — نه.',
        ),
        A1BasicExample(
          english: 'Are they ready? — Yes, they are.',
          persian: 'آنها آماده‌اند؟ — بله.',
        ),
        A1BasicExample(
          english: 'Are we late? — No, we aren’t.',
          persian: 'ما دیر کرده‌ایم؟ — نه.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Common Contractions',
      titleFa: 'شکل‌های کوتاه رایج',
      explanation:
          'Contractions are very common in spoken English and informal writing.',
      explanationFa:
          'شکل‌های کوتاه در مکالمه انگلیسی و نوشتار غیررسمی بسیار رایج هستند. یادگیری آن‌ها باعث می‌شود انگلیسی واقعی و روزمره را بهتر بفهمی و طبیعی‌تر صحبت کنی.',
      examples: [
        A1BasicExample(
          english: 'I am → I’m',
          persian: 'من هستم',
          pronunciation: 'آیم',
        ),
        A1BasicExample(
          english: 'You are → You’re',
          persian: 'تو / شما هستی / هستید',
          pronunciation: 'یور',
        ),
        A1BasicExample(
          english: 'He is → He’s',
          persian: 'او است',
          pronunciation: 'هیز',
        ),
        A1BasicExample(
          english: 'She is → She’s',
          persian: 'او است',
          pronunciation: 'شیز',
        ),
        A1BasicExample(
          english: 'It is → It’s',
          persian: 'آن / این است',
          pronunciation: 'اِتس',
        ),
        A1BasicExample(
          english: 'We are → We’re',
          persian: 'ما هستیم',
          pronunciation: 'ویر',
        ),
        A1BasicExample(
          english: 'They are → They’re',
          persian: 'آنها هستند',
          pronunciation: 'ذِیر',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Common Mistakes',
      titleFa: 'اشتباهات رایج',
      explanation:
          'These mistakes are especially common for beginners. '
          'Always check which subject you are using.',
      explanationFa:
          'این اشتباهات برای زبان‌آموزان مبتدی بسیار رایج هستند. هر بار قبل از انتخاب am، is یا are بررسی کن فاعل جمله چیست.',
      examples: [
        A1BasicExample(
          english: 'I am happy. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'I is happy. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'She is tired. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'She are tired. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'They are ready. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'They is ready. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'You are nice. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'You is nice. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'We are friends. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'We is friends. ✗',
          persian: 'غلط',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Real-Life Examples',
      titleFa: 'مثال‌های واقعی روزمره',
      explanation:
          'These sentences are useful in everyday conversations.',
      explanationFa:
          'این جمله‌ها نمونه‌هایی از کاربرد واقعی to be در مکالمات روزمره هستند. عبارت‌هایی مثل I’m hungry، I’m tired و Are you okay? را زیاد در زندگی واقعی می‌شنوی و استفاده می‌کنی.',
      examples: [
        A1BasicExample(
          english: 'I’m hungry.',
          persian: 'گرسنه‌ام.',
          pronunciation: 'آیم هانگری',
        ),
        A1BasicExample(
          english: 'I’m tired.',
          persian: 'خسته‌ام.',
          pronunciation: 'آیم تایِرد',
        ),
        A1BasicExample(
          english: 'I’m ready.',
          persian: 'آماده‌ام.',
          pronunciation: 'آیم رِدی',
        ),
        A1BasicExample(
          english: 'Are you okay?',
          persian: 'خوبی؟',
          pronunciation: 'آر یو اوکِی',
        ),
        A1BasicExample(
          english: 'I’m fine.',
          persian: 'خوبم.',
          pronunciation: 'آیم فاین',
        ),
        A1BasicExample(
          english: 'He’s busy right now.',
          persian: 'او الان سرش شلوغ است.',
          pronunciation: 'هیز بیزی رایت ناو',
        ),
        A1BasicExample(
          english: 'She’s at work.',
          persian: 'او سر کار است.',
          pronunciation: 'شیز اَت وِرک',
        ),
        A1BasicExample(
          english: 'We’re late.',
          persian: 'ما دیر کرده‌ایم.',
          pronunciation: 'ویر لِیت',
        ),
        A1BasicExample(
          english: 'They’re outside.',
          persian: 'آنها بیرون هستند.',
          pronunciation: 'ذِیر اَوتساید',
        ),
        A1BasicExample(
          english: 'It’s cold today.',
          persian: 'امروز هوا سرد است.',
          pronunciation: 'اِتس کُلد تودِی',
        ),
      ],
    ),
  ],

  examples: [
    A1BasicExample(
      english: 'I am happy.',
      persian: 'من خوشحالم.',
      pronunciation: 'آی اَم هَپی',
    ),
    A1BasicExample(
      english: 'I am from Iran.',
      persian: 'من اهل ایران هستم.',
      pronunciation: 'آی اَم فرام ایران',
    ),
    A1BasicExample(
      english: 'You are my friend.',
      persian: 'تو دوست من هستی.',
      pronunciation: 'یو آر مای فِرِند',
    ),
    A1BasicExample(
      english: 'He is my brother.',
      persian: 'او برادر من است.',
      pronunciation: 'هی ایز مای برادِر',
    ),
    A1BasicExample(
      english: 'She is my sister.',
      persian: 'او خواهر من است.',
      pronunciation: 'شی ایز مای سیستِر',
    ),
    A1BasicExample(
      english: 'It is very cute.',
      persian: 'خیلی بامزه است.',
      pronunciation: 'اِت ایز وِری کیوت',
    ),
    A1BasicExample(
      english: 'We are students.',
      persian: 'ما دانش‌آموز / دانشجو هستیم.',
      pronunciation: 'وی آر اِستودِنتس',
    ),
    A1BasicExample(
      english: 'They are at school.',
      persian: 'آنها در مدرسه هستند.',
      pronunciation: 'ذِی آر اَت اسکول',
    ),
    A1BasicExample(
      english: 'I’m not tired.',
      persian: 'من خسته نیستم.',
      pronunciation: 'آیم نات تایِرد',
    ),
    A1BasicExample(
      english: 'She isn’t here.',
      persian: 'او اینجا نیست.',
      pronunciation: 'شی ایزِنت هیر',
    ),
    A1BasicExample(
      english: 'Are you ready?',
      persian: 'آماده‌ای؟',
      pronunciation: 'آر یو رِدی',
    ),
    A1BasicExample(
      english: 'Is he your teacher?',
      persian: 'او معلم توست؟',
      pronunciation: 'ایز هی یور تیچِر',
    ),
    A1BasicExample(
      english: 'Are they your friends?',
      persian: 'آنها دوستان تو هستند؟',
      pronunciation: 'آر ذِی یور فِرِندز',
    ),
    A1BasicExample(
      english: 'Yes, I am.',
      persian: 'بله، هستم.',
      pronunciation: 'یِس، آی اَم',
    ),
    A1BasicExample(
      english: 'No, I’m not.',
      persian: 'نه، نیستم.',
      pronunciation: 'نو، آیم نات',
    ),
  ],

  questions: [
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct form: I ___ happy.',
      options: ['am', 'is', 'are', 'be'],
      answer: 'am',
      explanation: 'We always use am with I.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct form: She ___ tired.',
      options: ['is', 'am', 'are', 'be'],
      answer: 'is',
      explanation: 'We use is with she.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct form: They ___ ready.',
      options: ['are', 'is', 'am', 'be'],
      answer: 'are',
      explanation: 'We use are with they.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct form: You ___ my friend.',
      options: ['are', 'is', 'am', 'be'],
      answer: 'are',
      explanation: 'We use are with you.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct form: He ___ a doctor.',
      options: ['is', 'are', 'am', 'be'],
      answer: 'is',
      explanation: 'We use is with he.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct form: We ___ students.',
      options: ['are', 'is', 'am', 'be'],
      answer: 'are',
      explanation: 'We use are with we.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct form: It ___ cold today.',
      options: ['is', 'are', 'am', 'be'],
      answer: 'is',
      explanation: 'We use is with it.',
    ),
    A1BasicQuestion(
      type: 'fill_blank',
      question: 'I ___ from Iran.',
      options: ['am', 'is', 'are', 'be'],
      answer: 'am',
      explanation: 'We use am with I.',
    ),
    A1BasicQuestion(
      type: 'fill_blank',
      question: 'She ___ my sister.',
      options: ['is', 'are', 'am', 'be'],
      answer: 'is',
      explanation: 'We use is with she.',
    ),
    A1BasicQuestion(
      type: 'fill_blank',
      question: 'We ___ at home.',
      options: ['are', 'is', 'am', 'be'],
      answer: 'are',
      explanation: 'We use are with we.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct negative sentence.',
      options: [
        'I am not tired.',
        'I not am tired.',
        'I is not tired.',
        'I are not tired.',
      ],
      answer: 'I am not tired.',
      explanation: 'Put not after am.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct negative sentence.',
      options: [
        'She is not here.',
        'She not is here.',
        'She are not here.',
        'She am not here.',
      ],
      answer: 'She is not here.',
      explanation: 'Put not after is.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct negative sentence.',
      options: [
        'They are not ready.',
        'They not are ready.',
        'They is not ready.',
        'They am not ready.',
      ],
      answer: 'They are not ready.',
      explanation: 'Put not after are.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'What is the contraction of "I am"?',
      options: ['I’m', 'Im', 'I’s', 'I are'],
      answer: 'I’m',
      explanation: 'I am becomes I’m.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'What is the contraction of "she is"?',
      options: ['She’s', 'Shes', 'She’re', 'She’m'],
      answer: 'She’s',
      explanation: 'She is becomes she’s.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'What is the contraction of "they are"?',
      options: ['They’re', 'They’s', 'They’m', 'They is'],
      answer: 'They’re',
      explanation: 'They are becomes they’re.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct question.',
      options: [
        'Are you okay?',
        'You are okay?',
        'You okay are?',
        'Are okay you?',
      ],
      answer: 'Are you okay?',
      explanation:
          'In a to be question, put am/is/are before the subject.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct question.',
      options: [
        'Is she your sister?',
        'She is your sister?',
        'Your sister is she?',
        'Is your sister she?',
      ],
      answer: 'Is she your sister?',
      explanation:
          'Is comes before the subject she.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct question.',
      options: [
        'Are they ready?',
        'They are ready?',
        'Ready are they?',
        'Are ready they?',
      ],
      answer: 'Are they ready?',
      explanation:
          'Are comes before the subject they.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Complete: "Are you tired?" — "Yes, ___."',
      options: ['I am', 'I is', 'I are', 'I be'],
      answer: 'I am',
      explanation: 'The short positive answer is Yes, I am.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Complete: "Are you busy?" — "No, ___."',
      options: ['I’m not', 'I’m', 'I isn’t', 'I aren’t'],
      answer: 'I’m not',
      explanation: 'The short negative answer is No, I’m not.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Complete: "Is he your brother?" — "Yes, ___."',
      options: ['he is', 'he are', 'he am', 'he be'],
      answer: 'he is',
      explanation: 'The short positive answer is Yes, he is.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Complete: "Are they at home?" — "No, ___."',
      options: ['they aren’t', 'they isn’t', 'they am not', 'they not'],
      answer: 'they aren’t',
      explanation: 'The negative form with they is they aren’t.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'We use "am" with I.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'I am is the correct combination.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'We use "is" with they.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'We use are with they.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'We use "are" with you.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'You are is correct.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: '"She are happy" is correct English.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'The correct sentence is She is happy.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: '"They are ready" is correct English.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'They are is correct.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «من خسته‌ام.»',
      options: [
        'I am tired.',
        'I is tired.',
        'I are tired.',
        'I tired am.',
      ],
      answer: 'I am tired.',
      explanation: 'We use am with I.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «او خوشحال است.»',
      options: [
        'She is happy.',
        'She are happy.',
        'She am happy.',
        'She happy is.',
      ],
      answer: 'She is happy.',
      explanation: 'We use is with she.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «آنها آماده هستند.»',
      options: [
        'They are ready.',
        'They is ready.',
        'They am ready.',
        'They ready are.',
      ],
      answer: 'They are ready.',
      explanation: 'We use are with they.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «ما در خانه هستیم.»',
      options: [
        'We are at home.',
        'We is at home.',
        'We am at home.',
        'We at home are.',
      ],
      answer: 'We are at home.',
      explanation: 'We use are with we.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «آیا خوبی؟»',
      options: [
        'Are you okay?',
        'You are okay.',
        'Is you okay?',
        'Am you okay?',
      ],
      answer: 'Are you okay?',
      explanation: 'Questions with you use are before you.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in the correct order: "am / I / happy"',
      options: [
        'I am happy.',
        'Am I happy.',
        'Happy am I.',
        'I happy am.',
      ],
      answer: 'I am happy.',
      explanation: 'A normal statement begins with the subject.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in the correct order: "is / she / tired"',
      options: [
        'She is tired.',
        'Is she tired.',
        'Tired she is.',
        'She tired is.',
      ],
      answer: 'She is tired.',
      explanation: 'The statement order is subject + verb + adjective.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in the correct order: "are / they / ready"',
      options: [
        'They are ready.',
        'Are they ready.',
        'Ready they are.',
        'They ready are.',
      ],
      answer: 'They are ready.',
      explanation: 'The statement starts with they.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'I’m happy.',
        'I’m are happy.',
        'I is happy.',
        'I’re happy.',
      ],
      answer: 'I’m happy.',
      explanation: 'I’m is the contraction of I am.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'She’s my friend.',
        'She’re my friend.',
        'She’m my friend.',
        'She are my friend.',
      ],
      answer: 'She’s my friend.',
      explanation: 'She’s means she is.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'We’re ready.',
        'We’s ready.',
        'We’m ready.',
        'We is ready.',
      ],
      answer: 'We’re ready.',
      explanation: 'We’re means we are.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'It’s cold today.',
        'It’re cold today.',
        'It’m cold today.',
        'It are cold today.',
      ],
      answer: 'It’s cold today.',
      explanation: 'It’s means it is.',
    ),
  ],

  speakingQuestions: [
    A1BasicSpeakingQuestion(
      question: 'Say: I am happy.',
      persian: 'بگو: من خوشحالم.',
      acceptableAnswers: [
        'i am happy',
        'im happy',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: I am tired.',
      persian: 'بگو: من خسته‌ام.',
      acceptableAnswers: [
        'i am tired',
        'im tired',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: You are my friend.',
      persian: 'بگو: تو دوست من هستی.',
      acceptableAnswers: [
        'you are my friend',
        'youre my friend',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: He is my brother.',
      persian: 'بگو: او برادر من است.',
      acceptableAnswers: [
        'he is my brother',
        'hes my brother',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: She is my sister.',
      persian: 'بگو: او خواهر من است.',
      acceptableAnswers: [
        'she is my sister',
        'shes my sister',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: We are ready.',
      persian: 'بگو: ما آماده‌ایم.',
      acceptableAnswers: [
        'we are ready',
        'we are ready',
        'were ready',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: They are happy.',
      persian: 'بگو: آنها خوشحال هستند.',
      acceptableAnswers: [
        'they are happy',
        'theyre happy',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Answer: Are you okay?',
      persian: 'به سؤال «خوبی؟» جواب بده.',
      acceptableAnswers: [
        'yes i am',
        'yes im okay',
        'yes i am okay',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say one negative sentence using "am not".',
      persian: 'با am not یک جمله منفی بساز.',
      acceptableAnswers: [
        'i am not tired',
        'i am not busy',
        'i am not happy',
        'i am not ready',
        'i am not hungry',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Ask: Are you ready?',
      persian: 'بپرس: آماده‌ای؟',
      acceptableAnswers: [
        'are you ready',
      ],
    ),
  ],
);