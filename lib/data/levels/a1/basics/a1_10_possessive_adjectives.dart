import 'a1_basics_models.dart';

const A1BasicLesson a1BasicPossessiveAdjectives = A1BasicLesson(
  id: 'a1_basic_07',
  title: 'Possessive Adjectives',
  titleFa: 'صفت‌های ملکی',
  topic: 'my, your, his, her, its, our, their',
  explanation:
      'Possessive adjectives show who something belongs to. '
      'They come before a noun: my phone, your bag, her name, our house, their car.',

  learningPhases: [
    A1BasicLearningPhase(
      type: 'curiosity',
      title: 'Think First',
      titleFa: 'اول فکر کن',
      body: 'Think: If you want to say “my book,” why do we say “my book” and not “me book”?',
      bodyFa: 'فکر کن: اگر بخواهی بگویی «کتاب من»، چرا می‌گوییم my book و نه me book؟',
    ),
    A1BasicLearningPhase(
      type: 'introduction',
      title: 'What Are Possessive Adjectives?',
      titleFa: 'صفت‌های ملکی چیستند؟',
      body: 'Possessive adjectives show who something belongs to. They come before a noun.',
      bodyFa: 'صفت‌های ملکی نشان می‌دهند چیزی مال چه کسی است. این کلمه‌ها قبل از اسم می‌آیند.',
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'Simple Examples',
      titleFa: 'مثال‌های ساده',
      body: 'Look at my, your, his, and her before nouns.',
      bodyFa: 'به my، your، his و her در کنار اسم‌ها دقت کن.',
      examples: [
        A1BasicExample(english: 'my book', persian: 'کتاب من'),
        A1BasicExample(english: 'your car', persian: 'ماشین تو / شما'),
        A1BasicExample(english: 'his house', persian: 'خانه او (مرد)'),
        A1BasicExample(english: 'her bag', persian: 'کیف او (زن)'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'Possessive Adjective + Noun',
      titleFa: 'صفت ملکی + اسم',
      body: 'A possessive adjective comes before the noun and tells us who the noun belongs to. The basic order is possessive adjective + noun.',
      bodyFa: 'صفت ملکی قبل از اسم می‌آید و نشان می‌دهد اسم متعلق به چه کسی است. ترتیب اصلی این است: صفت ملکی + اسم.',
      examples: [
        A1BasicExample(english: 'my book', persian: 'کتاب من'),
        A1BasicExample(english: 'their house', persian: 'خانه آنها'),
        A1BasicExample(english: 'her bag', persian: 'کیف او'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'chart',
      title: 'Possessive Adjectives Chart',
      titleFa: 'جدول صفت‌های ملکی',
      body: 'Each subject pronoun has a related possessive adjective.',
      bodyFa: 'هر ضمیر فاعلی یک صفت ملکی مرتبط دارد.',
      tableRows: [
        ['Subject', 'Possessive Adjective', 'Meaning'],
        ['I', 'my', 'مال من'],
        ['You', 'your', 'مال تو / شما'],
        ['He', 'his', 'مال او (مرد)'],
        ['She', 'her', 'مال او (زن)'],
        ['It', 'its', 'مال آن'],
        ['We', 'our', 'مال ما'],
        ['They', 'their', 'مال آنها'],
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'His and Her',
      titleFa: 'نکته مهم: His و Her',
      body: 'Persian uses the same “او” for a male or female owner. English uses his for a male person and her for a female person.',
      bodyFa: 'در فارسی برای مالک مرد و زن از «او» استفاده می‌کنیم، اما انگلیسی برای مرد his و برای زن her دارد.',
      examples: [
        A1BasicExample(english: 'Ali’s book → his book', persian: 'کتاب علی → کتاب او'),
        A1BasicExample(english: 'Sara’s book → her book', persian: 'کتاب سارا → کتاب او'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'Its and It’s',
      titleFa: 'نکته مهم: Its و It’s',
      body: 'Its shows possession. It’s is short for it is or it has. Do not confuse them.',
      bodyFa: 'its مالکیت را نشان می‌دهد. it’s شکل کوتاه it is یا it has است. این دو را با هم اشتباه نکن.',
      examples: [
        A1BasicExample(english: 'The cat licked its paw.', persian: 'گربه پنجه‌اش را لیس زد.'),
        A1BasicExample(english: 'It’s cold.', persian: 'هوا سرد است.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'comparison',
      title: 'An Important Difference from Persian',
      titleFa: 'تفاوت مهم با فارسی',
      body: 'In Persian, possession is commonly expressed after the noun: کتابِ من. In English, the possessive adjective comes before the noun: my book.',
      bodyFa: 'در فارسی معمولاً مالکیت بعد از اسم می‌آید: «کتابِ من». در انگلیسی صفت ملکی قبل از اسم می‌آید: my book.',
      examples: [
        A1BasicExample(english: 'کتابِ من → my book', persian: 'در انگلیسی my قبل از book می‌آید.'),
        A1BasicExample(english: 'خانه آنها → their house', persian: 'در انگلیسی their قبل از house می‌آید.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'More Examples',
      titleFa: 'مثال‌های بیشتر',
      body: 'See the possessive adjectives in everyday sentences.',
      bodyFa: 'صفت‌های ملکی را در جمله‌های روزمره ببین.',
      examples: [
        A1BasicExample(english: 'My name is Ali.', persian: 'اسم من علی است.'),
        A1BasicExample(english: 'Your car is red.', persian: 'ماشین تو قرمز است.'),
        A1BasicExample(english: 'His father is a doctor.', persian: 'پدر او (مرد) پزشک است.'),
        A1BasicExample(english: 'Her mother is a teacher.', persian: 'مادر او (زن) معلم است.'),
        A1BasicExample(english: 'Its color is blue.', persian: 'رنگ آن آبی است.'),
        A1BasicExample(english: 'Our house is big.', persian: 'خانه ما بزرگ است.'),
        A1BasicExample(english: 'Their children are young.', persian: 'بچه‌های آنها کم‌سن هستند.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'practice',
      title: 'Guided Practice',
      titleFa: 'تمرین هدایت‌شده',
      body: 'Choose the possessive adjective that matches the owner, then place it before the noun.',
      bodyFa: 'صفت ملکی متناسب با مالک را انتخاب کن و آن را قبل از اسم قرار بده.',
      examples: [
        A1BasicExample(english: 'I have a book. → My book is new.', persian: 'من یک کتاب دارم. → کتاب من جدید است.'),
        A1BasicExample(english: 'She has a bag. → Her bag is red.', persian: 'او یک کیف دارد. → کیف او قرمز است.'),
        A1BasicExample(english: 'They have a house. → Their house is big.', persian: 'آنها یک خانه دارند. → خانه آنها بزرگ است.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'independent',
      title: 'Independent Production',
      titleFa: 'تمرین مستقل',
      body: 'Make your own short sentences with my, your, his, her, its, our, and their.',
      bodyFa: 'با my، your، his، her، its، our و their جمله‌های کوتاه خودت را بساز.',
      examples: [
        A1BasicExample(english: 'My name is ...', persian: 'اسم من ... است.'),
        A1BasicExample(english: 'My phone is ...', persian: 'گوشی من ... است.'),
        A1BasicExample(english: 'Our house is ...', persian: 'خانه ما ... است.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'real_world',
      title: 'Real-Life Use',
      titleFa: 'کاربرد واقعی',
      body: 'Use possessive adjectives in everyday introductions and descriptions: My name is..., What is your name?, This is her bag, and Their car is outside.',
      bodyFa: 'از صفت‌های ملکی در معرفی و توصیف‌های روزمره استفاده کن: My name is...، What is your name?، This is her bag و Their car is outside.',
      examples: [
        A1BasicExample(english: 'My name is Ali.', persian: 'اسم من علی است.'),
        A1BasicExample(english: 'What is your name?', persian: 'اسم تو چیست؟'),
        A1BasicExample(english: 'This is her bag.', persian: 'این کیف اوست.'),
        A1BasicExample(english: 'Their car is outside.', persian: 'ماشین آنها بیرون است.'),
      ],
    ),
    A1BasicLearningPhase(
      type: 'speaking',
      title: 'Speaking',
      titleFa: 'تمرین تلفظ و لهجه',
      body: 'Read the sentences aloud. Focus on the pronunciation of my, your, his, her, its, our, and their.',
      bodyFa: 'جمله‌ها را با صدای بلند بخوان. روی تلفظ my، your، his، her، its، our و their تمرکز کن.',
      examples: [
        A1BasicExample(english: 'This is my book.', persian: 'این کتاب من است.', pronunciation: 'ذیس ایز مای بوک'),
        A1BasicExample(english: 'What is your name?', persian: 'اسم تو چیست؟', pronunciation: 'وات ایز یور نِیم'),
        A1BasicExample(english: 'His car is red.', persian: 'ماشین او قرمز است.', pronunciation: 'هِز کار ایز رِد'),
        A1BasicExample(english: 'Her bag is black.', persian: 'کیف او مشکی است.', pronunciation: 'هِر بَگ ایز بِلَک'),
        A1BasicExample(english: 'Our house is big.', persian: 'خانه ما بزرگ است.', pronunciation: 'آوِر هاوس ایز بیگ'),
        A1BasicExample(english: 'Their car is outside.', persian: 'ماشین آنها بیرون است.', pronunciation: 'ذِر کار ایز آوت‌ساید'),
      ],
    ),
  ],


vocabulary: [
  A1BasicVocabulary(
    english: 'my',
    persian: 'مال من / ـِ من',
    pronunciation: 'مای',
    example: 'This is my phone.',
  ),
  A1BasicVocabulary(
    english: 'your',
    persian: 'مال تو / شما / ـِ تو / شما',
    pronunciation: 'یور',
    example: 'What is your name?',
  ),
  A1BasicVocabulary(
    english: 'his',
    persian: 'مال او / ـِ او (مذکر)',
    pronunciation: 'هِز',
    example: 'His phone is new.',
  ),
  A1BasicVocabulary(
    english: 'her',
    persian: 'مال او / ـِ او (مؤنث)',
    pronunciation: 'هِر',
    example: 'Her bag is black.',
  ),
  A1BasicVocabulary(
    english: 'its',
    persian: 'مال آن / ـِ آن',
    pronunciation: 'اِتس',
    example: 'The cat is eating its food.',
  ),
  A1BasicVocabulary(
    english: 'our',
    persian: 'مال ما / ـِ ما',
    pronunciation: 'آوِر',
    example: 'Our house is small.',
  ),
  A1BasicVocabulary(
    english: 'their',
    persian: 'مال آنها / ـِ آنها',
    pronunciation: 'ذِر',
    example: 'Their car is outside.',
  ),
  A1BasicVocabulary(
    english: 'mine',
    persian: 'مال من',
    pronunciation: 'ماین',
    example: 'This book is mine.',
  ),
  A1BasicVocabulary(
    english: 'phone',
    persian: 'گوشی / تلفن',
    pronunciation: 'فون',
    example: 'Where is my phone?',
  ),
  A1BasicVocabulary(
    english: 'bag',
    persian: 'کیف',
    pronunciation: 'بَگ',
    example: 'Where is her bag?',
  ),
  A1BasicVocabulary(
    english: 'name',
    persian: 'اسم / نام',
    pronunciation: 'نِیم',
    example: 'What is your name?',
  ),
  A1BasicVocabulary(
    english: 'room',
    persian: 'اتاق',
    pronunciation: 'روم',
    example: 'This is her room.',
  ),
  A1BasicVocabulary(
    english: 'car',
    persian: 'ماشین',
    pronunciation: 'کار',
    example: 'Their car is outside.',
  ),
  A1BasicVocabulary(
    english: 'house',
    persian: 'خانه',
    pronunciation: 'هاوس',
    example: 'Our house is small.',
  ),
  A1BasicVocabulary(
    english: 'book',
    persian: 'کتاب',
    pronunciation: 'بوک',
    example: 'This book is mine.',
  ),
  A1BasicVocabulary(
    english: 'teacher',
    persian: 'معلم',
    pronunciation: 'تیچِر',
    example: 'Our teacher is nice.',
  ),
  A1BasicVocabulary(
    english: 'school',
    persian: 'مدرسه',
    pronunciation: 'اِسکول',
    example: 'Our school',
  ),
  A1BasicVocabulary(
    english: 'friend',
    persian: 'دوست',
    pronunciation: 'فِرِند',
    example: 'This is my friend.',
  ),
  A1BasicVocabulary(
    english: 'family',
    persian: 'خانواده',
    pronunciation: 'فَمِلی',
    example: 'He loves his family.',
  ),
  A1BasicVocabulary(
    english: 'sister',
    persian: 'خواهر',
    pronunciation: 'سیستِر',
    example: 'His sister',
  ),
  A1BasicVocabulary(
    english: 'brother',
    persian: 'برادر',
    pronunciation: 'برادِر',
    example: 'Her brother',
  ),
  A1BasicVocabulary(
    english: 'parents',
    persian: 'والدین',
    pronunciation: 'پِرِنتس',
    example: 'Their parents',
  ),
  A1BasicVocabulary(
    english: 'children',
    persian: 'بچه‌ها / کودکان',
    pronunciation: 'چیلدرِن',
    example: 'Their children',
  ),
  A1BasicVocabulary(
    english: 'food',
    persian: 'غذا',
    pronunciation: 'فود',
    example: 'The cat is eating its food.',
  ),
  A1BasicVocabulary(
    english: 'cat',
    persian: 'گربه',
    pronunciation: 'کَت',
    example: 'The cat is eating its food.',
  ),
  A1BasicVocabulary(
    english: 'dog',
    persian: 'سگ',
    pronunciation: 'داگ',
    example: 'The dog moved its tail.',
  ),
  A1BasicVocabulary(
    english: 'tail',
    persian: 'دم',
    pronunciation: 'تِیل',
    example: 'The dog moved its tail.',
  ),
  A1BasicVocabulary(
    english: 'leg',
    persian: 'پا',
    pronunciation: 'لِگ',
    example: 'The dog hurt its leg.',
  ),
  A1BasicVocabulary(
    english: 'company',
    persian: 'شرکت',
    pronunciation: 'کامپِنی',
    example: 'The company changed its name.',
  ),
  A1BasicVocabulary(
    english: 'shirt',
    persian: 'پیراهن',
    pronunciation: 'شِرت',
    example: 'I like your shirt.',
  ),
  A1BasicVocabulary(
    english: 'table',
    persian: 'میز',
    pronunciation: 'تِیبِل',
    example: 'Her bag is on the table.',
  ),
  A1BasicVocabulary(
    english: 'phone',
    persian: 'گوشی / تلفن',
    pronunciation: 'فون',
    example: 'Is this your phone?',
  ),
  A1BasicVocabulary(
    english: 'book',
    persian: 'کتاب',
    pronunciation: 'بوک',
    example: 'This is his book.',
  ),
],

  sections: [
    A1BasicSection(
      title: 'What Are Possessive Adjectives?',
      titleFa: 'صفت‌های ملکی چیستند؟',
      explanationFa: "صفت‌های ملکی نشان می‌دهند یک چیز متعلق به چه کسی است یا چه رابطه‌ای با یک شخص دارد. صفت ملکی معمولاً قبل از اسم می‌آید؛ مثل my phone و her name.",

      explanation:
          'Possessive adjectives show ownership or a relationship between a person and a thing. '
          'They come before a noun.',
      examples: [
        A1BasicExample(
          english: 'my phone',
          persian: 'گوشی من',
        ),
        A1BasicExample(
          english: 'your bag',
          persian: 'کیف تو / شما',
        ),
        A1BasicExample(
          english: 'her name',
          persian: 'اسم او',
        ),
        A1BasicExample(
          english: 'their house',
          persian: 'خانه آنها',
        ),
      ],
    ),

    A1BasicSection(
      title: 'The Possessive Adjective Table',
      titleFa: 'جدول صفت‌های ملکی',
      explanationFa: "هر ضمیر فاعلی یک صفت ملکی مرتبط دارد. برای I از my، برای you از your، برای he از his، برای she از her، برای it از its، برای we از our و برای they از their استفاده می‌کنیم.",

      explanation:
          'Each subject pronoun has a possessive adjective.',
      examples: [
        A1BasicExample(
          english: 'I → my',
          persian: 'من → مال من / ـِ من',
        ),
        A1BasicExample(
          english: 'you → your',
          persian: 'تو / شما → مال تو / شما',
        ),
        A1BasicExample(
          english: 'he → his',
          persian: 'او (مذکر) → مال او',
        ),
        A1BasicExample(
          english: 'she → her',
          persian: 'او (مونث) → مال او',
        ),
        A1BasicExample(
          english: 'it → its',
          persian: 'آن → مال آن',
        ),
        A1BasicExample(
          english: 'we → our',
          persian: 'ما → مال ما',
        ),
        A1BasicExample(
          english: 'they → their',
          persian: 'آنها → مال آنها',
        ),
      ],
    ),

    A1BasicSection(
      title: 'My',
      titleFa: 'My',
      explanationFa: "my نشان می‌دهد چیزی متعلق به گوینده است. my همیشه قبل از اسم می‌آید؛ مثل my name، my phone و my room.",

      explanation:
          'My shows that something belongs to me. My comes before a noun.',
      examples: [
        A1BasicExample(
          english: 'my name',
          persian: 'اسم من',
        ),
        A1BasicExample(
          english: 'my phone',
          persian: 'گوشی من',
        ),
        A1BasicExample(
          english: 'my room',
          persian: 'اتاق من',
        ),
        A1BasicExample(
          english: 'This is my bag.',
          persian: 'این کیف من است.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Your',
      titleFa: 'Your',
      explanationFa: "your نشان می‌دهد چیزی متعلق به مخاطب است. your هم برای یک نفر و هم برای چند نفر استفاده می‌شود و قبل از اسم قرار می‌گیرد.",

      explanation:
          'Your shows that something belongs to you. It can be used for one person or more than one person.',
      examples: [
        A1BasicExample(
          english: 'your name',
          persian: 'اسم تو / شما',
        ),
        A1BasicExample(
          english: 'your phone',
          persian: 'گوشی تو / شما',
        ),
        A1BasicExample(
          english: 'your room',
          persian: 'اتاق تو / شما',
        ),
        A1BasicExample(
          english: 'Where is your bag?',
          persian: 'کیف تو کجاست؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'His',
      titleFa: 'His',
      explanationFa: "his نشان می‌دهد چیزی متعلق به یک فرد مذکر است. his قبل از اسم می‌آید؛ مثل his name، his phone و his car.",

      explanation:
          'His shows that something belongs to a male person.',
      examples: [
        A1BasicExample(
          english: 'his name',
          persian: 'اسم او',
        ),
        A1BasicExample(
          english: 'his phone',
          persian: 'گوشی او',
        ),
        A1BasicExample(
          english: 'his car',
          persian: 'ماشین او',
        ),
        A1BasicExample(
          english: 'That is his book.',
          persian: 'آن کتاب اوست.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Her',
      titleFa: 'Her',
      explanationFa: "her نشان می‌دهد چیزی متعلق به یک فرد مؤنث است. her قبل از اسم می‌آید؛ مثل her name، her phone و her bag.",

      explanation:
          'Her shows that something belongs to a female person.',
      examples: [
        A1BasicExample(
          english: 'her name',
          persian: 'اسم او',
        ),
        A1BasicExample(
          english: 'her phone',
          persian: 'گوشی او',
        ),
        A1BasicExample(
          english: 'her bag',
          persian: 'کیف او',
        ),
        A1BasicExample(
          english: 'This is her room.',
          persian: 'این اتاق اوست.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Its',
      titleFa: 'Its',
      explanationFa: "its برای نشان دادن مالکیت یک حیوان، چیز یا سازمان استفاده می‌شود. باید its را با it’s اشتباه نگیریم؛ it’s کوتاه‌شده it is یا it has است.",

      explanation:
          'Its shows that something belongs to an animal, thing, or organization. '
          'Do not confuse its with it’s. It’s means it is or it has.',
      examples: [
        A1BasicExample(
          english: 'The cat is eating its food.',
          persian: 'گربه دارد غذایش را می‌خورد.',
        ),
        A1BasicExample(
          english: 'The dog moved its tail.',
          persian: 'سگ دمش را تکان داد.',
        ),
        A1BasicExample(
          english: 'The company changed its name.',
          persian: 'شرکت نامش را تغییر داد.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Our',
      titleFa: 'Our',
      explanationFa: "our نشان می‌دهد چیزی متعلق به ماست. our قبل از اسم قرار می‌گیرد؛ مثل our house، our teacher و our school.",

      explanation:
          'Our shows that something belongs to us.',
      examples: [
        A1BasicExample(
          english: 'our house',
          persian: 'خانه ما',
        ),
        A1BasicExample(
          english: 'our teacher',
          persian: 'معلم ما',
        ),
        A1BasicExample(
          english: 'our school',
          persian: 'مدرسه ما',
        ),
        A1BasicExample(
          english: 'This is our room.',
          persian: 'این اتاق ماست.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Their',
      titleFa: 'Their',
      explanationFa: "their نشان می‌دهد چیزی متعلق به آن‌هاست. their قبل از اسم می‌آید؛ مثل their house، their car و their children.",

      explanation:
          'Their shows that something belongs to them.',
      examples: [
        A1BasicExample(
          english: 'their house',
          persian: 'خانه آنها',
        ),
        A1BasicExample(
          english: 'their car',
          persian: 'ماشین آنها',
        ),
        A1BasicExample(
          english: 'their children',
          persian: 'بچه‌های آنها',
        ),
        A1BasicExample(
          english: 'I know their teacher.',
          persian: 'من معلم آنها را می‌شناسم.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Possessive Adjective + Noun',
      titleFa: 'صفت ملکی + اسم',
      explanationFa: "صفت ملکی معمولاً مستقیماً قبل از اسم قرار می‌گیرد. بنابراین می‌گوییم my book، your friend، his sister و their parents.",

      explanation:
          'A possessive adjective normally comes directly before a noun.',
      examples: [
        A1BasicExample(
          english: 'my book',
          persian: 'کتاب من',
        ),
        A1BasicExample(
          english: 'your friend',
          persian: 'دوست تو',
        ),
        A1BasicExample(
          english: 'his sister',
          persian: 'خواهر او',
        ),
        A1BasicExample(
          english: 'her brother',
          persian: 'برادر او',
        ),
        A1BasicExample(
          english: 'our teacher',
          persian: 'معلم ما',
        ),
        A1BasicExample(
          english: 'their parents',
          persian: 'والدین آنها',
        ),
      ],
    ),

    A1BasicSection(
      title: 'His vs Her',
      titleFa: 'تفاوت His و Her',
      explanationFa: "his برای اشاره به مالکیت یک فرد مذکر و her برای اشاره به مالکیت یک فرد مؤنث استفاده می‌شود. جنسیت صاحب وسیله یا چیز تعیین می‌کند از کدام‌یک استفاده کنیم.",

      explanation:
          'His refers to a male person. Her refers to a female person.',
      examples: [
        A1BasicExample(
          english: 'Ali has a phone. His phone is new.',
          persian: 'علی یک گوشی دارد. گوشی او جدید است.',
        ),
        A1BasicExample(
          english: 'Sara has a bag. Her bag is black.',
          persian: 'سارا یک کیف دارد. کیف او مشکی است.',
        ),
        A1BasicExample(
          english: 'This is his book.',
          persian: 'این کتاب اوست.',
        ),
        A1BasicExample(
          english: 'This is her book.',
          persian: 'این کتاب اوست.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Its vs It’s',
      titleFa: 'تفاوت Its و It’s',
      explanationFa: "its برای نشان دادن مالکیت است، در حالی که it’s شکل کوتاه it is یا it has است. این دو کلمه تلفظ مشابهی دارند اما معنی و کاربردشان متفاوت است.",

      explanation:
          'Its shows possession. It’s is a contraction of it is or it has.',
      examples: [
        A1BasicExample(
          english: 'The cat is in its box.',
          persian: 'گربه داخل جعبه‌اش است.',
        ),
        A1BasicExample(
          english: 'It’s cold.',
          persian: 'هوا سرد است.',
        ),
        A1BasicExample(
          english: 'The dog hurt its leg.',
          persian: 'سگ پایش را زخمی کرد.',
        ),
        A1BasicExample(
          english: 'It’s a big dog.',
          persian: 'آن یک سگ بزرگ است.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Common Mistakes',
      titleFa: 'اشتباهات رایج',
      explanationFa: "یکی از اشتباه‌های رایج این است که صفت ملکی را با شکل کوتاه کلمات اشتباه بگیریم. مثلاً my phone درست است، اما you’re bag، they’re house و it’s name نادرست هستند.",

      explanation:
          'Remember that possessive adjectives come before nouns. Also remember that your and you’re, their and they’re, and its and it’s have different meanings.',
      examples: [
        A1BasicExample(
          english: 'my phone ✓',
          persian: 'گوشی من',
        ),
        A1BasicExample(
          english: 'your bag ✓',
          persian: 'کیف تو',
        ),
        A1BasicExample(
          english: 'you’re bag ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'their house ✓',
          persian: 'خانه آنها',
        ),
        A1BasicExample(
          english: 'they’re house ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'its name ✓',
          persian: 'نام آن',
        ),
        A1BasicExample(
          english: 'it’s name ✗',
          persian: 'غلط',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Real-Life Examples',
      titleFa: 'مثال‌های واقعی و روزمره',
      explanationFa: "صفت‌های ملکی در مکالمات روزمره بسیار رایج هستند. جمله‌هایی مثل What’s your name?، Where is my phone? و Is this your phone? را مرتب در موقعیت‌های واقعی می‌شنوی و استفاده می‌کنی.",

      explanation:
          'Possessive adjectives are everywhere in everyday English.',
      examples: [
        A1BasicExample(
          english: 'What’s your name?',
          persian: 'اسمت چیه؟',
        ),
        A1BasicExample(
          english: 'Where is my phone?',
          persian: 'گوشی من کجاست؟',
        ),
        A1BasicExample(
          english: 'This is my friend.',
          persian: 'این دوست من است.',
        ),
        A1BasicExample(
          english: 'Where is her bag?',
          persian: 'کیف او کجاست؟',
        ),
        A1BasicExample(
          english: 'I like their house.',
          persian: 'من خانه آنها را دوست دارم.',
        ),
        A1BasicExample(
          english: 'Our teacher is nice.',
          persian: 'معلم ما مهربان است.',
        ),
        A1BasicExample(
          english: 'Is this your phone?',
          persian: 'این گوشی توست؟',
        ),
      ],
    ),
  ],

  examples: [
    A1BasicExample(
      english: 'My name is Anna.',
      persian: 'اسم من آناست.',
    ),
    A1BasicExample(
      english: 'What is your name?',
      persian: 'اسمت چیست؟',
    ),
    A1BasicExample(
      english: 'His phone is new.',
      persian: 'گوشی او جدید است.',
    ),
    A1BasicExample(
      english: 'Her bag is on the table.',
      persian: 'کیف او روی میز است.',
    ),
    A1BasicExample(
      english: 'The cat is eating its food.',
      persian: 'گربه دارد غذایش را می‌خورد.',
    ),
    A1BasicExample(
      english: 'Our house is small.',
      persian: 'خانه ما کوچک است.',
    ),
    A1BasicExample(
      english: 'Their car is outside.',
      persian: 'ماشین آنها بیرون است.',
    ),
    A1BasicExample(
      english: 'I like your shirt.',
      persian: 'من پیراهنت را دوست دارم.',
    ),
    A1BasicExample(
      english: 'Where is my phone?',
      persian: 'گوشی من کجاست؟',
    ),
    A1BasicExample(
      english: 'This is her room.',
      persian: 'این اتاق اوست.',
    ),
    A1BasicExample(
      english: 'That book is mine.',
      persian: 'آن کتاب مال من است.',
    ),
    A1BasicExample(
      english: 'Is this your bag?',
      persian: 'این کیف توست؟',
    ),
  ],

  questions: [
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'This is ___ phone.',
      options: ['my', 'mine', 'I', 'me'],
      answer: 'my',
      explanation: 'My comes before the noun phone.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'What is ___ name?',
      options: ['your', 'you', 'yours', 'you’re'],
      answer: 'your',
      explanation: 'Your comes before the noun name.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Ali has a car. ___ car is red.',
      options: ['His', 'Her', 'Their', 'Our'],
      answer: 'His',
      explanation: 'Ali is male, so use his.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Sara has a bag. ___ bag is black.',
      options: ['Her', 'His', 'Their', 'Our'],
      answer: 'Her',
      explanation: 'Sara is female, so use her.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'We love ___ teacher.',
      options: ['our', 'us', 'ours', 'we'],
      answer: 'our',
      explanation: 'Our comes before the noun teacher.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'They have a house. ___ house is big.',
      options: ['Their', 'They', 'Them', 'Theirs'],
      answer: 'Their',
      explanation: 'Their comes before the noun house.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'The cat is eating ___ food.',
      options: ['its', 'it’s', 'it', 'their'],
      answer: 'its',
      explanation: 'Its shows possession.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'I like ___ new shoes.',
      options: ['your', 'you', 'yours', 'you’re'],
      answer: 'your',
      explanation: 'Your comes before shoes.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Where is ___ bag?',
      options: ['my', 'mine', 'me', 'I'],
      answer: 'my',
      explanation: 'My comes before the noun bag.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which is correct?',
      options: [
        'This is my book.',
        'This is mine book.',
        'This is me book.',
        'This is I book.',
      ],
      answer: 'This is my book.',
      explanation: 'Use my before a noun.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which is correct?',
      options: [
        'This book is mine.',
        'This book is my.',
        'This book is me.',
        'This book is I.',
      ],
      answer: 'This book is mine.',
      explanation: 'Mine is used without the noun after it.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'He loves ___ family.',
      options: ['his', 'him', 'he', 'hers'],
      answer: 'his',
      explanation: 'His shows possession by a male person.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'She loves ___ family.',
      options: ['her', 'hers', 'she', 'him'],
      answer: 'her',
      explanation: 'Her comes before the noun family.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'We are in ___ room.',
      options: ['our', 'us', 'ours', 'we'],
      answer: 'our',
      explanation: 'Our comes before room.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'They are with ___ friends.',
      options: ['their', 'them', 'they', 'theirs'],
      answer: 'their',
      explanation: 'Their comes before friends.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'The dog moved ___ tail.',
      options: ['its', 'it’s', 'it', 'their'],
      answer: 'its',
      explanation: 'Its shows that the tail belongs to the dog.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ name is David.',
      options: ['My', 'Mine', 'Me', 'I'],
      answer: 'My',
      explanation: 'My comes before the noun name.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Is this ___ phone?',
      options: ['your', 'you', 'yours', 'you’re'],
      answer: 'your',
      explanation: 'Your comes before phone.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'The students opened ___ books.',
      options: ['their', 'them', 'they', 'theirs'],
      answer: 'their',
      explanation: 'Their comes before books.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which means "گوشی من"?',
      options: ['my phone', 'mine phone', 'me phone', 'I phone'],
      answer: 'my phone',
      explanation: 'Use my before a noun.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which means "خانه آنها"?',
      options: ['their house', 'them house', 'they house', 'theirs house'],
      answer: 'their house',
      explanation: 'Their comes before house.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which means "ماشین او" for a man?',
      options: ['his car', 'her car', 'him car', 'he car'],
      answer: 'his car',
      explanation: 'His is used for a male person.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which means "کیف او" for a woman?',
      options: ['her bag', 'his bag', 'she bag', 'hers bag'],
      answer: 'her bag',
      explanation: 'Her is used for a female person.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'Our teacher is nice.',
        'Us teacher is nice.',
        'We teacher is nice.',
        'Ours teacher is nice.',
      ],
      answer: 'Our teacher is nice.',
      explanation: 'Our comes before the noun teacher.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which sentence is correct?',
      options: [
        'Their car is outside.',
        'Them car is outside.',
        'They car is outside.',
        'Theirs car is outside.',
      ],
      answer: 'Their car is outside.',
      explanation: 'Their comes before car.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'My comes before a noun.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'For example: my phone.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'Mine normally comes directly before a noun.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'Use my before a noun. Mine is normally used without the noun.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'His can show possession by a male person.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'Example: his phone.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'Her can show possession by a female person.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'Example: her bag.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'Their means possession by they.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'Their is the possessive adjective for they.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'Its and it’s always mean exactly the same thing.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'Its shows possession. It’s means it is or it has.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «این گوشی من است.»',
      options: [
        'This is my phone.',
        'This is mine phone.',
        'This is me phone.',
        'This is I phone.',
      ],
      answer: 'This is my phone.',
      explanation: 'Use my before phone.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «اسم تو چیست؟»',
      options: [
        'What is your name?',
        'What is you name?',
        'What is yours name?',
        'What is you’re name?',
      ],
      answer: 'What is your name?',
      explanation: 'Your comes before name.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «خانه آنها بزرگ است.»',
      options: [
        'Their house is big.',
        'Them house is big.',
        'They house is big.',
        'Theirs house is big.',
      ],
      answer: 'Their house is big.',
      explanation: 'Their comes before house.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «این اتاق ماست.»',
      options: [
        'This is our room.',
        'This is us room.',
        'This is we room.',
        'This is ours room.',
      ],
      answer: 'This is our room.',
      explanation: 'Our comes before room.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "my / phone / this / is"',
      options: [
        'This is my phone.',
        'My this is phone.',
        'This my phone is.',
        'Phone is this my.',
      ],
      answer: 'This is my phone.',
      explanation: 'Use this + is + possessive adjective + noun.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "your / what / name / is"',
      options: [
        'What is your name?',
        'Your what name is?',
        'What your is name?',
        'Name is what your?',
      ],
      answer: 'What is your name?',
      explanation: 'Your comes before the noun name.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "house / their / is / big"',
      options: [
        'Their house is big.',
        'House their is big.',
        'Their is house big.',
        'Big is their house.',
      ],
      answer: 'Their house is big.',
      explanation: 'Their comes before house.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct word: "This is ___ room."',
      options: ['her', 'hers', 'she', 'herself'],
      answer: 'her',
      explanation: 'Her comes before room.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct word: "That bag is ___."',
      options: ['mine', 'my', 'me', 'I'],
      answer: 'mine',
      explanation: 'Mine is used without the noun.',
    ),
  ],

  speakingQuestions: [
    A1BasicSpeakingQuestion(
      question: 'Say: My name is Anna.',
      persian: 'بگو: اسم من آناست.',
      acceptableAnswers: [
        'my name is anna',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Ask: What is your name?',
      persian: 'بپرس: اسمت چیست؟',
      acceptableAnswers: [
        'what is your name',
        'whats your name',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: This is my phone.',
      persian: 'بگو: این گوشی من است.',
      acceptableAnswers: [
        'this is my phone',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: His car is new.',
      persian: 'بگو: ماشین او جدید است.',
      acceptableAnswers: [
        'his car is new',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: Her bag is black.',
      persian: 'بگو: کیف او مشکی است.',
      acceptableAnswers: [
        'her bag is black',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: Our house is small.',
      persian: 'بگو: خانه ما کوچک است.',
      acceptableAnswers: [
        'our house is small',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: Their car is outside.',
      persian: 'بگو: ماشین آنها بیرون است.',
      acceptableAnswers: [
        'their car is outside',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Ask: Is this your phone?',
      persian: 'بپرس: این گوشی توست؟',
      acceptableAnswers: [
        'is this your phone',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: The cat is eating its food.',
      persian: 'بگو: گربه دارد غذایش را می‌خورد.',
      acceptableAnswers: [
        'the cat is eating its food',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: This book is mine.',
      persian: 'بگو: این کتاب مال من است.',
      acceptableAnswers: [
        'this book is mine',
      ],
    ),
  ],
);