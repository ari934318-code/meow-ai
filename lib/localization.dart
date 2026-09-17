import 'package:flutter/material.dart';

class MeowLocalizations {
  final Locale locale;

  MeowLocalizations(this.locale);

  static Locale? _currentLocale;

  static bool get isPersianGlobal =>
      _currentLocale?.languageCode == 'fa';

  bool get isPersian => locale.languageCode == 'fa';

  static MeowLocalizations of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    _currentLocale = locale;
    return MeowLocalizations(locale);
  }

  String get home => isPersian ? 'خانه' : 'Home';
  String get learn => isPersian ? 'یادگیری' : 'Learn';
  String get practice => isPersian ? 'تمرین' : 'Practice';
  String get progress => isPersian ? 'پیشرفت' : 'Progress';
  String get meow => isPersian ? 'میو زنده' : 'Live Meow';
  String get profile => isPersian ? 'پروفایل' : 'Profile';
  String get settings => isPersian ? 'تنظیمات' : 'Settings';

  String get appLanguage =>
      isPersian ? 'زبان برنامه' : 'App Language';

  String get english => 'English';
  String get persian => 'فارسی';

  String get accent => isPersian ? 'لهجه' : 'Accent';
  String get american => isPersian ? 'آمریکایی' : 'American';
  String get british => isPersian ? 'بریتانیایی' : 'British';

  String get personality =>
      isPersian ? 'شخصیت میو' : 'Meow Personality';

  String get funny => isPersian ? 'بامزه' : 'Funny';
  String get serious => isPersian ? 'جدی' : 'Serious';

  String get voice => isPersian ? 'صدا' : 'Voice';
  String get female => isPersian ? 'زن' : 'Female';
  String get male => isPersian ? 'مرد' : 'Male';

  String get learning => isPersian ? 'یادگیری' : 'Learning';

  String get dailyGoal =>
      isPersian ? 'هدف روزانه' : 'Daily Goal';

  String minutes(int value) {
    return isPersian ? '$value دقیقه' : '$value minutes';
  }

  String get notifications =>
      isPersian ? 'اعلان‌ها' : 'Notifications';

  String get dailyLearningReminders =>
      isPersian
          ? 'یادآوری روزانه یادگیری'
          : 'Daily learning reminders';

  String get memoryPrivacy =>
      isPersian ? 'حافظه و حریم خصوصی' : 'Memory & Privacy';

  String get learningMemory =>
      isPersian ? 'حافظه یادگیری' : 'Learning Memory';

  String get conversationHistory =>
      isPersian ? 'تاریخچه گفتگو' : 'Conversation History';

  String get savedEnglish =>
      isPersian ? 'انگلیسی‌های ذخیره‌شده' : 'Saved English';

  String get voiceData =>
      isPersian ? 'داده‌های صوتی' : 'Voice Data';

  String get appearance =>
      isPersian ? 'ظاهر' : 'Appearance';

  String get theme =>
      isPersian ? 'تم' : 'Theme';

  String get system =>
      isPersian ? 'سیستم' : 'System';

  String get light =>
      isPersian ? 'روشن' : 'Light';

  String get dark =>
      isPersian ? 'تیره' : 'Dark';

  String get about =>
      isPersian ? 'درباره' : 'About';

  String get aboutMeowAI =>
      isPersian ? 'درباره Meow AI' : 'About Meow AI';

  String get englishLearningWithMeow =>
      isPersian
          ? 'یادگیری انگلیسی با میو'
          : 'English learning with Meow';

  String get englishLevel =>
      isPersian ? 'سطح زبان انگلیسی' : 'English Level';

  String get beginner =>
      isPersian ? 'مبتدی' : 'Beginner';

  String get defaultVoice =>
      isPersian ? 'پیش‌فرض' : 'Default';
}
