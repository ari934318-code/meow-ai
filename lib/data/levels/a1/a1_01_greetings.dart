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

const A1Lesson a1Lesson01 = A1Lesson(
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
      english: 'Good afternoon',
      persian: 'بعدازظهر بخیر',
      pronunciation: 'گود اَفتِرنون',
      example: 'Good afternoon, Tom.',
    ),
    A1Word(
      english: 'Good evening',
      persian: 'عصر بخیر',
      pronunciation: 'گود ایونینگ',
      example: 'Good evening, Mr. Brown.',
    ),
    A1Word(
      english: 'Good night',
      persian: 'شب بخیر',
      pronunciation: 'گود نایت',
      example: 'Good night! See you tomorrow.',
    ),
    A1Word(
      english: 'Goodbye',
      persian: 'خداحافظ',
      pronunciation: 'گودبای',
      example: 'Goodbye! See you tomorrow.',
    ),
    A1Word(
      english: 'Bye',
      persian: 'خداحافظ / بای',
      pronunciation: 'بای',
      example: 'Bye! See you later.',
    ),
    A1Word(
      english: 'Thanks',
      persian: 'ممنون',
      pronunciation: 'ثَنکس',
      example: 'Thanks for your help.',
    ),
    A1Word(
      english: 'Thank you',
      persian: 'متشکرم / ممنون',
      pronunciation: 'ثَنک یو',
      example: 'Thank you very much.',
    ),
    A1Word(
      english: 'Please',
      persian: 'لطفاً',
      pronunciation: 'پلیز',
      example: 'Please sit down.',
    ),
    A1Word(
      english: 'Sorry',
      persian: 'ببخشید / متأسفم',
      pronunciation: 'ساری',
      example: 'Sorry, I am late.',
    ),
    A1Word(
      english: 'Excuse me',
      persian: 'ببخشید',
      pronunciation: 'اِکسکیوز می',
      example: 'Excuse me, where is the bathroom?',
    ),
    A1Word(
      english: 'Welcome',
      persian: 'خوش آمدید',
      pronunciation: 'وِلکِم',
      example: 'Welcome to our home.',
    ),
    A1Word(
      english: 'Nice',
      persian: 'خوب / خوشایند',
      pronunciation: 'نایس',
      example: 'Nice to meet you.',
    ),
    A1Word(
      english: 'Meet',
      persian: 'ملاقات کردن / آشنا شدن',
      pronunciation: 'میت',
      example: 'Nice to meet you.',
    ),
    A1Word(
      english: 'Later',
      persian: 'بعداً',
      pronunciation: 'لِیتِر',
      example: 'See you later.',
    ),
    A1Word(
      english: 'Tomorrow',
      persian: 'فردا',
      pronunciation: 'تِمارو',
      example: 'See you tomorrow.',
    ),
  ],
  sentences: [
    A1Sentence(
      english: 'Hello! How are you?',
      persian: 'سلام! حالت چطوره؟',
    ),
    A1Sentence(
      english: 'Hi! How are you?',
      persian: 'سلام! حالت چطوره؟',
    ),
    A1Sentence(
      english: 'I am fine, thank you.',
      persian: 'من خوبم، ممنون.',
    ),
    A1Sentence(
      english: 'I am good, thanks.',
      persian: 'خوبم، ممنون.',
    ),
    A1Sentence(
      english: 'I am great!',
      persian: 'عالی‌ام!',
    ),
    A1Sentence(
      english: 'Nice to meet you.',
      persian: 'از آشنایی با تو خوشحالم.',
    ),
    A1Sentence(
      english: 'Nice to meet you too.',
      persian: 'من هم از آشنایی با تو خوشحالم.',
    ),
    A1Sentence(
      english: 'Good morning!',
      persian: 'صبح بخیر!',
    ),
    A1Sentence(
      english: 'Good afternoon!',
      persian: 'بعدازظهر بخیر!',
    ),
    A1Sentence(
      english: 'Good evening!',
      persian: 'عصر بخیر!',
    ),
    A1Sentence(
      english: 'Good night!',
      persian: 'شب بخیر!',
    ),
    A1Sentence(
      english: 'Goodbye!',
      persian: 'خداحافظ!',
    ),
    A1Sentence(
      english: 'Bye! See you later.',
      persian: 'بای! بعداً می‌بینمت.',
    ),
    A1Sentence(
      english: 'See you tomorrow.',
      persian: 'فردا می‌بینمت.',
    ),
    A1Sentence(
      english: 'Thank you very much.',
      persian: 'خیلی ممنون.',
    ),
    A1Sentence(
      english: 'Thanks for your help.',
      persian: 'ممنون بابت کمکت.',
    ),
    A1Sentence(
      english: 'Please sit down.',
      persian: 'لطفاً بنشین.',
    ),
    A1Sentence(
      english: 'Sorry, I am late.',
      persian: 'ببخشید، دیر کردم.',
    ),
    A1Sentence(
      english: 'Excuse me.',
      persian: 'ببخشید.',
    ),
    A1Sentence(
      english: 'Welcome!',
      persian: 'خوش آمدی!',
    ),
    A1Sentence(
      english: 'How about you?',
      persian: 'تو چطور؟',
    ),
    A1Sentence(
      english: 'I am okay.',
      persian: 'من خوبم.',
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
        'Sorry',
      ],
      answer: 'Thanks',
    ),
    A1Question(
      question: 'What do you say in the morning?',
      options: [
        'Good night',
        'Good morning',
        'Goodbye',
        'Sorry',
      ],
      answer: 'Good morning',
    ),
    A1Question(
      question: 'What do you say before going to sleep?',
      options: [
        'Good morning',
        'Good afternoon',
        'Good night',
        'Welcome',
      ],
      answer: 'Good night',
    ),
    A1Question(
      question: 'What does "Please" mean?',
      options: [
        'ممنون',
        'ببخشید',
        'لطفاً',
        'خداحافظ',
      ],
      answer: 'لطفاً',
    ),
    A1Question(
      question: 'What does "Sorry" mean?',
      options: [
        'ببخشید / متأسفم',
        'صبح بخیر',
        'خوش آمدید',
        'ممنون',
      ],
      answer: 'ببخشید / متأسفم',
    ),
    A1Question(
      question: 'What does "Excuse me" mean?',
      options: [
        'خداحافظ',
        'ببخشید',
        'ممنون',
        'صبح بخیر',
      ],
      answer: 'ببخشید',
    ),
    A1Question(
      question: 'Complete: Nice to ___ you.',
      options: [
        'meet',
        'thanks',
        'please',
        'good',
      ],
      answer: 'meet',
    ),
    A1Question(
      question: 'Complete: See you ___.',
      options: [
        'sorry',
        'tomorrow',
        'please',
        'morning',
      ],
      answer: 'tomorrow',
    ),
    A1Question(
      question: 'Someone says "Nice to meet you." What do you say?',
      options: [
        'Good night.',
        'Nice to meet you too.',
        'I am sorry.',
        'Please sit down.',
      ],
      answer: 'Nice to meet you too.',
    ),
    A1Question(
      question: 'Someone says "Thank you." What can you say?',
      options: [
        'You are welcome.',
        'Good night.',
        'See you tomorrow.',
        'I am late.',
      ],
      answer: 'You are welcome.',
    ),
    A1Question(
      question: 'Which greeting is usually used in the evening?',
      options: [
        'Good morning',
        'Good evening',
        'Good night',
        'Goodbye',
      ],
      answer: 'Good evening',
    ),
    A1Question(
      question: 'Which sentence means "فردا می‌بینمت."?',
      options: [
        'See you later.',
        'See you tomorrow.',
        'Good evening.',
        'Thank you very much.',
      ],
      answer: 'See you tomorrow.',
    ),
    A1Question(
      question: 'Which sentence means "خیلی ممنون."?',
      options: [
        'Thank you very much.',
        'Good morning.',
        'Nice to meet you.',
        'Excuse me.',
      ],
      answer: 'Thank you very much.',
    ),
    A1Question(
      question: 'Which sentence is correct?',
      options: [
        'Nice meet you.',
        'Nice to meet you.',
        'Nice meeting you to.',
        'To nice meet you.',
      ],
      answer: 'Nice to meet you.',
    ),
    A1Question(
      question: 'Which sentence is correct?',
      options: [
        'I am fine, thank you.',
        'I fine am thank you.',
        'I am thank fine you.',
        'Fine I thank am you.',
      ],
      answer: 'I am fine, thank you.',
    ),
    A1Question(
      question: 'What can you say when you leave?',
      options: [
        'Goodbye!',
        'Welcome!',
        'Good morning!',
        'Thank you!',
      ],
      answer: 'Goodbye!',
    ),
    A1Question(
      question: 'What does "Welcome" mean?',
      options: [
        'خوش آمدید',
        'خداحافظ',
        'ببخشید',
        'صبح بخیر',
      ],
      answer: 'خوش آمدید',
    ),
    A1Question(
      question: 'Complete: Good ___, Sarah!',
      options: [
        'morning',
        'sorry',
        'please',
        'meet',
      ],
      answer: 'morning',
    ),
    A1Question(
      question: 'Complete: Good ___, Mr. Brown.',
      options: [
        'evening',
        'thanks',
        'please',
        'sorry',
      ],
      answer: 'evening',
    ),
  ],
);