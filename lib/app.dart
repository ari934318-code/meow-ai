import 'package:flutter/material.dart';

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
      },
    );
  }
}