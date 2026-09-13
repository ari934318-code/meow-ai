import 'a1_models.dart';

const A1Lesson a1Lesson01 = A1Lesson(
  id: 'a1_01',
  title: 'Greetings',
  topic: 'سلام و احوالپرسی',
  words: [
    A1Word(
      english: 'hello',
      persian: 'سلام',
      pronunciation: 'هِلُو',
      example: 'Hello! How are you?',
    ),
    A1Word(
      english: 'hi',
      persian: 'سلام',
      pronunciation: 'های',
      example: 'Hi! Nice to meet you.',
    ),
    A1Word(
      english: 'goodbye',
      persian: 'خداحافظ',
      pronunciation: 'گودبای',
      example: 'Goodbye! See you tomorrow.',
    ),
    A1Word(
      english: 'bye',
      persian: 'خداحافظ / بای',
      pronunciation: 'بای',
      example: 'Bye! Have a nice day.',
    ),
    A1Word(
      english: 'please',
      persian: 'لطفاً',
      pronunciation: 'پلیز',
      example: 'Please sit down.',
    ),
    A1Word(
      english: 'thank you',
      persian: 'ممنون',
      pronunciation: 'ثَنک یو',
      example: 'Thank you for your help.',
    ),
    A1Word(
      english: 'thanks',
      persian: 'ممنون / مرسی',
      pronunciation: 'ثَنکس',
      example: 'Thanks for the gift.',
    ),
    A1Word(
      english: 'sorry',
      persian: 'متأسفم / ببخشید',
      pronunciation: 'ساری',
      example: 'Sorry, I am late.',
    ),
    A1Word(
      english: 'welcome',
      persian: 'خوش آمدید',
      pronunciation: 'وِلکِم',
      example: 'Welcome to our home.',
    ),
    A1Word(
      english: 'morning',
      persian: 'صبح',
      pronunciation: 'مورنینگ',
      example: 'Good morning!',
    ),
    A1Word(
      english: 'afternoon',
      persian: 'بعدازظهر',
      pronunciation: 'اَفتِرنون',
      example: 'Good afternoon!',
    ),
    A1Word(
      english: 'evening',
      persian: 'عصر / شب',
      pronunciation: 'ایونینگ',
      example: 'Good evening!',
    ),
    A1Word(
      english: 'night',
      persian: 'شب',
      pronunciation: 'نایت',
      example: 'Good night!',
    ),
    A1Word(
      english: 'nice',
      persian: 'خوب / دلپذیر',
      pronunciation: 'نایس',
      example: 'Nice to meet you.',
    ),
    A1Word(
      english: 'meet',
      persian: 'ملاقات کردن / دیدن',
      pronunciation: 'میت',
      example: 'Nice to meet you.',
    ),
    A1Word(
      english: 'name',
      persian: 'اسم / نام',
      pronunciation: 'نِیم',
      example: 'What is your name?',
    ),
    A1Word(
      english: 'you',
      persian: 'تو / شما',
      pronunciation: 'یو',
      example: 'How are you?',
    ),
    A1Word(
      english: 'fine',
      persian: 'خوب',
      pronunciation: 'فاین',
      example: 'I am fine, thank you.',
    ),
  ],
  sentences: [
    A1Sentence(
      english: 'Hello!',
      persian: 'سلام!',
    ),
    A1Sentence(
      english: 'Hi!',
      persian: 'سلام!',
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
      english: 'Bye!',
      persian: 'بای!',
    ),
    A1Sentence(
      english: 'How are you?',
      persian: 'حالت چطوره؟',
    ),
    A1Sentence(
      english: 'I am fine, thank you.',
      persian: 'من خوبم، ممنون.',
    ),
    A1Sentence(
      english: 'I am good.',
      persian: 'من خوبم.',
    ),
    A1Sentence(
      english: 'I am great.',
      persian: 'من عالی‌ام.',
    ),
    A1Sentence(
      english: 'Nice to meet you.',
      persian: 'از آشنایی با شما خوشحالم.',
    ),
    A1Sentence(
      english: 'Nice to meet you too.',
      persian: 'من هم از آشنایی با شما خوشحالم.',
    ),
    A1Sentence(
      english: 'What is your name?',
      persian: 'اسمت چیه؟',
    ),
    A1Sentence(
      english: 'My name is Sara.',
      persian: 'اسم من سارا است.',
    ),
    A1Sentence(
      english: 'Please come in.',
      persian: 'لطفاً بیا داخل.',
    ),
    A1Sentence(
      english: 'Thank you.',
      persian: 'ممنون.',
    ),
    A1Sentence(
      english: 'You are welcome.',
      persian: 'خواهش می‌کنم.',
    ),
    A1Sentence(
      english: 'Sorry.',
      persian: 'ببخشید.',
    ),
    A1Sentence(
      english: 'See you later.',
      persian: 'بعداً می‌بینمت.',
    ),
    A1Sentence(
      english: 'See you tomorrow.',
      persian: 'فردا می‌بینمت.',
    ),
  ],
  questions: [
    A1Question(
      question: 'What do you say when you meet someone?',
      options: ['Hello', 'Goodbye', 'Good night', 'Sorry'],
      answer: 'Hello',
    ),
    A1Question(
      question: 'What does "Hi" mean?',
      options: ['سلام', 'خداحافظ', 'ممنون', 'ببخشید'],
      answer: 'سلام',
    ),
    A1Question(
      question: 'What does "Goodbye" mean?',
      options: ['سلام', 'خداحافظ', 'صبح بخیر', 'ممنون'],
      answer: 'خداحافظ',
    ),
    A1Question(
      question: 'What do you say in the morning?',
      options: ['Good morning', 'Good night', 'Goodbye', 'Sorry'],
      answer: 'Good morning',
    ),
    A1Question(
      question: 'What do you say before going to sleep?',
      options: ['Good morning', 'Good night', 'Hello', 'Thank you'],
      answer: 'Good night',
    ),
    A1Question(
      question: 'How do you ask about someone’s condition?',
      options: [
        'How are you?',
        'What is your name?',
        'Goodbye!',
        'Thank you.'
      ],
      answer: 'How are you?',
    ),
    A1Question(
      question: 'What is a common answer to "How are you?"',
      options: [
        'I am fine.',
        'Goodbye.',
        'My name is Ali.',
        'Good night.'
      ],
      answer: 'I am fine.',
    ),
    A1Question(
      question: 'What does "Thank you" mean?',
      options: ['ممنون', 'سلام', 'خداحافظ', 'لطفاً'],
      answer: 'ممنون',
    ),
    A1Question(
      question: 'What does "Please" mean?',
      options: ['لطفاً', 'ممنون', 'ببخشید', 'خوش آمدید'],
      answer: 'لطفاً',
    ),
    A1Question(
      question: 'What does "Sorry" mean?',
      options: ['ببخشید', 'ممنون', 'سلام', 'خداحافظ'],
      answer: 'ببخشید',
    ),
    A1Question(
      question: 'Complete: Nice to ___ you.',
      options: ['meet', 'name', 'please', 'night'],
      answer: 'meet',
    ),
    A1Question(
      question: 'Complete: My ___ is Ali.',
      options: ['name', 'morning', 'sorry', 'welcome'],
      answer: 'name',
    ),
    A1Question(
      question: 'What does "You are welcome" mean?',
      options: ['خواهش می‌کنم', 'خداحافظ', 'سلام', 'صبح بخیر'],
      answer: 'خواهش می‌کنم',
    ),
    A1Question(
      question: 'Which one is a goodbye expression?',
      options: ['See you later', 'How are you?', 'Hello', 'Nice to meet you'],
      answer: 'See you later',
    ),
    A1Question(
      question: 'Which greeting is used in the evening?',
      options: ['Good evening', 'Good morning', 'Good night', 'Goodbye'],
      answer: 'Good evening',
    ),
    A1Question(
      question: 'What does "Thanks" mean?',
      options: ['ممنون', 'سلام', 'ببخشید', 'لطفاً'],
      answer: 'ممنون',
    ),
    A1Question(
      question: 'Choose the correct sentence:',
      options: [
        'How are you?',
        'How you are?',
        'Are how you?',
        'You how are?'
      ],
      answer: 'How are you?',
    ),
    A1Question(
      question: 'Choose the correct sentence:',
      options: [
        'My name is Anna.',
        'My is name Anna.',
        'Name my is Anna.',
        'Anna my name.'
      ],
      answer: 'My name is Anna.',
    ),
    A1Question(
      question: 'Complete: See you ___.',
      options: ['tomorrow', 'name', 'please', 'fine'],
      answer: 'tomorrow',
    ),
    A1Question(
      question: 'Which phrase means "از آشنایی با شما خوشحالم"?',
      options: [
        'Nice to meet you.',
        'Goodbye.',
        'How are you?',
        'Thank you.'
      ],
      answer: 'Nice to meet you.',
    ),
  ],
);