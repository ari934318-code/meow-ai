import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization.dart';

import 'pages/home_page.dart';
import 'pages/learn_page.dart';
import 'pages/lesson_list_page.dart';
import 'pages/meow_page.dart';
import 'pages/practice_page.dart';
import 'pages/profile_page.dart';
import 'pages/progress_page.dart';
import 'pages/settings_page.dart';
import 'pages/a1_exam_page.dart';

import 'screens/onboarding/welcome_page.dart';
import 'screens/onboarding/placement_intro_page.dart';
import 'screens/onboarding/placement_test_page.dart';
import 'screens/onboarding/placement_result_page.dart';
import 'screens/onboarding/study_tip_page.dart';

final ValueNotifier<ThemeMode> appThemeMode =
    ValueNotifier<ThemeMode>(ThemeMode.system);

final ValueNotifier<Locale> appLocale =
    ValueNotifier<Locale>(const Locale('fa'));

class MeowApp extends StatefulWidget {
  const MeowApp({super.key});

  @override
  State<MeowApp> createState() => _MeowAppState();
}

class _MeowAppState extends State<MeowApp> {
  static const Color lavender = Color(0xFF9B7EDE);

  static const String _onboardingCompletedKey =
      'meow_onboarding_completed';

  static const String _selectedLevelKey =
      'meow_selected_level';

  bool _isLoading = true;
  bool _onboardingCompleted = false;

  String _selectedLevel = 'A1';

  @override
  void initState() {
    super.initState();
    _loadAppState();
  }

  Future<void> _loadAppState() async {
    final prefs = await SharedPreferences.getInstance();

    final completed =
        prefs.getBool(_onboardingCompletedKey) ?? false;

    final savedLevel =
        prefs.getString(_selectedLevelKey) ?? 'A1';

    if (!mounted) {
      return;
    }

    setState(() {
      _onboardingCompleted = completed;
      _selectedLevel = savedLevel;
      _isLoading = false;
    });
  }

  Future<void> _finishOnboarding(
    String level,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      _onboardingCompletedKey,
      true,
    );

    await prefs.setString(
      _selectedLevelKey,
      level,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _onboardingCompleted = true;
      _selectedLevel = level;
    });
  }

  Future<void> _saveSelectedLevel(
    String level,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _selectedLevelKey,
      level,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _selectedLevel = level;
    });
  }

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (route) => false,
    );
  }

  void _openStudyTip(
    BuildContext context,
    String level,
  ) {
    _saveSelectedLevel(level);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StudyTipPage(
          isPersian:
              appLocale.value.languageCode == 'fa',
          onContinue: () async {
            await _finishOnboarding(level);

            if (!context.mounted) {
              return;
            }

            _goToHome(context);
          },
        ),
      ),
    );
  }

  void _openPlacementTest(
    BuildContext context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlacementTestPage(
          isPersian:
              appLocale.value.languageCode == 'fa',
          onFinished: (level) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PlacementResultPage(
                  isPersian:
                      appLocale.value.languageCode == 'fa',
                  level: level,
                  onContinue: () {
                    _openStudyTip(
                      context,
                      level,
                    );
                  },
                  onStartFromA1: () {
                    _openStudyTip(
                      context,
                      'A1',
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openPlacementIntro(
    BuildContext context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlacementIntroPage(
          isPersian:
              appLocale.value.languageCode == 'fa',
          onStart: () {
            Navigator.of(context).pop();

            _openPlacementTest(context);
          },
        ),
      ),
    );
  }

  void _openWelcome(
    BuildContext context,
  ) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => WelcomePage(
          isPersian:
              appLocale.value.languageCode == 'fa',
          onPlacementTest: () {
            _openPlacementIntro(context);
          },
          onStartFromA1: () {
            _openStudyTip(
              context,
              'A1',
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meow AI',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: lavender,
          colorScheme: ColorScheme.fromSeed(
            seedColor: lavender,
          ),
        ),
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return ValueListenableBuilder2<ThemeMode, Locale>(
      first: appThemeMode,
      second: appLocale,
      builder: (
        context,
        currentTheme,
        currentLocale,
        child,
      ) {
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
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
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
            final isPersian =
                currentLocale.languageCode == 'fa';

            return Directionality(
              textDirection: isPersian
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: child ?? const SizedBox(),
            );
          },

          initialRoute: _onboardingCompleted
              ? '/home'
              : '/welcome',

          routes: {
            '/welcome': (context) {
              return WelcomePage(
                isPersian:
                    currentLocale.languageCode == 'fa',

                onPlacementTest: () {
                  _openPlacementIntro(context);
                },

                onStartFromA1: () {
                  _openStudyTip(
                    context,
                    'A1',
                  );
                },
              );
            },

            '/home': (context) =>
                const HomePage(),

            '/learn': (context) =>
                const LearnPage(),

            '/a1-lessons': (context) =>
                const LessonListPage(),

            '/a1-exam': (context) =>
                const A1ExamPage(),

            '/practice': (context) =>
                const PracticePage(),

            '/meow': (context) =>
                const MeowPage(),

            '/profile': (context) =>
                const ProfilePage(),

            '/progress': (context) =>
                const ProgressPage(),

            '/settings': (context) =>
                const SettingsPage(),
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
  bool shouldReload(
    MeowLocalizationsDelegate old,
  ) {
    return false;
  }
}

class ValueListenableBuilder2<A, B>
    extends StatelessWidget {
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
      builder: (
        context,
        firstValue,
        child,
      ) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (
            context,
            secondValue,
            child,
          ) {
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