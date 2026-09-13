import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/learn_page.dart';
import 'pages/lesson_list_page.dart';
import 'pages/lesson_page.dart';
import 'pages/meow_page.dart';
import 'pages/practice_page.dart';
import 'pages/profile_page.dart';
import 'pages/progress_page.dart';
import 'pages/settings_page.dart';

final ValueNotifier<ThemeMode> appThemeMode =
    ValueNotifier<ThemeMode>(ThemeMode.system);

class MeowApp extends StatelessWidget {
  const MeowApp({super.key});

  static const Color lavender = Color(0xFF9B7EDE);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meow AI',

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

          initialRoute: '/home',

          routes: {
            '/home': (context) => const HomePage(),
            '/learn': (context) => const LearnPage(),
            '/a1-lessons': (context) => const LessonListPage(),
            '/lesson': (context) => const LessonPage(),
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