class B1Lesson01Data {
  static const String id = 'b1_lesson_01';

  static const String titleEn = 'Life Experiences';
  static const String titleFa = 'تجربه‌های زندگی';

  static const String topicEn = 'Talking about experiences';
  static const String topicFa = 'صحبت درباره تجربه‌های زندگی';

  // ============================================================
  // VOCABULARY
  // ============================================================

  static const List<B1VocabularyItem> vocabulary = [
    B1VocabularyItem(
      word: 'experience',
      pronunciation: '/ɪkˈspɪəriəns/',
      meaningFa: 'تجربه',
      partOfSpeech: 'noun',
      exampleEn: 'It was an amazing experience.',
      exampleFa: 'این یک تجربه فوق‌العاده بود.',
      acceptedAnswers: [
        'تجربه',
        'experience',
      ],
    ),

    B1VocabularyItem(
      word: 'adventure',
      pronunciation: '/ədˈventʃər/',
      meaningFa: 'ماجراجویی',
      partOfSpeech: 'noun',
      exampleEn: 'We had an exciting adventure in the mountains.',
      exampleFa: 'ما در کوهستان یک ماجراجویی هیجان‌انگیز داشتیم.',
      acceptedAnswers: [
        'ماجراجویی',
        'ماجرا',
        'adventure',
      ],
    ),

    B1VocabularyItem(
      word: 'journey',
      pronunciation: '/ˈdʒɜːrni/',
      meaningFa: 'سفر',
      partOfSpeech: 'noun',
      exampleEn: 'The journey took six hours.',
      exampleFa: 'سفر شش ساعت طول کشید.',
      acceptedAnswers: [
        'سفر',
        'journey',
      ],
    ),

    B1VocabularyItem(
      word: 'discover',
      pronunciation: '/dɪˈskʌvər/',
      meaningFa: 'کشف کردن',
      partOfSpeech: 'verb',
      exampleEn: 'I discovered a beautiful little village.',
      exampleFa: 'من یک روستای کوچک و زیبا کشف کردم.',
      acceptedAnswers: [
        'کشف کردن',
        'کشف',
        'discover',
      ],
    ),

    B1VocabularyItem(
      word: 'memorable',
      pronunciation: '/ˈmemərəbəl/',
      meaningFa: 'به‌یادماندنی',
      partOfSpeech: 'adjective',
      exampleEn: 'It was a very memorable day.',
      exampleFa: 'آن روز خیلی به‌یادماندنی بود.',
      acceptedAnswers: [
        'به یاد ماندنی',
        'به‌یادماندنی',
        'فراموش نشدنی',
        'memorable',
      ],
    ),

    B1VocabularyItem(
      word: 'recently',
      pronunciation: '/ˈriːsəntli/',
      meaningFa: 'اخیراً',
      partOfSpeech: 'adverb',
      exampleEn: 'I have recently started a new job.',
      exampleFa: 'من اخیراً یک شغل جدید شروع کرده‌ام.',
      acceptedAnswers: [
        'اخیرا',
        'اخیراً',
        'recently',
      ],
    ),

    B1VocabularyItem(
      word: 'abroad',
      pronunciation: '/əˈbrɔːd/',
      meaningFa: 'خارج از کشور',
      partOfSpeech: 'adverb',
      exampleEn: 'She has never studied abroad.',
      exampleFa: 'او هرگز در خارج از کشور تحصیل نکرده است.',
      acceptedAnswers: [
        'خارج از کشور',
        'خارج',
        'abroad',
      ],
    ),

    B1VocabularyItem(
      word: 'achievement',
      pronunciation: '/əˈtʃiːvmənt/',
      meaningFa: 'دستاورد',
      partOfSpeech: 'noun',
      exampleEn: 'Winning the competition was a great achievement.',
      exampleFa: 'برنده شدن در مسابقه یک دستاورد بزرگ بود.',
      acceptedAnswers: [
        'دستاورد',
        'موفقیت',
        'achievement',
      ],
    ),

    B1VocabularyItem(
      word: 'challenge',
      pronunciation: '/ˈtʃælɪndʒ/',
      meaningFa: 'چالش',
      partOfSpeech: 'noun',
      exampleEn: 'Learning a new language can be a challenge.',
      exampleFa: 'یادگیری یک زبان جدید می‌تواند یک چالش باشد.',
      acceptedAnswers: [
        'چالش',
        'challenge',
      ],
    ),

    B1VocabularyItem(
      word: 'opportunity',
      pronunciation: '/ˌɑːpərˈtuːnəti/',
      meaningFa: 'فرصت',
      partOfSpeech: 'noun',
      exampleEn: 'I had an opportunity to travel abroad.',
      exampleFa: 'فرصتی داشتم که به خارج از کشور سفر کنم.',
      acceptedAnswers: [
        'فرصت',
        'opportunity',
      ],
    ),

    B1VocabularyItem(
      word: 'ever',
      pronunciation: '/ˈevər/',
      meaningFa: 'تا به حال',
      partOfSpeech: 'adverb',
      exampleEn: 'Have you ever tried sushi?',
      exampleFa: 'آیا تا به حال سوشی امتحان کرده‌ای؟',
      acceptedAnswers: [
        'تا به حال',
        'تا حالا',
        'ever',
      ],
    ),

    B1VocabularyItem(
      word: 'never',
      pronunciation: '/ˈnevər/',
      meaningFa: 'هرگز',
      partOfSpeech: 'adverb',
      exampleEn: 'I have never been to Canada.',
      exampleFa: 'من هرگز به کانادا نرفته‌ام.',
      acceptedAnswers: [
        'هرگز',
        'هیچ وقت',
        'never',
      ],
    ),
  ];

  // ============================================================
  // GRAMMAR
  // ============================================================

  static const B1GrammarSection grammar = B1GrammarSection(
    titleEn: 'Present Perfect vs Past Simple',
    titleFa: 'Present Perfect در برابر Past Simple',

    explanationEn:
        'We often use the Present Perfect to talk about experiences in our lives when we do not say exactly when they happened. We use the Past Simple when we talk about a finished action at a specific time in the past.',

    explanationFa:
        'از Present Perfect معمولاً برای صحبت درباره تجربه‌هایی استفاده می‌کنیم که زمان دقیق آن‌ها را مشخص نمی‌کنیم. از Past Simple برای اتفاق‌هایی استفاده می‌کنیم که در زمان مشخصی در گذشته رخ داده و تمام شده‌اند.',

    formulaEn: [
      'Present Perfect: have / has + past participle',
      'Past Simple: subject + past form of the verb',
    ],

    examples: [
      B1GrammarExample(
        english: 'I have visited Italy.',
        persian: 'من از ایتالیا دیدن کرده‌ام.',
        explanation:
            'The exact time is not important or not mentioned.',
      ),
      B1GrammarExample(
        english: 'I visited Italy in 2024.',
        persian: 'من در سال ۲۰۲۴ از ایتالیا دیدن کردم.',
        explanation:
            'A specific finished time is given.',
      ),
      B1GrammarExample(
        english: 'Have you ever traveled alone?',
        persian: 'آیا تا به حال تنها سفر کرده‌ای؟',
        explanation:
            'We are asking about life experience, not a specific time.',
      ),
      B1GrammarExample(
        english: 'Did you travel alone last summer?',
        persian: 'تابستان گذشته تنها سفر کردی؟',
        explanation:
            'Last summer is a finished and specific time.',
      ),
    ],

    commonMistakes: [
      B1CommonMistake(
        wrong: 'I have seen him yesterday.',
        correct: 'I saw him yesterday.',
        explanationFa:
            'وقتی زمان مشخص و تمام‌شده‌ای مثل yesterday داریم، از Past Simple استفاده می‌کنیم.',
      ),
      B1CommonMistake(
        wrong: 'Did you ever visit London?',
        correct: 'Have you ever visited London?',
        explanationFa:
            'برای پرسیدن درباره تجربه زندگی بدون زمان مشخص، Present Perfect طبیعی‌تر و درست‌تر است.',
      ),
      B1CommonMistake(
        wrong: 'I have went to Spain.',
        correct: 'I have gone to Spain.',
        explanationFa:
            'بعد از have یا has باید شکل سوم فعل بیاید. شکل سوم go برابر gone است.',
      ),
    ],
  );

  // ============================================================
  // GRAMMAR PRACTICE
  // ============================================================

  static const List<B1Question> grammarPractice = [
    B1Question(
      question: 'I _____ to London three times.',
      options: [
        'have been',
        'was',
        'am',
        'did',
      ],
      correctAnswer: 'have been',
      explanationFa:
          'برای تجربه‌ای بدون زمان مشخص از Present Perfect استفاده می‌کنیم.',
    ),

    B1Question(
      question: 'She _____ Paris last year.',
      options: [
        'visited',
        'has visited',
        'visits',
        'has visit',
      ],
      correctAnswer: 'visited',
      explanationFa:
          'Last year یک زمان مشخص و تمام‌شده در گذشته است، پس Past Simple لازم است.',
    ),

    B1Question(
      question: 'Have you _____ tried skiing?',
      options: [
        'ever',
        'yesterday',
        'last year',
        'ago',
      ],
      correctAnswer: 'ever',
      explanationFa:
          'Ever برای پرسیدن درباره تجربه‌ای در طول زندگی استفاده می‌شود.',
    ),

    B1Question(
      question: 'I _____ this movie two days ago.',
      options: [
        'watched',
        'have watched',
        'watch',
        'have watch',
      ],
      correctAnswer: 'watched',
      explanationFa:
          'Two days ago زمان مشخصی در گذشته است.',
    ),

    B1Question(
      question: 'He has _____ his homework.',
      options: [
        'finished',
        'finish',
        'finishing',
        'finishes',
      ],
      correctAnswer: 'finished',
      explanationFa:
          'بعد از has در Present Perfect باید past participle بیاید.',
    ),

    B1Question(
      question: 'We _____ never _____ abroad.',
      options: [
        'have / traveled',
        'did / travel',
        'are / travel',
        'has / traveled',
      ],
      correctAnswer: 'have / traveled',
      explanationFa:
          'برای تجربه منفی در طول زندگی از have never + past participle استفاده می‌کنیم.',
    ),
  ];

  // ============================================================
  // TYPE THE ANSWER
  // ============================================================

  static const List<B1TypingQuestion> typingPractice = [
    B1TypingQuestion(
      promptEn: 'What does "experience" mean?',
      promptFa: 'معنی کلمه را بنویس.',
      acceptedAnswers: [
        'تجربه',
        'experience',
      ],
    ),

    B1TypingQuestion(
      promptEn: 'What does "memorable" mean?',
      promptFa: 'معنی کلمه را بنویس.',
      acceptedAnswers: [
        'به یاد ماندنی',
        'به‌یادماندنی',
        'فراموش نشدنی',
        'memorable',
      ],
    ),

    B1TypingQuestion(
      promptEn: 'Write the English word for "فرصت".',
      promptFa: 'کلمه انگلیسی را بنویس.',
      acceptedAnswers: [
        'opportunity',
      ],
    ),

    B1TypingQuestion(
      promptEn: 'Write the English word for "دستاورد".',
      promptFa: 'کلمه انگلیسی را بنویس.',
      acceptedAnswers: [
        'achievement',
      ],
    ),

    B1TypingQuestion(
      promptEn: 'Write the English word for "ماجراجویی".',
      promptFa: 'کلمه انگلیسی را بنویس.',
      acceptedAnswers: [
        'adventure',
      ],
    ),
  ];

  // ============================================================
  // ERROR CORRECTION
  // ============================================================

  static const List<B1ErrorCorrectionQuestion> errorCorrection = [
    B1ErrorCorrectionQuestion(
      incorrectSentence: 'I have visited Rome last summer.',
      correctSentence: 'I visited Rome last summer.',
      explanationFa:
          'Last summer زمان مشخص و تمام‌شده‌ای است، بنابراین Past Simple استفاده می‌شود.',
    ),

    B1ErrorCorrectionQuestion(
      incorrectSentence: 'Have you ever went to Japan?',
      correctSentence: 'Have you ever been to Japan?',
      explanationFa:
          'بعد از have باید شکل سوم فعل بیاید و برای تجربه رفتن به یک مکان، have been طبیعی است.',
    ),

    B1ErrorCorrectionQuestion(
      incorrectSentence: 'She has saw this movie before.',
      correctSentence: 'She has seen this movie before.',
      explanationFa:
          'شکل سوم see برابر seen است.',
    ),
  ];

  // ============================================================
  // SENTENCE TRANSFORMATION
  // ============================================================

  static const List<B1TransformationQuestion> transformations = [
    B1TransformationQuestion(
      originalSentence:
          'I started learning English three years ago.',
      instruction:
          'Rewrite the sentence using Present Perfect.',
      answer:
          'I have been learning English for three years.',
      answerFa:
          'من سه سال است که انگلیسی یاد می‌گیرم.',
    ),

    B1TransformationQuestion(
      originalSentence:
          'She visited Spain in 2024.',
      instruction:
          'Ask about her life experience without mentioning a specific time.',
      answer:
          'Has she ever visited Spain?',
      answerFa:
          'آیا او تا به حال از اسپانیا دیدن کرده است؟',
    ),
  ];

  // ============================================================
  // LISTENING
  // ============================================================

  static const List<B1ListeningQuestion> listening = [
    B1ListeningQuestion(
      audioText:
          'I have visited three countries, but I have never traveled alone. Last summer, I went to Italy with my best friend.',
      questionEn:
          'How many countries has the speaker visited?',
      questionFa:
          'گوینده از چند کشور دیدن کرده است؟',
      options: [
        'One',
        'Two',
        'Three',
        'Four',
      ],
      correctAnswer: 'Three',
    ),

    B1ListeningQuestion(
      audioText:
          'I have visited three countries, but I have never traveled alone. Last summer, I went to Italy with my best friend.',
      questionEn:
          'Who did the speaker travel to Italy with?',
      questionFa:
          'گوینده با چه کسی به ایتالیا سفر کرد؟',
      options: [
        'A family member',
        'A best friend',
        'A teacher',
        'Alone',
      ],
      correctAnswer: 'A best friend',
    ),
  ];

  // ============================================================
  // READING
  // ============================================================

  static const B1ReadingSection reading = B1ReadingSection(
    titleEn: 'A New Experience',
    titleFa: 'یک تجربه جدید',

    passageEn:
        'Last year, Sara decided to try something new. She had never traveled alone before, so she planned a short trip to another city. At first, she was nervous, but the journey became one of the most memorable experiences of her life. She visited several interesting places, met new people, and discovered a small café near the old town. Since that trip, she has become much more confident about traveling on her own.',

    passageFa:
        'سال گذشته، سارا تصمیم گرفت چیز جدیدی را امتحان کند. او قبلاً هرگز تنها سفر نکرده بود، بنابراین یک سفر کوتاه به شهری دیگر برنامه‌ریزی کرد. در ابتدا مضطرب بود، اما این سفر به یکی از به‌یادماندنی‌ترین تجربه‌های زندگی‌اش تبدیل شد. او از چند مکان جالب دیدن کرد، با افراد جدید آشنا شد و یک کافه کوچک نزدیک بخش قدیمی شهر پیدا کرد. از آن سفر به بعد، او درباره تنها سفر کردن اعتمادبه‌نفس بیشتری پیدا کرده است.',

    questions: [
      B1Question(
        question:
            'Why did Sara plan a trip to another city?',
        options: [
          'She wanted to try something new.',
          'She needed to find a new job.',
          'She wanted to visit her family.',
          'She had to study there.',
        ],
        correctAnswer:
            'She wanted to try something new.',
        explanationFa:
            'او می‌خواست تجربه جدیدی داشته باشد.',
      ),

      B1Question(
        question:
            'How did Sara feel at first?',
        options: [
          'Nervous',
          'Angry',
          'Bored',
          'Confused',
        ],
        correctAnswer: 'Nervous',
        explanationFa:
            'متن می‌گوید که در ابتدا nervous بود.',
      ),

      B1Question(
        question:
            'What did Sara discover?',
        options: [
          'A small café',
          'A new school',
          'A hotel',
          'A museum',
        ],
        correctAnswer: 'A small café',
        explanationFa:
            'او یک کافه کوچک نزدیک بخش قدیمی شهر پیدا کرد.',
      ),

      B1Question(
        question:
            'How has Sara changed since the trip?',
        options: [
          'She has become more confident.',
          'She has stopped traveling.',
          'She has become more nervous.',
          'She has moved to another country.',
        ],
        correctAnswer:
            'She has become more confident.',
        explanationFa:
            'در پایان متن گفته می‌شود که اعتمادبه‌نفس بیشتری برای سفر تنها پیدا کرده است.',
      ),
    ],
  );

  // ============================================================
  // SPEAKING
  // ============================================================

  static const List<B1SpeakingTask> speaking = [
    B1SpeakingTask(
      promptEn:
          'Talk about something interesting you have done in your life.',
      promptFa:
          'درباره یک کار جالب که در زندگی انجام داده‌ای صحبت کن.',
      suggestedTimeSeconds: 45,
      targetStructures: [
        'I have...',
        'I have never...',
        'It was...',
        'I felt...',
      ],
    ),

    B1SpeakingTask(
      promptEn:
          'Have you ever traveled somewhere memorable? Describe the experience.',
      promptFa:
          'آیا تا به حال به جای به‌یادماندنی‌ای سفر کرده‌ای؟ تجربه‌ات را توضیح بده.',
      suggestedTimeSeconds: 60,
      targetStructures: [
        'I have been...',
        'I went...',
        'I saw...',
        'It was...',
      ],
    ),
  ];

  // ============================================================
  // REAL ENGLISH
  // ============================================================

  static const List<B1RealEnglishItem> realEnglish = [
    B1RealEnglishItem(
      expression: 'Have you ever...?',
      meaningFa: 'تا به حال ...؟',
      usageEn:
          'A very common way to ask someone about their life experiences.',
      exampleEn: 'Have you ever tried camping?',
      exampleFa: 'تا به حال کمپینگ را امتحان کرده‌ای؟',
    ),

    B1RealEnglishItem(
      expression: 'I’ve never...',
      meaningFa: 'من هیچ‌وقت ... نکرده‌ام.',
      usageEn:
          'A natural way to say that something has never happened in your life.',
      exampleEn: 'I’ve never eaten sushi.',
      exampleFa: 'من هیچ‌وقت سوشی نخورده‌ام.',
    ),

    B1RealEnglishItem(
      expression: 'It was an amazing experience.',
      meaningFa: 'تجربه فوق‌العاده‌ای بود.',
      usageEn:
          'A common phrase for describing something memorable or impressive.',
      exampleEn:
          'The concert was an amazing experience.',
      exampleFa:
          'کنسرت تجربه فوق‌العاده‌ای بود.',
    ),
  ];

  // ============================================================
  // WRITING
  // ============================================================

  static const List<B1WritingTask> writing = [
    B1WritingTask(
      promptEn:
          'Write 60–80 words about an interesting experience you have had.',
      promptFa:
          'در ۶۰ تا ۸۰ کلمه درباره یک تجربه جالب که داشته‌ای بنویس.',
      requirements: [
        'Use Present Perfect at least once.',
        'Use Past Simple at least twice.',
        'Describe how you felt.',
        'Include at least three vocabulary words from this lesson.',
      ],
    ),
  ];

  // ============================================================
  // MIXED PRACTICE
  // ============================================================

  static const List<B1Question> mixedPractice = [
    B1Question(
      question:
          'Which sentence is correct?',
      options: [
        'I have visited Paris last year.',
        'I visited Paris last year.',
        'I have visit Paris last year.',
        'I visiting Paris last year.',
      ],
      correctAnswer:
          'I visited Paris last year.',
      explanationFa:
          'Last year زمان مشخص گذشته است، پس Past Simple استفاده می‌شود.',
    ),

    B1Question(
      question:
          'Which sentence asks about life experience?',
      options: [
        'Did you go there yesterday?',
        'Have you ever been there?',
        'Are you going there now?',
        'Will you go there tomorrow?',
      ],
      correctAnswer:
          'Have you ever been there?',
      explanationFa:
          'Have you ever برای پرسیدن درباره تجربه زندگی استفاده می‌شود.',
    ),

    B1Question(
      question:
          'Choose the correct form: She has _____ to London twice.',
      options: [
        'been',
        'went',
        'go',
        'going',
      ],
      correctAnswer: 'been',
      explanationFa:
          'بعد از has باید شکل سوم فعل بیاید. برای تجربه سفر، been مناسب است.',
    ),

    B1Question(
      question:
          'Which word means "فرصت"?',
      options: [
        'achievement',
        'challenge',
        'opportunity',
        'journey',
      ],
      correctAnswer: 'opportunity',
      explanationFa:
          'Opportunity به معنی فرصت است.',
    ),

    B1Question(
      question:
          'Which sentence is about a specific finished time?',
      options: [
        'I have never visited Spain.',
        'I have visited Spain.',
        'I visited Spain in 2023.',
        'I have ever visited Spain.',
      ],
      correctAnswer:
          'I visited Spain in 2023.',
      explanationFa:
          'سال ۲۰۲۳ زمان مشخصی است و جمله درباره اتفاقی تمام‌شده صحبت می‌کند.',
    ),
  ];

  // ============================================================
  // CHALLENGE
  // ============================================================

  static const B1ChallengeTask challenge = B1ChallengeTask(
    titleEn: 'Your Experience Story',
    titleFa: 'داستان تجربه تو',

    promptEn:
        'Imagine you are talking to a new friend. Tell them about two experiences you have had. For each experience, explain when it happened, what you did, and how you felt.',

    promptFa:
        'فرض کن با یک دوست جدید صحبت می‌کنی. درباره دو تجربه‌ای که داشته‌ای صحبت کن. برای هر تجربه بگو چه زمانی اتفاق افتاد، چه کار کردی و چه احساسی داشتی.',

    suggestedTimeSeconds: 90,

    requirements: [
      'Use Present Perfect at least once.',
      'Use Past Simple to describe specific events.',
      'Use at least four vocabulary words from this lesson.',
      'Speak in complete sentences.',
    ],
  );
}

// ================================================================
// DATA MODELS
// ================================================================

class B1VocabularyItem {
  final String word;
  final String pronunciation;
  final String meaningFa;
  final String partOfSpeech;
  final String exampleEn;
  final String exampleFa;
  final List<String> acceptedAnswers;

  const B1VocabularyItem({
    required this.word,
    required this.pronunciation,
    required this.meaningFa,
    required this.partOfSpeech,
    required this.exampleEn,
    required this.exampleFa,
    required this.acceptedAnswers,
  });
}

class B1GrammarSection {
  final String titleEn;
  final String titleFa;
  final String explanationEn;
  final String explanationFa;
  final List<String> formulaEn;
  final List<B1GrammarExample> examples;
  final List<B1CommonMistake> commonMistakes;

  const B1GrammarSection({
    required this.titleEn,
    required this.titleFa,
    required this.explanationEn,
    required this.explanationFa,
    required this.formulaEn,
    required this.examples,
    required this.commonMistakes,
  });
}

class B1GrammarExample {
  final String english;
  final String persian;
  final String explanation;

  const B1GrammarExample({
    required this.english,
    required this.persian,
    required this.explanation,
  });
}

class B1CommonMistake {
  final String wrong;
  final String correct;
  final String explanationFa;

  const B1CommonMistake({
    required this.wrong,
    required this.correct,
    required this.explanationFa,
  });
}

class B1Question {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanationFa;

  const B1Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanationFa,
  });
}

class B1TypingQuestion {
  final String promptEn;
  final String promptFa;
  final List<String> acceptedAnswers;

  const B1TypingQuestion({
    required this.promptEn,
    required this.promptFa,
    required this.acceptedAnswers,
  });
}

class B1ErrorCorrectionQuestion {
  final String incorrectSentence;
  final String correctSentence;
  final String explanationFa;

  const B1ErrorCorrectionQuestion({
    required this.incorrectSentence,
    required this.correctSentence,
    required this.explanationFa,
  });
}

class B1TransformationQuestion {
  final String originalSentence;
  final String instruction;
  final String answer;
  final String answerFa;

  const B1TransformationQuestion({
    required this.originalSentence,
    required this.instruction,
    required this.answer,
    required this.answerFa,
  });
}

class B1ListeningQuestion {
  final String audioText;
  final String questionEn;
  final String questionFa;
  final List<String> options;
  final String correctAnswer;

  const B1ListeningQuestion({
    required this.audioText,
    required this.questionEn,
    required this.questionFa,
    required this.options,
    required this.correctAnswer,
  });
}

class B1ReadingSection {
  final String titleEn;
  final String titleFa;
  final String passageEn;
  final String passageFa;
  final List<B1Question> questions;

  const B1ReadingSection({
    required this.titleEn,
    required this.titleFa,
    required this.passageEn,
    required this.passageFa,
    required this.questions,
  });
}

class B1SpeakingTask {
  final String promptEn;
  final String promptFa;
  final int suggestedTimeSeconds;
  final List<String> targetStructures;

  const B1SpeakingTask({
    required this.promptEn,
    required this.promptFa,
    required this.suggestedTimeSeconds,
    required this.targetStructures,
  });
}

class B1RealEnglishItem {
  final String expression;
  final String meaningFa;
  final String usageEn;
  final String exampleEn;
  final String exampleFa;

  const B1RealEnglishItem({
    required this.expression,
    required this.meaningFa,
    required this.usageEn,
    required this.exampleEn,
    required this.exampleFa,
  });
}

class B1WritingTask {
  final String promptEn;
  final String promptFa;
  final List<String> requirements;

  const B1WritingTask({
    required this.promptEn,
    required this.promptFa,
    required this.requirements,
  });
}

class B1ChallengeTask {
  final String titleEn;
  final String titleFa;
  final String promptEn;
  final String promptFa;
  final int suggestedTimeSeconds;
  final List<String> requirements;

  const B1ChallengeTask({
    required this.titleEn,
    required this.titleFa,
    required this.promptEn,
    required this.promptFa,
    required this.suggestedTimeSeconds,
    required this.requirements,
  });
}