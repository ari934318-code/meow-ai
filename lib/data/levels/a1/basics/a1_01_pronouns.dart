import 'a1_basics_models.dart';

const A1BasicLesson a1BasicPronouns = A1BasicLesson(
  id: 'a1_01_pronouns',
  title: 'Subject Pronouns',
  titleFa: 'ضمیرهای فاعلی',
  topic: 'Pronouns',
  explanation:
      'Subject pronouns are words we use instead of names or nouns when they are the subject of a sentence.',
  
  vocabulary: [
    A1BasicVocabulary(
      english: 'I',
      persian: 'من',
      pronunciation: 'آی',
      example: 'I am a student.',
    ),
    A1BasicVocabulary(
      english: 'you',
      persian: 'تو / شما',
      pronunciation: 'یو',
      example: 'You are my friend.',
    ),
    A1BasicVocabulary(
      english: 'he',
      persian: 'او، مذکر',
      pronunciation: 'هی',
      example: 'He is a teacher.',
    ),
    A1BasicVocabulary(
      english: 'she',
      persian: 'او، مؤنث',
      pronunciation: 'شی',
      example: 'She is my sister.',
    ),
    A1BasicVocabulary(
      english: 'it',
      persian: 'آن / این',
      pronunciation: 'اِت',
      example: 'It is a book.',
    ),
    A1BasicVocabulary(
      english: 'we',
      persian: 'ما',
      pronunciation: 'وی',
      example: 'We are ready.',
    ),
    A1BasicVocabulary(
      english: 'they',
      persian: 'آن‌ها',
      pronunciation: 'ذِی',
      example: 'They are students.',
    ),
  ],

  sections: [
    A1BasicSection(
      title: 'The 7 Subject Pronouns',
      titleFa: '۷ ضمیر فاعلی',
      explanation:
          'English has seven main subject pronouns: I, you, he, she, it, we, and they.',
      explanationFa:
          'این‌ها ۷ ضمیر فاعلی اصلی هستند که در سطح A1 باید یاد بگیری. '
          'معنی، تلفظ و زمان استفاده از هرکدام را یاد بگیر.',
      examples: [
        A1BasicExample(
          english: 'I am happy.',
          persian: 'من خوشحالم.',
        ),
        A1BasicExample(
          english: 'You are my friend.',
          persian: 'تو دوست من هستی.',
        ),
        A1BasicExample(
          english: 'He is a teacher.',
          persian: 'او یک معلم است.',
        ),
        A1BasicExample(
          english: 'She is my sister.',
          persian: 'او خواهر من است.',
        ),
        A1BasicExample(
          english: 'It is cold.',
          persian: 'هوا سرد است.',
        ),
        A1BasicExample(
          english: 'We are ready.',
          persian: 'ما آماده‌ایم.',
        ),
        A1BasicExample(
          english: 'They are students.',
          persian: 'آن‌ها دانش‌آموز هستند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'I = Me',
      titleFa: 'I = من',
      explanation:
          'Use I when you are talking about yourself. The pronoun I is always written with a capital letter.',
      explanationFa:
          'از I وقتی استفاده می‌کنیم که درباره خودمان صحبت می‌کنیم. '
          'I همیشه با حرف بزرگ نوشته می‌شود، حتی وقتی وسط جمله قرار داشته باشد.',
      examples: [
        A1BasicExample(
          english: 'I am tired.',
          persian: 'من خسته‌ام.',
        ),
        A1BasicExample(
          english: 'I like coffee.',
          persian: 'من قهوه دوست دارم.',
        ),
        A1BasicExample(
          english: 'My name is Ali. I am 20.',
          persian: 'اسم من علی است. من ۲۰ ساله هستم.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'You = You',
      titleFa: 'You = تو / شما',
      explanation:
          'Use you when you are talking directly to one person or more than one person.',
      explanationFa:
          'از you وقتی استفاده می‌کنیم که مستقیماً با یک نفر یا یک گروه صحبت می‌کنیم. '
          'در انگلیسی برخلاف فارسی، برای «تو» و «شما» از یک کلمه یعنی you استفاده می‌شود.',
      examples: [
        A1BasicExample(
          english: 'You are nice.',
          persian: 'تو مهربانی.',
        ),
        A1BasicExample(
          english: 'You are my friends.',
          persian: 'شما دوستان من هستید.',
        ),
        A1BasicExample(
          english: 'Are you ready?',
          persian: 'آماده‌ای؟',
        ),
      ],
    ),

    A1BasicSection(
      title: 'He = He, Male',
      titleFa: 'He = او، مذکر',
      explanation:
          'Use he when you are talking about one male person.',
      explanationFa:
          'از he برای صحبت درباره یک فرد مذکر استفاده می‌کنیم؛ '
          'مثلاً یک مرد، پسر، پدر، برادر، معلم یا دوست مرد.',
      examples: [
        A1BasicExample(
          english: 'He is my brother.',
          persian: 'او برادر من است.',
        ),
        A1BasicExample(
          english: 'He is a doctor.',
          persian: 'او یک پزشک است.',
        ),
        A1BasicExample(
          english: 'He likes football.',
          persian: 'او فوتبال دوست دارد.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'She = She, Female',
      titleFa: 'She = او، مؤنث',
      explanation:
          'Use she when you are talking about one female person.',
      explanationFa:
          'از she برای صحبت درباره یک فرد مؤنث استفاده می‌کنیم؛ '
          'مثلاً یک زن، دختر، مادر، خواهر، معلم یا دوست زن.',
      examples: [
        A1BasicExample(
          english: 'She is my mother.',
          persian: 'او مادر من است.',
        ),
        A1BasicExample(
          english: 'She is a teacher.',
          persian: 'او یک معلم است.',
        ),
        A1BasicExample(
          english: 'She likes music.',
          persian: 'او موسیقی دوست دارد.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'It = It / This / That',
      titleFa: 'It = آن / این',
      explanation:
          'Use it for things, objects, animals when gender is not important, and many situations such as weather and time.',
      explanationFa:
          'از it برای یک چیز، وسیله، مکان یا موقعیت استفاده می‌کنیم و گاهی برای حیوانی که لازم نیست جنسیتش را مشخص کنیم. '
          'همچنین it در صحبت درباره آب‌وهوا، زمان و موقعیت‌های کلی بسیار رایج است.',
      examples: [
        A1BasicExample(
          english: 'It is a book.',
          persian: 'این یک کتاب است.',
        ),
        A1BasicExample(
          english: 'It is my phone.',
          persian: 'این گوشی من است.',
        ),
        A1BasicExample(
          english: 'It is cold today.',
          persian: 'امروز هوا سرد است.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'We = We',
      titleFa: 'We = ما',
      explanation:
          'Use we when you are talking about yourself and at least one other person.',
      explanationFa:
          'از we وقتی استفاده می‌کنیم که درباره خودمان و حداقل یک نفر دیگر صحبت می‌کنیم. '
          'یعنی گوینده هم جزو گروه است.',
      examples: [
        A1BasicExample(
          english: 'We are friends.',
          persian: 'ما دوست هستیم.',
        ),
        A1BasicExample(
          english: 'We live in Canada.',
          persian: 'ما در کانادا زندگی می‌کنیم.',
        ),
        A1BasicExample(
          english: 'We are ready.',
          persian: 'ما آماده‌ایم.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'They = They',
      titleFa: 'They = آنها',
      explanation:
          'Use they when talking about two or more people, animals, or things.',
      explanationFa:
          'از they وقتی استفاده می‌کنیم که درباره دو نفر یا بیشتر، چند حیوان یا چند چیز صحبت می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'They are my friends.',
          persian: 'آن‌ها دوستان من هستند.',
        ),
        A1BasicExample(
          english: 'They are students.',
          persian: 'آن‌ها دانش‌آموز هستند.',
        ),
        A1BasicExample(
          english: 'They are my books.',
          persian: 'آن‌ها کتاب‌های من هستند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Pronoun Comparison',
      titleFa: 'مقایسه ضمیرها',
      explanation:
          'Each subject pronoun has a different use. Choose the pronoun based on who or what you are talking about.',
      explanationFa:
          'در این بخش تفاوت ضمیرها را مقایسه می‌کنیم: '
          'برای خودمان از I، برای فردی که مستقیماً با او صحبت می‌کنیم از you، '
          'برای یک مرد از he، برای یک زن از she، برای یک چیز یا موقعیت از it، '
          'برای خودمان همراه با دیگران از we و برای افراد یا چیزهایی که درباره‌شان صحبت می‌کنیم از they استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'I am a student.',
          persian: 'من دانش‌آموز هستم.',
        ),
        A1BasicExample(
          english: 'You are a student.',
          persian: 'تو دانش‌آموز هستی.',
        ),
        A1BasicExample(
          english: 'He is a student.',
          persian: 'او دانش‌آموز است.',
        ),
        A1BasicExample(
          english: 'She is a student.',
          persian: 'او دانش‌آموز است.',
        ),
        A1BasicExample(
          english: 'We are students.',
          persian: 'ما دانش‌آموز هستیم.',
        ),
        A1BasicExample(
          english: 'They are students.',
          persian: 'آن‌ها دانش‌آموز هستند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'English Usually Needs the Subject',
      titleFa: 'انگلیسی معمولاً به فاعل نیاز دارد',
      explanation:
          'English sentences usually need an explicit subject. Unlike Persian, we normally cannot simply leave the subject out.',
      explanationFa:
          'در فارسی گاهی می‌توانیم فاعل را حذف کنیم، چون شکل فعل می‌تواند منظور را مشخص کند. '
          'اما در انگلیسی معمولاً باید فاعل را در جمله بیاوریم. '
          'پس به جای گفتن فقط «am happy»، می‌گوییم «I am happy».',
      examples: [
        A1BasicExample(
          english: 'I am happy.',
          persian: 'من خوشحالم.',
        ),
        A1BasicExample(
          english: 'She is tired.',
          persian: 'او خسته است.',
        ),
        A1BasicExample(
          english: 'They are ready.',
          persian: 'آن‌ها آماده هستند.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Capital I',
      titleFa: 'حرف بزرگ در I',
      explanation:
          'The pronoun I is always written with a capital letter, even when it appears in the middle of a sentence.',
      explanationFa:
          'ضمیر I همیشه با حرف بزرگ نوشته می‌شود. '
          'این قانون حتی زمانی که I در وسط جمله قرار دارد نیز برقرار است.',
      examples: [
        A1BasicExample(
          english: 'I am from Iran.',
          persian: 'من اهل ایران هستم.',
        ),
        A1BasicExample(
          english: 'My friend and I are here.',
          persian: 'من و دوستم اینجا هستیم.',
        ),
        A1BasicExample(
          english: 'When I wake up, I drink water.',
          persian: 'وقتی بیدار می‌شوم، آب می‌نوشم.',
        ),
      ],
    ),

    A1BasicSection(
      title: 'Common Mistakes',
      titleFa: 'اشتباهات رایج',
      explanation:
          'Beginners often choose the wrong pronoun or forget the subject. Pay attention to who or what the sentence is about.',
      explanationFa:
          'این اشتباهات برای زبان‌آموزان مبتدی رایج هستند. '
          'هنگام انتخاب ضمیر و فعل، دقت کن که درباره چه کسی یا چه چیزی صحبت می‌کنیم.',
      examples: [
        A1BasicExample(
          english: '❌ She is my brother.',
          persian: '❌ او برادر من است. (ضمیر اشتباه)',
        ),
        A1BasicExample(
          english: '✅ He is my brother.',
          persian: '✅ او برادر من است.',
        ),
        A1BasicExample(
          english: '❌ I are happy.',
          persian: '❌ من خوشحال هستم. (فعل اشتباه)',
        ),
        A1BasicExample(
          english: '✅ I am happy.',
          persian: '✅ من خوشحالم.',
        ),
      ],
    ),
  ],

  examples: [
    A1BasicExample(
      english: 'I am a student.',
      persian: 'من دانش‌آموز هستم.',
    ),
    A1BasicExample(
      english: 'You are my friend.',
      persian: 'تو دوست من هستی.',
    ),
    A1BasicExample(
      english: 'He is a doctor.',
      persian: 'او پزشک است.',
    ),
    A1BasicExample(
      english: 'She is my sister.',
      persian: 'او خواهر من است.',
    ),
    A1BasicExample(
      english: 'It is cold.',
      persian: 'هوا سرد است.',
    ),
    A1BasicExample(
      english: 'We are ready.',
      persian: 'ما آماده‌ایم.',
    ),
    A1BasicExample(
      english: 'They are happy.',
      persian: 'آن‌ها خوشحال هستند.',
    ),
  ],

  questions: [
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ am a student.',
      options: [
        'I',
        'You',
        'He',
        'They',
      ],
      answer: 'I',
      explanation: 'Use I when talking about yourself.',
      hint: 'من',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ is my brother.',
      options: [
        'He',
        'She',
        'It',
        'They',
      ],
      answer: 'He',
      explanation: 'Use he for one male person.',
      hint: 'او، مذکر',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ is my sister.',
      options: [
        'He',
        'She',
        'It',
        'We',
      ],
      answer: 'She',
      explanation: 'Use she for one female person.',
      hint: 'او، مؤنث',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ are my friends.',
      options: [
        'I',
        'He',
        'She',
        'They',
      ],
      answer: 'They',
      explanation: 'Use they for two or more people.',
      hint: 'آن‌ها',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: '___ are ready.',
      options: [
        'We',
        'He',
        'It',
        'She',
      ],
      answer: 'We',
      explanation: 'Use we when you are included in the group.',
      hint: 'ما',
    ),
  ],

  speakingQuestions: [
    A1BasicSpeakingQuestion(
      question: 'Say: I am a student.',
      persian: 'بگو: من دانش‌آموز هستم.',
      acceptableAnswers: [
        'I am a student',
        "I'm a student",
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: She is my friend.',
      persian: 'بگو: او دوست من است.',
      acceptableAnswers: [
        'She is my friend',
        "She's my friend",
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: They are happy.',
      persian: 'بگو: آن‌ها خوشحال هستند.',
      acceptableAnswers: [
        'They are happy',
        "They're happy",
      ],
    ),
  ],
);