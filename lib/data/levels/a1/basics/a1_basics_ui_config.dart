class A1BasicsUIConfig {
  A1BasicsUIConfig._();

  // =========================================================
  // LESSON FLOW
  // =========================================================

  // آموزش باید قبل از تمرین نمایش داده شود.
  static const bool teachBeforePractice = true;

  // مثال‌ها قبل از سؤال‌ها نمایش داده شوند.
  static const bool showExamplesBeforeQuestions = true;

  // بعد از پاسخ، نتیجه و توضیح نمایش داده شود.
  static const bool showFeedbackAfterAnswer = true;

  // ترتیب کلی هر مرحله:
  // Learn → Examples → Practice → Feedback → Next
  static const List<String> lessonFlow = [
    'learn',
    'examples',
    'practice',
    'feedback',
    'next',
  ];

  // =========================================================
  // STAGE LOCKS
  // =========================================================

  // مرحله‌ها به ترتیب باز شوند.
  static const bool lockStages = true;

  // برای باز شدن مرحله بعد، مرحله فعلی باید کامل شود.
  static const bool requireStageCompletion = true;

  // پاسخ اشتباه نباید کاربر را در مرحله گیر بیندازد.
  static const bool wrongAnswerBlocksProgress = false;

  // =========================================================
  // LESSON LOCKS
  // =========================================================

  // درس بعدی تا زمانی که درس قبلی کامل نشده باز نشود.
  static const bool lockNextLesson = true;

  // تکمیل درس قبلی شرط ورود به درس بعدی باشد.
  static const bool requirePreviousLessonCompletion = true;

  // =========================================================
  // ANSWER BEHAVIOR
  // =========================================================

  // بعد از جواب اشتباه، جواب صحیح نمایش داده شود.
  static const bool showCorrectAnswerAfterMistake = true;

  // کاربر بتواند سؤال را دوباره امتحان کند.
  static const bool allowRetry = true;

  // توضیح سؤال در صورت وجود نمایش داده شود.
  static const bool showQuestionExplanation = true;

  // =========================================================
  // SPEAKING
  // =========================================================

  // هر تلاش غیرخالی برای Speaking می‌تواند سؤال را کامل کند.
  static const bool speakingAttemptCountsAsComplete = true;

  // چیزی که Speech-to-Text تشخیص داده نمایش داده شود.
  static const bool showRecognizedText = true;

  // نتیجه Speaking نمایش داده شود.
  static const bool showSpeakingResult = true;

  // امکان تلاش مجدد برای Speaking وجود داشته باشد.
  static const bool allowSpeakingRetry = true;

  // =========================================================
  // AUDIO
  // =========================================================

  // دکمه تلفظ کنار کلمات و جمله‌ها نمایش داده شود.
  static const bool showPronunciationButton = true;

  // Text-to-Speech فعال باشد.
  static const bool enableTextToSpeech = true;

  // =========================================================
  // DESIGN
  // =========================================================

  // طراحی A1 Basics از طراحی استاندارد Lesson A1 پیروی می‌کند.
  static const bool followA1LessonDesign = true;

  // طراحی مینیمال و خلوت.
  static const bool minimalDesign = true;

  // از شلوغی بصری جلوگیری شود.
  static const bool avoidVisualClutter = true;

  // محتوای آموزشی داخل Card نمایش داده شود.
  static const bool useCards = true;

  // =========================================================
  // SPACING
  // =========================================================

  static const double pagePadding = 16;

  static const double sectionSpacing = 24;

  static const double cardSpacing = 12;

  // =========================================================
  // SHAPE
  // =========================================================

  static const double cardRadius = 12;

  static const double buttonRadius = 12;

  // =========================================================
  // PROGRESS
  // =========================================================

  // پیشرفت کاربر ذخیره شود.
  static const bool saveProgress = true;

  // کاربر بتواند از جایی که قبلاً متوقف شده ادامه دهد.
  static const bool allowResume = true;

  // =========================================================
  // THEME
  // =========================================================

  // رنگ‌ها عمداً اینجا تعریف نشده‌اند.
  //
  // A1 Basics باید از Theme اصلی برنامه استفاده کند:
  //
  // Theme.of(context).colorScheme.primary
  //
  // بنابراین Light / Dark و رنگ Lavender
  // از app.dart کنترل می‌شوند.
}