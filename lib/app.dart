import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/learn_page.dart';
import 'pages/practice_page.dart';
import 'pages/meow_page.dart';
import 'pages/progress_page.dart';
import 'pages/profile_page.dart';
import 'pages/lesson_list_page.dart';
import 'pages/settings_page.dart';

final ValueNotifier<Locale> appLocale =
    ValueNotifier(const Locale('en'));

class MeowApp extends StatelessWidget {
  const MeowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, locale, child) {
        final isPersian = locale.languageCode == 'fa';

        return Directionality(
          textDirection:
              isPersian ? TextDirection.rtl : TextDirection.ltr,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Meow AI',

            locale: locale,

            supportedLocales: const [
              Locale('en'),
              Locale('fa'),
            ],

            localizationsDelegates: const [
              MeowLocalizationsDelegate(),
            ],

            theme: ThemeData(
              brightness: Brightness.dark,
              useMaterial3: true,
            ),

            home: const HomePage(),

            routes: {
              '/a1-lessons': (_) => const LessonListPage(),
              '/learn': (_) => const LearnPage(),
              '/practice': (_) => const PracticePage(),
              '/meow': (_) => const MeowPage(),
              '/progress': (_) => const ProgressPage(),
              '/profile': (_) => const ProfilePage(),
              '/settings': (_) => const SettingsPage(),
            },
          ),
        );
      },
    );
  }
}

class MeowLocalizations {
  final Locale locale;

  const MeowLocalizations(this.locale);

  static MeowLocalizations of(BuildContext context) {
    return Localizations.of<MeowLocalizations>(
          context,
          MeowLocalizations,
        ) ??
        const MeowLocalizations(Locale('en'));
  }

  bool get isPersian => locale.languageCode == 'fa';

  String get home => isPersian ? 'خانه' : 'Home';

  String get learn => isPersian ? 'یادگیری' : 'Learn';

  String get practice => isPersian ? 'تمرین' : 'Practice';

  String get meow => isPersian ? 'میو' : 'Meow';

  String get progress => isPersian ? 'پیشرفت' : 'Progress';

  String get profile => isPersian ? 'پروفایل' : 'Profile';

  String get settings => isPersian ? 'تنظیمات' : 'Settings';

  String get appLanguage =>
      isPersian ? 'زبان برنامه' : 'App Language';

  String get english => 'English';

  String get persian => 'فارسی';
}

class MeowLocalizationsDelegate
    extends LocalizationsDelegate<MeowLocalizations> {
  const MeowLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'en' ||
        locale.languageCode == 'fa';
  }

  @override
  Future<MeowLocalizations> load(Locale locale) async {
    return MeowLocalizations(locale);
  }

  @override
  bool shouldReload(MeowLocalizationsDelegate old) {
    return false;
  }
}