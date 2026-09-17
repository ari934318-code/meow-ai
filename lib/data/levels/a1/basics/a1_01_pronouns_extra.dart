import 'a1_basics_models.dart';

const List<A1BasicQuestion> a1PronounExtraQuestions = [
  A1BasicQuestion(
    type: 'multipleChoice',
    question: 'Complete: My parents are here. ___ are ready.',
    questionFa: 'جمله را کامل کن: والدینم اینجا هستند. ___ آماده هستند.',
    options: ['They', 'We', 'He', 'She'],
    answer: 'They',
    explanation: 'Use they for two or more people.',
    explanationFa: 'برای دو یا چند نفر از they استفاده می‌کنیم.',
  ),
  A1BasicQuestion(
    type: 'multipleChoice',
    question: 'Complete: My sister and I are happy. ___ are happy.',
    questionFa: 'جمله را کامل کن: من و خواهرم خوشحال هستیم. ___ خوشحال هستیم.',
    options: ['We', 'They', 'She', 'It'],
    answer: 'We',
    explanation: 'Use we when the speaker is included.',
    explanationFa: 'وقتی گوینده هم در گروه باشد، از we استفاده می‌کنیم.',
  ),
  A1BasicQuestion(
    type: 'multipleChoice',
    question: 'Complete: I have a phone. ___ is new.',
    questionFa: 'جمله را کامل کن: من یک گوشی دارم. ___ جدید است.',
    options: ['It', 'He', 'She', 'They'],
    answer: 'It',
    explanation: 'Use it for one thing.',
    explanationFa: 'برای یک چیز مفرد از it استفاده می‌کنیم.',
  ),
];
