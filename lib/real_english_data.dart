class RealEnglishItem {
  final String term;
  final String? fullForm;
  final String meaning;
  final String category;
  final String level;
  final bool informal;
  final String? literalMeaning;
  final String? explanation;
  final String example;
  final String exampleMeaning;
  final String pronunciation;

  const RealEnglishItem({
    required this.term,
    this.fullForm,
    required this.meaning,
    required this.category,
    required this.level,
    required this.informal,
    this.literalMeaning,
    this.explanation,
    required this.example,
    required this.exampleMeaning,
    required this.pronunciation,
  });
}

const List<RealEnglishItem> realEnglishItems = [
  RealEnglishItem(
    term: 'gonna',
    fullForm: 'going to',
    meaning: 'قرار است / می‌خوام',
    category: 'Short Forms',
    level: 'A2',
    informal: true,
    explanation: 'A very common spoken form of "going to".',
    example: "I'm gonna call you.",
    exampleMeaning: 'می‌خوام بهت زنگ بزنم.',
    pronunciation: '/ˈɡʌnə/',
  ),

  RealEnglishItem(
    term: 'wanna',
    fullForm: 'want to',
    meaning: 'می‌خوام / می‌خوای',
    category: 'Short Forms',
    level: 'A2',
    informal: true,
    explanation: 'A common spoken form of "want to".',
    example: 'Do you wanna come?',
    exampleMeaning: 'می‌خوای بیای؟',
    pronunciation: '/ˈwɑːnə/',
  ),

  RealEnglishItem(
    term: 'ASAP',
    fullForm: 'as soon as possible',
    meaning: 'در اسرع وقت',
    category: 'Abbreviations',
    level: 'B1',
    informal: true,
    explanation: 'Used when something should happen very soon.',
    example: 'Please reply ASAP.',
    exampleMeaning: 'لطفاً در اسرع وقت جواب بده.',
    pronunciation: '/ˌeɪ.es.eɪˈpiː/',
  ),

  RealEnglishItem(
    term: 'BTW',
    fullForm: 'by the way',
    meaning: 'راستی / ضمناً',
    category: 'Abbreviations',
    level: 'A2',
    informal: true,
    explanation: 'Commonly used in messages and online conversations.',
    example: 'BTW, I saw your message.',
    exampleMeaning: 'راستی، پیامت رو دیدم.',
    pronunciation: '/ˌbiː tiː ˈdʌbəljuː/',
  ),

  RealEnglishItem(
    term: 'piece of cake',
    meaning: 'خیلی آسون',
    category: 'Idioms & Slang',
    level: 'A2',
    informal: true,
    literalMeaning: 'یک تکه کیک',
    explanation: 'Something that is very easy to do.',
    example: 'The test was a piece of cake.',
    exampleMeaning: 'امتحان خیلی آسون بود.',
    pronunciation: '/piːs əv keɪk/',
  ),
];