import '../models/lesson.dart';

class LessonService {
  static const List<Lesson> a1Lessons = [
    Lesson(
      id: 'a1_01',
      title: 'Greetings',
      level: 'A1',
      description:
          'Learn greetings, goodbyes, introductions and simple real-life conversations.',
      xp: 40,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          explanation:
              'Learn the most useful words for greeting people in everyday English.',
          items: [
            LessonItem(
              english: 'Hello',
              persian: 'سلام',
              example: 'Hello! Nice to meet you.',
              pronunciation: 'heh-LOH',
            ),
            LessonItem(
              english: 'Hi',
              persian: 'سلام / های',
              example: 'Hi! How are you?',
              pronunciation: 'hai',
            ),
            LessonItem(
              english: 'Good morning',
              persian: 'صبح بخیر',
              example: 'Good morning! How are you?',
              pronunciation: 'good MOR-ning',
            ),
            LessonItem(
              english: 'Good afternoon',
              persian: 'بعدازظهر بخیر',
              example: 'Good afternoon, everyone.',
              pronunciation: 'good af-ter-NOON',
            ),
            LessonItem(
              english: 'Good evening',
              persian: 'عصر بخیر',
              example: 'Good evening, Mr. Smith.',
              pronunciation: 'good EEV-ning',
            ),
            LessonItem(
              english: 'Goodbye',
              persian: 'خداحافظ',
              example: 'Goodbye! See you tomorrow.',
              pronunciation: 'good-BYE',
            ),
            LessonItem(
              english: 'See you',
              persian: 'می‌بینمت / به امید دیدار',
              example: 'See you later!',
              pronunciation: 'see yoo',
            ),
            LessonItem(
              english: 'Thanks',
              persian: 'ممنون',
              example: 'Thanks for your help.',
              pronunciation: 'thanks',
            ),
            LessonItem(
              english: 'Please',
              persian: 'لطفاً',
              example: 'Please come in.',
              pronunciation: 'pleez',
            ),
            LessonItem(
              english: 'Sorry',
              persian: 'متأسفم / ببخشید',
              example: 'Sorry, I am late.',
              pronunciation: 'SOR-ee',
            ),
          ],
        ),

        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          explanation:
              'These are common phrases you can actually use when meeting people.',
          items: [
            LessonItem(
              english: 'How are you?',
              persian: 'حالت چطوره؟',
              example: 'Hi! How are you?',
            ),
            LessonItem(
              english: 'I’m good, thanks.',
              persian: 'خوبم، ممنون.',
              example: 'I’m good, thanks. How about you?',
            ),
            LessonItem(
              english: 'Nice to meet you.',
              persian: 'از آشنایی با شما خوشحالم.',
              example: 'Hi, I’m Sara. Nice to meet you.',
            ),
            LessonItem(
              english: 'Nice to meet you too.',
              persian: 'من هم از آشنایی با شما خوشحالم.',
              example: 'Nice to meet you too!',
            ),
            LessonItem(
              english: 'How about you?',
              persian: 'تو چطور؟ / شما چطور؟',
              example: 'I’m fine. How about you?',
            ),
            LessonItem(
              english: 'See you later.',
              persian: 'بعداً می‌بینمت.',
              example: 'I have to go. See you later!',
            ),
          ],
        ),

        LessonSection(
          title: 'Grammar',
          type: 'grammar',
          explanation:
              'Use “I’m” as the short form of “I am”. It is one of the most common structures in English.',
          items: [
            LessonItem(
              english: 'I am good.',
              persian: 'من خوبم.',
              example: 'I am good, thanks.',
            ),
            LessonItem(
              english: 'I’m good.',
              persian: 'من خوبم.',
              example: 'I’m good. How about you?',
            ),
            LessonItem(
              english: 'You are nice.',
              persian: 'تو / شما خوب و مهربانی.',
              example: 'You are very nice.',
            ),
          ],
        ),

        LessonSection(
          title: 'Real-Life Examples',
          type: 'examples',
          explanation:
              'See how these expressions work in normal conversations.',
          items: [
            LessonItem(
              english: 'A: Hi! How are you?',
              persian: 'الف: سلام! حالت چطوره؟',
              example: 'B: I’m good, thanks. How about you?',
            ),
            LessonItem(
              english: 'A: Good morning!',
              persian: 'الف: صبح بخیر!',
              example: 'B: Good morning! Nice to see you.',
            ),
            LessonItem(
              english: 'A: Hi, I’m Alex.',
              persian: 'الف: سلام، من الکس هستم.',
              example: 'B: Hi, Alex. Nice to meet you.',
            ),
            LessonItem(
              english: 'A: I have to go now.',
              persian: 'الف: الان باید برم.',
              example: 'B: Okay, see you later!',
            ),
          ],
        ),

        LessonSection(
          title: 'Common Mistakes',
          type: 'mistakes',
          explanation:
              'A few small mistakes can make your English sound unnatural.',
          items: [
            LessonItem(
              english: 'How are you?',
              persian: 'حالت چطوره؟',
              example: 'Correct: How are you?',
            ),
            LessonItem(
              english: 'I’m good, thanks.',
              persian: 'خوبم، ممنون.',
              example: 'Natural answer to “How are you?”',
            ),
            LessonItem(
              english: 'Nice to meet you.',
              persian: 'از آشنایی با شما خوشحالم.',
              example: 'Use this when you meet someone for the first time.',
            ),
          ],
        ),

        LessonSection(
          title: 'Practice',
          type: 'practice',
          explanation:
              'Choose the correct phrase, complete sentences and build your own answers.',
          items: [
            LessonItem(
              english: '_____! How are you?',
              persian: 'جای خالی را کامل کن.',
              example: 'Possible answer: Hi!',
            ),
            LessonItem(
              english: 'I’m good, _____.',
              persian: 'جای خالی را کامل کن.',
              example: 'Possible answer: thanks',
            ),
            LessonItem(
              english: 'Nice to _____ you.',
              persian: 'جای خالی را کامل کن.',
              example: 'Possible answer: meet',
            ),
          ],
        ),

        LessonSection(
          title: 'Mini Conversation',
          type: 'speaking',
          explanation:
              'Practice a short conversation with Meow. Later, this section will use AI and voice recognition.',
          items: [
            LessonItem(
              english: 'Hi! What is your name?',
              persian: 'سلام! اسمت چیه؟',
              example: 'Answer with your name.',
            ),
            LessonItem(
              english: 'Nice to meet you!',
              persian: 'از آشنایی باهات خوشحالم!',
              example: 'Reply naturally.',
            ),
            LessonItem(
              english: 'How are you today?',
              persian: 'امروز حالت چطوره؟',
              example: 'Give a short answer.',
            ),
          ],
        ),

        LessonSection(
          title: 'Review',
          type: 'review',
          explanation:
              'Review the important words and phrases before finishing the lesson.',
          items: [
            LessonItem(
              english: 'Hello',
              persian: 'سلام',
            ),
            LessonItem(
              english: 'How are you?',
              persian: 'حالت چطوره؟',
            ),
            LessonItem(
              english: 'Nice to meet you.',
              persian: 'از آشنایی با شما خوشحالم.',
            ),
            LessonItem(
              english: 'See you later.',
              persian: 'بعداً می‌بینمت.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_02',
      title: 'Introducing Yourself',
      level: 'A1',
      description:
          'Learn how to introduce yourself and talk about basic personal information.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'name',
              persian: 'نام / اسم',
              example: 'My name is Alex.',
            ),
            LessonItem(
              english: 'age',
              persian: 'سن',
              example: 'I am 20 years old.',
            ),
            LessonItem(
              english: 'from',
              persian: 'اهلِ / از',
              example: 'I am from Iran.',
            ),
            LessonItem(
              english: 'live',
              persian: 'زندگی کردن',
              example: 'I live in Rotterdam.',
            ),
            LessonItem(
              english: 'student',
              persian: 'دانش‌آموز / دانشجو',
              example: 'I am a student.',
            ),
            LessonItem(
              english: 'job',
              persian: 'شغل',
              example: 'What is your job?',
            ),
          ],
        ),
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'My name is ...',
              persian: 'اسم من ... است.',
            ),
            LessonItem(
              english: 'I’m ... years old.',
              persian: 'من ... ساله هستم.',
            ),
            LessonItem(
              english: 'I’m from ...',
              persian: 'من اهل ... هستم.',
            ),
            LessonItem(
              english: 'I live in ...',
              persian: 'من در ... زندگی می‌کنم.',
            ),
            LessonItem(
              english: 'What is your name?',
              persian: 'اسمت چیه؟',
            ),
          ],
        ),
        LessonSection(
          title: 'Grammar',
          type: 'grammar',
          explanation:
              'Use “I am” or “I’m” to give basic information about yourself.',
          items: [
            LessonItem(
              english: 'I am a student.',
              persian: 'من دانشجو هستم.',
            ),
            LessonItem(
              english: 'I’m from Iran.',
              persian: 'من اهل ایران هستم.',
            ),
            LessonItem(
              english: 'I live in Rotterdam.',
              persian: 'من در روتردام زندگی می‌کنم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Real-Life Examples',
          type: 'examples',
          items: [
            LessonItem(
              english: 'Hi, my name is Sara. I’m 22 years old.',
              persian: 'سلام، اسم من سارا است. ۲۲ ساله هستم.',
            ),
            LessonItem(
              english: 'I’m from Iran, but I live in the Netherlands.',
              persian: 'من اهل ایرانم، ولی در هلند زندگی می‌کنم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'My name _____ Sara.',
              persian: 'جای خالی را کامل کن.',
            ),
            LessonItem(
              english: 'I _____ 20 years old.',
              persian: 'جای خالی را کامل کن.',
            ),
            LessonItem(
              english: 'I’m _____ Iran.',
              persian: 'جای خالی را کامل کن.',
            ),
          ],
        ),
        LessonSection(
          title: 'Speaking',
          type: 'speaking',
          explanation:
              'Introduce yourself to Meow using your name, age and where you are from.',
          items: [
            LessonItem(
              english: 'Tell Meow about yourself.',
              persian: 'خودت را برای میو معرفی کن.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_03',
      title: 'Numbers & Age',
      level: 'A1',
      description:
          'Learn numbers, ages and simple questions about numbers.',
      xp: 40,
      sections: [
        LessonSection(
          title: 'Numbers',
          type: 'vocabulary',
          items: [
            LessonItem(english: 'one', persian: 'یک'),
            LessonItem(english: 'two', persian: 'دو'),
            LessonItem(english: 'three', persian: 'سه'),
            LessonItem(english: 'four', persian: 'چهار'),
            LessonItem(english: 'five', persian: 'پنج'),
            LessonItem(english: 'ten', persian: 'ده'),
            LessonItem(english: 'twenty', persian: 'بیست'),
            LessonItem(english: 'thirty', persian: 'سی'),
            LessonItem(english: 'one hundred', persian: 'صد'),
          ],
        ),
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'How old are you?',
              persian: 'چند سالته؟',
            ),
            LessonItem(
              english: 'I’m twenty years old.',
              persian: 'من بیست ساله هستم.',
            ),
            LessonItem(
              english: 'How many?',
              persian: 'چند تا؟ / چند عدد؟',
            ),
          ],
        ),
        LessonSection(
          title: 'Grammar',
          type: 'grammar',
          explanation:
              'Use “I am” with age in English, not “I have”.',
          items: [
            LessonItem(
              english: 'I am twenty years old.',
              persian: 'من بیست ساله هستم.',
              example: 'Correct English structure.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'How _____ are you?',
              persian: 'جای خالی را کامل کن.',
            ),
            LessonItem(
              english: 'I am _____ years old.',
              persian: 'سن خودت را بگو.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_04',
      title: 'Countries & Nationalities',
      level: 'A1',
      description:
          'Talk about countries, nationalities and where people are from.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(
              english: 'Iran',
              persian: 'ایران',
            ),
            LessonItem(
              english: 'the Netherlands',
              persian: 'هلند',
            ),
            LessonItem(
              english: 'England',
              persian: 'انگلستان',
            ),
            LessonItem(
              english: 'American',
              persian: 'آمریکایی',
            ),
            LessonItem(
              english: 'British',
              persian: 'بریتانیایی',
            ),
            LessonItem(
              english: 'Iranian',
              persian: 'ایرانی',
            ),
            LessonItem(
              english: 'Dutch',
              persian: 'هلندی',
            ),
          ],
        ),
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'Where are you from?',
              persian: 'اهل کجایی؟',
            ),
            LessonItem(
              english: 'I’m from Iran.',
              persian: 'من اهل ایران هستم.',
            ),
            LessonItem(
              english: 'I’m Iranian.',
              persian: 'من ایرانی هستم.',
            ),
            LessonItem(
              english: 'Where do you live?',
              persian: 'کجا زندگی می‌کنی؟',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'I’m _____ Iran.',
              persian: 'جای خالی را کامل کن.',
            ),
            LessonItem(
              english: 'I’m _____.',
              persian: 'ملیت خودت را بگو.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_05',
      title: 'Family',
      level: 'A1',
      description:
          'Learn common family words and talk about the people in your family.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(english: 'mother', persian: 'مادر'),
            LessonItem(english: 'father', persian: 'پدر'),
            LessonItem(english: 'sister', persian: 'خواهر'),
            LessonItem(english: 'brother', persian: 'برادر'),
            LessonItem(english: 'parents', persian: 'والدین'),
            LessonItem(english: 'family', persian: 'خانواده'),
            LessonItem(english: 'child', persian: 'کودک / بچه'),
          ],
        ),
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'This is my mother.',
              persian: 'این مادر من است.',
            ),
            LessonItem(
              english: 'I have one brother.',
              persian: 'من یک برادر دارم.',
            ),
            LessonItem(
              english: 'I live with my family.',
              persian: 'من با خانواده‌ام زندگی می‌کنم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'This is my _____.',
              persian: 'یکی از اعضای خانواده را بگو.',
            ),
            LessonItem(
              english: 'I have _____ brothers.',
              persian: 'تعداد برادرهایت را بگو.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_06',
      title: 'Daily Routine',
      level: 'A1',
      description:
          'Talk about your daily routine and common everyday activities.',
      xp: 50,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(english: 'wake up', persian: 'بیدار شدن'),
            LessonItem(english: 'get up', persian: 'از خواب بلند شدن'),
            LessonItem(english: 'eat breakfast', persian: 'صبحانه خوردن'),
            LessonItem(english: 'go to work', persian: 'به سر کار رفتن'),
            LessonItem(english: 'study', persian: 'درس خواندن'),
            LessonItem(english: 'come home', persian: 'به خانه آمدن'),
            LessonItem(english: 'go to bed', persian: 'به رختخواب رفتن'),
          ],
        ),
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'I wake up at seven.',
              persian: 'من ساعت هفت بیدار می‌شوم.',
            ),
            LessonItem(
              english: 'I have breakfast in the morning.',
              persian: 'من صبحانه را صبح می‌خورم.',
            ),
            LessonItem(
              english: 'I go to bed at eleven.',
              persian: 'من ساعت یازده می‌خوابم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Grammar',
          type: 'grammar',
          explanation:
              'Use the present simple to talk about routines and things you do regularly.',
          items: [
            LessonItem(
              english: 'I study English every day.',
              persian: 'من هر روز انگلیسی می‌خوانم.',
            ),
            LessonItem(
              english: 'I drink coffee in the morning.',
              persian: 'من صبح قهوه می‌نوشم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'I _____ up at eight.',
              persian: 'جای خالی را کامل کن.',
            ),
            LessonItem(
              english: 'I go to _____ at night.',
              persian: 'جای خالی را کامل کن.',
            ),
          ],
        ),
        LessonSection(
          title: 'Speaking',
          type: 'speaking',
          items: [
            LessonItem(
              english: 'Tell Meow about your daily routine.',
              persian: 'روتین روزانه‌ات را برای میو تعریف کن.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_07',
      title: 'Food & Drinks',
      level: 'A1',
      description:
          'Learn common food and drink vocabulary and order simple things.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(english: 'water', persian: 'آب'),
            LessonItem(english: 'milk', persian: 'شیر'),
            LessonItem(english: 'bread', persian: 'نان'),
            LessonItem(english: 'rice', persian: 'برنج'),
            LessonItem(english: 'egg', persian: 'تخم‌مرغ'),
            LessonItem(english: 'apple', persian: 'سیب'),
            LessonItem(english: 'coffee', persian: 'قهوه'),
            LessonItem(english: 'tea', persian: 'چای'),
          ],
        ),
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'I’d like some water.',
              persian: 'کمی آب می‌خواهم.',
            ),
            LessonItem(
              english: 'Can I have a coffee?',
              persian: 'می‌توانم یک قهوه داشته باشم؟',
            ),
            LessonItem(
              english: 'I’m hungry.',
              persian: 'گرسنه‌ام.',
            ),
            LessonItem(
              english: 'I’m thirsty.',
              persian: 'تشنه‌ام.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'I’d like some _____.',
              persian: 'یک خوراکی یا نوشیدنی انتخاب کن.',
            ),
            LessonItem(
              english: 'Can I have a _____?',
              persian: 'یک نوشیدنی یا خوراکی انتخاب کن.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_08',
      title: 'Likes & Dislikes',
      level: 'A1',
      description:
          'Learn how to talk about things you like, love and dislike.',
      xp: 50,
      sections: [
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'I like coffee.',
              persian: 'من قهوه دوست دارم.',
            ),
            LessonItem(
              english: 'I love music.',
              persian: 'من عاشق موسیقی هستم.',
            ),
            LessonItem(
              english: 'I don’t like tea.',
              persian: 'من چای دوست ندارم.',
            ),
            LessonItem(
              english: 'I really like cats.',
              persian: 'من واقعاً گربه‌ها را دوست دارم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Grammar',
          type: 'grammar',
          explanation:
              'Use “like” with things you enjoy. Use “don’t like” for things you dislike.',
          items: [
            LessonItem(
              english: 'I like English.',
              persian: 'من انگلیسی را دوست دارم.',
            ),
            LessonItem(
              english: 'I don’t like cold weather.',
              persian: 'من هوای سرد را دوست ندارم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'I _____ pizza.',
              persian: 'یک فعل مناسب انتخاب کن.',
            ),
            LessonItem(
              english: 'I don’t _____ coffee.',
              persian: 'جای خالی را کامل کن.',
            ),
          ],
        ),
        LessonSection(
          title: 'Speaking',
          type: 'speaking',
          items: [
            LessonItem(
              english: 'Tell Meow three things you like.',
              persian: 'سه چیزی که دوست داری را به میو بگو.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_09',
      title: 'Home & Rooms',
      level: 'A1',
      description:
          'Learn words for rooms, furniture and common things around your home.',
      xp: 45,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(english: 'house', persian: 'خانه'),
            LessonItem(english: 'room', persian: 'اتاق'),
            LessonItem(english: 'bedroom', persian: 'اتاق خواب'),
            LessonItem(english: 'kitchen', persian: 'آشپزخانه'),
            LessonItem(english: 'bathroom', persian: 'حمام / دستشویی'),
            LessonItem(english: 'table', persian: 'میز'),
            LessonItem(english: 'chair', persian: 'صندلی'),
            LessonItem(english: 'bed', persian: 'تخت'),
          ],
        ),
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'This is my bedroom.',
              persian: 'این اتاق خواب من است.',
            ),
            LessonItem(
              english: 'The kitchen is small.',
              persian: 'آشپزخانه کوچک است.',
            ),
            LessonItem(
              english: 'There is a table in the room.',
              persian: 'یک میز در اتاق هست.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'This is my _____.',
              persian: 'یکی از اتاق‌های خانه را انتخاب کن.',
            ),
            LessonItem(
              english: 'There is a _____ in my room.',
              persian: 'یک وسیله از اتاقت را بگو.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_10',
      title: 'Time & Dates',
      level: 'A1',
      description:
          'Learn how to talk about time, days, dates and simple schedules.',
      xp: 50,
      sections: [
        LessonSection(
          title: 'Vocabulary',
          type: 'vocabulary',
          items: [
            LessonItem(english: 'today', persian: 'امروز'),
            LessonItem(english: 'tomorrow', persian: 'فردا'),
            LessonItem(english: 'yesterday', persian: 'دیروز'),
            LessonItem(english: 'morning', persian: 'صبح'),
            LessonItem(english: 'afternoon', persian: 'بعدازظهر'),
            LessonItem(english: 'evening', persian: 'عصر'),
            LessonItem(english: 'night', persian: 'شب'),
          ],
        ),
        LessonSection(
          title: 'Useful Phrases',
          type: 'phrases',
          items: [
            LessonItem(
              english: 'What time is it?',
              persian: 'ساعت چنده؟',
            ),
            LessonItem(
              english: 'It’s seven o’clock.',
              persian: 'ساعت هفت است.',
            ),
            LessonItem(
              english: 'See you tomorrow.',
              persian: 'فردا می‌بینمت.',
            ),
            LessonItem(
              english: 'What day is it today?',
              persian: 'امروز چه روزی است؟',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'What _____ is it?',
              persian: 'جای خالی را کامل کن.',
            ),
            LessonItem(
              english: 'See you _____.',
              persian: 'برای خداحافظی مناسب کامل کن.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_11',
      title: 'Everyday Conversations',
      level: 'A1',
      description:
          'Practice simple conversations you can use in real everyday situations.',
      xp: 55,
      sections: [
        LessonSection(
          title: 'At a Café',
          type: 'conversation',
          items: [
            LessonItem(
              english: 'Can I have a coffee, please?',
              persian: 'لطفاً می‌توانم یک قهوه داشته باشم؟',
            ),
            LessonItem(
              english: 'Anything else?',
              persian: 'چیز دیگری؟',
            ),
            LessonItem(
              english: 'No, thank you.',
              persian: 'نه، ممنون.',
            ),
          ],
        ),
        LessonSection(
          title: 'Meeting Someone',
          type: 'conversation',
          items: [
            LessonItem(
              english: 'Hi! What’s your name?',
              persian: 'سلام! اسمت چیه؟',
            ),
            LessonItem(
              english: 'My name is Alex.',
              persian: 'اسم من الکس است.',
            ),
            LessonItem(
              english: 'Where are you from?',
              persian: 'اهل کجایی؟',
            ),
            LessonItem(
              english: 'I’m from Iran.',
              persian: 'من اهل ایران هستم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Practice',
          type: 'practice',
          items: [
            LessonItem(
              english: 'Complete a short conversation with Meow.',
              persian: 'یک مکالمه کوتاه با میو کامل کن.',
            ),
          ],
        ),
        LessonSection(
          title: 'Speaking',
          type: 'speaking',
          explanation:
              'Use everything you learned in A1 to have a short conversation.',
          items: [
            LessonItem(
              english: 'Introduce yourself and talk about your day.',
              persian: 'خودت را معرفی کن و درباره روزت صحبت کن.',
            ),
          ],
        ),
      ],
    ),

    Lesson(
      id: 'a1_12',
      title: 'A1 Review',
      level: 'A1',
      description:
          'Review vocabulary, phrases, grammar and conversations from the whole A1 path.',
      xp: 75,
      sections: [
        LessonSection(
          title: 'Vocabulary Review',
          type: 'review',
          items: [
            LessonItem(
              english: 'greetings',
              persian: 'سلام و احوالپرسی',
            ),
            LessonItem(
              english: 'family',
              persian: 'خانواده',
            ),
            LessonItem(
              english: 'food',
              persian: 'غذا',
            ),
            LessonItem(
              english: 'home',
              persian: 'خانه',
            ),
            LessonItem(
              english: 'routine',
              persian: 'روتین روزانه',
            ),
          ],
        ),
        LessonSection(
          title: 'Grammar Review',
          type: 'grammar',
          explanation:
              'Review the basic sentence patterns used throughout A1.',
          items: [
            LessonItem(
              english: 'I am ...',
              persian: 'من ... هستم.',
            ),
            LessonItem(
              english: 'I have ...',
              persian: 'من ... دارم.',
            ),
            LessonItem(
              english: 'I like ...',
              persian: 'من ... را دوست دارم.',
            ),
            LessonItem(
              english: 'I don’t like ...',
              persian: 'من ... را دوست ندارم.',
            ),
          ],
        ),
        LessonSection(
          title: 'Final Practice',
          type: 'practice',
          explanation:
              'A mixed review of vocabulary, grammar, translation and real-life situations.',
          items: [
            LessonItem(
              english: 'Introduce yourself.',
              persian: 'خودت را معرفی کن.',
            ),
            LessonItem(
              english: 'Talk about your family.',
              persian: 'درباره خانواده‌ات صحبت کن.',
            ),
            LessonItem(
              english: 'Describe your daily routine.',
              persian: 'روتین روزانه‌ات را توضیح بده.',
            ),
            LessonItem(
              english: 'Talk about things you like.',
              persian: 'درباره چیزهایی که دوست داری صحبت کن.',
            ),
          ],
        ),
      ],
    ),
  ];
}