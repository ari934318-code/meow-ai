import 'a1_basics_exam_models.dart';

const List<A1BasicsExamQuestion> a1BasicsExamQuestions = [
  // ============================================================
  // PRONOUNS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_001',
    lessonId: 'a1_basic_01',
    topic: 'Pronouns',
    category: 'Grammar',
    question: '___ am a student.',
    options: ['I', 'He', 'They', 'She'],
    correctAnswer: 'I',
    explanation: 'Use "I" when you are talking about yourself.',
    persian: 'من دانش‌آموز هستم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_002',
    lessonId: 'a1_basic_01',
    topic: 'Pronouns',
    category: 'Grammar',
    question: 'Sara is my friend. ___ is very kind.',
    options: ['He', 'She', 'It', 'They'],
    correctAnswer: 'She',
    explanation: 'Use "she" for a female person.',
    persian: 'سارا دوست من است. او خیلی مهربان است.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // TO BE
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_003',
    lessonId: 'a1_basic_02',
    topic: 'To Be',
    category: 'Grammar',
    question: 'I ___ tired today.',
    options: ['am', 'is', 'are', 'be'],
    correctAnswer: 'am',
    explanation: 'Use "am" with the subject "I".',
    persian: 'من امروز خسته هستم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_004',
    lessonId: 'a1_basic_02',
    topic: 'To Be',
    category: 'Sentence Building',
    question: 'Choose the correct sentence.',
    options: [
      'She is happy.',
      'She are happy.',
      'She am happy.',
      'She be happy.',
    ],
    correctAnswer: 'She is happy.',
    explanation: 'Use "is" with he, she, and it.',
    persian: 'او خوشحال است.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // HAVE / HAS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_005',
    lessonId: 'a1_basic_03',
    topic: 'Have / Has',
    category: 'Grammar',
    question: 'He ___ a new phone.',
    options: ['have', 'has', 'having', 'haves'],
    correctAnswer: 'has',
    explanation: 'Use "has" with he, she, and it.',
    persian: 'او یک گوشی جدید دارد.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_006',
    lessonId: 'a1_basic_03',
    topic: 'Have / Has',
    category: 'Sentence Building',
    question: 'Choose the correct sentence.',
    options: [
      'They have two cats.',
      'They has two cats.',
      'They having two cats.',
      'They haves two cats.',
    ],
    correctAnswer: 'They have two cats.',
    explanation: 'Use "have" with I, you, we, and they.',
    persian: 'آن‌ها دو گربه دارند.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // DO / DOES
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_007',
    lessonId: 'a1_basic_04',
    topic: 'Do / Does',
    category: 'Grammar',
    question: '___ you like coffee?',
    options: ['Do', 'Does', 'Is', 'Are'],
    correctAnswer: 'Do',
    explanation: 'Use "do" with I, you, we, and they in present simple questions.',
    persian: 'آیا قهوه دوست داری؟',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_008',
    lessonId: 'a1_basic_04',
    topic: 'Do / Does',
    category: 'Grammar',
    question: 'She ___ like spicy food.',
    options: ['doesn’t', 'don’t', 'isn’t', 'aren’t'],
    correctAnswer: 'doesn’t',
    explanation: 'Use "doesn’t" with he, she, and it.',
    persian: 'او غذای تند دوست ندارد.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // REGULAR VERBS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_009',
    lessonId: 'a1_basic_05',
    topic: 'Present Simple',
    category: 'Grammar',
    question: 'She ___ English every day.',
    options: ['study', 'studies', 'studying', 'studys'],
    correctAnswer: 'studies',
    explanation: 'With he, she, and it, study changes to studies in a positive present simple sentence.',
    persian: 'او هر روز انگلیسی می‌خواند.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_010',
    lessonId: 'a1_basic_05',
    topic: 'Present Simple',
    category: 'Grammar',
    question: 'She ___ English every day.',
    options: ['doesn’t study', 'doesn’t studies', 'don’t study', 'not study'],
    correctAnswer: 'doesn’t study',
    explanation: 'After doesn’t, use the base verb.',
    persian: 'او هر روز انگلیسی نمی‌خواند.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // SIMPLE WH-QUESTIONS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_017',
    lessonId: 'a1_basic_06',
    topic: 'Simple WH-Questions',
    category: 'Grammar',
    question: '___ do you live?',
    options: ['Where', 'Who', 'When', 'Why'],
    correctAnswer: 'Where',
    explanation: 'Use "where" to ask about a place.',
    persian: 'کجا زندگی می‌کنی؟',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // OBJECT PRONOUNS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_019',
    lessonId: 'a1_basic_07',
    topic: 'Object Pronouns',
    category: 'Grammar',
    question: 'I see Sara. I see ___.',
    options: ['her', 'she', 'hers', 'herself'],
    correctAnswer: 'her',
    explanation: 'Sara is the object of see, so use the object pronoun "her".',
    persian: 'من سارا را می‌بینم. من ___ را می‌بینم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // CAN / CAN'T
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_020',
    lessonId: 'a1_basic_10',
    topic: 'Can / Can’t',
    category: 'Grammar',
    question: 'She ___ swim.',
    options: ['can', 'cans', 'can to', 'is can'],
    correctAnswer: 'can',
    explanation: 'Use can + base verb to talk about ability.',
    persian: 'او می‌تواند شنا کند.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // ARTICLES + PLURALS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_018',
    lessonId: 'a1_basic_09',
    topic: 'Articles + Plurals',
    category: 'Grammar',
    question: 'I have ___ apple.',
    options: ['an', 'a', 'the', 'some'],
    correctAnswer: 'an',
    explanation: 'Use "an" before a singular noun that begins with a vowel sound.',
    persian: 'من یک سیب دارم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // REGULAR PAST
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_026',
    lessonId: 'a1_basic_12',
    topic: 'Regular Past',
    category: 'Grammar',
    question: 'Yesterday, I ___ at home.',
    options: ['worked', 'work', 'working', 'works'],
    correctAnswer: 'worked',
    explanation: 'Regular past verbs commonly use -ed for a completed action in the past.',
    persian: 'دیروز در خانه کار کردم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // IRREGULAR PAST
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_025',
    lessonId: 'a1_basic_13',
    topic: 'Irregular Past',
    category: 'Grammar',
    question: 'I ___ to the store yesterday.',
    options: ['went', 'go', 'goed', 'going'],
    correctAnswer: 'went',
    explanation: '"Go" has the irregular past form "went".',
    persian: 'دیروز به فروشگاه رفتم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // PRESENT CONTINUOUS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_021',
    lessonId: 'a1_basic_14',
    topic: 'Present Continuous',
    category: 'Grammar',
    question: 'She ___ studying now.',
    options: ['is', 'are', 'am', 'be'],
    correctAnswer: 'is',
    explanation: 'Use "is" with she in the present continuous: she is studying.',
    persian: 'او الان در حال درس خواندن است.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // WILL / GOING TO
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_022',
    lessonId: 'a1_basic_15',
    topic: 'Will / Going to',
    category: 'Grammar',
    question: 'I think it ___ rain tomorrow.',
    options: ['will', 'am going to', 'is', 'does'],
    correctAnswer: 'will',
    explanation: 'Use "will" for a prediction or opinion about the future.',
    persian: 'فکر می‌کنم فردا باران خواهد بارید.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // FULL WH-QUESTIONS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_023',
    lessonId: 'a1_basic_16',
    topic: 'Full WH-Questions',
    category: 'Grammar',
    question: 'Where ___ you go yesterday?',
    options: ['did', 'do', 'does', 'are'],
    correctAnswer: 'did',
    explanation: 'Use "did" to form a past simple WH-question.',
    persian: 'دیروز کجا رفتی؟',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // POSSESSIVE ADJECTIVES
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_024',
    lessonId: 'a1_basic_08',
    topic: 'Possessive Adjectives',
    category: 'Grammar',
    question: 'This is ___ book. I bought it yesterday.',
    options: ['my', 'me', 'mine', 'I'],
    correctAnswer: 'my',
    explanation: 'Use "my" before a noun to show possession.',
    persian: 'این کتاب من است. دیروز آن را خریدم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_027',
    lessonId: 'a1_basic_08',
    topic: 'Possessive Adjectives',
    category: 'Grammar',
    question: 'They love ___ dog.',
    options: ['their', 'them', 'they', 'theirs'],
    correctAnswer: 'their',
    explanation: 'Use "their" before a noun when something belongs to they/them.',
    persian: 'آن‌ها سگشان را دوست دارند.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // SPEAKING
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_033',
    lessonId: 'a1_basic_01',
    topic: 'Pronouns',
    category: 'Speaking',
    question: 'Introduce yourself. Say your name.',
    options: [],
    correctAnswer: 'My name is ...',
    explanation: 'Use a simple sentence with "My name is..." to introduce yourself.',
    persian: 'خودت را معرفی کن و اسمت را بگو.',
    isSpeaking: true,
    acceptableAnswers: [
      'my name is',
      'i am',
      "i'm",
    ],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_034',
    lessonId: 'a1_basic_02',
    topic: 'To Be',
    category: 'Speaking',
    question: 'Say: "I am happy."',
    options: [],
    correctAnswer: 'I am happy.',
    explanation: 'Use "am" with the subject "I".',
    persian: 'بگو: من خوشحالم.',
    isSpeaking: true,
    acceptableAnswers: [
      'i am happy',
      "i'm happy",
    ],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_035',
    lessonId: 'a1_basic_10',
    topic: 'Can / Can’t',
    category: 'Speaking',
    question: 'Say: "I can swim."',
    options: [],
    correctAnswer: 'I can swim.',
    explanation: 'Use "can" followed by the base form of the verb.',
    persian: 'بگو: من می‌توانم شنا کنم.',
    isSpeaking: true,
    acceptableAnswers: [
      'i can swim',
    ],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_036',
    lessonId: 'a1_basic_11',
    topic: 'Must / Mustn’t',
    category: 'Speaking',
    question: 'Say: "I must study every day."',
    options: [],
    correctAnswer: 'I must study every day.',
    explanation: 'Use "must" followed by the base form of the verb.',
    persian: 'بگو: من باید هر روز درس بخوانم.',
    isSpeaking: true,
    acceptableAnswers: [
      'i must study every day',
      'i must study everyday',
    ],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_037',
    lessonId: 'a1_basic_05',
    topic: 'Present Simple',
    category: 'Speaking',
    question: 'Say: "I study every day."',
    options: [],
    correctAnswer: 'I study every day.',
    explanation: 'Use the present simple to talk about habits and routines.',
    persian: 'بگو: من هر روز درس می‌خوانم.',
    isSpeaking: true,
    acceptableAnswers: [
      'i study every day',
      'i study everyday',
    ],
  ),
];