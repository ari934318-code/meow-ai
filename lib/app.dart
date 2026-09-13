import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/learn_page.dart';
import 'pages/practice_page.dart';
import 'pages/meow_page.dart';
import 'pages/progress_page.dart';
import 'pages/profile_page.dart';
import 'pages/lesson_list_page.dart';
import 'pages/settings_page.dart';

class MeowApp extends StatefulWidget {
  const MeowApp({super.key});

  @override
  State<MeowApp> createState() => _MeowAppState();
}

class _MeowAppState extends State<MeowApp> {
  Locale _locale = const Locale('en');

  void changeLanguage(String language) {
    setState(() {
      _locale = Locale(language);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meow AI',
      locale: _locale,
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

  String get home {
    return isPersian ? 'خانه' : 'Home';
  }

  String get learn {
    return isPersian ? 'یادگیری' : 'Learn';
  }

  String get practice {
    return isPersian ? 'تمرین' : 'Practice';
  }

  String get meow {
    return isPersian ? 'میو' : 'Meow';
  }

  String get progress {
    return isPersian ? 'پیشرفت' : 'Progress';
  }

  String get profile {
    return isPersian ? 'پروفایل' : 'Profile';
  }

  String get settings {
    return isPersian ? 'تنظیمات' : 'Settings';
  }

  String get appLanguage {
    return isPersian ? 'زبان برنامه' : 'App Language';
  }

  String get english {
    return 'English';
  }

  String get persian {
    return 'فارسی';
  }
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