class B1Lesson {
  final int id;
  final String titleEn;
  final String titleFa;
  final String topicEn;
  final String topicFa;
  final List<String> skills;
  final List<String> grammar;

  const B1Lesson({
    required this.id,
    required this.titleEn,
    required this.titleFa,
    required this.topicEn,
    required this.topicFa,
    required this.skills,
    required this.grammar,
  });
}

const List<B1Lesson> b1Lessons = [
  B1Lesson(
    id: 1,
    titleEn: 'Life Experiences',
    titleFa: 'تجربه‌های زندگی',
    topicEn: 'Talking about experiences',
    topicFa: 'صحبت درباره تجربه‌ها',
    skills: [
      'Speaking',
      'Vocabulary',
      'Grammar',
      'Listening',
    ],
    grammar: [
      'Present Perfect',
      'Past Simple',
      'Present Perfect vs Past Simple',
    ],
  ),

  B1Lesson(
    id: 2,
    titleEn: 'Recently',
    titleFa: 'به‌تازگی',
    topicEn: 'Recent events and actions',
    topicFa: 'اتفاق‌ها و کارهای اخیر',
    skills: [
      'Grammar',
      'Vocabulary',
      'Speaking',
    ],
    grammar: [
      'just',
      'already',
      'yet',
    ],
  ),

  B1Lesson(
    id: 3,
    titleEn: 'For and Since',
    titleFa: 'For و Since',
    topicEn: 'Talking about duration',
    topicFa: 'صحبت درباره مدت زمان',
    skills: [
      'Grammar',
      'Speaking',
      'Writing',
    ],
    grammar: [
      'for',
      'since',
      'Present Perfect',
    ],
  ),

  B1Lesson(
    id: 4,
    titleEn: 'Past Stories',
    titleFa: 'داستان‌های گذشته',
    topicEn: 'Describing events in the past',
    topicFa: 'توصیف اتفاق‌های گذشته',
    skills: [
      'Grammar',
      'Listening',
      'Speaking',
    ],
    grammar: [
      'Past Simple',
      'Past Continuous',
    ],
  ),

  B1Lesson(
    id: 5,
    titleEn: 'What Happened?',
    titleFa: 'چه اتفاقی افتاد؟',
    topicEn: 'Telling and sequencing stories',
    topicFa: 'تعریف داستان و ترتیب اتفاق‌ها',
    skills: [
      'Speaking',
      'Vocabulary',
      'Listening',
      'Writing',
    ],
    grammar: [
      'Past Simple',
      'Past Continuous',
      'Sequence words',
    ],
  ),

  B1Lesson(
    id: 6,
    titleEn: 'Memorable Moments',
    titleFa: 'لحظه‌های به‌یادماندنی',
    topicEn: 'Talking about memorable experiences',
    topicFa: 'صحبت درباره تجربه‌های به‌یادماندنی',
    skills: [
      'Speaking',
      'Writing',
      'Vocabulary',
      'Review',
    ],
    grammar: [
      'Past Simple',
      'Past Continuous',
      'Present Perfect',
    ],
  ),

  B1Lesson(
    id: 7,
    titleEn: 'Future Plans',
    titleFa: 'برنامه‌های آینده',
    topicEn: 'Talking about future plans',
    topicFa: 'صحبت درباره برنامه‌های آینده',
    skills: [
      'Grammar',
      'Speaking',
      'Listening',
    ],
    grammar: [
      'will',
      'going to',
      'Present Continuous',
    ],
  ),

  B1Lesson(
    id: 8,
    titleEn: 'Predictions',
    titleFa: 'پیش‌بینی‌ها',
    topicEn: 'Making predictions',
    topicFa: 'پیش‌بینی کردن',
    skills: [
      'Grammar',
      'Speaking',
      'Vocabulary',
    ],
    grammar: [
      'will',
      'may',
      'might',
    ],
  ),

  B1Lesson(
    id: 9,
    titleEn: 'Making Plans',
    titleFa: 'برنامه‌ریزی',
    topicEn: 'Arrangements and invitations',
    topicFa: 'هماهنگی و دعوت',
    skills: [
      'Speaking',
      'Listening',
      'Real English',
    ],
    grammar: [
      'Present Continuous for future',
      'Future expressions',
    ],
  ),

  B1Lesson(
    id: 10,
    titleEn: 'If Things Change',
    titleFa: 'اگر شرایط تغییر کند',
    topicEn: 'Talking about possible situations',
    topicFa: 'صحبت درباره موقعیت‌های احتمالی',
    skills: [
      'Grammar',
      'Speaking',
      'Writing',
    ],
    grammar: [
      'First Conditional',
      'if clauses',
    ],
  ),

  B1Lesson(
    id: 11,
    titleEn: 'Giving Advice',
    titleFa: 'توصیه کردن',
    topicEn: 'Giving advice and suggestions',
    topicFa: 'توصیه و پیشنهاد دادن',
    skills: [
      'Grammar',
      'Speaking',
      'Real English',
    ],
    grammar: [
      'should',
      'ought to',
      'had better',
    ],
  ),

  B1Lesson(
    id: 12,
    titleEn: 'Decisions & Possibilities',
    titleFa: 'تصمیم‌ها و احتمالات',
    topicEn: 'Making decisions and discussing possibilities',
    topicFa: 'تصمیم‌گیری و صحبت درباره احتمالات',
    skills: [
      'Speaking',
      'Grammar',
      'Vocabulary',
      'Review',
    ],
    grammar: [
      'will',
      'may',
      'might',
      'First Conditional',
    ],
  ),

  B1Lesson(
    id: 13,
    titleEn: 'What Are They Like?',
    titleFa: 'چه جور آدم‌هایی هستند؟',
    topicEn: 'Describing personality and behavior',
    topicFa: 'توصیف شخصیت و رفتار',
    skills: [
      'Vocabulary',
      'Speaking',
      'Reading',
    ],
    grammar: [
      'Adjectives',
      'Adverbs',
    ],
  ),

  B1Lesson(
    id: 14,
    titleEn: 'Getting Along',
    titleFa: 'کنار آمدن با دیگران',
    topicEn: 'Relationships and communication',
    topicFa: 'روابط و ارتباط با دیگران',
    skills: [
      'Speaking',
      'Listening',
      'Vocabulary',
    ],
    grammar: [
      'Gerunds',
      'Infinitives',
    ],
  ),

  B1Lesson(
    id: 15,
    titleEn: 'Problems Between People',
    titleFa: 'مشکلات بین آدم‌ها',
    topicEn: 'Conflict and solutions',
    topicFa: 'اختلاف و راه‌حل‌ها',
    skills: [
      'Speaking',
      'Reading',
      'Writing',
    ],
    grammar: [
      'First Conditional',
      'Modals',
    ],
  ),

  B1Lesson(
    id: 16,
    titleEn: 'What Did You Mean?',
    titleFa: 'منظورت چی بود؟',
    topicEn: 'Misunderstandings and communication',
    topicFa: 'سوءتفاهم و ارتباط',
    skills: [
      'Listening',
      'Speaking',
      'Real English',
    ],
    grammar: [
      'Reported speech basics',
      'Question forms',
    ],
  ),

  B1Lesson(
    id: 17,
    titleEn: 'Polite Communication',
    titleFa: 'ارتباط مؤدبانه',
    topicEn: 'Polite requests and questions',
    topicFa: 'درخواست‌ها و سؤال‌های مؤدبانه',
    skills: [
      'Speaking',
      'Grammar',
      'Real English',
    ],
    grammar: [
      'Indirect questions',
      'Polite requests',
    ],
  ),

  B1Lesson(
    id: 18,
    titleEn: 'People in My Life',
    titleFa: 'آدم‌های زندگی من',
    topicEn: 'Talking about people and relationships',
    topicFa: 'صحبت درباره افراد و روابط',
    skills: [
      'Speaking',
      'Writing',
      'Vocabulary',
      'Review',
    ],
    grammar: [
      'Relative clauses basics',
      'Adjectives',
    ],
  ),

  B1Lesson(
    id: 19,
    titleEn: 'Working Life',
    titleFa: 'زندگی کاری',
    topicEn: 'Jobs and responsibilities',
    topicFa: 'شغل‌ها و مسئولیت‌ها',
    skills: [
      'Vocabulary',
      'Speaking',
      'Reading',
    ],
    grammar: [
      'Present Simple',
      'Present Continuous',
    ],
  ),

  B1Lesson(
    id: 20,
    titleEn: 'At Work',
    titleFa: 'در محل کار',
    topicEn: 'Workplace communication',
    topicFa: 'ارتباط در محیط کار',
    skills: [
      'Speaking',
      'Listening',
      'Writing',
      'Real English',
    ],
    grammar: [
      'Polite requests',
      'Modal verbs',
    ],
  ),

  B1Lesson(
    id: 21,
    titleEn: 'Travel Plans',
    titleFa: 'برنامه‌های سفر',
    topicEn: 'Planning a trip',
    topicFa: 'برنامه‌ریزی سفر',
    skills: [
      'Vocabulary',
      'Speaking',
      'Reading',
    ],
    grammar: [
      'Future forms',
      'Comparatives',
    ],
  ),

  B1Lesson(
    id: 22,
    titleEn: 'Travel Problems',
    titleFa: 'مشکلات سفر',
    topicEn: 'Solving travel problems',
    topicFa: 'حل مشکلات سفر',
    skills: [
      'Speaking',
      'Listening',
      'Real English',
    ],
    grammar: [
      'Modal verbs',
      'Requests',
      'Conditionals',
    ],
  ),

  B1Lesson(
    id: 23,
    titleEn: 'Money & Shopping',
    titleFa: 'پول و خرید',
    topicEn: 'Shopping, prices and complaints',
    topicFa: 'خرید، قیمت‌ها و شکایت',
    skills: [
      'Vocabulary',
      'Speaking',
      'Listening',
      'Real English',
    ],
    grammar: [
      'Comparatives',
      'Quantifiers',
    ],
  ),

  B1Lesson(
    id: 24,
    titleEn: 'Everyday Decisions',
    titleFa: 'تصمیم‌های روزمره',
    topicEn: 'Making practical decisions',
    topicFa: 'تصمیم‌گیری‌های کاربردی',
    skills: [
      'Speaking',
      'Writing',
      'Grammar',
      'Review',
    ],
    grammar: [
      'Modals',
      'Conditionals',
      'Comparatives',
    ],
  ),

  B1Lesson(
    id: 25,
    titleEn: 'Technology in Our Lives',
    titleFa: 'فناوری در زندگی ما',
    topicEn: 'Technology and everyday life',
    topicFa: 'فناوری و زندگی روزمره',
    skills: [
      'Reading',
      'Speaking',
      'Vocabulary',
      'Writing',
    ],
    grammar: [
      'Comparatives',
      'Present Perfect',
    ],
  ),

  B1Lesson(
    id: 26,
    titleEn: 'News & Information',
    titleFa: 'خبر و اطلاعات',
    topicEn: 'Understanding and discussing information',
    topicFa: 'درک و بیان اطلاعات',
    skills: [
      'Reading',
      'Listening',
      'Vocabulary',
    ],
    grammar: [
      'Passive voice basics',
      'Reported speech basics',
    ],
  ),

  B1Lesson(
    id: 27,
    titleEn: 'Giving Your Opinion',
    titleFa: 'بیان نظر',
    topicEn: 'Agreeing, disagreeing and supporting ideas',
    topicFa: 'موافقت، مخالفت و حمایت از نظر',
    skills: [
      'Speaking',
      'Writing',
      'Real English',
    ],
    grammar: [
      'Linking words',
      'Opinion expressions',
    ],
  ),

  B1Lesson(
    id: 28,
    titleEn: 'Real English',
    titleFa: 'انگلیسی واقعی',
    topicEn: 'Phrasal verbs, idioms and casual expressions',
    topicFa: 'افعال عبارتی، اصطلاحات و عبارت‌های محاوره‌ای',
    skills: [
      'Vocabulary',
      'Listening',
      'Speaking',
      'Real English',
    ],
    grammar: [
      'Phrasal verbs',
      'Common expressions',
    ],
  ),

  B1Lesson(
    id: 29,
    titleEn: 'Putting It All Together',
    titleFa: 'ترکیب همه چیز',
    topicEn: 'Integrated B1 practice',
    topicFa: 'تمرین ترکیبی B1',
    skills: [
      'Grammar',
      'Vocabulary',
      'Reading',
      'Listening',
      'Speaking',
      'Writing',
    ],
    grammar: [
      'Mixed B1 Grammar',
    ],
  ),

  B1Lesson(
    id: 30,
    titleEn: 'B1 Final Challenge',
    titleFa: 'چالش نهایی B1',
    topicEn: 'Full B1 preparation',
    topicFa: 'آمادگی کامل برای آزمون B1',
    skills: [
      'Grammar',
      'Vocabulary',
      'Reading',
      'Listening',
      'Speaking',
      'Writing',
    ],
    grammar: [
      'Mixed B1 Grammar',
    ],
  ),
];