class A1Lesson {
  final String id;
  final String title;
  final String topic;
  final List<A1Word> words;
  final List<A1Sentence> sentences;
  final List<A1Question> questions;

  const A1Lesson({
    required this.id,
    required this.title,
    required this.topic,
    required this.words,
    required this.sentences,
    required this.questions,
  });
}

class A1Word {
  final String english;
  final String persian;
  final String pronunciation;
  final String example;

  const A1Word({
    required this.english,
    required this.persian,
    required this.pronunciation,
    required this.example,
  });
}

class A1Sentence {
  final String english;
  final String persian;

  const A1Sentence({
    required this.english,
    required this.persian,
  });
}

class A1Question {
  final String question;
  final List<String> options;
  final String answer;

  const A1Question({
    required this.question,
    required this.options,
    required this.answer,
  });
}

const List<A1Lesson> a1Lessons = [
  A1Lesson(
    id: 'a1_01',
    title: 'Greetings',
    topic: 'سلام و احوالپرسی',
    words: [
      A1Word(
        english: 'Hello',
        persian: 'سلام',
        pronunciation: 'هِلُو',
        example: 'Hello! How are you?',
      ),
      A1Word(
        english: 'Hi',
        persian: 'سلام',
        pronunciation: 'های',
        example: 'Hi! Nice to meet you.',
      ),
      A1Word(
        english: 'Good morning',
        persian: 'صبح بخیر',
        pronunciation: 'گود مورنینگ',
        example: 'Good morning, Sarah!',
      ),
      A1Word(
        english: 'Goodbye',
        persian: 'خداحافظ',
        pronunciation: 'گودبای',
        example: 'Goodbye! See you tomorrow.',
      ),
      A1Word(
        english: 'Thanks',
        persian: 'ممنون',
        pronunciation: 'ثَنکس',
        example: 'Thanks for your help.',
      ),
      A1Word(
        english: 'Please',
        persian: 'لطفاً',
        pronunciation: 'پلیز',
        example: 'Please sit down.',
      ),
    ],
    sentences: [
      A1Sentence(
        english: 'Hello! How are you?',
        persian: 'سلام! حالت چطوره؟',
      ),
      A1Sentence(
        english: 'I am fine, thank you.',
        persian: 'من خوبم، ممنون.',
      ),
      A1Sentence(
        english: 'Nice to meet you.',
        persian: 'از آشنایی با تو خوشحالم.',
      ),
      A1Sentence(
        english: 'See you tomorrow.',
        persian: 'فردا می‌بینمت.',
      ),
    ],
    questions: [
      A1Question(
        question: 'What does "Hello" mean?',
        options: [
          'خداحافظ',
          'سلام',
          'ممنون',
          'لطفاً',
        ],
        answer: 'سلام',
      ),
      A1Question(
        question: 'Which one means "ممنون"?',
        options: [
          'Please',
          'Goodbye',
          'Thanks',
          'Hello',
        ],
        answer: 'Thanks',
      ),
    ],
  ),

  A1Lesson(
    id: 'a1_02',
    title: 'Introducing Yourself',
    topic: 'معرفی خودت',
    words: [
      A1Word(
        english: 'Name',
        persian: 'اسم',
        pronunciation: 'نِیم',
        example: 'My name is Ali.',
      ),
      A1Word(
        english: 'I',
        persian: 'من',
        pronunciation: 'آی',
        example: 'I am a student.',
      ),
      A1Word(
        english: 'You',
        persian: 'تو / شما',
        pronunciation: 'یو',
        example: 'You are very kind.',
      ),
      A1Word(
        english: 'Student',
        persian: 'دانش‌آموز / دانشجو',
        pronunciation: 'اِستیودِنت',
        example: 'I am a student.',
      ),
      A1Word(
        english: 'From',
        persian: 'از',
        pronunciation: 'فرام',
        example: 'I am from Iran.',
      ),
      A1Word(
        english: 'Live',
        persian: 'زندگی کردن',
        pronunciation: 'لیو',
        example: 'I live in Tokyo.',
      ),
    ],
    sentences: [
      A1Sentence(
        english: 'My name is Sara.',
        persian: 'اسم من سارا است.',
      ),
      A1Sentence(
        english: 'I am a student.',
        persian: 'من دانش‌آموز / دانشجو هستم.',
      ),
      A1Sentence(
        english: 'I am from Iran.',
        persian: 'من اهل ایران هستم.',
      ),
      A1Sentence(
        english: 'Where are you from?',
        persian: 'اهل کجایی؟',
      ),
      A1Sentence(
        english: 'What is your name?',
        persian: 'اسمت چیه؟',
      ),
    ],
    questions: [
      A1Question(
        question: 'What does "Name" mean?',
        options: [
          'سن',
          'اسم',
          'کشور',
          'خانه',
        ],
        answer: 'اسم',
      ),
      A1Question(
        question: 'Complete: My ___ is Sara.',
        options: [
          'student',
          'from',
          'name',
          'live',
        ],
        answer: 'name',
      ),
    ],
  ),

  A1Lesson(
    id: 'a1_03',
    title: 'Numbers',
    topic: 'اعداد',
    words: [
      A1Word(
        english: 'One',
        persian: 'یک',
        pronunciation: 'وان',
        example: 'I have one cat.',
      ),
      A1Word(
        english: 'Two',
        persian: 'دو',
        pronunciation: 'تو',
        example: 'I have two birds.',
      ),
      A1Word(
        english: 'Three',
        persian: 'سه',
        pronunciation: 'ثری',
        example: 'Three books are on the table.',
      ),
      A1Word(
        english: 'Four',
        persian: 'چهار',
        pronunciation: 'فور',
        example: 'I have four pencils.',
      ),
      A1Word(
        english: 'Five',
        persian: 'پنج',
        pronunciation: 'فایو',
        example: 'Five people are here.',
      ),
      A1Word(
        english: 'Ten',
        persian: 'ده',
        pronunciation: 'تِن',
        example: 'I have ten fingers.',
      ),
    ],
    sentences: [
      A1Sentence(
        english: 'I have two cats.',
        persian: 'من دو گربه دارم.',
      ),
      A1Sentence(
        english: 'I have five books.',
        persian: 'من پنج کتاب دارم.',
      ),
      A1Sentence(
        english: 'There are three people.',
        persian: 'سه نفر وجود دارند.',
      ),
    ],
    questions: [
      A1Question(
        question: 'What does "Two" mean?',
        options: [
          'یک',
          'دو',
          'سه',
          'چهار',
        ],
        answer: 'دو',
      ),
      A1Question(
        question: 'Which number is "Five"?',
        options: [
          '3',
          '4',
          '5',
          '10',
        ],
        answer: '5',
      ),
    ],
  ),

  A1Lesson(
    id: 'a1_04',
    title: 'Family',
    topic: 'خانواده',
    words: [
      A1Word(
        english: 'Mother',
        persian: 'مادر',
        pronunciation: 'مادِر',
        example: 'My mother is kind.',
      ),
      A1Word(
        english: 'Father',
        persian: 'پدر',
        pronunciation: 'فادِر',
        example: 'My father is at home.',
      ),
      A1Word(
        english: 'Brother',
        persian: 'برادر',
        pronunciation: 'برادِر',
        example: 'My brother is tall.',
      ),
      A1Word(
        english: 'Sister',
        persian: 'خواهر',
        pronunciation: 'سیستِر',
        example: 'My sister is funny.',
      ),
      A1Word(
        english: 'Family',
        persian: 'خانواده',
        pronunciation: 'فَمِلی',
        example: 'I love my family.',
      ),
    ],
    sentences: [
      A1Sentence(
        english: 'This is my mother.',
        persian: 'این مادر من است.',
      ),
      A1Sentence(
        english: 'This is my father.',
        persian: 'این پدر من است.',
      ),
      A1Sentence(
        english: 'I have one brother.',
        persian: 'من یک برادر دارم.',
      ),
      A1Sentence(
        english: 'I love my family.',
        persian: 'من خانواده‌ام را دوست دارم.',
      ),
    ],
    questions: [
      A1Question(
        question: 'What does "Mother" mean?',
        options: [
          'خواهر',
          'مادر',
          'برادر',
          'پدر',
        ],
        answer: 'مادر',
      ),
      A1Question(
        question: 'Which word means "خانواده"?',
        options: [
          'Family',
          'Father',
          'Sister',
          'Brother',
        ],
        answer: 'Family',
      ),
    ],
  ),

  A1Lesson(
    id: 'a1_05',
    title: 'Everyday Objects',
    topic: 'وسایل روزمره',
    words: [
      A1Word(
        english: 'Book',
        persian: 'کتاب',
        pronunciation: 'بوک',
        example: 'This is my book.',
      ),
      A1Word(
        english: 'Pen',
        persian: 'خودکار',
        pronunciation: 'پِن',
        example: 'I have a blue pen.',
      ),
      A1Word(
        english: 'Phone',
        persian: 'گوشی',
        pronunciation: 'فون',
        example: 'My phone is here.',
      ),
      A1Word(
        english: 'Table',
        persian: 'میز',
        pronunciation: 'تِیبِل',
        example: 'The book is on the table.',
      ),
      A1Word(
        english: 'Chair',
        persian: 'صندلی',
        pronunciation: 'چِر',
        example: 'Sit on the chair.',
      ),
    ],
    sentences: [
      A1Sentence(
        english: 'This is my phone.',
        persian: 'این گوشی من است.',
      ),
      A1Sentence(
        english: 'The book is on the table.',
        persian: 'کتاب روی میز است.',
      ),
      A1Sentence(
        english: 'I have a pen.',
        persian: 'من یک خودکار دارم.',
      ),
    ],
    questions: [
      A1Question(
        question: 'What does "Book" mean?',
        options: [
          'میز',
          'گوشی',
          'کتاب',
          'صندلی',
        ],
        answer: 'کتاب',
      ),
      A1Question(
        question: 'Where do you sit?',
        options: [
          'On a chair',
          'On a phone',
          'In a pen',
          'In a book',
        ],
        answer: 'On a chair',
      ),
    ],
  ),
];