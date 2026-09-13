import '../models/lesson.dart';

class LessonService {
  static const List<Lesson> a1Lessons = [
    // ============================================================
    // LESSON 1
    // ============================================================
    Lesson(
      id: 'a1_01',
      title: 'Greetings',
      level: 'A1',
      description:
          'Learn greetings, introductions, useful everyday phrases, and simple real-life conversations.',
      xp: 40,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          explanation:
              'These are common words and phrases you will hear when meeting people.',
          items: [
            LessonItem(
              english: 'Hello',
              persian: 'سلام',
              pronunciation: 'heh-LOH',
              example: 'Hello! How are you?',
              examplePersian: 'سلام! حالت چطوره؟',
            ),
            LessonItem(
              english: 'Hi',
              persian: 'سلام',
              pronunciation: 'hai',
              example: 'Hi! Nice to meet you.',
              examplePersian: 'سلام! از آشنایی باهات خوشحالم.',
            ),
            LessonItem(
              english: 'Good morning',
              persian: 'صبح بخیر',
              pronunciation: 'good MOR-ning',
              example: 'Good morning! How are you?',
              examplePersian: 'صبح بخیر! حالت چطوره؟',
            ),
            LessonItem(
              english: 'Good evening',
              persian: 'عصر بخیر',
              pronunciation: 'good EEV-ning',
              example: 'Good evening, everyone.',
              examplePersian: 'عصر بخیر، همه.',
            ),
            LessonItem(
              english: 'Goodbye',
              persian: 'خداحافظ',
              pronunciation: 'good-BYE',
              example: 'Goodbye! See you tomorrow.',
              examplePersian: 'خداحافظ! فردا می‌بینمت.',
            ),
            LessonItem(
              english: 'Nice to meet you',
              persian: 'از آشنایی باهات خوشحالم',
              pronunciation: 'nice tuh MEET yoo',
              example: 'Hi, I’m Sara. Nice to meet you.',
              examplePersian: 'سلام، من سارا هستم. از آشنایی باهات خوشحالم.',
            ),
          ],
        ),

        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          explanation:
              'These phrases are useful in everyday conversations.',
          items: [
            LessonItem(
              english: 'How are you?',
              persian: 'حالت چطوره؟',
              example: 'Hi! How are you?',
              examplePersian: 'سلام! حالت چطوره؟',
            ),
            LessonItem(
              english: "I'm good.",
              persian: 'خوبم.',
              example: "I'm good, thanks.",
              examplePersian: 'خوبم، ممنون.',
            ),
            LessonItem(
              english: 'Thank you',
              persian: 'ممنون',
              example: 'Thank you for your help.',
              examplePersian: 'ممنون بابت کمکت.',
            ),
            LessonItem(
              english: "You're welcome.",
              persian: 'خواهش می‌کنم.',
              example: 'Thank you! — You’re welcome.',
              examplePersian: 'ممنون! — خواهش می‌کنم.',
            ),
            LessonItem(
              english: 'See you later.',
              persian: 'بعداً می‌بینمت.',
              example: 'I have to go. See you later!',
              examplePersian: 'باید برم. بعداً می‌بینمت!',
            ),
          ],
        ),

        LessonSection(
          title: 'Real English',
          type: 'real_english',
          explanation:
              'People often use these casual phrases in real conversations.',
          items: [
            LessonItem(
              english: "What's up?",
              persian: 'چه خبر؟ / اوضاع چطوره؟',
              example: "Hey! What's up?",
              examplePersian: 'هی! چه خبر؟',
            ),
            LessonItem(
              english: "I'm good.",
              persian: 'خوبم.',
              example: "I'm good. How about you?",
              examplePersian: 'خوبم. تو چطوری؟',
            ),
            LessonItem(
              english: 'No worries.',
              persian: 'اشکالی نداره / نگران نباش',
              example: 'Sorry! — No worries.',
              examplePersian: 'ببخشید! — اشکالی نداره.',
            ),
            LessonItem(
              english: 'My bad.',
              persian: 'تقصیر من بود.',
              example: 'My bad! I forgot.',
              examplePersian: 'تقصیر من بود! یادم رفت.',
            ),
            LessonItem(
              english: 'Give me a sec.',
              persian: 'یه لحظه بهم وقت بده.',
              example: 'Give me a sec. I’m almost ready.',
              examplePersian: 'یه لحظه بهم وقت بده. تقریباً آماده‌ام.',
            ),
            LessonItem(
              english: 'See you around.',
              persian: 'بعداً می‌بینمت.',
              example: 'I’m leaving now. See you around!',
              examplePersian: 'من دیگه میرم. بعداً می‌بینمت!',
            ),
          ],
        ),

        LessonSection(
          title: 'Grammar',
          type: 'grammar',
          explanation:
              'Use "I am" to talk about yourself. In everyday English, "I am" is usually shortened to "I’m".',
          items: [
            LessonItem(
              english: "I'm",
              persian: 'من هستم',
              example: "I'm Ali.",
              examplePersian: 'من علی هستم.',
            ),
            LessonItem(
              english: "I'm good.",
              persian: 'خوبم.',
              example: "I'm good, thank you.",
              examplePersian: 'خوبم، ممنون.',
            ),
            LessonItem(
              english: "I'm happy.",
              persian: 'خوشحالم.',
              example: "I'm happy to see you.",
              examplePersian: 'از دیدنت خوشحالم.',
            ),
          ],
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'Choose the correct answer.',
              promptPersian: 'جواب درست را انتخاب کن.',
              sentence: 'I ___ Sara.',
              options: ['am', 'is', 'are', 'be'],
              correctIndex: 0,
              correctAnswer: 'am',
              explanation:
                  'With "I", we use "am": I am Sara.',
            ),
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'Complete the sentence.',
              promptPersian: 'جمله را کامل کن.',
              sentence: "I'm ___ today.",
              options: ['good', 'are', 'is', 'am'],
              correctIndex: 0,
              correctAnswer: 'good',
              explanation:
                  'After "I’m", an adjective like "good" can describe how you feel.',
            ),
          ],
        ),

        LessonSection(
          title: 'Real-Life Examples',
          type: 'examples',
          explanation:
              'See how these phrases sound in normal everyday conversations.',
          items: [
            LessonItem(
              english: 'A: Hi! How are you?',
              persian: 'الف: سلام! حالت چطوره؟',
              example: 'B: I’m good, thanks. How about you?',
              examplePersian: 'ب: خوبم، ممنون. تو چطوری؟',
            ),
            LessonItem(
              english: 'A: Hello, I’m Alex.',
              persian: 'الف: سلام، من الکس هستم.',
              example: 'B: Nice to meet you!',
              examplePersian: 'ب: از آشنایی باهات خوشحالم!',
            ),
            LessonItem(
              english: 'A: I have to go.',
              persian: 'الف: باید برم.',
              example: 'B: Okay, see you later!',
              examplePersian: 'ب: باشه، بعداً می‌بینمت!',
            ),
          ],
        ),

        LessonSection(
          title: 'Common Mistakes',
          type: 'mistakes',
          explanation:
              'These mistakes are common for beginners. Meow is watching. 👀',
          items: [
            LessonItem(
              english: 'How are you? → I’m good.',
              persian: 'حالت چطوره؟ → خوبم.',
              example: 'How are you? — I’m good.',
              examplePersian: 'حالت چطوره؟ — خوبم.',
            ),
            LessonItem(
              english: 'Nice to meet you.',
              persian: 'از آشنایی باهات خوشحالم.',
              example: 'Nice to meet you.',
              examplePersian: 'از آشنایی باهات خوشحالم.',
            ),
          ],
        ),

        LessonSection(
          title: 'Practice',
          type: 'practice',
          explanation:
              'Choose the best answer. The options stay in English so you learn to think in English.',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'How are you?',
              promptPersian: 'حالت چطوره؟',
              options: [
                "I'm good, thank you.",
                'Good morning!',
                'Goodbye!',
                'Nice to meet you.',
              ],
              correctIndex: 0,
              correctAnswer: "I'm good, thank you.",
              explanation:
                  '“I’m good, thank you.” is a natural answer to “How are you?”',
            ),
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'Someone says "Nice to meet you." What can you say?',
              promptPersian: 'کسی می‌گوید «از آشنایی باهات خوشحالم». چه می‌گویی؟',
              options: [
                'Nice to meet you too.',
                'Good morning.',
                'I am goodbye.',
                'What is your name?',
              ],
              correctIndex: 0,
              correctAnswer: 'Nice to meet you too.',
              explanation:
                  '“Nice to meet you too.” is the natural response.',
            ),
            LessonQuestion(
              type: LessonQuestionType.fillBlank,
              prompt: 'Complete the sentence.',
              promptPersian: 'جمله را کامل کن.',
              sentence: 'Nice to ___ you.',
              options: [
                'meet',
                'go',
                'have',
                'morning',
              ],
              correctIndex: 0,
              correctAnswer: 'meet',
              explanation:
                  'The correct phrase is “Nice to meet you.”',
            ),
            LessonQuestion(
              type: LessonQuestionType.fillBlank,
              prompt: 'Complete the sentence.',
              promptPersian: 'جمله را کامل کن.',
              sentence: "I'm ___, thank you.",
              options: [
                'good',
                'meet',
                'hello',
                'later',
              ],
              correctIndex: 0,
              correctAnswer: 'good',
              explanation:
                  '“I’m good, thank you.” is a common response to “How are you?”',
            ),
          ],
        ),

        LessonSection(
          title: 'Read It',
          type: 'read_aloud',
          explanation:
              'Read the sentence aloud. In the future, Meow will check your pronunciation.',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.readAloud,
              prompt: 'Read this sentence aloud.',
              promptPersian: 'این جمله را با صدای بلند بخوان.',
              sentence: 'Hi! Nice to meet you.',
              correctAnswer: 'Hi! Nice to meet you.',
            ),
            LessonQuestion(
              type: LessonQuestionType.readAloud,
              prompt: 'Read this sentence aloud.',
              promptPersian: 'این جمله را با صدای بلند بخوان.',
              sentence: 'How are you today?',
              correctAnswer: 'How are you today?',
            ),
          ],
        ),

        LessonSection(
          title: 'Speaking',
          type: 'speaking',
          explanation:
              'Answer naturally in English. Your speech will be checked against the expected answer.',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.speaking,
              prompt: 'How are you?',
              promptPersian: 'حالت چطوره؟',
              correctAnswer: "I'm good, thank you.",
            ),
            LessonQuestion(
              type: LessonQuestionType.speaking,
              prompt: 'Someone says: "Nice to meet you."',
              promptPersian: 'کسی می‌گوید: «از آشنایی باهات خوشحالم».',
              correctAnswer: 'Nice to meet you too.',
            ),
          ],
        ),

        LessonSection(
          title: 'Mini Conversation',
          type: 'conversation',
          explanation:
              'Read the conversation and imagine you are talking to someone for the first time.',
          items: [
            LessonItem(
              english: 'A: Hi! I’m Emma.',
              persian: 'الف: سلام! من اِما هستم.',
              example: 'B: Hi! I’m Alex. Nice to meet you.',
              examplePersian: 'ب: سلام! من الکس هستم. از آشنایی باهات خوشحالم.',
            ),
            LessonItem(
              english: 'A: Nice to meet you too. How are you?',
              persian: 'الف: من هم از آشنایی باهات خوشحالم. حالت چطوره؟',
              example: 'B: I’m good, thanks!',
              examplePersian: 'ب: خوبم، ممنون!',
            ),
          ],
        ),

        LessonSection(
          title: 'Review',
          type: 'review',
          explanation:
              'Quick review before you finish the lesson.',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'What does "What’s up?" mean?',
              promptPersian: 'عبارت «What’s up?» یعنی چه؟',
              options: [
                'What’s new?',
                'Goodbye.',
                'Good morning.',
                'Thank you.',
              ],
              correctIndex: 0,
              correctAnswer: 'What’s new?',
            ),
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'Choose the natural goodbye.',
              promptPersian: 'خداحافظی طبیعی را انتخاب کن.',
              options: [
                'See you later.',
                'How are you?',
                'Nice to meet you.',
                'What’s up?',
              ],
              correctIndex: 0,
              correctAnswer: 'See you later.',
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 2
    // ============================================================
    Lesson(
      id: 'a1_02',
      title: 'Introducing Yourself',
      level: 'A1',
      description: 'Learn how to introduce yourself and ask simple questions.',
      xp: 40,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'Name',
              persian: 'اسم',
              example: 'My name is Anna.',
              examplePersian: 'اسم من آناست.',
            ),
            LessonItem(
              english: 'From',
              persian: 'از',
              example: 'I’m from Iran.',
              examplePersian: 'من اهل ایران هستم.',
            ),
            LessonItem(
              english: 'Live',
              persian: 'زندگی کردن',
              example: 'I live in Amsterdam.',
              examplePersian: 'من در آمستردام زندگی می‌کنم.',
            ),
            LessonItem(
              english: 'Student',
              persian: 'دانش‌آموز / دانشجو',
              example: 'I’m a student.',
              examplePersian: 'من دانش‌آموز / دانشجو هستم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: "What's your name?",
              persian: 'اسمت چیه؟',
              example: "What's your name?",
              examplePersian: 'اسمت چیه؟',
            ),
            LessonItem(
              english: 'My name is...',
              persian: 'اسم من ... است.',
              example: 'My name is Emma.',
              examplePersian: 'اسم من اِماست.',
            ),
            LessonItem(
              english: 'Where are you from?',
              persian: 'اهل کجایی؟',
              example: 'Where are you from?',
              examplePersian: 'اهل کجایی؟',
            ),
            LessonItem(
              english: "I'm from...",
              persian: 'من اهل ... هستم.',
              example: "I'm from Iran.",
              examplePersian: 'من اهل ایران هستم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: "What's your name?",
              promptPersian: 'اسمت چیه؟',
              options: [
                'My name is Sara.',
                'I’m good.',
                'See you later.',
                'Good morning.',
              ],
              correctIndex: 0,
              correctAnswer: 'My name is Sara.',
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 3
    // ============================================================
    Lesson(
      id: 'a1_03',
      title: 'Family',
      level: 'A1',
      description: 'Learn basic family words and simple sentences.',
      xp: 40,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'Mother',
              persian: 'مادر',
              example: 'This is my mother.',
              examplePersian: 'این مادر من است.',
            ),
            LessonItem(
              english: 'Father',
              persian: 'پدر',
              example: 'My father is at home.',
              examplePersian: 'پدرم خانه است.',
            ),
            LessonItem(
              english: 'Sister',
              persian: 'خواهر',
              example: 'I have one sister.',
              examplePersian: 'من یک خواهر دارم.',
            ),
            LessonItem(
              english: 'Brother',
              persian: 'برادر',
              example: 'My brother is young.',
              examplePersian: 'برادرم جوان است.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'Who is your mother’s son?',
              promptPersian: 'پسر مادرت چه نسبتی با تو دارد؟',
              options: [
                'Brother',
                'Sister',
                'Father',
                'Mother',
              ],
              correctIndex: 0,
              correctAnswer: 'Brother',
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 4
    // ============================================================
    Lesson(
      id: 'a1_04',
      title: 'Daily Routine',
      level: 'A1',
      description: 'Talk about your everyday routine.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'Wake up',
              persian: 'بیدار شدن',
              example: 'I wake up at seven.',
              examplePersian: 'من ساعت هفت بیدار می‌شوم.',
            ),
            LessonItem(
              english: 'Eat breakfast',
              persian: 'صبحانه خوردن',
              example: 'I eat breakfast at home.',
              examplePersian: 'من در خانه صبحانه می‌خورم.',
            ),
            LessonItem(
              english: 'Go to work',
              persian: 'به سر کار رفتن',
              example: 'I go to work at eight.',
              examplePersian: 'من ساعت هشت به سر کار می‌روم.',
            ),
            LessonItem(
              english: 'Go to bed',
              persian: 'به رختخواب رفتن',
              example: 'I go to bed at eleven.',
              examplePersian: 'من ساعت یازده می‌خوابم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.fillBlank,
              prompt: 'Complete the sentence.',
              promptPersian: 'جمله را کامل کن.',
              sentence: 'I ___ up at seven.',
              options: ['wake', 'wakes', 'waking', 'woke'],
              correctIndex: 0,
              correctAnswer: 'wake',
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 5
    // ============================================================
    Lesson(
      id: 'a1_05',
      title: 'Food and Drinks',
      level: 'A1',
      description: 'Talk about common food and drinks.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'Water',
              persian: 'آب',
              example: 'I want some water.',
              examplePersian: 'کمی آب می‌خواهم.',
            ),
            LessonItem(
              english: 'Coffee',
              persian: 'قهوه',
              example: 'I drink coffee in the morning.',
              examplePersian: 'صبح‌ها قهوه می‌نوشم.',
            ),
            LessonItem(
              english: 'Bread',
              persian: 'نان',
              example: 'I like bread.',
              examplePersian: 'من نان دوست دارم.',
            ),
            LessonItem(
              english: 'Apple',
              persian: 'سیب',
              example: 'I want an apple.',
              examplePersian: 'یک سیب می‌خواهم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'Which one is a drink?',
              promptPersian: 'کدام یکی نوشیدنی است؟',
              options: ['Coffee', 'Bread', 'Apple', 'Rice'],
              correctIndex: 0,
              correctAnswer: 'Coffee',
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 6
    // ============================================================
    Lesson(
      id: 'a1_06',
      title: 'Shopping',
      level: 'A1',
      description: 'Learn useful English for shopping.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'How much is it?',
              persian: 'قیمتش چقدره؟',
              example: 'How much is it?',
              examplePersian: 'قیمتش چقدره؟',
            ),
            LessonItem(
              english: 'I like this.',
              persian: 'این را دوست دارم.',
              example: 'I like this shirt.',
              examplePersian: 'این پیراهن را دوست دارم.',
            ),
            LessonItem(
              english: 'I’ll take it.',
              persian: 'برش می‌دارم / می‌خرمش.',
              example: 'It looks good. I’ll take it.',
              examplePersian: 'خوبه. برش می‌دارم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'You want to ask about the price. What do you say?',
              promptPersian: 'می‌خواهی قیمت را بپرسی. چه می‌گویی؟',
              options: [
                'How much is it?',
                'How are you?',
                'Where are you from?',
                'See you later.',
              ],
              correctIndex: 0,
              correctAnswer: 'How much is it?',
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 7
    // ============================================================
    Lesson(
      id: 'a1_07',
      title: 'Time and Dates',
      level: 'A1',
      description: 'Talk about time, days and simple dates.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'Today',
              persian: 'امروز',
              example: 'Today is Monday.',
              examplePersian: 'امروز دوشنبه است.',
            ),
            LessonItem(
              english: 'Tomorrow',
              persian: 'فردا',
              example: 'See you tomorrow.',
              examplePersian: 'فردا می‌بینمت.',
            ),
            LessonItem(
              english: 'Yesterday',
              persian: 'دیروز',
              example: 'I was busy yesterday.',
              examplePersian: 'دیروز سرم شلوغ بود.',
            ),
            LessonItem(
              english: 'Morning',
              persian: 'صبح',
              example: 'I study in the morning.',
              examplePersian: 'صبح درس می‌خوانم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'What comes after today?',
              promptPersian: 'بعد از امروز چه روزی است؟',
              options: ['Tomorrow', 'Yesterday', 'Morning', 'Night'],
              correctIndex: 0,
              correctAnswer: 'Tomorrow',
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 8
    // ============================================================
    Lesson(
      id: 'a1_08',
      title: 'Places Around You',
      level: 'A1',
      description: 'Learn common places and simple location phrases.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'Home',
              persian: 'خانه',
              example: 'I’m at home.',
              examplePersian: 'من خانه هستم.',
            ),
            LessonItem(
              english: 'School',
              persian: 'مدرسه',
              example: 'The school is near my home.',
              examplePersian: 'مدرسه نزدیک خانه من است.',
            ),
            LessonItem(
              english: 'Store',
              persian: 'فروشگاه',
              example: 'I’m going to the store.',
              examplePersian: 'دارم به فروشگاه می‌روم.',
            ),
            LessonItem(
              english: 'Park',
              persian: 'پارک',
              example: 'Let’s go to the park.',
              examplePersian: 'بیا بریم پارک.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'Where can you buy things?',
              promptPersian: 'کجا می‌توانی چیز بخری؟',
              options: ['Store', 'Park', 'School', 'Home'],
              correctIndex: 0,
              correctAnswer: 'Store',
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 9
    // ============================================================
    Lesson(
      id: 'a1_09',
      title: 'Likes and Dislikes',
      level: 'A1',
      description: 'Say what you like and dislike.',
      xp: 50,
      sections: [
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'I like...',
              persian: 'من ... دوست دارم.',
              example: 'I like music.',
              examplePersian: 'من موسیقی دوست دارم.',
            ),
            LessonItem(
              english: "I don't like...",
              persian: 'من ... دوست ندارم.',
              example: "I don't like coffee.",
              examplePersian: 'من قهوه دوست ندارم.',
            ),
            LessonItem(
              english: 'I love...',
              persian: 'من عاشق ... هستم.',
              example: 'I love cats.',
              examplePersian: 'من عاشق گربه‌ها هستم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'Choose the negative sentence.',
              promptPersian: 'جمله منفی را انتخاب کن.',
              options: [
                "I don't like tea.",
                'I like tea.',
                'I love tea.',
                'Tea is good.',
              ],
              correctIndex: 0,
              correctAnswer: "I don't like tea.",
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 10
    // ============================================================
    Lesson(
      id: 'a1_10',
      title: 'Weather',
      level: 'A1',
      description: 'Talk about basic weather and temperature.',
      xp: 50,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'Sunny',
              persian: 'آفتابی',
              example: 'It’s sunny today.',
              examplePersian: 'امروز هوا آفتابی است.',
            ),
            LessonItem(
              english: 'Rainy',
              persian: 'بارانی',
              example: 'It’s rainy today.',
              examplePersian: 'امروز هوا بارانی است.',
            ),
            LessonItem(
              english: 'Cold',
              persian: 'سرد',
              example: 'It’s cold outside.',
              examplePersian: 'بیرون سرد است.',
            ),
            LessonItem(
              english: 'Hot',
              persian: 'گرم',
              example: 'It’s very hot today.',
              examplePersian: 'امروز خیلی گرم است.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'What do you say when there is a lot of rain?',
              promptPersian: 'وقتی باران زیادی می‌بارد چه می‌گویی؟',
              options: [
                'It’s rainy.',
                'It’s sunny.',
                'It’s hot.',
                'It’s dry.',
              ],
              correctIndex: 0,
              correctAnswer: 'It’s rainy.',
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 11
    // ============================================================
    Lesson(
      id: 'a1_11',
      title: 'Feelings',
      level: 'A1',
      description: 'Talk about simple feelings and emotions.',
      xp: 50,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'Happy',
              persian: 'خوشحال',
              example: 'I’m happy today.',
              examplePersian: 'امروز خوشحالم.',
            ),
            LessonItem(
              english: 'Sad',
              persian: 'غمگین',
              example: 'She is sad.',
              examplePersian: 'او ناراحت است.',
            ),
            LessonItem(
              english: 'Tired',
              persian: 'خسته',
              example: 'I’m tired.',
              examplePersian: 'خسته‌ام.',
            ),
            LessonItem(
              english: 'Hungry',
              persian: 'گرسنه',
              example: 'I’m hungry.',
              examplePersian: 'گرسنه‌ام.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'You want to say you need food. What do you say?',
              promptPersian: 'می‌خواهی بگویی غذا می‌خواهی. چه می‌گویی؟',
              options: [
                "I'm hungry.",
                "I'm tired.",
                "I'm sad.",
                "I'm happy.",
              ],
              correctIndex: 0,
              correctAnswer: "I'm hungry.",
            ),
          ],
        ),
      ],
    ),

    // ============================================================
    // LESSON 12
    // ============================================================
    Lesson(
      id: 'a1_12',
      title: 'Everyday Conversations',
      level: 'A1',
      description:
          'Put everything together in simple everyday conversations.',
      xp: 60,
      sections: [
        LessonSection(
          title: 'Real English',
          type: 'real_english',
          items: [
            LessonItem(
              english: 'Sounds good.',
              persian: 'خوبه / خوب به نظر میاد.',
              example: 'Let’s meet at six. — Sounds good.',
              examplePersian: 'ساعت شش همدیگه رو ببینیم. — خوبه.',
            ),
            LessonItem(
              english: 'Sure.',
              persian: 'حتماً / باشه.',
              example: 'Can you help me? — Sure.',
              examplePersian: 'می‌تونی کمکم کنی؟ — حتماً.',
            ),
            LessonItem(
              english: 'No problem.',
              persian: 'مشکلی نیست.',
              example: 'Thanks! — No problem.',
              examplePersian: 'ممنون! — مشکلی نیست.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          questions: [
            LessonQuestion(
              type: LessonQuestionType.multipleChoice,
              prompt: 'Someone says: "Thanks!" What is a natural response?',
              promptPersian: 'کسی می‌گوید «ممنون!» پاسخ طبیعی چیست؟',
              options: [
                "You're welcome.",
                'Good morning.',
                'What’s your name?',
                'I’m hungry.',
              ],
              correctIndex: 0,
              correctAnswer: "You're welcome.",
            ),
            LessonQuestion(
              type: LessonQuestionType.readAloud,
              prompt: 'Read this sentence aloud.',
              promptPersian: 'این جمله را با صدای بلند بخوان.',
              sentence: 'Sounds good! See you later.',
              correctAnswer: 'Sounds good! See you later.',
            ),
          ],
        ),
      ],
    ),
  ];
}