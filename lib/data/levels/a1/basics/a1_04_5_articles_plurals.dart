import 'a1_basics_models.dart';

const A1BasicLesson a1BasicArticlesPlurals = A1BasicLesson(
  id: 'a1_basic_04_5',
  title: 'A / An / The + Plural Nouns',
  titleFa: 'A / An / The + اسم‌های جمع',
  topic: 'articles, singular and plural nouns',
  explanation:
      'Articles help us show whether a singular noun is indefinite or specific. '
      'We also need to know when a plural noun can appear without an article.',
  learningPhases: [
    A1BasicLearningPhase(
      type: 'curiosity',
      title: 'Think First',
      titleFa: 'اول فکر کن',
      body:
          'If you want to say “a book”, which word comes before book? Why do we say “a book” but “an apple”?',
      bodyFa:
          'اگر بخواهی بگویی «یه کتاب»، به انگلیسی چه کلمه‌ای قبل از book می‌آید؟ چرا می‌گوییم a book ولی an apple؟ این سؤال فقط برای کنجکاوی است و نمره ندارد.',
      examples: [
        A1BasicExample(english: 'a book', persian: 'یک کتاب'),
        A1BasicExample(english: 'an apple', persian: 'یک سیب'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'introduction',
      title: 'What Are A, An, and The?',
      titleFa: 'A، An و The چیستند؟',
      body:
          'A, an, and the are articles. They come before nouns and help us understand whether we mean one non-specific thing or a specific thing.',
      bodyFa:
          'a، an و the حروف تعریف هستند. آن‌ها قبل از اسم می‌آیند و کمک می‌کنند بفهمیم درباره یک چیز نامشخص صحبت می‌کنیم یا یک چیز مشخص.',
      examples: [
        A1BasicExample(english: 'a book', persian: 'یک کتاب، نامشخص'),
        A1BasicExample(english: 'an apple', persian: 'یک سیب، نامشخص'),
        A1BasicExample(english: 'the book', persian: 'آن کتاب / کتاب مشخص'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'Simple Examples',
      titleFa: 'مثال‌های ساده',
      body: 'See the three basic patterns before learning the rules.',
      bodyFa: 'قبل از یاد گرفتن قانون، این سه الگوی پایه را ببین.',
      examples: [
        A1BasicExample(english: 'I have a book.', persian: 'من یک کتاب دارم.'),
        A1BasicExample(english: 'She has an apple.', persian: 'او یک سیب دارد.'),
        A1BasicExample(english: 'The book is good.', persian: 'آن کتاب خوب است.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'A and An',
      titleFa: 'A و An',
      body:
          'Use a or an with a singular countable noun when the thing is not specific. Use a before a consonant sound and an before a vowel sound.',
      bodyFa:
          'از a یا an با اسم مفرد قابل‌شمارش وقتی چیز مشخصی مدنظر نیست استفاده می‌کنیم. a قبل از صدای صامت و an قبل از صدای واکه می‌آید. فعلاً مثال‌های ساده را یاد بگیر و به صدا توجه کن، نه فقط حرف اول.',
      examples: [
        A1BasicExample(english: 'a book', persian: 'یک کتاب'),
        A1BasicExample(english: 'a car', persian: 'یک ماشین'),
        A1BasicExample(english: 'an apple', persian: 'یک سیب'),
        A1BasicExample(english: 'an egg', persian: 'یک تخم‌مرغ'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'The',
      titleFa: 'The',
      body:
          'Use the when the listener can identify the specific person or thing. For example, first we can mention a book, and then talk about the book.',
      bodyFa:
          'وقتی منظورمان یک چیز یا شخص مشخص است و شنونده می‌تواند آن را تشخیص دهد، از the استفاده می‌کنیم. مثلاً اول می‌گوییم a book و بعد که همان کتاب مشخص شد، می‌گوییم the book.',
      examples: [
        A1BasicExample(
          english: 'I bought a book. The book is good.',
          persian: 'من یک کتاب خریدم. آن کتاب خوب است.',
        ),
        A1BasicExample(
          english: 'The sun is hot.',
          persian: 'خورشید داغ است.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'table',
      title: 'A, An, and The Chart',
      titleFa: 'جدول A، An و The',
      body:
          'Remember the main difference: a/an are indefinite; the is definite or specific.',
      bodyFa:
          'تفاوت اصلی را به خاطر بسپار: a و an برای یک چیز نامشخص و the برای چیز مشخص یا شناخته‌شده است.',
      tableRows: [
        ['Article', 'Use', 'Example'],
        ['a', 'singular + indefinite + consonant sound', 'a book'],
        ['an', 'singular + indefinite + vowel sound', 'an apple'],
        ['the', 'specific / definite', 'the book'],
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'Singular and Plural',
      titleFa: 'مفرد و جمع',
      body:
          'A and an can only be used with singular nouns. A plural noun does not take a or an. A plural noun can use the when it is specific, or no article when we mean the group in general.',
      bodyFa:
          'a و an فقط با اسم مفرد می‌آیند. اسم جمع نمی‌تواند a یا an داشته باشد. اسم جمع اگر مشخص باشد می‌تواند با the بیاید، و اگر درباره آن به طور کلی صحبت کنیم معمولاً بدون حرف تعریف می‌آید.',
      examples: [
        A1BasicExample(english: 'a book', persian: 'یک کتاب'),
        A1BasicExample(english: 'books', persian: 'کتاب‌ها، به طور کلی'),
        A1BasicExample(english: 'the books', persian: 'کتاب‌های مشخص'),
        A1BasicExample(english: '❌ a books', persian: 'غلط'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'table',
      title: 'Plural Noun Patterns',
      titleFa: 'الگوهای اسم جمع',
      body:
          'Compare a singular noun with its plural form, and compare general plural nouns with specific plural nouns.',
      bodyFa:
          'اسم مفرد و جمع را کنار هم ببین. همچنین فرق اسم جمع به طور کلی با اسم‌های جمع مشخص را ببین.',
      tableRows: [
        ['Meaning', 'Singular', 'Plural'],
        ['indefinite', 'a book', 'books'],
        ['indefinite', 'an apple', 'apples'],
        ['definite / specific', 'the book', 'the books'],
        ['general', '—', 'books'],
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'Useful Irregular Plurals',
      titleFa: 'چند جمع بی‌قاعده کاربردی',
      body:
          'Some common nouns do not make their plural with a simple -s. Learn these few useful examples.',
      bodyFa:
          'بعضی اسم‌های رایج برای جمع شدن فقط -s نمی‌گیرند. فعلاً چند نمونه کاربردی را یاد بگیر.',
      tableRows: [
        ['Singular', 'Plural'],
        ['man', 'men'],
        ['woman', 'women'],
        ['child', 'children'],
        ['foot', 'feet'],
        ['tooth', 'teeth'],
        ['mouse', 'mice'],
      ],
      examples: [
        A1BasicExample(english: 'a man → men', persian: 'یک مرد → مردان'),
        A1BasicExample(english: 'a child → children', persian: 'یک کودک → کودکان'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'When Do We Use The?',
      titleFa: 'چه زمانی از The استفاده می‌کنیم؟',
      body:
          'Use the for a specific thing, something already mentioned, or a unique thing in a context. Some names also use the, such as the Caspian Sea.',
      bodyFa:
          'از the برای چیز مشخص، چیزی که قبلاً درباره‌اش صحبت کرده‌ایم، یا چیزی که در آن موقعیت یکتا و مشخص است استفاده می‌کنیم. بعضی نام‌ها هم the می‌گیرند، مثل the Caspian Sea.',
      examples: [
        A1BasicExample(english: 'The car is red.', persian: 'آن ماشین مشخص قرمز است.'),
        A1BasicExample(
          english: 'I saw a dog. The dog was big.',
          persian: 'یک سگ دیدم. آن سگ بزرگ بود.',
        ),
        A1BasicExample(english: 'The sun is hot.', persian: 'خورشید داغ است.'),
        A1BasicExample(
          english: 'The Caspian Sea is large.',
          persian: 'دریای خزر بزرگ است.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'When Do We Not Use The?',
      titleFa: 'چه زمانی The نمی‌آوریم؟',
      body:
          'For a general plural idea, we normally use the plural noun without the. For example, “Books are useful” means books in general. “The books are useful” means specific books.',
      bodyFa:
          'وقتی درباره اسم‌های جمع به طور کلی صحبت می‌کنیم، معمولاً the نمی‌آوریم. مثلاً Books are useful یعنی «کتاب‌ها به طور کلی مفیدند». اما The books are useful یعنی «آن کتاب‌های مشخص مفیدند». همچنین بعضی نام‌های خاص مثل Tehran معمولاً the نمی‌گیرند.',
      examples: [
        A1BasicExample(english: 'Books are useful.', persian: 'کتاب‌ها به طور کلی مفیدند.'),
        A1BasicExample(
          english: 'The books are on the shelf.',
          persian: 'کتاب‌های مشخص روی قفسه هستند.',
        ),
        A1BasicExample(english: 'Tehran is a city.', persian: 'تهران یک شهر است.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'More Examples',
      titleFa: 'مثال‌های بیشتر',
      body:
          'Notice how the article changes the meaning from one non-specific thing to a specific thing, or disappears for a general plural.',
      bodyFa:
          'دقت کن که حرف تعریف چطور معنی جمله را تغییر می‌دهد: از یک چیز نامشخص به یک چیز مشخص، یا در جمع کلی حذف می‌شود.',
      examples: [
        A1BasicExample(english: 'I have a car.', persian: 'من یک ماشین دارم.'),
        A1BasicExample(english: 'She ate an orange.', persian: 'او یک پرتقال خورد.'),
        A1BasicExample(english: 'The book is on the table.', persian: 'آن کتاب روی میز است.'),
        A1BasicExample(english: 'Books are useful.', persian: 'کتاب‌ها به طور کلی مفیدند.'),
        A1BasicExample(
          english: 'The books are on the shelf.',
          persian: 'کتاب‌های مشخص روی قفسه هستند.',
        ),
        A1BasicExample(english: 'Children like books.', persian: 'کودکان کتاب دوست دارند.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'recognition',
      title: 'Recognize the Pattern',
      titleFa: 'الگو را تشخیص بده',
      body:
          'Before filling a blank, decide whether the noun is singular or plural, and whether it is specific or general.',
      bodyFa:
          'قبل از کامل کردن جای خالی، اول تشخیص بده اسم مفرد است یا جمع و آیا منظور یک چیز مشخص است یا کلی.',
      examples: [
        A1BasicExample(english: 'a book ✓', persian: 'یک کتاب، درست'),
        A1BasicExample(english: 'an book ✗', persian: 'غلط'),
        A1BasicExample(english: 'the books ✓', persian: 'کتاب‌های مشخص، درست'),
        A1BasicExample(english: 'books ✓', persian: 'کتاب‌ها به طور کلی، درست'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'practice',
      title: 'Guided Practice',
      titleFa: 'تمرین هدایت‌شده',
      body:
          'Choose the article that matches the noun and the meaning. Start with simple examples, then notice specific versus general plural nouns.',
      bodyFa:
          'حرف تعریف مناسب را بر اساس اسم و معنی انتخاب کن. اول از مثال‌های ساده شروع کن و بعد تفاوت جمع کلی و جمع مشخص را تشخیص بده.',
      examples: [
        A1BasicExample(english: 'I have ___ dog. → a', persian: 'من یک سگ دارم. → a'),
        A1BasicExample(english: 'She ate ___ apple. → an', persian: 'او یک سیب خورد. → an'),
        A1BasicExample(english: '___ sun is hot. → The', persian: 'خورشید داغ است. → The'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'production',
      title: 'Independent Production',
      titleFa: 'تولید مستقل',
      body:
          'Translate short sentences and choose the article without a rule prompt. Focus on meaning, not memorizing a single sentence.',
      bodyFa:
          'چند جمله کوتاه را بدون راهنمایی مستقیم ترجمه کن. روی معنی جمله تمرکز کن، نه حفظ کردن یک جمله خاص.',
      examples: [
        A1BasicExample(english: 'I have a car.', persian: 'من یک ماشین دارم.'),
        A1BasicExample(english: 'The books are new.', persian: 'آن کتاب‌های مشخص جدید هستند.'),
        A1BasicExample(english: 'Books are useful.', persian: 'کتاب‌ها به طور کلی مفیدند.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'real_world',
      title: 'Real-World Use',
      titleFa: 'کاربرد واقعی',
      body:
          'Imagine you are describing things around you. Introduce one thing with a or an, then use the when you mean that specific thing.',
      bodyFa:
          'فرض کن داری چیزهای اطرافت را توصیف می‌کنی. یک چیز را اول با a یا an معرفی کن و وقتی بعداً به همان چیز مشخص اشاره می‌کنی، از the استفاده کن.',
      examples: [
        A1BasicExample(
          english: 'I see a cat. The cat is small.',
          persian: 'یک گربه می‌بینم. آن گربه کوچک است.',
        ),
        A1BasicExample(
          english: 'I have an apple. The apple is red.',
          persian: 'یک سیب دارم. آن سیب قرمز است.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'speaking',
      title: 'Speaking',
      titleFa: 'تمرین تلفظ و لهجه',
      body:
          'Say the examples aloud. Pay attention to the sound difference between a and an, and pronounce the final sounds in plural nouns clearly.',
      bodyFa:
          'مثال‌ها را با صدای بلند بگو. به تفاوت صدای a و an و همچنین تلفظ صدای پایانی اسم‌های جمع دقت کن.',
      examples: [
        A1BasicExample(english: 'a book', persian: 'یک کتاب', pronunciation: 'اَ بوک'),
        A1BasicExample(english: 'an apple', persian: 'یک سیب', pronunciation: 'اَن اَپِل'),
        A1BasicExample(english: 'the book', persian: 'آن کتاب', pronunciation: 'ذِ بوک'),
        A1BasicExample(english: 'books', persian: 'کتاب‌ها', pronunciation: 'بوکس'),
        A1BasicExample(english: 'the books', persian: 'کتاب‌های مشخص', pronunciation: 'ذِ بوکس'),
      ],
    ),
  ],
  examples: [
    A1BasicExample(english: 'a book', persian: 'یک کتاب', pronunciation: 'اَ بوک'),
    A1BasicExample(english: 'an apple', persian: 'یک سیب', pronunciation: 'اَن اَپِل'),
    A1BasicExample(english: 'the book', persian: 'آن کتاب', pronunciation: 'ذِ بوک'),
    A1BasicExample(english: 'books', persian: 'کتاب‌ها', pronunciation: 'بوکس'),
  ],
  questions: const [],
  speakingQuestions: [
    A1BasicSpeakingQuestion(
      question: 'a book',
      persian: 'یک کتاب',
      acceptableAnswers: ['a book'],
    ),
    A1BasicSpeakingQuestion(
      question: 'an apple',
      persian: 'یک سیب',
      acceptableAnswers: ['an apple'],
    ),
    A1BasicSpeakingQuestion(
      question: 'The book is good.',
      persian: 'آن کتاب خوب است.',
      acceptableAnswers: ['the book is good', 'the book is good.'],
    ),
    A1BasicSpeakingQuestion(
      question: 'Books are useful.',
      persian: 'کتاب‌ها به طور کلی مفیدند.',
      acceptableAnswers: ['books are useful', 'books are useful.'],
    ),
    A1BasicSpeakingQuestion(
      question: 'The books are on the shelf.',
      persian: 'کتاب‌های مشخص روی قفسه هستند.',
      acceptableAnswers: [
        'the books are on the shelf',
        'the books are on the shelf.',
      ],
    ),
  ],
  vocabulary: [
    A1BasicVocabulary(
      english: 'book',
      persian: 'کتاب',
      pronunciation: 'بوک',
      example: 'a book',
    ),
    A1BasicVocabulary(
      english: 'apple',
      persian: 'سیب',
      pronunciation: 'اَپِل',
      example: 'an apple',
    ),
    A1BasicVocabulary(
      english: 'car',
      persian: 'ماشین',
      pronunciation: 'کار',
      example: 'a car',
    ),
    A1BasicVocabulary(
      english: 'orange',
      persian: 'پرتقال',
      pronunciation: 'اورِنج',
      example: 'an orange',
    ),
    A1BasicVocabulary(
      english: 'shelf',
      persian: 'قفسه',
      pronunciation: 'شِلف',
      example: 'the books are on the shelf',
    ),
    A1BasicVocabulary(
      english: 'child',
      persian: 'کودک',
      pronunciation: 'چایلد',
      example: 'a child',
    ),
    A1BasicVocabulary(
      english: 'children',
      persian: 'کودکان',
      pronunciation: 'چیلدرِن',
      example: 'children like books',
    ),
    A1BasicVocabulary(
      english: 'man',
      persian: 'مرد',
      pronunciation: 'مَن',
      example: 'a man',
    ),
    A1BasicVocabulary(
      english: 'men',
      persian: 'مردان',
      pronunciation: 'مِن',
      example: 'men',
    ),
    A1BasicVocabulary(
      english: 'woman',
      persian: 'زن',
      pronunciation: 'وومِن',
      example: 'a woman',
    ),
    A1BasicVocabulary(
      english: 'women',
      persian: 'زنان',
      pronunciation: 'ویمِن',
      example: 'women',
    ),
  ],
  sections: [
    A1BasicSection(
      title: 'A, An, The, and Plurals',
      titleFa: 'A، An، The و اسم‌های جمع',
      explanation:
          'Articles come before nouns and help show whether a noun is indefinite or specific. Plural nouns follow different article patterns.',
      explanationFa:
          'حروف تعریف قبل از اسم می‌آیند و به ما کمک می‌کنند بفهمیم اسم نامشخص است یا مشخص. اسم‌های جمع هم الگوی متفاوتی برای حرف تعریف دارند.',
      examples: [
        A1BasicExample(english: 'a book', persian: 'یک کتاب'),
        A1BasicExample(english: 'an apple', persian: 'یک سیب'),
        A1BasicExample(english: 'the book', persian: 'آن کتاب'),
        A1BasicExample(english: 'books', persian: 'کتاب‌ها به طور کلی'),
      ],
    ),
    A1BasicSection(
      title: 'A or An?',
      titleFa: 'A یا An؟',
      explanation:
          'Use a before a consonant sound and an before a vowel sound in simple singular examples.',
      explanationFa:
          'در مثال‌های ساده، قبل از صدای صامت از a و قبل از صدای واکه از an استفاده می‌کنیم.',
      examples: [
        A1BasicExample(english: 'a car', persian: 'یک ماشین'),
        A1BasicExample(english: 'an apple', persian: 'یک سیب'),
        A1BasicExample(english: 'an egg', persian: 'یک تخم‌مرغ'),
      ],
    ),
    A1BasicSection(
      title: 'The for Specific Things',
      titleFa: 'The برای چیزهای مشخص',
      explanation:
          'Use the when the listener can identify the specific thing, including something already mentioned.',
      explanationFa:
          'وقتی منظورمان چیز مشخصی است که شنونده می‌تواند آن را تشخیص دهد، از the استفاده می‌کنیم؛ از جمله چیزی که قبلاً معرفی شده است.',
      examples: [
        A1BasicExample(
          english: 'I saw a dog. The dog was big.',
          persian: 'یک سگ دیدم. آن سگ بزرگ بود.',
        ),
        A1BasicExample(english: 'The sun is hot.', persian: 'خورشید داغ است.'),
      ],
    ),
    A1BasicSection(
      title: 'Plural Nouns',
      titleFa: 'اسم‌های جمع',
      explanation:
          'A and an only work with singular nouns. General plural nouns can appear without an article, while specific plural nouns can use the.',
      explanationFa:
          'a و an فقط با اسم مفرد می‌آیند. اسم جمعِ کلی می‌تواند بدون حرف تعریف بیاید و اسم جمعِ مشخص می‌تواند با the بیاید.',
      examples: [
        A1BasicExample(english: 'books', persian: 'کتاب‌ها به طور کلی'),
        A1BasicExample(english: 'the books', persian: 'کتاب‌های مشخص'),
        A1BasicExample(english: '❌ a books', persian: 'غلط'),
      ],
    ),
  ],
);