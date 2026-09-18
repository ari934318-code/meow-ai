import 'a1_basics_models.dart';

const A1BasicLesson a1BasicObjectPronouns = A1BasicLesson(
  id: 'a1_basic_07',
  title: 'Object Pronouns',
  titleFa: 'ضمیرهای مفعولی',
  topic: 'me, you, him, her, it, us, them',
  explanation:
      'Object pronouns are used when a person or thing receives the action of a verb. '
      'The main object pronouns are me, you, him, her, it, us, and them. '
      'They usually come after a verb or after a preposition.',


  learningPhases: [
    A1BasicLearningPhase(
      type: 'curiosity',
      title: 'Think First',
      titleFa: 'اول فکر کن',
      body: 'Think: If you want to say “I see him/her,” why do we say “I see him” and not “I see he”?',
      bodyFa: 'فکر کن: اگر بخواهی بگویی «من او را می‌بینم»، چرا می‌گوییم I see him و نه I see he؟',
    ),
    A1BasicLearningPhase(
      type: 'introduction',
      title: 'What Are Object Pronouns?',
      titleFa: 'ضمیرهای مفعولی چیستند؟',
      body: 'Object pronouns are used for the person or thing that receives the action. Today we will learn me, you, him, her, it, us, and them.',
      bodyFa: 'ضمیر مفعولی برای شخص یا چیزی استفاده می‌شود که عمل فعل روی آن انجام می‌شود. امروز me، you، him، her، it، us و them را یاد می‌گیریم.',
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'Simple Examples',
      titleFa: 'مثال‌های ساده',
      body: 'Look at how the object pronoun replaces a person or thing.',
      bodyFa: 'ببین چطور ضمیر مفعولی جای یک شخص یا چیز را می‌گیرد.',
      examples: [
        A1BasicExample(
          english: 'I see Sara. → I see her.',
          persian: 'من سارا را می‌بینم. → من او را می‌بینم.',
        ),
        A1BasicExample(
          english: 'I see Ali. → I see him.',
          persian: 'من علی را می‌بینم. → من او را می‌بینم.',
        ),
        A1BasicExample(
          english: 'I see my friends. → I see them.',
          persian: 'من دوستانم را می‌بینم. → من آنها را می‌بینم.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'Subject vs Object',
      titleFa: 'فاعل و مفعول چیست؟',
      body: 'The subject usually does the action. The object receives the action. In “She loves me,” she does the action and me receives it.',
      bodyFa: 'فاعل معمولاً انجام‌دهنده عمل است و مفعول دریافت‌کننده عمل. در جمله She loves me، کلمه she انجام‌دهنده عمل و me دریافت‌کننده عمل است.',
      examples: [
        A1BasicExample(
          english: 'She loves me.',
          persian: 'او من را دوست دارد.',
        ),
        A1BasicExample(
          english: 'He sees her.',
          persian: 'او او را می‌بیند.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'guided',
      title: 'Find the Object',
      titleFa: 'فاعل و مفعول را پیدا کن',
      body: 'Ask: Who does the action? That is the subject. Who receives the action? That is the object.',
      bodyFa: 'بپرس: چه کسی عمل را انجام می‌دهد؟ آن فاعل است. عمل روی چه کسی یا چه چیزی انجام می‌شود؟ آن مفعول است.',
      examples: [
        A1BasicExample(
          english: 'She loves me. → She = subject, me = object',
          persian: 'She فاعل است و me مفعول.',
        ),
        A1BasicExample(
          english: 'They helped us. → They = subject, us = object',
          persian: 'They فاعل است و us مفعول.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'chart',
      title: 'Object Pronouns Chart',
      titleFa: 'جدول ضمیرهای مفعولی',
      body: 'Some subject pronouns change in the object form. You and it stay the same.',
      bodyFa: 'بعضی ضمیرهای فاعلی در حالت مفعولی تغییر می‌کنند. you و it در هر دو حالت یکسان می‌مانند.',
      tableRows: [
        ['Subject', 'Object', 'Meaning'],
        ['I', 'me', 'من / من را'],
        ['you', 'you', 'تو / شما'],
        ['he', 'him', 'او (مذکر) / او را'],
        ['she', 'her', 'او (مؤنث) / او را'],
        ['it', 'it', 'آن / آن را'],
        ['we', 'us', 'ما / ما را'],
        ['they', 'them', 'آنها / آنها را'],
      ],
    ),
    A1BasicLearningPhase(
      type: 'concept',
      title: 'An Important Difference from Persian',
      titleFa: 'یک تفاوت مهم با فارسی',
      body: 'Persian uses “او را” for both male and female. English separates him and her. In English, a direct object usually comes after the verb.',
      bodyFa: 'در فارسی برای زن و مرد هر دو می‌گوییم «او را»، اما انگلیسی بین him و her تفاوت می‌گذارد. در انگلیسی مفعول مستقیم معمولاً بعد از فعل می‌آید.',
      examples: [
        A1BasicExample(
          english: 'من او را می‌بینم. → I see him.',
          persian: 'برای مرد از him استفاده می‌کنیم.',
        ),
        A1BasicExample(
          english: 'من او را می‌بینم. → I see her.',
          persian: 'برای زن از her استفاده می‌کنیم.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'Object After a Verb',
      titleFa: 'مفعول بعد از فعل',
      body: 'Object pronouns commonly come after a verb: help me, know him, like her, need it, help us, and know them.',
      bodyFa: 'ضمیرهای مفعولی معمولاً بعد از فعل می‌آیند؛ مثل help me، know him، like her، need it، help us و know them.',
      examples: [
        A1BasicExample(
          english: 'Please help me.',
          persian: 'لطفاً به من کمک کن.',
        ),
        A1BasicExample(
          english: 'I know him.',
          persian: 'من او را می‌شناسم.',
        ),
        A1BasicExample(
          english: 'I like her.',
          persian: 'من او را دوست دارم.',
        ),
        A1BasicExample(
          english: 'I need it.',
          persian: 'من به آن نیاز دارم.',
        ),
        A1BasicExample(
          english: 'They helped us.',
          persian: 'آنها به ما کمک کردند.',
        ),
        A1BasicExample(
          english: 'I know them.',
          persian: 'من آنها را می‌شناسم.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'Object After a Preposition',
      titleFa: 'مفعول بعد از حرف اضافه',
      body: 'Object pronouns also come after prepositions such as for, with, and to: for me, with us, to him.',
      bodyFa: 'ضمیرهای مفعولی بعد از حروف اضافه‌ای مثل for، with و to هم می‌آیند؛ مثل for me، with us و to him.',
      examples: [
        A1BasicExample(
          english: 'This is for me.',
          persian: 'این برای من است.',
        ),
        A1BasicExample(
          english: 'Come with us.',
          persian: 'با ما بیا.',
        ),
        A1BasicExample(
          english: 'Give it to him.',
          persian: 'آن را به او بده.',
        ),
        A1BasicExample(
          english: 'This message is from her.',
          persian: 'این پیام از طرف اوست.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'comparison',
      title: 'Subject vs Object Forms',
      titleFa: 'مقایسه شکل فاعلی و مفعولی',
      body: 'Use the subject form for the doer and the object form for the receiver. Do not choose the form just because it appears first in a sentence.',
      bodyFa: 'برای انجام‌دهنده عمل از شکل فاعلی و برای دریافت‌کننده عمل از شکل مفعولی استفاده کن. فقط بر اساس جای کلمه تصمیم نگیر.',
      examples: [
        A1BasicExample(
          english: 'I see him. → I = subject, him = object',
          persian: 'I فاعل و him مفعول است.',
        ),
        A1BasicExample(
          english: 'She loves me. → She = subject, me = object',
          persian: 'She فاعل و me مفعول است.',
        ),
        A1BasicExample(
          english: 'They called us. → They = subject, us = object',
          persian: 'They فاعل و us مفعول است.',
        ),
        A1BasicExample(
          english: 'He knows her. → He = subject, her = object',
          persian: 'He فاعل و her مفعول است.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'mistakes',
      title: 'Common Mistakes',
      titleFa: 'اشتباهات رایج',
      body: 'After a verb or preposition, use the object form: me, you, him, her, it, us, or them.',
      bodyFa: 'بعد از فعل یا حرف اضافه، از شکل مفعولی استفاده کن: me، you، him، her، it، us یا them.',
      examples: [
        A1BasicExample(
          english: 'I see him. ✓  I see he. ✗',
          persian: 'درست: I see him. غلط: I see he.',
        ),
        A1BasicExample(
          english: 'She loves me. ✓  She loves I. ✗',
          persian: 'درست: She loves me. غلط: She loves I.',
        ),
        A1BasicExample(
          english: 'This is for us. ✓  This is for we. ✗',
          persian: 'درست: This is for us. غلط: This is for we.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'examples',
      title: 'More Examples',
      titleFa: 'مثال‌های بیشتر',
      body: 'Now see the object pronouns in short everyday sentences.',
      bodyFa: 'حالا ضمیرهای مفعولی را در چند جمله کوتاه و روزمره ببین.',
      examples: [
        A1BasicExample(
          english: 'Please help me.',
          persian: 'لطفاً به من کمک کن.',
        ),
        A1BasicExample(
          english: 'I know him.',
          persian: 'من او را می‌شناسم.',
        ),
        A1BasicExample(
          english: 'She saw us.',
          persian: 'او ما را دید.',
        ),
        A1BasicExample(
          english: 'They invited them.',
          persian: 'آنها آنها را دعوت کردند.',
        ),
        A1BasicExample(
          english: 'Can you call her?',
          persian: 'می‌توانی با او تماس بگیری؟',
        ),
        A1BasicExample(
          english: 'This gift is for you.',
          persian: 'این هدیه برای تو/شماست.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'practice',
      title: 'Guided Practice',
      titleFa: 'تمرین هدایت‌شده',
      body: 'Choose the correct object pronoun. Start with forms you have just learned, then mix them together.',
      bodyFa: 'ضمیر مفعولی درست را انتخاب کن. ابتدا شکل‌هایی را که تازه یاد گرفته‌ای تمرین کن و بعد آنها را با هم ترکیب کن.',
      examples: [
        A1BasicExample(
          english: 'I see Ali. → I see him.',
          persian: 'من علی را می‌بینم. → من او را می‌بینم.',
        ),
        A1BasicExample(
          english: 'She loves me.',
          persian: 'او من را دوست دارد.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'independent',
      title: 'Independent Translation',
      titleFa: 'تمرین مستقل',
      body: 'Translate short sentences using the correct object pronoun: me, him, her, it, us, or them.',
      bodyFa: 'جمله‌های کوتاه را با ضمیر مفعولی درست ترجمه کن: me، him، her، it، us یا them.',
      examples: [
        A1BasicExample(
          english: 'I see him.',
          persian: 'من او (مرد) را می‌بینم.',
        ),
        A1BasicExample(
          english: 'She loves me.',
          persian: 'او (زن) من را دوست دارد.',
        ),
        A1BasicExample(
          english: 'This is for us.',
          persian: 'این برای ماست.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'real_world',
      title: 'Real-Life Use',
      titleFa: 'کاربرد واقعی',
      body: 'Use object pronouns in everyday requests and short conversations: Can you help me? Call her. Come with us. Give it to him.',
      bodyFa: 'از ضمیرهای مفعولی در درخواست‌ها و گفت‌وگوهای روزمره استفاده کن: Can you help me?، Call her.، Come with us.، Give it to him.',
      examples: [
        A1BasicExample(
          english: 'Can you help me?',
          persian: 'می‌توانی به من کمک کنی؟',
        ),
        A1BasicExample(
          english: 'Come with us.',
          persian: 'با ما بیا.',
        ),
        A1BasicExample(
          english: 'Give it to him.',
          persian: 'آن را به او بده.',
        ),
      ],
    ),
    A1BasicLearningPhase(
      type: 'speaking',
      title: 'Speaking',
      titleFa: 'تمرین تلفظ و لهجه',
      body: 'Read the sentences aloud. Focus on the natural pronunciation of me, him, her, us, and them.',
      bodyFa: 'جمله‌ها را با صدای بلند بخوان. روی تلفظ طبیعی me، him، her، us و them تمرکز کن.',
      examples: [
        A1BasicExample(
          english: 'Please help me.',
          persian: 'لطفاً به من کمک کن.',
          pronunciation: 'پلیز هِلپ می',
        ),
        A1BasicExample(
          english: 'I know him.',
          persian: 'من او را می‌شناسم.',
          pronunciation: 'آی نو هِم',
        ),
        A1BasicExample(
          english: 'I like her.',
          persian: 'من او را دوست دارم.',
          pronunciation: 'آی لایک هِر',
        ),
        A1BasicExample(
          english: 'They helped us.',
          persian: 'آنها به ما کمک کردند.',
          pronunciation: 'ذِی هِلپت اَس',
        ),
        A1BasicExample(
          english: 'I know them.',
          persian: 'من آنها را می‌شناسم.',
          pronunciation: 'آی نو ذِم',
        ),
      ],
    ),
  ],


  vocabulary: [
    A1BasicVocabulary(
      english: 'me',
      persian: 'من را / به من',
      pronunciation: 'می',
      example: 'She called me.',
    ),
    A1BasicVocabulary(
      english: 'you',
      persian: 'تو را / شما را',
      pronunciation: 'یو',
      example: 'I know you.',
    ),
    A1BasicVocabulary(
      english: 'him',
      persian: 'او را / به او (مذکر)',
      pronunciation: 'هِم',
      example: 'I know him.',
    ),
    A1BasicVocabulary(
      english: 'her',
      persian: 'او را / به او (مؤنث)',
      pronunciation: 'هِر',
      example: 'I like her.',
    ),
    A1BasicVocabulary(
      english: 'it',
      persian: 'آن را',
      pronunciation: 'اِت',
      example: 'I like it.',
    ),
    A1BasicVocabulary(
      english: 'us',
      persian: 'ما را / به ما',
      pronunciation: 'اَس',
      example: 'They helped us.',
    ),
    A1BasicVocabulary(
      english: 'them',
      persian: 'آنها را / به آنها',
      pronunciation: 'ذِم',
      example: 'I know them.',
    ),
    A1BasicVocabulary(
      english: 'help',
      persian: 'کمک کردن',
      pronunciation: 'هِلپ',
      example: 'Can you help me?',
    ),
    A1BasicVocabulary(
      english: 'call',
      persian: 'تماس گرفتن',
      pronunciation: 'کال',
      example: 'Please call me later.',
    ),
    A1BasicVocabulary(
      english: 'know',
      persian: 'شناختن / دانستن',
      pronunciation: 'نو',
      example: 'I know him.',
    ),
    A1BasicVocabulary(
      english: 'like',
      persian: 'دوست داشتن',
      pronunciation: 'لایک',
      example: 'I like her.',
    ),
    A1BasicVocabulary(
      english: 'see',
      persian: 'دیدن',
      pronunciation: 'سی',
      example: 'I can see him.',
    ),
    A1BasicVocabulary(
      english: 'hear',
      persian: 'شنیدن',
      pronunciation: 'هِیر',
      example: 'Can you hear me?',
    ),
    A1BasicVocabulary(
      english: 'need',
      persian: 'نیاز داشتن',
      pronunciation: 'نید',
      example: 'I need it.',
    ),
    A1BasicVocabulary(
      english: 'open',
      persian: 'باز کردن',
      pronunciation: 'اوپِن',
      example: 'Please open it.',
    ),
    A1BasicVocabulary(
      english: 'wait',
      persian: 'صبر کردن / منتظر ماندن',
      pronunciation: 'وِیت',
      example: 'Please wait for us.',
    ),
    A1BasicVocabulary(
      english: 'give',
      persian: 'دادن',
      pronunciation: 'گیو',
      example: 'Give it to him.',
    ),
    A1BasicVocabulary(
      english: 'talk',
      persian: 'صحبت کردن',
      pronunciation: 'تاک',
      example: 'I am talking to her.',
    ),
    A1BasicVocabulary(
      english: 'message',
      persian: 'پیام',
      pronunciation: 'مِسِج',
      example: 'This message is from her.',
    ),
    A1BasicVocabulary(
      english: 'friend',
      persian: 'دوست',
      pronunciation: 'فِرِند',
      example: 'I see my friends.',
    ),
    A1BasicVocabulary(
      english: 'Sara',
      persian: 'سارا',
      pronunciation: 'سارا',
      example: 'I see Sara. → I see her.',
    ),
    A1BasicVocabulary(
      english: 'Ali',
      persian: 'علی',
      pronunciation: 'علی',
      example: 'I called Ali. → I called him.',
    ),
  ],

  sections: [
    A1BasicSection(
      title: 'What Are Object Pronouns?',
      titleFa: 'ضمیرهای مفعولی چیستند؟',
      explanation:
          'Object pronouns replace the person or thing that receives an action. '
          'For example, instead of saying "I see Sara", we can say "I see her".',
      explanationFa:
          'ضمیرهای مفعولی جای شخص یا چیزی را می‌گیرند که عمل فعل روی آن انجام می‌شود. ضمیرهای مفعولی اصلی عبارت‌اند از me، you، him، her، it، us و them.',
      examples: [
        A1BasicExample(
          english: 'I see Sara. → I see her.',
          persian: 'من سارا را می‌بینم. → من او را می‌بینم.',
        ),
        A1BasicExample(
          english: 'She calls me.',
          persian: 'او با من تماس می‌گیرد.',
        ),
        A1BasicExample(
          english: 'They help us.',
          persian: 'آنها به ما کمک می‌کنند.',
        ),
        A1BasicExample(
          english: 'I know him.',
          persian: 'من او را می‌شناسم.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Subject vs Object Pronouns',
      titleFa: 'ضمیرهای فاعلی و مفعولی',
      explanation:
          'Subject pronouns usually do the action. Object pronouns receive the action.',
      explanationFa:
          'ضمیر فاعلی معمولاً انجام‌دهنده عمل است، اما ضمیر مفعولی شخص یا چیزی را نشان می‌دهد که عمل روی آن انجام می‌شود. مثلاً I فاعل است و me شکل مفعولی آن است.',
      examples: [
        A1BasicExample(
          english: 'I → me',
          persian: 'من → من را / به من',
        ),
        A1BasicExample(
          english: 'you → you',
          persian: 'تو / شما → تو را / شما را',
        ),
        A1BasicExample(
          english: 'he → him',
          persian: 'او (مذکر) → او را / به او',
        ),
        A1BasicExample(
          english: 'she → her',
          persian: 'او (مونث) → او را / به او',
        ),
        A1BasicExample(
          english: 'it → it',
          persian: 'آن / آن را',
        ),
        A1BasicExample(
          english: 'we → us',
          persian: 'ما → ما را / به ما',
        ),
        A1BasicExample(
          english: 'they → them',
          persian: 'آنها → آنها را / به آنها',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Me',
      titleFa: 'Me',
      explanation:
          'Me is the object form of I. Use me when I receive the action.',
      explanationFa:
          'me شکل مفعولی I است. وقتی عمل فعل روی خود گوینده انجام می‌شود، از me استفاده می‌کنیم؛ مثل She called me.',
      examples: [
        A1BasicExample(
          english: 'She called me.',
          persian: 'او با من تماس گرفت.',
        ),
        A1BasicExample(
          english: 'He helped me.',
          persian: 'او به من کمک کرد.',
        ),
        A1BasicExample(
          english: 'Can you hear me?',
          persian: 'می‌توانی صدای من را بشنوی؟',
        ),
        A1BasicExample(
          english: 'Please help me.',
          persian: 'لطفاً به من کمک کن.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'You',
      titleFa: 'You',
      explanation:
          'You is used as both a subject and an object. It can mean one person or more than one person.',
      explanationFa:
          'you هم می‌تواند ضمیر فاعلی باشد و هم مفعولی. این کلمه برای یک نفر یا چند نفر استفاده می‌شود و شکل آن در حالت مفعولی تغییر نمی‌کند.',
      examples: [
        A1BasicExample(
          english: 'I know you.',
          persian: 'من تو را می‌شناسم.',
        ),
        A1BasicExample(
          english: 'She likes you.',
          persian: 'او تو را دوست دارد.',
        ),
        A1BasicExample(
          english: 'Can I help you?',
          persian: 'می‌توانم به تو کمک کنم؟',
        ),
        A1BasicExample(
          english: 'I called you yesterday.',
          persian: 'من دیروز با تو تماس گرفتم.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Him',
      titleFa: 'Him',
      explanation:
          'Him is the object form of he. Use him when a male person receives the action.',
      explanationFa:
          'him شکل مفعولی he است. وقتی یک فرد مذکر دریافت‌کننده عمل باشد، از him استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'I know him.',
          persian: 'من او را می‌شناسم.',
        ),
        A1BasicExample(
          english: 'She called him.',
          persian: 'او با او تماس گرفت.',
        ),
        A1BasicExample(
          english: 'We helped him.',
          persian: 'ما به او کمک کردیم.',
        ),
        A1BasicExample(
          english: 'I can see him.',
          persian: 'می‌توانم او را ببینم.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Her',
      titleFa: 'Her',
      explanation:
          'Her is the object form of she. Use her when a female person receives the action.',
      explanationFa:
          'her شکل مفعولی she است. وقتی یک فرد مؤنث دریافت‌کننده عمل باشد، از her استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'I know her.',
          persian: 'من او را می‌شناسم.',
        ),
        A1BasicExample(
          english: 'He called her.',
          persian: 'او با او تماس گرفت.',
        ),
        A1BasicExample(
          english: 'We helped her.',
          persian: 'ما به او کمک کردیم.',
        ),
        A1BasicExample(
          english: 'I can see her.',
          persian: 'می‌توانم او را ببینم.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'It',
      titleFa: 'It',
      explanation:
          'It can be used as an object for a thing, animal, or situation.',
      explanationFa:
          'it می‌تواند به‌عنوان ضمیر مفعولی برای یک چیز، حیوان یا موقعیت استفاده شود. مثلاً I like it یعنی «من آن را دوست دارم».',
      examples: [
        A1BasicExample(
          english: 'I like it.',
          persian: 'من آن را دوست دارم.',
        ),
        A1BasicExample(
          english: 'I can see it.',
          persian: 'می‌توانم آن را ببینم.',
        ),
        A1BasicExample(
          english: 'Please open it.',
          persian: 'لطفاً آن را باز کن.',
        ),
        A1BasicExample(
          english: 'I need it.',
          persian: 'من به آن نیاز دارم.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Us',
      titleFa: 'Us',
      explanation:
          'Us is the object form of we. Use us when we receive the action.',
      explanationFa:
          'us شکل مفعولی we است. وقتی عمل روی گوینده و افراد همراه او انجام می‌شود، از us استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'They helped us.',
          persian: 'آنها به ما کمک کردند.',
        ),
        A1BasicExample(
          english: 'Can you hear us?',
          persian: 'می‌توانی صدای ما را بشنوی؟',
        ),
        A1BasicExample(
          english: 'She called us.',
          persian: 'او با ما تماس گرفت.',
        ),
        A1BasicExample(
          english: 'Please wait for us.',
          persian: 'لطفاً منتظر ما بمان.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Them',
      titleFa: 'Them',
      explanation:
          'Them is the object form of they. Use them when two or more people or things receive the action.',
      explanationFa:
          'them شکل مفعولی they است. وقتی دو یا چند نفر یا چیز دریافت‌کننده عمل باشند، از them استفاده می‌کنیم.',
      examples: [
        A1BasicExample(
          english: 'I know them.',
          persian: 'من آنها را می‌شناسم.',
        ),
        A1BasicExample(
          english: 'She called them.',
          persian: 'او با آنها تماس گرفت.',
        ),
        A1BasicExample(
          english: 'We helped them.',
          persian: 'ما به آنها کمک کردیم.',
        ),
        A1BasicExample(
          english: 'I can see them.',
          persian: 'می‌توانم آنها را ببینم.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Object Pronouns After Verbs',
      titleFa: 'ضمیرهای مفعولی بعد از فعل',
      explanation:
          'Object pronouns commonly come directly after a verb.',
      explanationFa:
          'ضمیرهای مفعولی معمولاً مستقیماً بعد از فعل می‌آیند. مثلاً در I like her، کلمه her مفعول فعل like است.',
      examples: [
        A1BasicExample(
          english: 'I like her.',
          persian: 'من او را دوست دارم.',
        ),
        A1BasicExample(
          english: 'She knows me.',
          persian: 'او من را می‌شناسد.',
        ),
        A1BasicExample(
          english: 'They helped us.',
          persian: 'آنها به ما کمک کردند.',
        ),
        A1BasicExample(
          english: 'We called them.',
          persian: 'ما با آنها تماس گرفتیم.',
        ),
        A1BasicExample(
          english: 'He sees him.',
          persian: 'او او را می‌بیند.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Object Pronouns After Prepositions',
      titleFa: 'ضمیرهای مفعولی بعد از حروف اضافه',
      explanation:
          'Object pronouns are also used after prepositions such as for, with, to, and from.',
      explanationFa:
          'ضمیرهای مفعولی بعد از حروف اضافه‌ای مثل for، with، to و from نیز استفاده می‌شوند. بنابراین می‌گوییم for me، with us، to him و from her.',
      examples: [
        A1BasicExample(
          english: 'This is for me.',
          persian: 'این برای من است.',
        ),
        A1BasicExample(
          english: 'Come with us.',
          persian: 'با ما بیا.',
        ),
        A1BasicExample(
          english: 'Give it to him.',
          persian: 'آن را به او بده.',
        ),
        A1BasicExample(
          english: 'This message is from her.',
          persian: 'این پیام از طرف اوست.',
        ),
        A1BasicExample(
          english: 'I am talking to you.',
          persian: 'دارم با تو صحبت می‌کنم.',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Common Everyday Verbs',
      titleFa: 'افعال روزمره با ضمیر مفعولی',
      explanation:
          'Many common verbs are followed by object pronouns.',
      explanationFa:
          'بسیاری از فعل‌های پرکاربرد روزمره می‌توانند با ضمیرهای مفعولی بیایند؛ مثل help me، call me، see him، know her، like it، help us و call them.',
      examples: [
        A1BasicExample(
          english: 'help me',
          persian: 'به من کمک کردن',
        ),
        A1BasicExample(
          english: 'call me',
          persian: 'با من تماس گرفتن',
        ),
        A1BasicExample(
          english: 'see him',
          persian: 'او را دیدن',
        ),
        A1BasicExample(
          english: 'know her',
          persian: 'او را شناختن',
        ),
        A1BasicExample(
          english: 'like it',
          persian: 'آن را دوست داشتن',
        ),
        A1BasicExample(
          english: 'help us',
          persian: 'به ما کمک کردن',
        ),
        A1BasicExample(
          english: 'call them',
          persian: 'با آنها تماس گرفتن',
        ),
      ],
    ),
    A1BasicSection(
      title: 'Common Mistakes',
      titleFa: 'اشتباهات رایج',
      explanation:
          'Do not use subject pronouns where object pronouns are needed.',
      explanationFa:
          'یکی از اشتباه‌های رایج این است که به جای ضمیر مفعولی از ضمیر فاعلی استفاده کنیم. بعد از فعل یا حرف اضافه باید شکل مفعولی مناسب را انتخاب کنیم؛ مثلاً She called me درست است، نه She called I.',
      examples: [
        A1BasicExample(
          english: 'She called me. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'She called I. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'I know him. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'I know he. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'They helped us. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'They helped we. ✗',
          persian: 'غلط',
        ),
        A1BasicExample(
          english: 'I like her. ✓',
          persian: 'درست',
        ),
        A1BasicExample(
          english: 'I like she. ✗',
          persian: 'غلط',
        ),
      ],
    ),
  ],

  examples: [
    A1BasicExample(
      english: 'She called me.',
      persian: 'او با من تماس گرفت.',
    ),
    A1BasicExample(
      english: 'I know you.',
      persian: 'من تو را می‌شناسم.',
    ),
    A1BasicExample(
      english: 'I know him.',
      persian: 'من او را می‌شناسم.',
    ),
    A1BasicExample(
      english: 'I like her.',
      persian: 'من او را دوست دارم.',
    ),
    A1BasicExample(
      english: 'I need it.',
      persian: 'من به آن نیاز دارم.',
    ),
    A1BasicExample(
      english: 'They helped us.',
      persian: 'آنها به ما کمک کردند.',
    ),
    A1BasicExample(
      english: 'We know them.',
      persian: 'ما آنها را می‌شناسیم.',
    ),
    A1BasicExample(
      english: 'Can you help me?',
      persian: 'می‌توانی به من کمک کنی؟',
    ),
    A1BasicExample(
      english: 'Please call me later.',
      persian: 'لطفاً بعداً با من تماس بگیر.',
    ),
    A1BasicExample(
      english: 'Come with us.',
      persian: 'با ما بیا.',
    ),
    A1BasicExample(
      english: 'Give it to him.',
      persian: 'آن را به او بده.',
    ),
    A1BasicExample(
      english: 'I am talking to her.',
      persian: 'دارم با او صحبت می‌کنم.',
    ),
  ],

  questions: [
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'She called ___.',
      options: ['me', 'I', 'my', 'mine'],
      answer: 'me',
      explanation: 'Me is the object form of I.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'I know ___.',
      options: ['him', 'he', 'his', 'himself'],
      answer: 'him',
      explanation: 'Him is the object form of he.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'I like ___.',
      options: ['her', 'she', 'hers', 'herself'],
      answer: 'her',
      explanation: 'Her is the object form of she.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'They helped ___.',
      options: ['us', 'we', 'our', 'ours'],
      answer: 'us',
      explanation: 'Us is the object form of we.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'I know ___.',
      options: ['them', 'they', 'their', 'theirs'],
      answer: 'them',
      explanation: 'Them is the object form of they.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Can you help ___?',
      options: ['me', 'I', 'my', 'mine'],
      answer: 'me',
      explanation: 'Me comes after the verb help.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'She called ___.',
      options: ['him', 'he', 'his', 'himself'],
      answer: 'him',
      explanation: 'Him is used as the object.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'He called ___.',
      options: ['her', 'she', 'hers', 'herself'],
      answer: 'her',
      explanation: 'Her is the object form of she.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'I like ___.',
      options: ['it', 'its', 'itself', 'they'],
      answer: 'it',
      explanation: 'It can be used as an object.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Come with ___.',
      options: ['us', 'we', 'our', 'ours'],
      answer: 'us',
      explanation: 'Use us after the preposition with.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'I am talking to ___.',
      options: ['you', 'your', 'yours', 'yourselves'],
      answer: 'you',
      explanation: 'You can be both subject and object.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Give it to ___.',
      options: ['him', 'he', 'his', 'himself'],
      answer: 'him',
      explanation: 'Use him after to.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'This gift is for ___.',
      options: ['me', 'I', 'my', 'mine'],
      answer: 'me',
      explanation: 'Use me after for.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'She is talking to ___.',
      options: ['them', 'they', 'their', 'theirs'],
      answer: 'them',
      explanation: 'Them is used after to.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which is correct?',
      options: [
        'She helped me.',
        'She helped I.',
        'She helped my.',
        'She helped mine.',
      ],
      answer: 'She helped me.',
      explanation: 'Me is the object form of I.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which is correct?',
      options: [
        'I know him.',
        'I know he.',
        'I know his.',
        'I know himself.',
      ],
      answer: 'I know him.',
      explanation: 'Him is the object form of he.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which is correct?',
      options: [
        'I like her.',
        'I like she.',
        'I like hers.',
        'I like herself.',
      ],
      answer: 'I like her.',
      explanation: 'Her is the object form of she.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which is correct?',
      options: [
        'They helped us.',
        'They helped we.',
        'They helped our.',
        'They helped ours.',
      ],
      answer: 'They helped us.',
      explanation: 'Us is the object form of we.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which is correct?',
      options: [
        'I know them.',
        'I know they.',
        'I know their.',
        'I know theirs.',
      ],
      answer: 'I know them.',
      explanation: 'Them is the object form of they.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which word replaces "Sara" in: I know Sara.',
      options: ['her', 'she', 'hers', 'herself'],
      answer: 'her',
      explanation: 'Sara is the object of know, so use her.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which word replaces "Ali" in: I called Ali.',
      options: ['him', 'he', 'his', 'himself'],
      answer: 'him',
      explanation: 'Ali is the object, so use him.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which word replaces "my friends" in: I see my friends.',
      options: ['them', 'they', 'their', 'theirs'],
      answer: 'them',
      explanation: 'My friends is plural and receives the action.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question:
          'Which word replaces "my brother and me" in: She helped my brother and me.',
      options: ['us', 'we', 'our', 'ours'],
      answer: 'us',
      explanation: 'My brother and me becomes us.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Which word replaces "the phone" in: I need the phone.',
      options: ['it', 'its', 'they', 'them'],
      answer: 'it',
      explanation: 'A singular thing can be replaced by it.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'She called me is correct.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'Me is the correct object pronoun.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'She called I is correct.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'Use me, not I, after called.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'I know him is correct.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'Him is the object form of he.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'I know he is correct in this sentence.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'Use him as the object.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'They helped us is correct.',
      options: ['True', 'False'],
      answer: 'True',
      explanation: 'Us is the object form of we.',
    ),
    A1BasicQuestion(
      type: 'true_false',
      question: 'Come with we is correct.',
      options: ['True', 'False'],
      answer: 'False',
      explanation: 'Use us after the preposition with.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «او با من تماس گرفت.»',
      options: [
        'She called me.',
        'She called I.',
        'She called my.',
        'She called mine.',
      ],
      answer: 'She called me.',
      explanation: 'Me is the object form of I.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «من او را می‌شناسم.»',
      options: [
        'I know him.',
        'I know he.',
        'I know his.',
        'I know himself.',
      ],
      answer: 'I know him.',
      explanation: 'Him is used for a male person as an object.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «من او را دوست دارم.»',
      options: [
        'I like her.',
        'I like she.',
        'I like hers.',
        'I like herself.',
      ],
      answer: 'I like her.',
      explanation: 'Her is the object form of she.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «آنها به ما کمک کردند.»',
      options: [
        'They helped us.',
        'They helped we.',
        'They helped our.',
        'They helped ours.',
      ],
      answer: 'They helped us.',
      explanation: 'Us is the object form of we.',
    ),
    A1BasicQuestion(
      type: 'translation',
      question: 'ترجمه کن: «من آنها را می‌شناسم.»',
      options: [
        'I know them.',
        'I know they.',
        'I know their.',
        'I know theirs.',
      ],
      answer: 'I know them.',
      explanation: 'Them is the object form of they.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "helped / me / she"',
      options: [
        'She helped me.',
        'Me helped she.',
        'She me helped.',
        'Helped she me.',
      ],
      answer: 'She helped me.',
      explanation:
          'The subject comes before the verb and the object comes after it.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "know / him / I"',
      options: [
        'I know him.',
        'Him know I.',
        'I him know.',
        'Know I him.',
      ],
      answer: 'I know him.',
      explanation: 'Use subject + verb + object.',
    ),
    A1BasicQuestion(
      type: 'word_order',
      question: 'Put the words in order: "helped / us / they"',
      options: [
        'They helped us.',
        'Us helped they.',
        'They us helped.',
        'Helped they us.',
      ],
      answer: 'They helped us.',
      explanation: 'They is the subject and us is the object.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'Can you help me?',
        'Can you help I?',
        'Can you help my?',
        'Can you help mine?',
      ],
      answer: 'Can you help me?',
      explanation: 'Me is used after help.',
    ),
    A1BasicQuestion(
      type: 'multiple_choice',
      question: 'Choose the correct sentence.',
      options: [
        'Come with us.',
        'Come with we.',
        'Come with our.',
        'Come with ours.',
      ],
      answer: 'Come with us.',
      explanation: 'Use us after with.',
    ),
  ],

  speakingQuestions: [
    A1BasicSpeakingQuestion(
      question: 'Say: She called me.',
      persian: 'بگو: او با من تماس گرفت.',
      acceptableAnswers: [
        'she called me',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: I know him.',
      persian: 'بگو: من او را می‌شناسم.',
      acceptableAnswers: [
        'i know him',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: I like her.',
      persian: 'بگو: من او را دوست دارم.',
      acceptableAnswers: [
        'i like her',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: I need it.',
      persian: 'بگو: من به آن نیاز دارم.',
      acceptableAnswers: [
        'i need it',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: They helped us.',
      persian: 'بگو: آنها به ما کمک کردند.',
      acceptableAnswers: [
        'they helped us',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: I know them.',
      persian: 'بگو: من آنها را می‌شناسم.',
      acceptableAnswers: [
        'i know them',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Ask: Can you help me?',
      persian: 'بپرس: می‌توانی به من کمک کنی؟',
      acceptableAnswers: [
        'can you help me',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: Come with us.',
      persian: 'بگو: با ما بیا.',
      acceptableAnswers: [
        'come with us',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: Give it to him.',
      persian: 'بگو: آن را به او بده.',
      acceptableAnswers: [
        'give it to him',
      ],
    ),
    A1BasicSpeakingQuestion(
      question: 'Say: I am talking to her.',
      persian: 'بگو: دارم با او صحبت می‌کنم.',
      acceptableAnswers: [
        'i am talking to her',
        'im talking to her',
      ],
    ),
  ],
);