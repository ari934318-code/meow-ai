import 'package:flutter/material.dart';

import '../app.dart';
import '../localization.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  String appLanguage = 'English';
  String accent = 'American';
  String personality = 'Funny';
  String voice = 'Female';
  String theme = 'System';

  int dailyGoal = 20;

  bool notifications = true;
  bool learningMemory = true;
  bool conversationHistory = true;
  bool savedEnglish = true;
  bool voiceData = false;

  @override
  void initState() {
    super.initState();

    appLanguage =
        appLocale.value.languageCode == 'fa' ? 'فارسی' : 'English';

    theme = _themeName(appThemeMode.value);
  }

  String _themeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${lang.settings} ⚙️',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
          children: [
            Text(
              lang.isPersian
                  ? 'تنظیمات برنامه'
                  : 'App Settings',
              style: const TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              lang.isPersian
                  ? 'Meow AI رو دقیقاً همون‌طور که دوست داری تنظیم کن 🐱'
                  : 'Customize Meow AI the way you like it 🐱',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            _sectionTitle(
              lang.isPersian ? 'عمومی' : 'General',
            ),

            _settingTile(
              context,
              icon: Icons.language_rounded,
              title: lang.appLanguage,
              subtitle: appLanguage,
              onTap: _chooseLanguage,
              color: lavender,
            ),

            _settingTile(
              context,
              icon: Icons.record_voice_over_rounded,
              title: lang.accent,
              subtitle: accent,
              onTap: _chooseAccent,
              color: const Color(0xFF5C8DDE),
            ),

            _settingTile(
              context,
              icon: Icons.pets_rounded,
              title: lang.personality,
              subtitle: personality,
              onTap: _choosePersonality,
              color: const Color(0xFF8C72D8),
            ),

            _settingTile(
              context,
              icon: Icons.mic_rounded,
              title: lang.voice,
              subtitle: voice,
              onTap: _chooseVoice,
              color: const Color(0xFFE477A8),
            ),

            const SizedBox(height: 22),

            _sectionTitle(
              lang.isPersian ? 'یادگیری' : 'Learning',
            ),

            _settingTile(
              context,
              icon: Icons.flag_rounded,
              title: lang.dailyGoal,
              subtitle: lang.minutes(dailyGoal),
              onTap: _chooseDailyGoal,
              color: const Color(0xFF4CAF50),
            ),

            _switchTile(
              context,
              icon: Icons.notifications_none_rounded,
              title: lang.notifications,
              subtitle: lang.dailyLearningReminders,
              value: notifications,
              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
            ),

            const SizedBox(height: 22),

            _sectionTitle(
              lang.memoryPrivacy,
            ),

            _switchTile(
              context,
              icon: Icons.psychology_outlined,
              title: lang.learningMemory,
              subtitle: lang.isPersian
                  ? 'اجازه بده میو روند یادگیریت رو به خاطر بسپره'
                  : 'Let Meow remember your learning progress',
              value: learningMemory,
              onChanged: (value) {
                setState(() {
                  learningMemory = value;
                });
              },
            ),

            _switchTile(
              context,
              icon: Icons.history_rounded,
              title: lang.conversationHistory,
              subtitle: lang.isPersian
                  ? 'گفتگوهای تو با میو ذخیره بشن'
                  : 'Keep your conversations with Meow',
              value: conversationHistory,
              onChanged: (value) {
                setState(() {
                  conversationHistory = value;
                });
              },
            ),

            _switchTile(
              context,
              icon: Icons.bookmark_outline_rounded,
              title: lang.savedEnglish,
              subtitle: lang.isPersian
                  ? 'کلمات و عبارت‌هایی که یاد می‌گیری ذخیره کن'
                  : 'Save words and phrases you learn',
              value: savedEnglish,
              onChanged: (value) {
                setState(() {
                  savedEnglish = value;
                });
              },
            ),

            _switchTile(
              context,
              icon: Icons.graphic_eq_rounded,
              title: lang.voiceData,
              subtitle: lang.isPersian
                  ? 'اجازه استفاده از داده صوتی برای یادگیری'
                  : 'Allow voice data to be used for learning',
              value: voiceData,
              onChanged: (value) {
                setState(() {
                  voiceData = value;
                });
              },
            ),

            const SizedBox(height: 22),

            _sectionTitle(
              lang.appearance,
            ),

            _settingTile(
              context,
              icon: Icons.brightness_6_outlined,
              title: lang.theme,
              subtitle: _localizedTheme(lang),
              onTap: _chooseTheme,
              color: lavender,
            ),

            const SizedBox(height: 22),

            _sectionTitle(
              lang.about,
            ),

            _settingTile(
              context,
              icon: Icons.info_outline_rounded,
              title: lang.aboutMeowAI,
              subtitle: lang.englishLearningWithMeow,
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Meow AI',
                  applicationVersion: '1.0.0',
                  applicationLegalese:
                      'Learn English with Meow 🐱',
                );
              },
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  String _localizedTheme(MeowLocalizations lang) {
    switch (theme) {
      case 'Light':
        return lang.light;
      case 'Dark':
        return lang.dark;
      default:
        return lang.system;
    }
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 2, 2, 11),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: lavender,
        ),
      ),
    );
  }

  Widget _settingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: color.withOpacity(0.13),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.11),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: color.withOpacity(0.75),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _switchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.withOpacity(0.13),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: lavender.withOpacity(0.11),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: lavender,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            activeThumbColor: lavender,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  void _chooseLanguage() {
    _showOptions(
      title: 'App Language',
      options: ['English', 'فارسی'],
      current: appLanguage,
      onSelected: (value) {
        setState(() {
          appLanguage = value;
        });

        if (value == 'فارسی') {
          appLocale.value = const Locale('fa');
        } else {
          appLocale.value = const Locale('en');
        }
      },
    );
  }

  void _chooseAccent() {
    _showOptions(
      title: 'Accent',
      options: ['American', 'British'],
      current: accent,
      onSelected: (value) {
        setState(() {
          accent = value;
        });
      },
    );
  }

  void _choosePersonality() {
    _showOptions(
      title: 'Meow Personality',
      options: ['Funny', 'Serious'],
      current: personality,
      onSelected: (value) {
        setState(() {
          personality = value;
        });
      },
    );
  }

  void _chooseVoice() {
    _showOptions(
      title: 'Voice',
      options: ['Female', 'Male'],
      current: voice,
      onSelected: (value) {
        setState(() {
          voice = value;
        });
      },
    );
  }

  void _chooseDailyGoal() {
    _showOptions(
      title: 'Daily Goal',
      options: ['10', '20', '30', '45'],
      current: dailyGoal.toString(),
      onSelected: (value) {
        setState(() {
          dailyGoal = int.parse(value);
        });
      },
    );
  }

  void _chooseTheme() {
    _showOptions(
      title: 'Theme',
      options: ['System', 'Light', 'Dark'],
      current: theme,
      onSelected: (value) {
        setState(() {
          theme = value;
        });

        if (value == 'Light') {
          appThemeMode.value = ThemeMode.light;
        } else if (value == 'Dark') {
          appThemeMode.value = ThemeMode.dark;
        } else {
          appThemeMode.value = ThemeMode.system;
        }
      },
    );
  }

  void _showOptions({
    required String title,
    required List<String> options,
    required String current,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 14),

                ...options.map(
                  (option) {
                    final selected = option == current;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        tileColor: selected
                            ? lavender.withOpacity(0.10)
                            : Theme.of(context)
                                .colorScheme
                                .surface,
                        title: Text(
                          option,
                          style: TextStyle(
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                        trailing: selected
                            ? const Icon(
                                Icons.check_rounded,
                                color: lavender,
                              )
                            : null,
                        onTap: () {
                          onSelected(option);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}