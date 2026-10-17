/// Genuine B1 Lesson 2 content: recent events with just, already, and yet.
class B1Lesson02Data {
  static const id = 'b1_lesson_02';
  static const titleEn = 'Recently';
  static const titleFa = 'اتفاق‌های اخیر';
  static const vocabulary = <B1Lesson02Word>[
    B1Lesson02Word('recently', 'اخیراً', 'I have recently started a new course.'),
    B1Lesson02Word('just', 'همین الان / به‌تازگی', 'She has just arrived home.'),
    B1Lesson02Word('already', 'از قبل / همین حالا', 'We have already finished the task.'),
    B1Lesson02Word('yet', 'هنوز / تا حالا', 'Have you called him yet?'),
    B1Lesson02Word('still', 'هنوز', 'I still haven’t received the email.'),
    B1Lesson02Word('so far', 'تا اینجا / تاکنون', 'So far, we have learned ten new words.'),
  ];
  static const grammarEn = 'Use just for something that happened a very short time ago. Use already when something happened earlier than expected. Use yet mainly in questions and negative sentences, usually at the end.';
  static const grammarFa = 'از just برای اتفاقی که همین چند لحظه پیش افتاده، از already برای کاری که زودتر از انتظار انجام شده، و از yet بیشتر در سؤال‌ها و جمله‌های منفی استفاده می‌کنیم. Yet معمولاً آخر جمله می‌آید.';
  static const examples = <B1Lesson02Question>[
    B1Lesson02Question('I have ___ finished my homework. I finished it a minute ago.', ['just', 'yet', 'still'], 'just', 'just برای اتفاقی است که همین چند لحظه پیش رخ داده.'),
    B1Lesson02Question('Have you sent the message ___?', ['already', 'yet', 'just'], 'yet', 'در سؤال درباره انجام شدن کار تا این لحظه، yet معمولاً آخر جمله می‌آید.'),
    B1Lesson02Question('She has ___ seen that film, so she doesn’t want to watch it again.', ['already', 'yet', 'still'], 'already', 'already نشان می‌دهد کار قبلاً انجام شده است.'),
    B1Lesson02Question('We haven’t received the results ___.', ['just', 'already', 'yet'], 'yet', 'در جمله منفی، yet یعنی «هنوز».'),
    B1Lesson02Question('So far, the team ___ three matches.', ['has won', 'won', 'is winning'], 'has won', 'so far به بازه‌ای تا زمان حال اشاره می‌کند؛ Present Perfect مناسب است.'),
  ];
  static const typedPromptEn = 'Translate: «من هنوز ایمیل را دریافت نکرده‌ام.»';
  static const typedPromptFa = 'ترجمه را به انگلیسی بنویس.';
  static const acceptedTypedAnswers = <String>[
    'i have not received the email yet',
    'i have not received the email',
    'i haven’t received the email yet',
    'i havent received the email yet',
  ];
}
class B1Lesson02Word {
  final String word, meaningFa, exampleEn;
  const B1Lesson02Word(this.word, this.meaningFa, this.exampleEn);
}
class B1Lesson02Question {
  final String prompt;
  final List<String> options;
  final String answer, explanationFa;
  const B1Lesson02Question(this.prompt, this.options, this.answer, this.explanationFa);
}
