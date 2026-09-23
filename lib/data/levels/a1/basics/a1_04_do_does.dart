import 'a1_basics_models.dart';

const A1BasicLesson a1BasicDoDoes = A1BasicLesson(
  id: 'a1_basic_04',
  title: 'Do and Does',
  titleFa: 'Do و Does',
  topic: 'do, does, don’t, doesn’t',
  explanation:
      'Do and does are used mainly to make questions and negative sentences '
      'in the present simple. Do is used with I, you, we, and they. Does is '
      'used with he, she, and it.',


  learningPhases: [
    A1BasicLearningPhase(
      type: 'curiosity',
      title: 'Think First',
      titleFa: 'اول فکر کن',
      body: 'Before we learn the rule, try to guess how you would say: “I don’t play football.”',
      bodyFa: 'قبل از اینکه قانون را یاد بگیریم، یک لحظه فکر کن: اگر بخواهی بگویی «من فوتبال بازی نمی‌کنم»، جمله انگلیسی چطور می‌شود؟ این فقط یک سؤال کنجکاوی است و نمره ندارد.',
      examples: [
        A1BasicExample(
          english: 'I ___ play football.',
          persian: 'من ___ فوتبال بازی نمی‌کنم.',
        ),
        A1BasicExample(
          english: 'Do you like coffee?',
          persian: 'قهوه دوست داری؟',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'introduction',
      title: 'What Are Do and Does?',
      titleFa: 'Do و Does چیستند؟',
      body: 'Do and does are helping verbs in the present simple. They help us make questions and negative sentences. Do can also be a main verb meaning “to do”.',
      bodyFa: 'do و does در زمان حال ساده می‌توانند فعل کمکی باشند. با آن‌ها سؤال و جمله منفی می‌سازیم. خودِ do گاهی هم فعل اصلی است و معنی «انجام دادن» می‌دهد.',
      examples: [
        A1BasicExample(
          english: 'Do you like coffee?',
          persian: 'قهوه دوست داری؟',
        ),
        A1BasicExample(
          english: 'I don’t like coffee.',
          persian: 'من قهوه دوست ندارم.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'Simple Examples',
      titleFa: 'مثال‌های ساده',
      body: 'Look at these question and negative patterns before learning the rule.',
      bodyFa: 'قبل از حفظ کردن قانون، چند الگوی ساده را ببین.',
      examples: [
        A1BasicExample(
          english: 'I don’t like coffee.',
          persian: 'من قهوه دوست ندارم.',
        ),
        A1BasicExample(
          english: 'He doesn’t like coffee.',
          persian: 'او قهوه دوست ندارد.',
        ),
        A1BasicExample(
          english: 'Do you like coffee?',
          persian: 'قهوه دوست داری؟',
        ),
        A1BasicExample(
          english: 'Does he like coffee?',
          persian: 'او قهوه دوست دارد؟',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'The Concept',
      titleFa: 'مفهوم اصلی',
      body: 'Do and does do not usually carry the main meaning here. They help the main verb form a question or a negative sentence. Do goes with I, you, we, they. Does goes with he, she, it.',
      bodyFa: 'اینجا do و does معمولاً معنی اصلی جمله را نمی‌سازند؛ آن‌ها به فعل اصلی کمک می‌کنند تا سؤال یا جمله منفی بسازیم. do با I، you، we و they می‌آید و does با he، she و it.',
      examples: [
        A1BasicExample(
          english: 'You like music. → Do you like music?',
          persian: 'تو موسیقی دوست داری. → موسیقی دوست داری؟',
        ),
        A1BasicExample(
          english: 'She likes music. → Does she like music?',
          persian: 'او موسیقی دوست دارد. → او موسیقی دوست دارد؟',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'positive_s',
      title: 'Positive Sentences and -s',
      titleFa: 'جمله مثبت و s',
      body: 'Before we use does, notice the positive form: he, she, and it usually take -s on the main verb in the present simple.',
      bodyFa: 'قبل از اینکه does را یاد بگیریم، شکل مثبت را ببین: در زمان حال ساده، با he، she و it معمولاً به فعل اصلی s اضافه می‌شود.',
      examples: [
        A1BasicExample(
          english: 'I like coffee.',
          persian: 'من قهوه دوست دارم.',
        ),
        A1BasicExample(
          english: 'He likes coffee.',
          persian: 'او قهوه دوست دارد.',
        ),
        A1BasicExample(
          english: 'She works here.',
          persian: 'او اینجا کار می‌کند.',
        ),
        A1BasicExample(
          english: 'It works.',
          persian: 'کار می‌کند.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'chart',
      title: 'Do / Does Chart',
      titleFa: 'جدول Do و Does',
      body: 'Use do with I, you, we, they. Use does with he, she, it.',
      bodyFa: 'do با I، you، we و they می‌آید. does با he، she و it می‌آید.',
      tableRows: [
        ['I', 'do', 'Do I like...?'],
        ['You', 'do', 'Do you like...?'],
        ['He', 'does', 'Does he like...?'],
        ['She', 'does', 'Does she like...?'],
        ['It', 'does', 'Does it work...?'],
        ['We', 'do', 'Do we like...?'],
        ['They', 'do', 'Do they like...?'],
      ],
    ),
    A1BasicLearningPhase(
      type: 'rule',
      title: 'The Big Rule: Does + Base Verb',
      titleFa: 'قانون مهم: Does + شکل ساده فعل',
      body: 'When does appears, it carries the third-person -s. The main verb goes back to its base form.',
      bodyFa: 'وقتی does وارد جمله می‌شود، s مربوط به شخص سوم را خودش به دوش می‌کشد. پس فعل اصلی دوباره به شکل ساده برمی‌گردد.',
      examples: [
        A1BasicExample(
          english: 'She likes coffee.',
          persian: 'او قهوه دوست دارد.',
        ),
        A1BasicExample(
          english: 'Does she like coffee? ✓',
          persian: 'درست: بعد از does، like بدون s می‌آید.',
        ),
        A1BasicExample(
          english: 'Does she likes coffee? ✗',
          persian: 'غلط: بعد از does، likes نمی‌آید.',
        ),
        A1BasicExample(
          english: 'He works here. → Does he work here?',
          persian: 'او اینجا کار می‌کند. → آیا او اینجا کار می‌کند؟',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'negative',
      title: 'Negative Sentences',
      titleFa: 'جمله‌های منفی',
      body: 'Use don’t with I, you, we, they. Use doesn’t with he, she, it. The main verb stays in its base form.',
      bodyFa: 'برای منفی کردن جمله، با I، you، we و they از don’t و با he، she و it از doesn’t استفاده می‌کنیم. بعد از آن‌ها فعل اصلی شکل ساده دارد.',
      examples: [
        A1BasicExample(
          english: 'I don’t like tea.',
          persian: 'من چای دوست ندارم.',
        ),
        A1BasicExample(
          english: 'They don’t live here.',
          persian: 'آنها اینجا زندگی نمی‌کنند.',
        ),
        A1BasicExample(
          english: 'She doesn’t speak English.',
          persian: 'او انگلیسی صحبت نمی‌کند.',
        ),
        A1BasicExample(
          english: 'He doesn’t eat meat.',
          persian: 'او گوشت نمی‌خورد.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'compare_to_be',
      title: 'Do / Does vs To Be',
      titleFa: 'تفاوت Do / Does با To Be',
      body: 'With to be, make the negative with not. With a normal main verb, use don’t or doesn’t.',
      bodyFa: 'با to be، منفی را با not می‌سازیم. اما وقتی فعل اصلی یک فعل معمولی است، برای منفی کردن از don’t یا doesn’t استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'I am not happy. ✓',
          persian: 'من خوشحال نیستم.',
        ),
        A1BasicExample(
          english: 'I don’t like coffee. ✓',
          persian: 'من قهوه دوست ندارم.',
        ),
        A1BasicExample(
          english: 'I don’t happy. ✗',
          persian: 'غلط است.',
        ),
        A1BasicExample(
          english: 'I am not like coffee. ✗',
          persian: 'غلط است.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'short_answers',
      title: 'Short Answers',
      titleFa: 'جواب‌های کوتاه',
      body: 'In short answers, keep do or does. Use don’t or doesn’t for a negative answer.',
      bodyFa: 'در جواب کوتاه، do یا does را نگه می‌داریم. برای جواب منفی از don’t یا doesn’t استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'Do you like music? — Yes, I do.',
          persian: 'موسیقی دوست داری؟ — بله.',
        ),
        A1BasicExample(
          english: 'Do you like music? — No, I don’t.',
          persian: 'موسیقی دوست داری؟ — نه.',
        ),
        A1BasicExample(
          english: 'Does she work here? — Yes, she does.',
          persian: 'او اینجا کار می‌کند؟ — بله.',
        ),
        A1BasicExample(
          english: 'Does he drive? — No, he doesn’t.',
          persian: 'او رانندگی می‌کند؟ — نه.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'main_verb',
      title: 'Do as a Main Verb',
      titleFa: 'Do به‌عنوان فعل اصلی',
      body: 'Do can also be the main verb and mean “to do”. This is different from helping do.',
      bodyFa: 'do گاهی خودش فعل اصلی است و معنی «انجام دادن» می‌دهد. این با do کمکی که برای سؤال و منفی می‌آید فرق دارد.',
      examples: [
        A1BasicExample(
          english: 'I do my homework.',
          persian: 'من تکالیفم را انجام می‌دهم.',
        ),
        A1BasicExample(
          english: 'She does her homework.',
          persian: 'او تکالیفش را انجام می‌دهد.',
        ),
        A1BasicExample(
          english: 'Do you like coffee?',
          persian: 'قهوه دوست داری؟',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'more_examples',
      title: 'More Examples',
      titleFa: 'مثال‌های بیشتر',
      body: 'Now see the same patterns with different everyday verbs.',
      bodyFa: 'حالا همین الگوها را با چند فعل روزمره دیگر ببین.',
      examples: [
        A1BasicExample(
          english: 'Do you have a car?',
          persian: 'ماشین داری؟',
        ),
        A1BasicExample(
          english: 'Does she speak English?',
          persian: 'او انگلیسی صحبت می‌کند؟',
        ),
        A1BasicExample(
          english: 'Do they go to school?',
          persian: 'آنها به مدرسه می‌روند؟',
        ),
        A1BasicExample(
          english: 'Does he eat meat?',
          persian: 'او گوشت می‌خورد؟',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'guided_practice',
      title: 'Guided Practice',
      titleFa: 'تمرین هدایت‌شده',
      body: 'Choose the correct helping verb. The pattern is now familiar, so focus on the subject.',
      bodyFa: 'حالا با راهنمایی الگو را تمرین کن. به فاعل دقت کن و do، does، don’t یا doesn’t را انتخاب کن.',
      examples: [
        A1BasicExample(
          english: 'I ___ like tea. → don’t',
          persian: 'من چای دوست ندارم.',
        ),
        A1BasicExample(
          english: 'She ___ have a dog. → doesn’t',
          persian: 'او سگ ندارد.',
        ),
        A1BasicExample(
          english: '___ you speak English? → Do',
          persian: 'انگلیسی صحبت می‌کنی؟',
        ),
        A1BasicExample(
          english: 'He ___ work here. → doesn’t',
          persian: 'او اینجا کار نمی‌کند.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'independent',
      title: 'Independent Production',
      titleFa: 'تولید مستقل',
      body: 'Build complete sentences without a model.',
      bodyFa: 'حالا بدون کپی کردن از یک الگو، جمله کامل بساز.',
      examples: [
        A1BasicExample(
          english: 'I don’t play football.',
          persian: 'من فوتبال بازی نمی‌کنم.',
        ),
        A1BasicExample(
          english: 'She doesn’t speak English.',
          persian: 'او انگلیسی صحبت نمی‌کند.',
        ),
        A1BasicExample(
          english: 'Do you have a book?',
          persian: 'کتاب داری؟',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'real_world',
      title: 'Real-Life Use',
      titleFa: 'کاربرد واقعی',
      body: 'These patterns appear constantly in everyday conversations.',
      bodyFa: 'این ساختارها در مکالمه روزمره خیلی زیاد استفاده می‌شوند. سؤال بپرس، جواب کوتاه بده و درباره چیزهایی که دوست داری یا انجام می‌دهی صحبت کن.',
      examples: [
        A1BasicExample(
          english: 'Do you understand?',
          persian: 'متوجه می‌شی؟',
        ),
        A1BasicExample(
          english: 'Do you need help?',
          persian: 'کمک لازم داری؟',
        ),
        A1BasicExample(
          english: 'Does he live nearby?',
          persian: 'او نزدیک اینجا زندگی می‌کند؟',
        ),
        A1BasicExample(
          english: 'I don’t know.',
          persian: 'نمی‌دانم.',
        ),
      ],
    ),
  ],

  vocabulary: [
    A1BasicVocabulary(
      english: 'homework',
      persian: 'تکلیف / تکالیف',
      example: 'I do my homework.',
    ),
    A1BasicVocabulary(
      english: 'music',
      persian: 'موسیقی',
      example: 'Do you like music?',
    ),
    A1BasicVocabulary(
      english: 'coffee',
      persian: 'قهوه',
      pronunciation: 'کافی',
      example: 'Do you like coffee?',
    ),
    A1BasicVocabulary(
      english: 'speak English',
      persian: 'انگلیسی صحبت کردن',
      example: 'Do you speak English?',
    ),
    A1BasicVocabulary(
      english: 'work',
      persian: 'کار کردن',
      example: 'Does he work here?',
    ),
    A1BasicVocabulary(
      english: 'here',
      persian: 'اینجا',
      example: 'Does she work here?',
    ),
    A1BasicVocabulary(
      english: 'like',
      persian: 'دوست داشتن',
      example: 'Do you like pizza?',
    ),
    A1BasicVocabulary(
      english: 'pizza',
      persian: 'پیتزا',
      example: 'Do you like pizza?',
    ),
    A1BasicVocabulary(
      english: 'class',
      persian: 'کلاس',
      example: 'Do we have class today?',
    ),
    A1BasicVocabulary(
      english: 'live',
      persian: 'زندگی کردن',
      example: 'Do they live here?',
    ),
    A1BasicVocabulary(
      english: 'need',
      persian: 'نیاز داشتن',
      example: 'Do I need a ticket?',
    ),
    A1BasicVocabulary(
      english: 'ticket',
      persian: 'بلیت',
      example: 'Do I need a ticket?',
    ),
    A1BasicVocabulary(
      english: 'football',
      persian: 'فوتبال',
      example: 'Does he like football?',
    ),
    A1BasicVocabulary(
      english: 'drive',
      persian: 'رانندگی کردن',
      example: 'Does your brother drive?',
    ),
    A1BasicVocabulary(
      english: 'tea',
      persian: 'چای',
      example: 'He doesn’t like tea.',
    ),
    A1BasicVocabulary(
      english: 'understand',
      persian: 'متوجه شدن / فهمیدن',
      example: 'I don’t understand.',
    ),
    A1BasicVocabulary(
      english: 'know',
      persian: 'دانستن / شناختن',
      example: 'We don’t know.',
    ),
    A1BasicVocabulary(
      english: 'help',
      persian: 'کمک',
      example: 'Do you need help?',
    ),
    A1BasicVocabulary(
      english: 'want',
      persian: 'خواستن',
      example: 'Do you want coffee?',
    ),
    A1BasicVocabulary(
      english: 'exercise',
      persian: 'ورزش',
      example: 'They do exercise every morning.',
    ),
    A1BasicVocabulary(
      english: 'dishes',
      persian: 'ظرف‌ها',
      example: 'I do the dishes.',
    ),
    A1BasicVocabulary(
      english: 'nearby',
      persian: 'نزدیک / در نزدیکی',
      example: 'Does he live nearby?',
    ),
  ],

  sections: [
    A1BasicSection(
      title: 'What are Do and Does?',
      titleFa: 'Do و Does چیستند؟',
      explanation:
          'Do and does can be helping verbs. They help us make questions and '
          'negative sentences in the present simple.',
      explanationFa:
          'do و does در زمان حال ساده بیشتر به عنوان فعل کمکی استفاده می‌شوند. از آن‌ها برای ساختن سؤال و جمله منفی استفاده می‌کنیم. همچنین do می‌تواند خودش یک فعل اصلی به معنی «انجام دادن» باشد.',
      examples: [
        A1BasicExample(
          english: 'Do you like coffee?',
          persian: 'قهوه دوست داری؟',
          pronunciation: 'دو یو لایک کافی؟',
        ),
        A1BasicExample(
          english: 'Does she speak English?',
          persian: 'آیا او انگلیسی صحبت می‌کند؟',
          pronunciation: 'داز شی اسپیک انگلیش؟',
        ),
        A1BasicExample(
          english: 'I don’t like coffee.',
          persian: 'من قهوه دوست ندارم.',
          pronunciation: 'آی دونت لایک کافی',
        ),
        A1BasicExample(
          english: 'He doesn’t speak English.',
          persian: 'او انگلیسی صحبت نمی‌کند.',
          pronunciation: 'هی دازِنت اسپیک انگلیش',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Do',
      titleFa: 'Do',
      explanation:
          'Use do with I, you, we, and they.',
      explanationFa:
          'از do با I، you، we و they استفاده می‌کنیم. این الگو هم در سؤال‌ها و هم در جمله‌های منفی کاربرد دارد.',
      examples: [
        A1BasicExample(
          english: 'I do my homework.',
          persian: 'من تکالیفم را انجام می‌دهم.',
        ),
        A1BasicExample(
          english: 'Do you like music?',
          persian: 'موسیقی دوست داری؟',
        ),
        A1BasicExample(
          english: 'We do our best.',
          persian: 'ما تمام تلاشمان را می‌کنیم.',
        ),
        A1BasicExample(
          english: 'Do they work here?',
          persian: 'آنها اینجا کار می‌کنند؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Does',
      titleFa: 'Does',
      explanation:
          'Use does with he, she, and it.',
      explanationFa:
          'از does با he، she و it استفاده می‌کنیم. همچنین وقتی فاعل یک نفر یا یک چیز مفرد باشد، معمولاً از does استفاده می‌شود.',
      examples: [
        A1BasicExample(
          english: 'Does he work here?',
          persian: 'او اینجا کار می‌کند؟',
        ),
        A1BasicExample(
          english: 'Does she like cats?',
          persian: 'او گربه‌ها را دوست دارد؟',
        ),
        A1BasicExample(
          english: 'Does it work?',
          persian: 'آیا کار می‌کند؟',
        ),
        A1BasicExample(
          english: 'Does Ali speak English?',
          persian: 'علی انگلیسی صحبت می‌کند؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Do and Does Chart',
      titleFa: 'جدول Do و Does',
      explanation:
          'Remember which subjects use do and which subjects use does.',
      explanationFa:
          'این الگو را خوب حفظ کن: I، you، we و they با do می‌آیند و he، she و it با does. این یکی از پایه‌های مهم ساخت سؤال و منفی در زمان حال ساده است.',
      examples: [
        A1BasicExample(
          english: 'I → do',
          persian: 'من → do',
        ),
        A1BasicExample(
          english: 'You → do',
          persian: 'تو / شما → do',
        ),
        A1BasicExample(
          english: 'He → does',
          persian: 'او، مذکر → does',
        ),
        A1BasicExample(
          english: 'She → does',
          persian: 'او، مؤنث → does',
        ),
        A1BasicExample(
          english: 'It → does',
          persian: 'آن → does',
        ),
        A1BasicExample(
          english: 'We → do',
          persian: 'ما → do',
        ),
        A1BasicExample(
          english: 'They → do',
          persian: 'آنها → do',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Questions with Do',
      titleFa: 'سؤال با Do',
      explanation:
          'For questions with I, you, we, and they, put do before the subject.',
      explanationFa:
          'برای ساختن سؤال با I، you، we و they، do را قبل از فاعل قرار می‌دهیم. بعد از فاعل، فعل اصلی به شکل ساده می‌آید.',
      examples: [
        A1BasicExample(
          english: 'Do you like pizza?',
          persian: 'پیتزا دوست داری؟',
        ),
        A1BasicExample(
          english: 'Do you speak English?',
          persian: 'انگلیسی صحبت می‌کنی؟',
        ),
        A1BasicExample(
          english: 'Do we have class today?',
          persian: 'امروز کلاس داریم؟',
        ),
        A1BasicExample(
          english: 'Do they live here?',
          persian: 'آنها اینجا زندگی می‌کنند؟',
        ),
        A1BasicExample(
          english: 'Do I need a ticket?',
          persian: 'من به بلیت نیاز دارم؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Questions with Does',
      titleFa: 'سؤال با Does',
      explanation:
          'For questions with he, she, and it, use does before the subject.',
      explanationFa:
          'برای ساختن سؤال با he، she و it، از does در ابتدای جمله استفاده می‌کنیم. بعد از فاعل، فعل اصلی باید به شکل ساده باشد و دیگر s نمی‌گیرد.',
      examples: [
        A1BasicExample(
          english: 'Does he like football?',
          persian: 'او فوتبال دوست دارد؟',
        ),
        A1BasicExample(
          english: 'Does she work here?',
          persian: 'او اینجا کار می‌کند؟',
        ),
        A1BasicExample(
          english: 'Does it work?',
          persian: 'کار می‌کند؟',
        ),
        A1BasicExample(
          english: 'Does your brother drive?',
          persian: 'برادرت رانندگی می‌کند؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Important: Does + Base Verb',
      titleFa: 'نکته مهم: Does + شکل ساده فعل',
      explanation:
          'After does, the main verb returns to its base form. Do not add s to the main verb.',
      explanationFa:
          'این نکته خیلی مهم است: بعد از does، فعل اصلی به شکل پایه برمی‌گردد. بنابراین می‌گوییم Does she like coffee؟ نه Does she likes coffee؟',
      examples: [
        A1BasicExample(
          english: 'She likes coffee.',
          persian: 'او قهوه دوست دارد.',
        ),
        A1BasicExample(
          english: 'Does she like coffee? ✓',
          persian: 'آیا او قهوه دوست دارد؟',
        ),
        A1BasicExample(
          english: 'Does she likes coffee? ✗',
          persian: 'غلط است.',
        ),
        A1BasicExample(
          english: 'He works here.',
          persian: 'او اینجا کار می‌کند.',
        ),
        A1BasicExample(
          english: 'Does he work here? ✓',
          persian: 'آیا او اینجا کار می‌کند؟',
        ),
        A1BasicExample(
          english: 'Does he works here? ✗',
          persian: 'غلط است.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Negative with Don’t',
      titleFa: 'منفی با Don’t',
      explanation:
          'Don’t means do not. Use don’t with I, you, we, and they.',
      explanationFa:
          'don’t شکل کوتاه do not است. از don’t با I، you، we و they برای ساختن جمله‌های منفی در زمان حال ساده استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'I don’t like coffee.',
          persian: 'من قهوه دوست ندارم.',
        ),
        A1BasicExample(
          english: 'You don’t need a ticket.',
          persian: 'تو به بلیت نیاز نداری.',
        ),
        A1BasicExample(
          english: 'We don’t work on Sunday.',
          persian: 'ما یکشنبه کار نمی‌کنیم.',
        ),
        A1BasicExample(
          english: 'They don’t live here.',
          persian: 'آنها اینجا زندگی نمی‌کنند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Negative with Doesn’t',
      titleFa: 'منفی با Doesn’t',
      explanation:
          'Doesn’t means does not. Use doesn’t with he, she, and it.',
      explanationFa:
          'doesn’t شکل کوتاه does not است. از doesn’t با he، she و it برای ساختن جمله‌های منفی استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'He doesn’t like tea.',
          persian: 'او چای دوست ندارد.',
        ),
        A1BasicExample(
          english: 'She doesn’t work here.',
          persian: 'او اینجا کار نمی‌کند.',
        ),
        A1BasicExample(
          english: 'It doesn’t work.',
          persian: 'کار نمی‌کند.',
        ),
        A1BasicExample(
          english: 'My brother doesn’t drive.',
          persian: 'برادرم رانندگی نمی‌کند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Important: Doesn’t + Base Verb',
      titleFa: 'نکته مهم: Doesn’t + شکل ساده فعل',
      explanation:
          'After doesn’t, the main verb also returns to its base form.',
      explanationFa:
          'بعد از doesn’t نیز فعل اصلی باید به شکل پایه بیاید و s نگیرد. بنابراین می‌گوییم She doesn’t like cats، نه She doesn’t likes cats.',
      examples: [
        A1BasicExample(
          english: 'She likes cats.',
          persian: 'او گربه‌ها را دوست دارد.',
        ),
        A1BasicExample(
          english: 'She doesn’t like cats. ✓',
          persian: 'او گربه‌ها را دوست ندارد.',
        ),
        A1BasicExample(
          english: 'She doesn’t likes cats. ✗',
          persian: 'غلط است.',
        ),
        A1BasicExample(
          english: 'He works here.',
          persian: 'او اینجا کار می‌کند.',
        ),
        A1BasicExample(
          english: 'He doesn’t work here. ✓',
          persian: 'او اینجا کار نمی‌کند.',
        ),
        A1BasicExample(
          english: 'He doesn’t works here. ✗',
          persian: 'غلط است.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Short Answers',
      titleFa: 'جواب‌های کوتاه',
      explanation:
          'Questions with do and does usually have short answers using do, does, don’t, or doesn’t.',
      explanationFa:
          'در جواب کوتاه، معمولاً همان do یا does را نگه می‌داریم. برای جواب مثبت از do یا does و برای جواب منفی از don’t یا doesn’t استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'Do you like coffee? — Yes, I do.',
          persian: 'قهوه دوست داری؟ — بله.',
        ),
        A1BasicExample(
          english: 'Do you like coffee? — No, I don’t.',
          persian: 'قهوه دوست داری؟ — نه.',
        ),
        A1BasicExample(
          english: 'Does she work here? — Yes, she does.',
          persian: 'او اینجا کار می‌کند؟ — بله.',
        ),
        A1BasicExample(
          english: 'Does he drive? — No, he doesn’t.',
          persian: 'او رانندگی می‌کند؟ — نه.',
        ),
        A1BasicExample(
          english: 'Do they speak English? — Yes, they do.',
          persian: 'آنها انگلیسی صحبت می‌کنند؟ — بله.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Do as a Main Verb',
      titleFa: 'Do به‌عنوان فعل اصلی',
      explanation:
          'Do can also be a normal verb. In this case, it can mean انجام دادن. '
          'The same word can be both a helping verb and a main verb.',
      explanationFa:
          'do همیشه فعل کمکی نیست. وقتی do به عنوان فعل اصلی استفاده شود، معمولاً معنی «انجام دادن» دارد؛ مثل انجام دادن تکالیف یا کارهای روزمره.',
      examples: [
        A1BasicExample(
          english: 'I do my homework.',
          persian: 'من تکالیفم را انجام می‌دهم.',
        ),
        A1BasicExample(
          english: 'I do the dishes.',
          persian: 'من ظرف‌ها را می‌شویم.',
        ),
        A1BasicExample(
          english: 'She does her homework.',
          persian: 'او تکالیفش را انجام می‌دهد.',
        ),
        A1BasicExample(
          english: 'They do exercise every morning.',
          persian: 'آنها هر صبح ورزش می‌کنند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Do as a Helping Verb',
      titleFa: 'Do به‌عنوان فعل کمکی',
      explanation:
          'When do is a helping verb, it helps us make questions or negative sentences.',
      explanationFa:
          'وقتی do یا does نقش فعل کمکی داشته باشند، خودشان معنی اصلی جمله را نمی‌سازند، بلکه برای ساختن سؤال یا جمله منفی به فعل اصلی کمک می‌کنند.',
      examples: [
        A1BasicExample(
          english: 'Do you like music?',
          persian: 'موسیقی دوست داری؟',
        ),
        A1BasicExample(
          english: 'I don’t like music.',
          persian: 'من موسیقی دوست ندارم.',
        ),
        A1BasicExample(
          english: 'Does she work here?',
          persian: 'او اینجا کار می‌کند؟',
        ),
        A1BasicExample(
          english: 'She doesn’t work here.',
          persian: 'او اینجا کار نمی‌کند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Everyday Questions',
      titleFa: 'سؤال‌های روزمره',
      explanation:
          'These structures are extremely common in everyday English.',
      explanationFa:
          'ساختارهای do و does در سؤال‌های روزمره بسیار رایج هستند. عبارت‌هایی مثل Do you understand؟ و Do you need help؟ را در مکالمات واقعی زیاد می‌شنوی.',
      examples: [
        A1BasicExample(
          english: 'Do you understand?',
          persian: 'متوجه می‌شی؟',
        ),
        A1BasicExample(
          english: 'Do you need help?',
          persian: 'کمک لازم داری؟',
        ),
        A1BasicExample(
          english: 'Do you want coffee?',
          persian: 'قهوه می‌خوای؟',
        ),
        A1BasicExample(
          english: 'Do you know him?',
          persian: 'اونو می‌شناسی؟',
        ),
        A1BasicExample(
          english: 'Does she know you?',
          persian: 'او تو را می‌شناسد؟',
        ),
        A1BasicExample(
          english: 'Does he live nearby?',
          persian: 'او نزدیک اینجا زندگی می‌کند؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Common Mistakes',
      titleFa: 'اشتباهات رایج',
      explanation:
          'The biggest mistake is using does with a verb that still has s, '
          'or using do with he and she.',
      explanationFa:
          'این اشتباهات رایج بیشتر به دو دلیل اتفاق می‌افتند: انتخاب اشتباه do و does، یا استفاده از s روی فعل اصلی بعد از does و doesn’t. بعد از این کلمات، فعل اصلی را به شکل پایه استفاده کن.',
      examples: [
        A1BasicExample(
          english: 'Does she like coffee? ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'Does she likes coffee? ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'He doesn’t work here. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'He doesn’t works here. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'Do they like pizza? ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'Does they like pizza? ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'She doesn’t like tea. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'She don’t like tea. ✗',
          persian: 'غلط',
        ),
      ],
    ),
  ],

  examples: [
    A1BasicExample(
      english: 'Do you like music?',
      persian: 'موسیقی دوست داری؟',
    ),
    A1BasicExample(
      english: 'Does she like cats?',
      persian: 'او گربه‌ها را دوست دارد؟',
    ),
    A1BasicExample(
      english: 'Do they live here?',
      persian: 'آنها اینجا زندگی می‌کنند؟',
    ),
    A1BasicExample(
      english: 'Does he work here?',
      persian: 'او اینجا کار می‌کند؟',
    ),
    A1BasicExample(
      english: 'I don’t understand.',
      persian: 'متوجه نمی‌شوم.',
    ),
    A1BasicExample(
      english: 'She doesn’t understand.',
      persian: 'او متوجه نمی‌شود.',
    ),
    A1BasicExample(
      english: 'We don’t know.',
      persian: 'ما نمی‌دانیم.',
    ),
    A1BasicExample(
      english: 'He doesn’t know.',
      persian: 'او نمی‌داند.',
    ),
    A1BasicExample(
      english: 'Do you need help?',
      persian: 'کمک لازم داری؟',
    ),
    A1BasicExample(
      english: 'Does she need help?',
      persian: 'او کمک لازم دارد؟',
    ),
    A1BasicExample(
      english: 'Yes, I do.',
      persian: 'بله.',
    ),
    A1BasicExample(
      english: 'No, I don’t.',
      persian: 'نه.',
    ),
    A1BasicExample(
      english: 'Yes, she does.',
      persian: 'بله.',
    ),
    A1BasicExample(
      english: 'No, he doesn’t.',
      persian: 'نه.',
    ),
  ],

  questions: [
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ you like coffee?',
      options: ['Do', 'Does', 'Is', 'Are'],
      answer: 'Do',
      explanation: 'We use do with you.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ she like music?',
      options: ['Does', 'Do', 'Is', 'Are'],
      answer: 'Does',
      explanation: 'We use does with she.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ they work here?',
      options: ['Do', 'Does', 'Is', 'Has'],
      answer: 'Do',
      explanation: 'We use do with they.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ he speak English?',
      options: ['Does', 'Do', 'Are', 'Have'],
      answer: 'Does',
      explanation: 'We use does with he.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ we need a ticket?',
      options: ['Do', 'Does', 'Is', 'Has'],
      answer: 'Do',
      explanation: 'We use do with we.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ your brother drive?',
      options: ['Does', 'Do', 'Are', 'Have'],
      answer: 'Does',
      explanation: 'Your brother is one person, so use does.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'I ___ like tea.',
      options: ['don’t', 'doesn’t', 'am not', 'not'],
      answer: 'don’t',
      explanation: 'We use don’t with I.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'She ___ like tea.',
      options: ['doesn’t', 'don’t', 'isn’t', 'not'],
      answer: 'doesn’t',
      explanation: 'We use doesn’t with she.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'They ___ live here.',
      options: ['don’t', 'doesn’t', 'aren’t', 'isn’t'],
      answer: 'don’t',
      explanation: 'We use don’t with they.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'He ___ work here.',
      options: ['doesn’t', 'don’t', 'isn’t', 'aren’t'],
      answer: 'doesn’t',
      explanation: 'We use doesn’t with he.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'Does she like coffee?',
        'Does she likes coffee?',
        'Do she like coffee?',
        'Does she liking coffee?',
      ],
      answer: 'Does she like coffee?',
      explanation: 'After does, use the base form like.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'He doesn’t work here.',
        'He doesn’t works here.',
        'He don’t work here.',
        'He not work here.',
      ],
      answer: 'He doesn’t work here.',
      explanation: 'After doesn’t, use the base form work.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'Do you speak English?',
        'Does you speak English?',
        'Do you speaks English?',
        'You does speak English?',
      ],
      answer: 'Do you speak English?',
      explanation: 'We use do with you, followed by the base verb speak.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'Does he play football?',
        'Does he plays football?',
        'Do he play football?',
        'He does plays football?',
      ],
      answer: 'Does he play football?',
      explanation: 'Does + he + base verb is correct.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Complete: "Do you like pizza?" — "Yes, ___."',
      options: ['I do', 'I does', 'I am', 'I like'],
      answer: 'I do',
      explanation: 'Use do in the short answer.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Complete: "Do you like pizza?" — "No, ___."',
      options: ['I don’t', 'I doesn’t', 'I not', 'I am not'],
      answer: 'I don’t',
      explanation: 'Use don’t in the negative short answer.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Complete: "Does she work here?" — "Yes, ___."',
      options: ['she does', 'she do', 'she is', 'she works'],
      answer: 'she does',
      explanation: 'Use does in the short answer.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Complete: "Does he drive?" — "No, ___."',
      options: ['he doesn’t', 'he don’t', 'he isn’t', 'he not'],
      answer: 'he doesn’t',
      explanation: 'Use doesn’t in the negative short answer.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'We use "do" with they.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'We use do with they.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'We use "does" with she.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'We use does with she.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'We use "does" with they.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'We use do with they.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'After does, the main verb usually has s.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'After does, use the base form.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: '"Does he likes pizza?" is correct.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'The correct sentence is "Does he like pizza?"',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: '"She doesn’t work here" is correct.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'Doesn’t is followed by the base verb work.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'Translate: “تو انگلیسی صحبت می‌کنی؟”',
      questionFa: 'ترجمه کن: «تو انگلیسی صحبت می‌کنی؟»',
      options: [
        'Do you speak English?',
        'Does you speak English?',
        'Do you speaks English?',
        'You does speak English?',
      ],
      answer: 'Do you speak English?',
      explanation: 'You uses do + base verb.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'Translate: “او قهوه دوست دارد؟”',
      questionFa: 'ترجمه کن: «او قهوه دوست دارد؟»',
      options: [
        'Does she like coffee?',
        'Do she like coffee?',
        'Does she likes coffee?',
        'She does likes coffee?',
      ],
      answer: 'Does she like coffee?',
      explanation: 'We use does with she, followed by the base verb.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'Translate: “من نمی‌فهمم.”',
      questionFa: 'ترجمه کن: «من نمی‌فهمم.»',
      options: [
        'I don’t understand.',
        'I doesn’t understand.',
        'I don’t understands.',
        'I not understand.',
      ],
      answer: 'I don’t understand.',
      explanation: 'We use don’t with I, followed by the base verb.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'Translate: “او اینجا کار نمی‌کند.”',
      questionFa: 'ترجمه کن: «او اینجا کار نمی‌کند.»',
      options: [
        'He doesn’t work here.',
        'He don’t work here.',
        'He doesn’t works here.',
        'He not work here.',
      ],
      answer: 'He doesn’t work here.',
      explanation: 'We use doesn’t with he, followed by the base verb.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "you / do / like / music"',
      options: [
        'Do you like music?',
        'You do like music?',
        'Do like you music?',
        'Like do you music?',
      ],
      answer: 'Do you like music?',
      explanation: 'Question order: do + subject + base verb.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "she / does / work / here"',
      options: [
        'Does she work here?',
        'She does work here?',
        'Does work she here?',
        'Work does she here?',
      ],
      answer: 'Does she work here?',
      explanation: 'Question order: does + subject + base verb.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "don’t / I / understand"',
      options: [
        'I don’t understand.',
        'Don’t I understand.',
        'I understand don’t.',
        'Understand I don’t.',
      ],
      answer: 'I don’t understand.',
      explanation: 'Negative order: subject + don’t + base verb.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "doesn’t / he / drive"',
      options: [
        'He doesn’t drive.',
        'Doesn’t he drive.',
        'He drive doesn’t.',
        'Drive he doesn’t.',
      ],
      answer: 'He doesn’t drive.',
      explanation: 'Negative order: subject + doesn’t + base verb.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'Do they like pizza?',
        'Does they like pizza?',
        'Do they likes pizza?',
        'They does like pizza?',
      ],
      answer: 'Do they like pizza?',
      explanation: 'We use do with they, followed by the base verb.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'Does your sister speak English?',
        'Do your sister speak English?',
        'Does your sister speaks English?',
        'Your sister does speaks English?',
      ],
      answer: 'Does your sister speak English?',
      explanation: 'Your sister is singular, so use does + base verb.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'We don’t know.',
        'We doesn’t know.',
        'We don’t knows.',
        'We not knows.',
      ],
      answer: 'We don’t know.',
      explanation: 'We use don’t with we, followed by the base verb.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'She doesn’t like tea.',
        'She don’t like tea.',
        'She doesn’t likes tea.',
        'She not like tea.',
      ],
      answer: 'She doesn’t like tea.',
      explanation: 'She uses doesn’t + base verb.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'In "I do my homework", what does "do" mean?',
      options: [
        'انجام دادن',
        'داشتن',
        'بودن',
        'رفتن',
      ],
      answer: 'انجام دادن',
      explanation: 'Here do is the main verb and means انجام دادن.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'In "Do you like coffee?", what is "do"?',
      options: [
        'A helping verb',
        'A noun',
        'An adjective',
        'A preposition',
      ],
      answer: 'A helping verb',
      explanation: 'Here do helps form a question.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which one is correct?',
      options: [
        'Does it work?',
        'Do it work?',
        'Does it works?',
        'It does works?',
      ],
      answer: 'Does it work?',
      explanation: 'We use does with it, followed by the base verb.',
    ),
  ],

  speakingQuestions: [
    A1BasicSpeakingQuestion(
      question: 'Ask: Do you like coffee?',
      persian: 'بپرس: قهوه دوست داری؟',
      acceptableAnswers: [
        'do you like coffee',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Ask: Do you speak English?',
      persian: 'بپرس: انگلیسی صحبت می‌کنی؟',
      acceptableAnswers: [
        'do you speak english',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Ask: Does she like cats?',
      persian: 'بپرس: آیا او گربه‌ها را دوست دارد؟',
      acceptableAnswers: [
        'does she like cats',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Ask: Does he work here?',
      persian: 'بپرس: آیا او اینجا کار می‌کند؟',
      acceptableAnswers: [
        'does he work here',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: I don’t understand.',
      persian: 'بگو: من متوجه نمی‌شوم.',
      acceptableAnswers: [
        'i dont understand',
        'i do not understand',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: I don’t like coffee.',
      persian: 'بگو: من قهوه دوست ندارم.',
      acceptableAnswers: [
        'i dont like coffee',
        'i do not like coffee',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: She doesn’t work here.',
      persian: 'بگو: او اینجا کار نمی‌کند.',
      acceptableAnswers: [
        'she doesnt work here',
        'she does not work here',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: He doesn’t like tea.',
      persian: 'بگو: او چای دوست ندارد.',
      acceptableAnswers: [
        'he doesnt like tea',
        'he does not like tea',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Answer: Do you like music? Say: Yes, I do.',
      persian: 'جواب بده: موسیقی دوست داری؟ بگو: بله.',
      acceptableAnswers: [
        'yes i do',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Answer: Does she work here? Say: No, she doesn’t.',
      persian: 'جواب بده: آیا او اینجا کار می‌کند؟ بگو: نه.',
      acceptableAnswers: [
        'no she doesnt',
        'no she does not',
      ],
    ),
  ],
);