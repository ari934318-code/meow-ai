import 'a1_exam_model.dart';

const List<A1ExamQuestion> a1ExamQuestions = [
  // Lesson 01 - Greetings
  A1ExamQuestion(
    id: 'a1_exam_001',
    lessonId: 'a1_01',
    category: 'Vocabulary',
    question: 'What do you say when you meet someone?',
    options: [
      'Hello',
      'Goodbye',
      'Good night',
      'Sorry',
    ],
    correctAnswer: 'Hello',
  ),

  A1ExamQuestion(
    id: 'a1_exam_002',
    lessonId: 'a1_01',
    category: 'Conversation',
    question: 'How are you?',
    options: [
      'I am fine, thank you.',
      'My name is Ali.',
      'I am twenty.',
      'Good night.',
    ],
    correctAnswer: 'I am fine, thank you.',
  ),

  // Lesson 02 - Introducing Yourself
  A1ExamQuestion(
    id: 'a1_exam_003',
    lessonId: 'a1_02',
    category: 'Grammar',
    question: 'Which sentence is correct?',
    options: [
      'My name Sara.',
      'My name is Sara.',
      'My is name Sara.',
      'Name my is Sara.',
    ],
    correctAnswer: 'My name is Sara.',
  ),

  A1ExamQuestion(
    id: 'a1_exam_004',
    lessonId: 'a1_02',
    category: 'Vocabulary',
    question: 'What does "age" mean?',
    options: [
      'سن',
      'نام',
      'شهر',
      'غذا',
    ],
    correctAnswer: 'سن',
  ),

  // Lesson 03 - Numbers
  A1ExamQuestion(
    id: 'a1_exam_005',
    lessonId: 'a1_03',
    category: 'Vocabulary',
    question: 'What number is "ten"?',
    options: [
      '5',
      '8',
      '10',
      '20',
    ],
    correctAnswer: '10',
  ),

  A1ExamQuestion(
    id: 'a1_exam_006',
    lessonId: 'a1_03',
    category: 'Vocabulary',
    question: 'What number is "twenty"?',
    options: [
      '12',
      '15',
      '20',
      '30',
    ],
    correctAnswer: '20',
  ),

  // Lesson 04 - Family
  A1ExamQuestion(
    id: 'a1_exam_007',
    lessonId: 'a1_04',
    category: 'Vocabulary',
    question: 'What does "mother" mean?',
    options: [
      'مادر',
      'خواهر',
      'دختر',
      'مادربزرگ',
    ],
    correctAnswer: 'مادر',
  ),

  A1ExamQuestion(
    id: 'a1_exam_008',
    lessonId: 'a1_04',
    category: 'Vocabulary',
    question: 'What does "brother" mean?',
    options: [
      'پدر',
      'برادر',
      'پسر',
      'شوهر',
    ],
    correctAnswer: 'برادر',
  ),

  // Lesson 05 - Everyday Objects
  A1ExamQuestion(
    id: 'a1_exam_009',
    lessonId: 'a1_05',
    category: 'Vocabulary',
    question: 'What do you use to write?',
    options: [
      'Pen',
      'Chair',
      'Door',
      'Bed',
    ],
    correctAnswer: 'Pen',
  ),

  A1ExamQuestion(
    id: 'a1_exam_010',
    lessonId: 'a1_05',
    category: 'Vocabulary',
    question: 'What is a "chair"?',
    options: [
      'صندلی',
      'میز',
      'تخت',
      'پنجره',
    ],
    correctAnswer: 'صندلی',
  ),

  // Lesson 06 - Daily Routine
  A1ExamQuestion(
    id: 'a1_exam_011',
    lessonId: 'a1_06',
    category: 'Grammar',
    question: 'Which sentence is correct?',
    options: [
      'I wake up every day.',
      'I every day wake up.',
      'Wake I up every day.',
      'Every I day wake up.',
    ],
    correctAnswer: 'I wake up every day.',
  ),

  A1ExamQuestion(
    id: 'a1_exam_012',
    lessonId: 'a1_06',
    category: 'Vocabulary',
    question: 'What does "sleep" mean?',
    options: [
      'خوابیدن',
      'بیدار شدن',
      'غذا خوردن',
      'رفتن',
    ],
    correctAnswer: 'خوابیدن',
  ),

  // Lesson 07 - Food and Drinks
  A1ExamQuestion(
    id: 'a1_exam_013',
    lessonId: 'a1_07',
    category: 'Vocabulary',
    question: 'Which one is a drink?',
    options: [
      'Apple',
      'Rice',
      'Milk',
      'Bread',
    ],
    correctAnswer: 'Milk',
  ),

  A1ExamQuestion(
    id: 'a1_exam_014',
    lessonId: 'a1_07',
    category: 'Conversation',
    question: 'What do you say when you want water?',
    options: [
      'I want some water.',
      'I am a water.',
      'Water I am.',
      'I water want some.',
    ],
    correctAnswer: 'I want some water.',
  ),

  // Lesson 08 - Shopping
  A1ExamQuestion(
    id: 'a1_exam_015',
    lessonId: 'a1_08',
    category: 'Vocabulary',
    question: 'What does "cheap" mean?',
    options: [
      'گران',
      'ارزان',
      'بزرگ',
      'کوچک',
    ],
    correctAnswer: 'ارزان',
  ),

  A1ExamQuestion(
    id: 'a1_exam_016',
    lessonId: 'a1_08',
    category: 'Conversation',
    question: 'What do you ask about the price?',
    options: [
      'How much is it?',
      'How old is it?',
      'Where is it?',
      'Who is it?',
    ],
    correctAnswer: 'How much is it?',
  ),

  // Lesson 09 - Time and Dates
  A1ExamQuestion(
    id: 'a1_exam_017',
    lessonId: 'a1_09',
    category: 'Vocabulary',
    question: 'Which one is a day of the week?',
    options: [
      'January',
      'Monday',
      'Morning',
      'Summer',
    ],
    correctAnswer: 'Monday',
  ),

  A1ExamQuestion(
    id: 'a1_exam_018',
    lessonId: 'a1_09',
    category: 'Conversation',
    question: 'What do you ask when you want to know the time?',
    options: [
      'What time is it?',
      'What day is it?',
      'What is your name?',
      'Where are you?',
    ],
    correctAnswer: 'What time is it?',
  ),

  // Lesson 10 - Places Around You
  A1ExamQuestion(
    id: 'a1_exam_019',
    lessonId: 'a1_10',
    category: 'Vocabulary',
    question: 'Where can you borrow books?',
    options: [
      'Library',
      'Restaurant',
      'Hospital',
      'Market',
    ],
    correctAnswer: 'Library',
  ),

  A1ExamQuestion(
    id: 'a1_exam_020',
    lessonId: 'a1_10',
    category: 'Vocabulary',
    question: 'What does "near" mean?',
    options: [
      'دور',
      'نزدیک',
      'پشت',
      'داخل',
    ],
    correctAnswer: 'نزدیک',
  ),

  // Lesson 11 - Likes and Dislikes
  A1ExamQuestion(
    id: 'a1_exam_021',
    lessonId: 'a1_11',
    category: 'Grammar',
    question: 'Which sentence is correct?',
    options: [
      'I like pizza.',
      'I pizza like.',
      'Like I pizza.',
      'I likes pizza.',
    ],
    correctAnswer: 'I like pizza.',
  ),

  A1ExamQuestion(
    id: 'a1_exam_022',
    lessonId: 'a1_11',
    category: 'Conversation',
    question: 'Do you like cats?',
    options: [
      'Yes, I do.',
      'Yes, I am.',
      'Yes, I like.',
      'Yes, I does.',
    ],
    correctAnswer: 'Yes, I do.',
  ),

  // Lesson 12 - Everyday Conversations
  A1ExamQuestion(
    id: 'a1_exam_023',
    lessonId: 'a1_12',
    category: 'Conversation',
    question: 'What do you say when you do not understand?',
    options: [
      'Please repeat.',
      'Goodbye.',
      'I am hungry.',
      'See you yesterday.',
    ],
    correctAnswer: 'Please repeat.',
  ),

  A1ExamQuestion(
    id: 'a1_exam_024',
    lessonId: 'a1_12',
    category: 'Conversation',
    question: 'What do you say when someone helps you?',
    options: [
      'Thank you.',
      'Good night.',
      'Excuse me.',
      'Maybe.',
    ],
    correctAnswer: 'Thank you.',
  ),
];