import 'package:flutter/material.dart';

class A1BasicsUI {
  A1BasicsUI._();

  // =========================
  // COLORS
  // =========================

  static const Color primary = Color(0xFF9B7EDE);
  static const Color primaryDark = Color(0xFF7D5FC4);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);

  // =========================
  // RADIUS
  // =========================

  static const double cardRadius = 20;
  static const double buttonRadius = 16;
  static const double optionRadius = 16;

  // =========================
  // SPACING
  // =========================

  static const double pagePadding = 20;
  static const double sectionSpacing = 24;
  static const double itemSpacing = 12;

  // =========================
  // QUESTION TYPES
  // =========================

  static const String multipleChoice = 'multiple_choice';
  static const String fillBlank = 'fill_blank';
  static const String trueFalse = 'true_false';
  static const String wordOrder = 'word_order';
  static const String translation = 'translation';
  static const String correctSentence = 'correct_sentence';
  static const String speaking = 'speaking';

  // =========================
  // LESSON FLOW
  // =========================

  static const List<String> lessonFlow = [
    'learn',
    'examples',
    'practice',
    'feedback',
    'next',
  ];

  // =========================
  // RULES
  // =========================

  /// در Lesson پاسخ غلط باعث قفل شدن کاربر نمی‌شود.
  static const bool wrongAnswerStillCompletes = true;

  /// پاسخ غلط باید جواب صحیح و توضیح را نشان دهد.
  static const bool showCorrectAnswerAfterMistake = true;

  /// Speaking با هر تلاش غیرخالی تکمیل می‌شود.
  static const bool speakingAttemptCountsAsCompleted = true;

  /// Exam قوانین جداگانه و سخت‌گیرانه خودش را دارد.
  static const bool examUsesStrictScoring = true;

  // =========================
  // TEXT
  // =========================

  static const String learnTitle = 'Learn';
  static const String learnTitleFa = 'یاد بگیر';

  static const String examplesTitle = 'Examples';
  static const String examplesTitleFa = 'مثال‌ها';

  static const String practiceTitle = 'Practice';
  static const String practiceTitleFa = 'تمرین';

  static const String feedbackTitle = 'Feedback';
  static const String feedbackTitleFa = 'بازخورد';

  static const String nextTitle = 'Next';
  static const String nextTitleFa = 'مرحله بعد';

  static const String correctFeedback =
      'Correct! 😼💜';

  static const String wrongFeedback =
      'اشکالی نداره 😼';

  static const String speakingSuccess =
      'آفرین! پاسخ قابل قبول بود. 😼💜';

  static const String speakingAttemptSaved =
      'تلاش ثبت شد. پاسخ پیشنهادی را ببین. 😼';

  // =========================
  // QUESTION BEHAVIOR
  // =========================

  static const bool disableQuestionAfterFirstAnswer = true;

  static const bool showExplanationAfterAnswer = true;

  static const bool allowRetryAfterEmptySpeaking = true;

  // =========================
  // DESIGN PRINCIPLES
  // =========================

  static const bool minimalDesign = true;
  static const bool avoidVisualClutter = true;
  static const bool useRealLifeEnglish = true;
  static const bool teachBeforeTesting = true;
}