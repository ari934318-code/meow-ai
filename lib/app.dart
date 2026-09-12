import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/learn_page.dart';
import 'pages/practice_page.dart';
import 'pages/meow_page.dart';
import 'pages/progress_page.dart';
import 'pages/profile_page.dart';
import 'pages/lesson_list_page.dart';

class MeowApp extends StatelessWidget {
  const MeowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meow AI',
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
      },
    );
  }
}
