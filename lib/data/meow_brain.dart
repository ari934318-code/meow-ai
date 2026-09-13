import 'dart:math';

enum MeowIntent {
  greeting,
  waterRequest,
  drinkRequest,
  foodRequest,
  bathroomRequest,
  helpRequest,
  translation,
  meaning,
  pronunciation,
  homework,
  speakingPractice,
  vocabularyPractice,
  writingPractice,
  reviewPractice,
  generalPractice,
  unknown,
}

enum MeowMood {
  calm,
  happy,
  surprised,
  angry,
  cheering,
}

class MeowResponse {
  final MeowIntent intent;
  final MeowMood mood;

  final String english;
  final String persian;
  final List<String> examples;
  final String? pronunciation;
  final String? note;

  const MeowResponse({
    required this.intent,
    required this.mood,
    required this.english,
    required this.persian,
    this.examples = const [],
    this.pronunciation,
    this.note,
  });
}

class MeowBrain {
  static final Random _random = Random();

  static String _normalize(String text) {
    return text
        .trim()
        .toLowerCase()
        .replaceAll('ي', 'ی')
        .replaceAll('ى', 'ی')
        .replaceAll('ك', 'ک')
        .replaceAll('ۀ', 'ه')
        .replaceAll('ة', 'ه')
        .replaceAll(RegExp(r'[؟?!.,،؛:()\[\]{}"“”]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  static bool _containsAny(String text, List<String> words) {
    for (final word in words) {
      if (text.contains(word)) {
        return true;
      }
    }
    return false;
  }

  static MeowResponse respond(String input) {
    final text = _normalize(input);

    if (text.isEmpty) {
      return const MeowResponse(
        intent: MeowIntent.unknown,
        mood: MeowMood.surprised,
        english: 'Tell me what you want to practice.',
        persian: 'بگو چی می‌خوای تمرین کنیم 😺',
      );
    }

    // ─────────────────────────────
    // GREETING
    // ─────────────────────────────

    if (_containsAny(text, [
      'سلام',
      'های',
      'هلو',
      'hello',
      'hi',
      'hey',
      'good morning',
      'good evening',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.greeting,
        mood: MeowMood.happy,
        english: 'Hi! Ready to practice some English? 🐱',
        persian: 'سلام! آماده‌ای کمی انگلیسی تمرین کنیم؟ 🐱',
        examples: [
          'Hi!',
          'Hello!',
          'Hey! How are you?',
        ],
      );
    }

    // ─────────────────────────────
    // WATER
    // ─────────────────────────────

    if (_containsAny(text, [
      'آب میخوام',
      'آب می‌خوام',
      'اب میخوام',
      'اب می‌خوام',
      'آب لازم دارم',
      'water',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.waterRequest,
        mood: MeowMood.happy,
        english: "I'd like some water, please.",
        persian: 'می‌خوام کمی آب، لطفاً.',
        pronunciation: 'آید لایک سام واتِر، پلیز',
        examples: [
          "I'd like some water, please.",
          'Can I have some water, please?',
          'Could I have some water?',
        ],
        note: 'برای درخواست مؤدبانه، "I’d like..." خیلی طبیعی و کاربردی است.',
      );
    }

    // ─────────────────────────────
    // DRINK
    // ─────────────────────────────

    if (_containsAny(text, [
      'نوشیدنی میخوام',
      'نوشیدنی می‌خوام',
      'یه نوشیدنی میخوام',
      'یک نوشیدنی میخوام',
      'نوشیدنی',
      'drink',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.drinkRequest,
        mood: MeowMood.happy,
        english: "I'd like a drink, please.",
        persian: 'یک نوشیدنی می‌خواهم، لطفاً.',
        pronunciation: 'آید لایک ا درینک، پلیز',
        examples: [
          "I'd like a drink, please.",
          'Can I have a drink, please?',
          'Could I get a drink?',
        ],
        note: 'در رستوران یا کافه، این جمله کاملاً طبیعی است.',
      );
    }

    // ─────────────────────────────
    // FOOD
    // ─────────────────────────────

    if (_containsAny(text, [
      'غذا میخوام',
      'غذا می‌خوام',
      'یه غذا میخوام',
      'یک غذا میخوام',
      'food',
      'hungry',
      'گرسنه',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.foodRequest,
        mood: MeowMood.happy,
        english: "I'd like something to eat, please.",
        persian: 'لطفاً یک چیزی برای خوردن می‌خواهم.',
        pronunciation: 'آید لایک سامثینگ تو ایت، پلیز',
        examples: [
          "I'd like something to eat.",
          'I’m hungry.',
          'Can I get something to eat?',
        ],
        note: 'برای بیان گرسنگی، "I’m hungry" ساده‌تر است.',
      );
    }

    // ─────────────────────────────
    // BATHROOM
    // ─────────────────────────────

    if (_containsAny(text, [
      'دستشویی',
      'سرویس بهداشتی',
      'حمام',
      'bathroom',
      'toilet',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.bathroomRequest,
        mood: MeowMood.calm,
        english: 'Excuse me, where is the bathroom?',
        persian: 'ببخشید، دستشویی کجاست؟',
        pronunciation: 'اِکسکیوز می، وِر ایز دِ بَث‌روم؟',
        examples: [
          'Where is the bathroom?',
          'Excuse me, where is the restroom?',
          'Is there a bathroom nearby?',
        ],
      );
    }

    // ─────────────────────────────
    // HELP
    // ─────────────────────────────

    if (_containsAny(text, [
      'کمک',
      'کمکم کن',
      'راهنمایی',
      'help',
      'i need help',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.helpRequest,
        mood: MeowMood.calm,
        english: 'How can I help you?',
        persian: 'چطور می‌تونم کمکت کنم؟',
        examples: [
          'Can you help me?',
          'I need some help.',
          'Could you help me, please?',
        ],
      );
    }

    // ─────────────────────────────
    // HOMEWORK
    // ─────────────────────────────

    if (_containsAny(text, [
      'تکلیف',
      'مشقم',
      'مشق',
      'homework',
    ])) {
      if (_containsAny(text, [
        'speaking',
        'اسپیکینگ',
        'صحبت',
        'حرف زدن',
        'گفتاری',
      ])) {
        return _speakingHomework();
      }

      if (_containsAny(text, [
        'vocabulary',
        'لغت',
        'کلمه',
        'واژگان',
      ])) {
        return _vocabularyHomework();
      }

      if (_containsAny(text, [
        'writing',
        'نوشتن',
        'رایتینگ',
      ])) {
        return _writingHomework();
      }

      if (_containsAny(text, [
        'translation',
        'ترجمه',
      ])) {
        return _translationHomework();
      }

      return _generalHomework();
    }

    // ─────────────────────────────
    // PRACTICE
    // ─────────────────────────────

    if (_containsAny(text, [
      'تمرین',
      'تمرین بده',
      'practice',
      'تمرین انگلیسی',
    ])) {
      if (_containsAny(text, [
        'speaking',
        'اسپیکینگ',
        'صحبت',
        'گفتاری',
      ])) {
        return const MeowResponse(
          intent: MeowIntent.speakingPractice,
          mood: MeowMood.cheering,
          english: 'Speaking Practice 🎤',
          persian:
              'این جمله را با صدای بلند بگو: "I’d like some water, please."',
          pronunciation: 'آید لایک سام واتِر، پلیز',
          examples: [
            'I’d like some water, please.',
          ],
          note: 'اول آرام بگو، بعد یک بار طبیعی‌تر تکرار کن.',
        );
      }

      if (_containsAny(text, [
        'لغت',
        'کلمه',
        'vocabulary',
      ])) {
        return _vocabularyPractice();
      }

      if (_containsAny(text, [
        'نوشتن',
        'writing',
        'رایتینگ',
      ])) {
        return _writingPractice();
      }

      if (_containsAny(text, [
        'ترجمه',
        'translation',
      ])) {
        return _translationPractice();
      }

      return const MeowResponse(
        intent: MeowIntent.generalPractice,
        mood: MeowMood.cheering,
        english: 'Let’s practice! 🐱',
        persian: 'بریم تمرین کنیم! 🐱',
        examples: [
          'I am learning English.',
          'I like coffee.',
          'I want some water.',
        ],
        note: 'می‌تونی از Meow بخوای speaking، vocabulary، writing یا translation تمرین بده.',
      );
    }

    // ─────────────────────────────
    // PRONUNCIATION
    // ─────────────────────────────

    if (_containsAny(text, [
      'تلفظ',
      'چطور تلفظ',
      'چجوری تلفظ',
      'pronunciation',
      'pronounce',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.pronunciation,
        mood: MeowMood.calm,
        english: 'Tell me the word or sentence you want to pronounce.',
        persian: 'کلمه یا جمله‌ای که می‌خوای تلفظش رو تمرین کنی بفرست.',
        examples: [
          'How do I pronounce "water"?',
          'How do I pronounce "comfortable"?',
          'How do I say this sentence?',
        ],
      );
    }

    // ─────────────────────────────
    // MEANING
    // ─────────────────────────────

    if (_containsAny(text, [
      'یعنی چی',
      'معنی',
      'معنیش',
      'what does',
      'meaning',
      'means',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.meaning,
        mood: MeowMood.calm,
        english: 'Send me the word or sentence and I’ll explain it.',
        persian: 'کلمه یا جمله رو بفرست تا معنی و کاربردش رو توضیح بدم.',
        examples: [
          'What does "awkward" mean?',
          'What does this sentence mean?',
          'What does "piece of cake" mean?',
        ],
      );
    }

    // ─────────────────────────────
    // TRANSLATION / HOW TO SAY
    // ─────────────────────────────

    if (_containsAny(text, [
      'چطور بگم',
      'چجوری بگم',
      'به انگلیسی چی میشه',
      'انگلیسیش چی میشه',
      'به انگلیسی',
      'ترجمه کن',
      'ترجمه',
      'how do i say',
      'how can i say',
      'translate',
    ])) {
      return _translationResponse(text);
    }

    // ─────────────────────────────
    // UNKNOWN
    // ─────────────────────────────

    return const MeowResponse(
      intent: MeowIntent.unknown,
      mood: MeowMood.surprised,
      english: "Hmm... I don't know that one yet. 😺",
      persian:
          'هوم... هنوز جواب دقیق این مورد رو توی مغزم ندارم 😺\nمی‌تونی ساده‌تر بپرسی یا بگی «چطور بگم...؟»',
      examples: [
        'چطور بگم آب می‌خوام؟',
        'معنی این کلمه چیه؟',
        'چطور تلفظش کنم؟',
        'بهم تکلیف بده',
      ],
      note: 'این بخش بعداً می‌تونه به لایه‌ی AI متصل بشه.',
    );
  }

  // ═══════════════════════════════
  // TRANSLATION
  // ═══════════════════════════════

  static MeowResponse _translationResponse(String text) {
    if (_containsAny(text, [
      'آب',
      'اب',
      'water',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.translation,
        mood: MeowMood.happy,
        english: "I'd like some water, please.",
        persian: 'می‌خوام کمی آب، لطفاً.',
        pronunciation: 'آید لایک سام واتِر، پلیز',
        examples: [
          "I'd like some water, please.",
          'Can I have some water?',
        ],
      );
    }

    if (_containsAny(text, [
      'نوشیدنی',
      'drink',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.translation,
        mood: MeowMood.happy,
        english: "I'd like a drink, please.",
        persian: 'یک نوشیدنی می‌خواهم، لطفاً.',
        pronunciation: 'آید لایک ا درینک، پلیز',
        examples: [
          "I'd like a drink, please.",
          'Can I have a drink?',
        ],
      );
    }

    if (_containsAny(text, [
      'گرسنه',
      'غذا',
      'hungry',
      'food',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.translation,
        mood: MeowMood.happy,
        english: "I'm hungry.",
        persian: 'من گرسنه‌ام.',
        pronunciation: 'آیم هانگری',
        examples: [
          "I'm hungry.",
          "I'd like something to eat.",
        ],
      );
    }

    if (_containsAny(text, [
      'متوجه نشدم',
      'نفهمیدم',
      'نمیفهمم',
      'نمی‌فهمم',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.translation,
        mood: MeowMood.calm,
        english: "I didn't understand.",
        persian: 'متوجه نشدم.',
        pronunciation: 'آی دیدِنت آندِرستَند',
        examples: [
          "I didn't understand.",
          'Sorry, I didn’t understand.',
          'Could you say that again?',
        ],
      );
    }

    return const MeowResponse(
      intent: MeowIntent.translation,
      mood: MeowMood.calm,
      english: 'Send me the Persian sentence you want to say in English.',
      persian: 'جمله فارسی رو بفرست تا معادل انگلیسی مناسبش رو پیدا کنم.',
      examples: [
        'چطور بگم آب می‌خوام؟',
        'چطور بگم متوجه نشدم؟',
        'به انگلیسی «خسته‌ام» چی میشه؟',
      ],
    );
  }

  // ═══════════════════════════════
  // HOMEWORK
  // ═══════════════════════════════

  static MeowResponse _generalHomework() {
    const homeworks = [
      const MeowResponse(
        intent: MeowIntent.homework,
        mood: MeowMood.cheering,
        english: 'Homework: Write 3 sentences about yourself.',
        persian:
            'تکلیف امروز 📝\n۳ جمله انگلیسی درباره خودت بنویس.',
        examples: [
          'My name is ...',
          'I like ...',
          'I am learning English.',
        ],
        note: 'سعی کن جمله‌ها از چیزهایی باشن که واقعاً درباره خودت درست هستن.',
      ),
      const MeowResponse(
        intent: MeowIntent.homework,
        mood: MeowMood.cheering,
        english: 'Homework: Translate 3 everyday sentences.',
        persian:
            'تکلیف امروز 📚\nاین ۳ جمله رو به انگلیسی ترجمه کن.',
        examples: [
          'من آب می‌خوام.',
          'من گرسنه‌ام.',
          'متوجه نشدم.',
        ],
      ),
      const MeowResponse(
        intent: MeowIntent.homework,
        mood: MeowMood.cheering,
        english: 'Homework: Practice these words aloud.',
        persian:
            'تکلیف امروز 🎤\nاین کلمات رو با صدای بلند تمرین کن.',
        examples: [
          'water',
          'drink',
          'hungry',
          'understand',
          'please',
        ],
      ),
    ];

    return homeworks[_random.nextInt(homeworks.length)];
  }

  static const MeowResponse _speakingHomeworkResponse = MeowResponse(
    intent: MeowIntent.homework,
    mood: MeowMood.cheering,
    english: 'Speaking Homework 🎤',
    persian:
        'تکلیف Speaking:\nاین جمله را ۳ بار با صدای بلند بگو:',
    examples: [
      "I'd like some water, please.",
    ],
    pronunciation: 'آید لایک سام واتِر، پلیز',
    note: 'بار اول آرام، بار دوم طبیعی، بار سوم بدون نگاه کردن به متن.',
  );

  static MeowResponse _speakingHomework() {
    return _speakingHomeworkResponse;
  }

  static const MeowResponse _vocabularyHomeworkResponse = MeowResponse(
    intent: MeowIntent.homework,
    mood: MeowMood.cheering,
    english: 'Vocabulary Homework 📚',
    persian:
        '۵ کلمه زیر را یاد بگیر و برای هرکدام یک جمله بساز:',
    examples: [
      'water',
      'drink',
      'hungry',
      'help',
      'understand',
    ],
    note: 'فقط معنی کلمه را حفظ نکن. با جمله یادش بگیر.',
  );

  static MeowResponse _vocabularyHomework() {
    return _vocabularyHomeworkResponse;
  }

  static const MeowResponse _writingHomeworkResponse = MeowResponse(
    intent: MeowIntent.homework,
    mood: MeowMood.cheering,
    english: 'Writing Homework 📝',
    persian:
        '۵ جمله کوتاه درباره روزت به انگلیسی بنویس.',
    examples: [
      'I woke up...',
      'I had...',
      'I like...',
      'I watched...',
      'I learned...',
    ],
    note: 'جمله‌های واقعی درباره زندگی خودت بنویس.',
  );

  static MeowResponse _writingHomework() {
    return _writingHomeworkResponse;
  }

  static const MeowResponse _translationHomeworkResponse = MeowResponse(
    intent: MeowIntent.homework,
    mood: MeowMood.cheering,
    english: 'Translation Homework 🔤',
    persian: 'این جمله‌ها را به انگلیسی ترجمه کن:',
    examples: [
      'من آب می‌خواهم.',
      'من گرسنه‌ام.',
      'من متوجه نشدم.',
    ],
  );

  static MeowResponse _translationHomework() {
    return _translationHomeworkResponse;
  }

  // ═══════════════════════════════
  // PRACTICE
  // ═══════════════════════════════

  static const MeowResponse _vocabularyPracticeResponse = MeowResponse(
    intent: MeowIntent.vocabularyPractice,
    mood: MeowMood.happy,
    english: 'Vocabulary Practice 📚',
    persian: 'معنی این کلمات رو بگو:',
    examples: [
      'water',
      'drink',
      'hungry',
      'help',
      'understand',
    ],
  );

  static MeowResponse _vocabularyPractice() {
    return _vocabularyPracticeResponse;
  }

  static const MeowResponse _writingPracticeResponse = MeowResponse(
    intent: MeowIntent.writingPractice,
    mood: MeowMood.happy,
    english: 'Writing Practice 📝',
    persian: 'با این کلمه یک جمله انگلیسی بساز:',
    examples: [
      'water',
    ],
    note: 'سعی کن جمله درباره یک موقعیت واقعی باشه.',
  );

  static MeowResponse _writingPractice() {
    return _writingPracticeResponse;
  }

  static const MeowResponse _translationPracticeResponse = MeowResponse(
    intent: MeowIntent.translation,
    mood: MeowMood.happy,
    english: 'Translation Practice 🔤',
    persian: 'این جمله را به انگلیسی ترجمه کن:',
    examples: [
      'من یک نوشیدنی می‌خواهم.',
    ],
  );

  static MeowResponse _translationPractice() {
    return _translationPracticeResponse;
  }
}