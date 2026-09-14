class A1BasicsUIConfig {
  A1BasicsUIConfig._();

  // =========================
  // LESSON FLOW
  // =========================

  static const bool teachBeforePractice = true;
  static const bool showExamplesBeforeQuestions = true;
  static const bool showFeedbackAfterAnswer = true;

  // =========================
  // LOCKS
  // =========================

  static const bool lockStages = true;
  static const bool requireStageCompletion = true;
  static const bool lockNextLesson = true;
  static const bool requirePreviousLessonCompletion = true;

  // =========================
  // ANSWERS
  // =========================

  static const bool wrongAnswerBlocksProgress = false;
  static const bool showCorrectAnswerAfterMistake = true;
  static const bool allowRetry = true;

  // =========================
  // SPEAKING
  // =========================

  static const bool speakingAttemptCountsAsComplete = true;
  static const bool showRecognizedText = true;
  static const bool showSpeakingResult = true;

  // =========================
  // DESIGN
  // =========================

  static const double pagePadding = 16;
  static const double sectionSpacing = 24;
  static const double cardSpacing = 12;
  static const double cardRadius = 12;
  static const double buttonRadius = 12;

  static const bool useCards = true;
  static const bool minimalDesign = true;
  static const bool avoidVisualClutter = true;

  // =========================
  // AUDIO
  // =========================

  static const bool showPronunciationButton = true;
  static const bool enableTextToSpeech = true;
}