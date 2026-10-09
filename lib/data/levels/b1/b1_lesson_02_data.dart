/// Genuine B1 Lesson 2 content: travel plans and making arrangements.
class B1Lesson02Data {
  static const id = 'b1_lesson_02';
  static const titleEn = 'Travel Plans & Arrangements';
  static const titleFa = 'برنامه‌ریزی سفر و هماهنگی‌ها';
  static const vocabulary = <B1Lesson02Word>[
    B1Lesson02Word('accommodation', 'محل اقامت', 'We booked accommodation near the station.'),
    B1Lesson02Word('itinerary', 'برنامه سفر', 'I sent the itinerary to everyone.'),
    B1Lesson02Word('departure', 'حرکت / زمان حرکت', 'Our departure is at six in the morning.'),
    B1Lesson02Word('destination', 'مقصد', 'Our final destination is Edinburgh.'),
    B1Lesson02Word('reservation', 'رزرو', 'I made a reservation for two nights.'),
    B1Lesson02Word('delay', 'تأخیر', 'The flight was delayed by an hour.'),
  ];
  static const grammarEn = 'Use “be going to” for plans and “Present Continuous” for fixed arrangements.';
  static const grammarFa = 'برای قصد و برنامه از be going to و برای هماهنگی قطعی از حال استمراری استفاده می‌کنیم.';
  static const examples = <B1Lesson02Question>[
    B1Lesson02Question('We ___ stay in a small hotel next weekend.', ['are going to', 'is going to', 'going'], 'are going to', 'فاعل we با are می‌آید.'),
    B1Lesson02Question('Our train ___ at 8:15 tomorrow morning.', ['leaves', 'leave', 'leaving'], 'leaves', 'برای برنامه زمانی ثابت می‌توان از حال ساده استفاده کرد.'),
    B1Lesson02Question('I ___ meeting Sara at the airport at noon.', ['am', 'is', 'are'], 'am', 'برای قرار قطعی: am/is/are + verb-ing.'),
    B1Lesson02Question('They have booked their ___.', ['accommodation', 'departure', 'delay'], 'accommodation', 'accommodation یعنی محل اقامت.'),
    B1Lesson02Question('The flight arrived late because of a ___.', ['reservation', 'delay', 'destination'], 'delay', 'delay یعنی تأخیر.'),
  ];
  static const typedPromptEn = 'Translate: «ما فردا ساعت هفت حرکت می‌کنیم.»';
  static const typedPromptFa = 'ترجمه را به انگلیسی بنویس.';
  static const acceptedTypedAnswers = <String>[
    'we are leaving at seven tomorrow',
    'we leave at seven tomorrow',
    'we are going to leave at seven tomorrow',
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
