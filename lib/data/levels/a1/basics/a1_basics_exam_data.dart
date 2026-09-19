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
  // OBJECT PRONOUNS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_011',
    lessonId: 'a1_basic_07',
    topic: 'Object Pronouns',
    category: 'Grammar',
    question: 'I see Sara every day. I see ___.',
    options: ['she', 'her', 'hers', 'herself'],
    correctAnswer: 'her',
    explanation: 'Her is the object pronoun for she.',
    persian: 'من هر روز سارا را می‌بینم. من او را می‌بینم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_012',
    lessonId: 'a1_basic_07',
    topic: 'Object Pronouns',
    category: 'Grammar',
    question: 'Can you help ___?',
    options: ['I', 'me', 'my', 'mine'],
    correctAnswer: 'me',
    explanation: 'Me is the object pronoun for I.',
    persian: 'می‌توانی به من کمک کنی؟',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // CAN / CAN'T
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_013',
    lessonId: 'a1_basic_10',
    topic: 'Can / Can’t',
    category: 'Grammar',
    question: 'I can ___ English.',
    options: ['speak', 'speaks', 'speaking', 'spoke'],
    correctAnswer: 'speak',
    explanation: 'After "can", always use the base form of the verb.',
    persian: 'من می‌توانم انگلیسی صحبت کنم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_014',
    lessonId: 'a1_basic_10',
    topic: 'Can / Can’t',
    category: 'Grammar',
    question: 'Choose the correct sentence.',
    options: [
      'She can swim.',
      'She can swims.',
      'She cans swim.',
      'She can swimming.',
    ],
    correctAnswer: 'She can swim.',
    explanation: 'Can is followed by the base form of the verb.',
    persian: 'او می‌تواند شنا کند.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // MUST / MUSTN'T
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_015',
    lessonId: 'a1_basic_11',
    topic: 'Must / Mustn’t',
    category: 'Grammar',
    question: 'You must ___ your homework.',
    options: ['do', 'does', 'doing', 'did'],
    correctAnswer: 'do',
    explanation: 'After "must", use the base form of the verb.',
    persian: 'باید تکالیفت را انجام بدهی.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_016',
    lessonId: 'a1_basic_11',
    topic: 'Must / Mustn’t',
    category: 'Vocabulary',
    question: 'What does "You mustn’t smoke here" mean?',
    options: [
      'Smoking is not allowed here.',
      'Smoking is required here.',
      'You can smoke here.',
      'You like smoking here.',
    ],
    correctAnswer: 'Smoking is not allowed here.',
    explanation: '"Mustn’t" means something is prohibited or not allowed.',
    persian: 'اینجا نباید سیگار بکشی.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // OBJECT PRONOUNS
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_017',
    lessonId: 'a1_basic_07',
    topic: 'Object Pronouns',
    category: 'Grammar',
    question: 'Can you help ___?',
    options: ['I', 'me', 'my', 'mine'],
    correctAnswer: 'me',
    explanation: '"Me" is the object pronoun for "I".',
    persian: 'می‌توانی به من کمک کنی؟',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_018',
    lessonId: 'a1_basic_07',
    topic: 'Object Pronouns',
    category: 'Grammar',
    question: 'I know Sara. I see ___ every day.',
    options: ['she', 'her', 'hers', 'herself'],
    correctAnswer: 'her',
    explanation: '"Her" is the object pronoun for "she".',
    persian: 'من سارا را می‌شناسم. هر روز او را می‌بینم.',
    isSpeaking: false,
    acceptableAnswers: [],
  ),

  // ============================================================
  // POSSESSIVE ADJECTIVES
  // ============================================================

  A1BasicsExamQuestion(
    id: 'basics_exam_019',
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
    id: 'basics_exam_020',
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
    question: 'Say one thing you can do.',
    options: [],
    correctAnswer: 'I can ...',
    explanation: 'Use "can" followed by the base form of the verb.',
    persian: 'یک کاری که می‌توانی انجام بدهی بگو.',
    isSpeaking: true,
    acceptableAnswers: [
      'i can',
    ],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_036',
    lessonId: 'a1_basic_11',
    topic: 'Must / Mustn’t',
    category: 'Speaking',
    question: 'Say one thing you must do every day.',
    options: [],
    correctAnswer: 'I must ...',
    explanation: 'Use "must" followed by the base form of the verb.',
    persian: 'یک کاری که هر روز باید انجام بدهی بگو.',
    isSpeaking: true,
    acceptableAnswers: [
      'i must',
    ],
  ),

  A1BasicsExamQuestion(
    id: 'basics_exam_037',
    lessonId: 'a1_basic_05',
    topic: 'Present Simple',
    category: 'Speaking',
    question: 'Tell me one thing you do every day.',
    options: [],
    correctAnswer: 'I ... every day.',
    explanation: 'Use the present simple to talk about habits and routines.',
    persian: 'یک کاری که هر روز انجام می‌دهی بگو.',
    isSpeaking: true,
    acceptableAnswers: [
      'i',
      'every day',
      'everyday',
    ],
  ),
];