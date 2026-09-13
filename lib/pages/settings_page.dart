import 'package:flutter/material.dart';

class MeowApp extends StatefulWidget {
  const MeowApp({super.key});

  @override
  State<MeowApp> createState() => _MeowAppState();
}

class _MeowAppState extends State<MeowApp> {
  static const Color lavender = Color(0xFF9B7EDE);

  ThemeMode themeMode = ThemeMode.system;

  void changeTheme(String theme) {
    setState(() {
      switch (theme) {
        case 'Light':
          themeMode = ThemeMode.light;
          break;

        case 'Dark':
          themeMode = ThemeMode.dark;
          break;

        default:
          themeMode = ThemeMode.system;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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

      themeMode: themeMode,

      home: const Scaffold(
        body: Center(
          child: Text(
            'Meow AI',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}