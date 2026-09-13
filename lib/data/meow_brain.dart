import 'dart:math';

import '../memory/meow_learning/base_intents.dart';
import '../memory/meow_learning/intent_detector.dart';

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

  static final IntentDetector _intentDetector =
      IntentDetector(
    intents: BaseIntents.create(),
  );

  // ═══════════════════════════════
  // NORMALIZATION
  // ═══════════════════════════════

  static String _normalize(String text) {
    return text
        .trim()
        .toLowerCase()
        .replaceAll('ي', 'ی')
        .replaceAll('ى', 'ی')
        .replaceAll('ك', 'ک')
        .replaceAll('ۀ', 'ه')
        .replaceAll('ة', 'ه')
        .replaceAll('‌', ' ')
        .replaceAll('ـ', '')
        .replaceAll('’', "'")
        .replaceAll('‘', "'")
        .replaceAll('“', '"')
        .replaceAll('”', '"')
        .replaceAll(
          RegExp(
            r'''[؟?!.,،؛:()\[\]{}""]''',
          ),
          ' ',
        )
        .replaceAll(
          RegExp(r'\s+'),
          ' ',
        )
        .trim();
  }

  static bool _containsAny(
    String text,
    List<String> words,
  ) {
    for (final word in words) {
      if (text.contains(_normalize(word))) {
        return true;
      }
    }

    return false;
  }

  static bool _hasAnyWord(
    String text,
    List<String> words,
  ) {
    final normalizedWords = text.split(' ');

    for (final word in words) {
      final normalized = _normalize(word);

      if (normalizedWords.contains(normalized)) {
        return true;
      }
    }

    return false;
  }

  // ═══════════════════════════════
  // MAIN BRAIN
  // ═══════════════════════════════

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

    // ═══════════════════════════════
    // 1. PRONUNCIATION
    // ═══════════════════════════════
    //
    // این بخش عمداً زود بررسی می‌شود.
    //
    // مثلاً:
    // "I'd pronunciation"
    // "تلفظ I'd"
    // "I'd چطور خونده میشه"
    //
    // نباید صرفاً به خاطر وجود کلمه‌ی I'd
    // وارد بخش ترجمه یا unknown شود.

    if (_isPronunciationRequest(text)) {
      return _pronunciationResponse(text);
    }

    // ═══════════════════════════════
    // 2. MEANING
    // ═══════════════════════════════

    if (_isMeaningRequest(text)) {
      return _meaningResponse(text);
    }

    // ═══════════════════════════════
    // 3. TRANSLATION / HOW TO SAY
    // ═══════════════════════════════

    if (_isTranslationRequest(text)) {
      return _translationResponse(text);
    }

    // ═══════════════════════════════
    // 4. GREETING
    // ═══════════════════════════════

    if (_isGreeting(text)) {
      return const MeowResponse(
        intent: MeowIntent.greeting,
        mood: MeowMood.happy,
        english: 'Hi! Ready to practice some English? 🐱',
        persian:
            'سلام! آماده‌ای کمی انگلیسی تمرین کنیم؟ 🐱',
        examples: [
          'Hi!',
          'Hello!',
          'Hey! How are you?',
        ],
      );
    }

    // ═══════════════════════════════
    // 5. HOMEWORK
    // ═══════════════════════════════

    if (_isHomeworkRequest(text)) {
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

    // ═══════════════════════════════
    // 6. PRACTICE
    // ═══════════════════════════════

    if (_isPracticeRequest(text)) {
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
          pronunciation:
              'آید لایک سام واتِر، پلیز',
          examples: [
            'I’d like some water, please.',
          ],
          note:
              'اول آرام بگو، بعد یک بار طبیعی‌تر تکرار کن.',
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
        persian:
            'بریم تمرین کنیم! 🐱',
        examples: [
          'I am learning English.',
          'I like coffee.',
          'I want some water.',
        ],
        note:
            'می‌تونی از Meow بخوای speaking، vocabulary، writing یا translation تمرین بده.',
      );
    }

    // ═══════════════════════════════
    // 7. WATER / DRINK
    // ═══════════════════════════════

    final detectedIntent =
        _intentDetector.detect(text);

    if (detectedIntent == 'drink_request') {
      if (_looksLikeWaterRequest(text)) {
        return _waterResponse();
      }

      return _drinkResponse();
    }

    // تشخیص مستقیم و طبیعی‌تر
    if (_looksLikeWaterRequest(text)) {
      return _waterResponse();
    }

    if (_looksLikeDrinkRequest(text)) {
      return _drinkResponse();
    }

    // ═══════════════════════════════
    // 8. FOOD
    // ═══════════════════════════════

    if (_looksLikeFoodRequest(text)) {
      return _foodResponse();
    }

    // ═══════════════════════════════
    // 9. BATHROOM
    // ═══════════════════════════════

    if (_looksLikeBathroomRequest(text)) {
      return const MeowResponse(
        intent: MeowIntent.bathroomRequest,
        mood: MeowMood.calm,
        english:
            'Excuse me, where is the bathroom?',
        persian:
            'ببخشید، دستشویی کجاست؟',
        pronunciation:
            'اِکسکیوز می، وِر ایز دِ بَث‌روم؟',
        examples: [
          'Where is the bathroom?',
          'Excuse me, where is the restroom?',
          'Is there a bathroom nearby?',
        ],
      );
    }

    // ═══════════════════════════════
    // 10. HELP
    // ═══════════════════════════════

    if (_looksLikeHelpRequest(text)) {
      return const MeowResponse(
        intent: MeowIntent.helpRequest,
        mood: MeowMood.calm,
        english: 'How can I help you?',
        persian:
            'چطور می‌تونم کمکت کنم؟',
        examples: [
          'Can you help me?',
          'I need some help.',
          'Could you help me, please?',
        ],
      );
    }

    // ═══════════════════════════════
    // 11. UNKNOWN
    // ═══════════════════════════════

    return const MeowResponse(
      intent: MeowIntent.unknown,
      mood: MeowMood.surprised,
      english:
          "Hmm... I don't know that one yet. 😺",
      persian:
          'هوم... هنوز جواب دقیق این مورد رو توی مغزم ندارم 😺\n'
          'می‌تونی ساده‌تر بپرسی یا بگی «چطور بگم...؟»',
      examples: [
        'چطور بگم آب می‌خوام؟',
        'معنی این کلمه چیه؟',
        'چطور تلفظش کنم؟',
        'بهم تکلیف بده',
      ],
      note:
          'این بخش بعداً می‌تونه به لایه‌ی AI متصل بشه.',
    );
  }

  // ═══════════════════════════════
  // INTENT HELPERS
  // ═══════════════════════════════

  static bool _isGreeting(String text) {
    return _containsAny(text, [
      'سلام',
      'های',
      'هلو',
      'hello',
      'hi',
      'hey',
      'good morning',
      'good evening',
      'good afternoon',
    ]);
  }

  static bool _isPronunciationRequest(String text) {
    return _containsAny(text, [
      'تلفظ',
      'تلفظش',
      'تلفظ این',
      'چطور تلفظ',
      'چجوری تلفظ',
      'چطوری تلفظ',
      'چطور خونده میشه',
      'چجوری خونده میشه',
      'چطوری خونده میشه',
      'pronunciation',
      'pronounce',
      'how do you pronounce',
      'how is this pronounced',
      'how do i pronounce',
    ]);
  }

  static bool _isMeaningRequest(String text) {
    return _containsAny(text, [
      'یعنی چی',
      'معنی',
      'معنیش',
      'معنی این',
      'این یعنی',
      'what does',
      'what does this mean',
      'meaning',
      'means',
    ]);
  }

  static bool _isTranslationRequest(String text) {
    return _containsAny(text, [
      'چطور بگم',
      'چجوری بگم',
      'چطوری بگم',
      'به انگلیسی چی میشه',
      'انگلیسیش چی میشه',
      'به انگلیسی',
      'ترجمه کن',
      'ترجمه',
      'how do i say',
      'how can i say',
      'how to say',
      'translate',
    ]);
  }

  static bool _isHomeworkRequest(String text) {
    return _containsAny(text, [
      'تکلیف',
      'مشقم',
      'مشق',
      'homework',
    ]);
  }

  static bool _isPracticeRequest(String text) {
    return _containsAny(text, [
      'تمرین',
      'تمرین بده',
      'تمرین کنیم',
      'practice',
      'practice english',
      'تمرین انگلیسی',
    ]);
  }

  // ═══════════════════════════════
  // WATER
  // ═══════════════════════════════

  static bool _looksLikeWaterRequest(String text) {
    final hasWater = _containsAny(text, [
      'آب',
      'اب',
      'water',
    ]);

    final hasRequest = _containsAny(text, [
      'میخوام',
      'می‌خوام',
      'می خواهم',
      'میخواهم',
      'می‌خواهم',
      'می‌خوام',
      'میخوام',
      'میخاستم',
      'می‌خواستم',
      'لازم دارم',
      'می‌تونم',
      'میشه',
      'میتونم',
      'can i have',
      'could i have',
      'give me',
      'get me',
      'want',
      'need',
      'have',
      'some',
    ]);

    final thirsty = _containsAny(text, [
      'تشنه',
      'تشنمه',
      'خیلی تشنمه',
      'i am thirsty',
      "i'm thirsty",
      'im thirsty',
      'thirsty',
    ]);

    return (hasWater && hasRequest) || thirsty;
  }

  static MeowResponse _waterResponse() {
    return const MeowResponse(
      intent: MeowIntent.waterRequest,
      mood: MeowMood.happy,
      english:
          "I'd like some water, please.",
      persian:
          'می‌خوام کمی آب، لطفاً.',
      pronunciation:
          'آید لایک سام واتِر، پلیز',
      examples: [
        "I'd like some water, please.",
        'Can I have some water, please?',
        'Could I have some water?',
        'I need some water.',
      ],
      note:
          'برای درخواست مؤدبانه، "I’d like..." خیلی طبیعی و کاربردی است.',
    );
  }

  // ═══════════════════════════════
  // DRINK
  // ═══════════════════════════════

  static bool _looksLikeDrinkRequest(String text) {
    final hasDrink = _containsAny(text, [
      'نوشیدنی',
      'drink',
      'something to drink',
      'چیزی برای نوشیدن',
      'یه چیزی برای نوشیدن',
      'یک چیزی برای نوشیدن',
    ]);

    final request = _containsAny(text, [
      'میخوام',
      'می‌خوام',
      'میخواهم',
      'می‌خواهم',
      'می‌خواستم',
      'لازم دارم',
      'want',
      'need',
      'can i have',
      'could i get',
      'give me',
    ]);

    return hasDrink && request;
  }

  static MeowResponse _drinkResponse() {
    return const MeowResponse(
      intent: MeowIntent.drinkRequest,
      mood: MeowMood.happy,
      english:
          "I'd like a drink, please.",
      persian:
          'یک نوشیدنی می‌خواهم، لطفاً.',
      pronunciation:
          'آید لایک ا درینک، پلیز',
      examples: [
        "I'd like a drink, please.",
        'Can I have a drink, please?',
        'Could I get a drink?',
        "I'd like something to drink.",
      ],
      note:
          'در رستوران یا کافه، این جمله کاملاً طبیعی است.',
    );
  }

  // ═══════════════════════════════
  // FOOD
  // ═══════════════════════════════

  static bool _looksLikeFoodRequest(String text) {
    final hungry = _containsAny(text, [
      'گرسنه',
      'گرسنه‌ام',
      'گرسنمه',
      'hungry',
      "i'm hungry",
      'im hungry',
    ]);

    final food = _containsAny(text, [
      'غذا',
      'food',
      'something to eat',
      'چیزی برای خوردن',
      'یه چیزی برای خوردن',
      'یک چیزی برای خوردن',
    ]);

    final request = _containsAny(text, [
      'میخوام',
      'می‌خوام',
      'میخواهم',
      'می‌خواهم',
      'می‌خواستم',
      'لازم دارم',
      'want',
      'need',
      'can i have',
      'could i get',
      'get me',
    ]);

    return hungry || (food && request);
  }

  static MeowResponse _foodResponse() {
    return const MeowResponse(
      intent: MeowIntent.foodRequest,
      mood: MeowMood.happy,
      english:
          "I'd like something to eat, please.",
      persian:
          'لطفاً یک چیزی برای خوردن می‌خواهم.',
      pronunciation:
          'آید لایک سامثینگ تو ایت، پلیز',
      examples: [
        "I'd like something to eat.",
        "I'm hungry.",
        'Can I get something to eat?',
      ],
      note:
          'برای بیان گرسنگی، "I’m hungry" ساده‌تر است.',
    );
  }

  // ═══════════════════════════════
  // BATHROOM
  // ═══════════════════════════════

  static bool _looksLikeBathroomRequest(String text) {
    return _containsAny(text, [
      'دستشویی',
      'سرویس بهداشتی',
      'حمام',
      'bathroom',
      'restroom',
      'toilet',
    ]);
  }

  // ═══════════════════════════════
  // HELP
  // ═══════════════════════════════

  static bool _looksLikeHelpRequest(String text) {
    return _containsAny(text, [
      'کمک',
      'کمکم کن',
      'راهنمایی',
      'help',
      'i need help',
      'can you help',
      'could you help',
    ]);
  }

  // ═══════════════════════════════
  // PRONUNCIATION RESPONSE
  // ═══════════════════════════════

  static MeowResponse _pronunciationResponse(
    String text,
  ) {
    final target = _extractPronunciationTarget(text);

    if (target == "i'd" ||
        target == 'id' ||
        target == 'i’d') {
      return const MeowResponse(
        intent: MeowIntent.pronunciation,
        mood: MeowMood.happy,
        english: "I'd",
        persian:
            'تلفظ "I’d" اینه:',
        pronunciation:
            'آید /aɪd/',
        examples: [
          "I'd like some water.",
          "I'd love to go.",
          "I'd rather stay home.",
        ],
        note:
            'I’d کوتاه‌شده‌ی "I would" یا گاهی "I had" است. در جمله باید از روی context تشخیص داد کدام معنی را دارد.',
      );
    }

    return const MeowResponse(
      intent: MeowIntent.pronunciation,
      mood: MeowMood.calm,
      english:
          'Tell me the word or sentence you want to pronounce.',
      persian:
          'کلمه یا جمله‌ای که می‌خوای تلفظش رو تمرین کنی بفرست.',
      examples: [
        'How do I pronounce "water"?',
        'How do I pronounce "comfortable"?',
        'How do I say this sentence?',
      ],
      note:
          'مثلاً می‌تونی فقط بنویسی: "pronunciation of comfortable"',
    );
  }

  static String _extractPronunciationTarget(
    String text,
  ) {
    final normalized = _normalize(text);

    if (normalized.contains("i'd") ||
        normalized.contains('i’d')) {
      return "i'd";
    }

    final quoted = RegExp(
      r'''["']([^"']+)["']''',
    ).firstMatch(normalized);

    if (quoted != null) {
      return quoted.group(1)?.trim() ?? '';
    }

    final patterns = [
      'تلفظ ',
      'pronunciation of ',
      'pronounce ',
    ];

    for (final pattern in patterns) {
      if (normalized.startsWith(pattern)) {
        return normalized
            .substring(pattern.length)
            .trim();
      }
    }

    return '';
  }

  // ═══════════════════════════════
  // MEANING RESPONSE
  // ═══════════════════════════════

  static MeowResponse _meaningResponse(
    String text,
  ) {
    final normalized = _normalize(text);

    if (normalized.contains("i'd") ||
        normalized.contains('i’d')) {
      return const MeowResponse(
        intent: MeowIntent.meaning,
        mood: MeowMood.calm,
        english: "I'd",
        persian:
            '"I’d" معمولاً کوتاه‌شده‌ی "I would" است و در بعضی جمله‌ها کوتاه‌شده‌ی "I had" هم می‌تواند باشد.',
        pronunciation:
            'آید /aɪd/',
        examples: [
          "I'd like some water.",
          "I'd love to help.",
          "I'd already finished.",
        ],
        note:
            'در "I’d like..." یعنی "دوست دارم / مایلم".',
      );
    }

    return const MeowResponse(
      intent: MeowIntent.meaning,
      mood: MeowMood.calm,
      english:
          'Send me the word or sentence and I’ll explain it.',
      persian:
          'کلمه یا جمله رو بفرست تا معنی و کاربردش رو توضیح بدم.',
      examples: [
        'What does "awkward" mean?',
        'What does this sentence mean?',
        'What does "piece of cake" mean?',
      ],
    );
  }

  // ═══════════════════════════════
  // TRANSLATION
  // ═══════════════════════════════

  static MeowResponse _translationResponse(
    String text,
  ) {
    if (_containsAny(text, [
      'آب',
      'اب',
      'water',
    ])) {
      return const MeowResponse(
        intent: MeowIntent.translation,
        mood: MeowMood.happy,
        english:
            "I'd like some water, please.",
        persian:
            'می‌خوام کمی آب، لطفاً.',
        pronunciation:
            'آید لایک سام واتِر، پلیز',
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
        english:
            "I'd like a drink, please.",
        persian:
            'یک نوشیدنی می‌خواهم، لطفاً.',
        pronunciation:
            'آید لایک ا درینک، پلیز',
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
        english:
            "I'm hungry.",
        persian:
            'من گرسنه‌ام.',
        pronunciation:
            'آیم هانگری',
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
        english:
            "I didn't understand.",
        persian:
            'متوجه نشدم.',
        pronunciation:
            'آی دیدِنت آندِرستَند',
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
      english:
          'Send me the Persian sentence you want to say in English.',
      persian:
          'جمله فارسی رو بفرست تا معادل انگلیسی مناسبش رو پیدا کنم.',
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
    final homeworks = [
      const MeowResponse(
        intent: MeowIntent.homework,
        mood: MeowMood.cheering,
        english:
            'Homework: Write 3 sentences about yourself.',
        persian:
            'تکلیف امروز 📝\n۳ جمله انگلیسی درباره خودت بنویس.',
        examples: [
          'My name is ...',
          'I like ...',
          'I am learning English.',
        ],
        note:
            'سعی کن جمله‌ها از چیزهایی باشن که واقعاً درباره خودت درست هستن.',
      ),
      const MeowResponse(
        intent: MeowIntent.homework,
        mood: MeowMood.cheering,
        english:
            'Homework: Translate 3 everyday sentences.',
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
        english:
            'Homework: Practice these words aloud.',
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

    return homeworks[
      _random.nextInt(homeworks.length)
    ];
  }

  static const MeowResponse
      _speakingHomeworkResponse =
      MeowResponse(
    intent: MeowIntent.homework,
    mood: MeowMood.cheering,
    english:
        'Speaking Homework 🎤',
    persian:
        'تکلیف Speaking:\nاین جمله را ۳ بار با صدای بلند بگو:',
    examples: [
      "I'd like some water, please.",
    ],
    pronunciation:
        'آید لایک سام واتِر، پلیز',
    note:
        'بار اول آرام، بار دوم طبیعی، بار سوم بدون نگاه کردن به متن.',
  );

  static MeowResponse _speakingHomework() {
    return _speakingHomeworkResponse;
  }

  static const MeowResponse
      _vocabularyHomeworkResponse =
      MeowResponse(
    intent: MeowIntent.homework,
    mood: MeowMood.cheering,
    english:
        'Vocabulary Homework 📚',
    persian:
        '۵ کلمه زیر را یاد بگیر و برای هرکدام یک جمله بساز:',
    examples: [
      'water',
      'drink',
      'hungry',
      'help',
      'understand',
    ],
    note:
        'فقط معنی کلمه را حفظ نکن. با جمله یادش بگیر.',
  );

  static MeowResponse _vocabularyHomework() {
    return _vocabularyHomeworkResponse;
  }

  static const MeowResponse
      _writingHomeworkResponse =
      MeowResponse(
    intent: MeowIntent.homework,
    mood: MeowMood.cheering,
    english:
        'Writing Homework 📝',
    persian:
        '۵ جمله کوتاه درباره روزت به انگلیسی بنویس.',
    examples: [
      'I woke up...',
      'I had...',
      'I like...',
      'I watched...',
      'I learned...',
    ],
    note:
        'جمله‌های واقعی درباره زندگی خودت بنویس.',
  );

  static MeowResponse _writingHomework() {
    return _writingHomeworkResponse;
  }

  static const MeowResponse
      _translationHomeworkResponse =
      MeowResponse(
    intent: MeowIntent.homework,
    mood: MeowMood.cheering,
    english:
        'Translation Homework 🔤',
    persian:
        'این جمله‌ها را به انگلیسی ترجمه کن:',
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

  static const MeowResponse
      _vocabularyPracticeResponse =
      MeowResponse(
    intent: MeowIntent.vocabularyPractice,
    mood: MeowMood.happy,
    english:
        'Vocabulary Practice 📚',
    persian:
        'معنی این کلمات رو بگو:',
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

  static const MeowResponse
      _writingPracticeResponse =
      MeowResponse(
    intent: MeowIntent.writingPractice,
    mood: MeowMood.happy,
    english:
        'Writing Practice 📝',
    persian:
        'با این کلمه یک جمله انگلیسی بساز:',
    examples: [
      'water',
    ],
    note:
        'سعی کن جمله درباره یک موقعیت واقعی باشه.',
  );

  static MeowResponse _writingPractice() {
    return _writingPracticeResponse;
  }

  static const MeowResponse
      _translationPracticeResponse =
      MeowResponse(
    intent: MeowIntent.translation,
    mood: MeowMood.happy,
    english:
        'Translation Practice 🔤',
    persian:
        'این جمله را به انگلیسی ترجمه کن:',
    examples: [
      'من یک نوشیدنی می‌خواهم.',
    ],
  );

  static MeowResponse _translationPractice() {
    return _translationPracticeResponse;
  }
}