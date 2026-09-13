import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'localization.dart';

import 'pages/home_page.dart';
import 'pages/learn_page.dart';
import 'pages/lesson_list_page.dart';
import 'pages/meow_page.dart';
import 'pages/practice_page.dart';
import 'pages/profile_page.dart';
import 'pages/progress_page.dart';
import 'pages/settings_page.dart';

final ValueNotifier<ThemeMode> appThemeMode =
    ValueNotifier<ThemeMode>(ThemeMode.system);

final ValueNotifier<Locale> appLocale =
    ValueNotifier<Locale>(const Locale('en'));

class MeowApp extends StatelessWidget {
  const MeowApp({super.key});

  static const Color lavender = Color(0xFF9B7EDE);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder2<ThemeMode, Locale>(
      first: appThemeMode,
      second: appLocale,
      builder: (context, currentTheme, currentLocale, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meow AI',
          locale: currentLocale,
          supportedLocales: const [
            Locale('en'),
            Locale('fa'),
          ],
          localizationsDelegates: const [
            MeowLocalizationsDelegate(),
          ],
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: lavender,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: lavender,
              brightness: Brightness.light,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: lavender,
            colorScheme: ColorScheme.fromSeed(
              seedColor: lavender,
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
          ),
          themeMode: currentTheme,
          builder: (context, child) {
            final isPersian = currentLocale.languageCode == 'fa';

            return Directionality(
              textDirection:
                  isPersian ? TextDirection.rtl : TextDirection.ltr,
              child: child ?? const SizedBox(),
            );
          },
          initialRoute: '/home',
          routes: {
            '/home': (context) => const HomePage(),
            '/learn': (context) => const LearnPage(),
            '/a1-lessons': (context) => const LessonListPage(),
            '/practice': (context) => const PracticePage(),
            '/meow': (context) => const MeowPage(),
            '/profile': (context) => const ProfilePage(),
            '/progress': (context) => const ProgressPage(),
            '/settings': (context) => const SettingsPage(),
          },
        );
      },
    );
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

class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    super.key,
    required this.first,
    required this.second,
    required this.builder,
  });

  final ValueListenable<A> first;
  final ValueListenable<B> second;

  final Widget Function(
    BuildContext context,
    A firstValue,
    B secondValue,
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (context, firstValue, child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, secondValue, child) {
            return builder(
              context,
              firstValue,
              secondValue,
              child,
            );
          },
        );
      },
    );
  }
}