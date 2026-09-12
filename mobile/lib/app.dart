import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

class MeowApp extends StatelessWidget {
  const MeowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meow AI',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('fa')],
      home: const Scaffold(
        body: Center(child: Text('Meow AI - Foundation')),
      ),
    );
  }
}
