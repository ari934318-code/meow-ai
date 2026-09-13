import 'package:flutter/material.dart';
import '../app.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings ⚙️',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
        children: [
          _sectionTitle('General'),

          _settingTile(
            icon: Icons.language_rounded,
            title: 'App Language',
            subtitle: appLanguage,
            onTap: _chooseLanguage,
          ),

          _settingTile(
            icon: Icons.record_voice_over_rounded,
            title: 'Accent',
            subtitle: accent,
            onTap: _chooseAccent,
          ),

          _settingTile(
            icon: Icons.pets_rounded,
            title: 'Meow Personality',
            subtitle: personality,
            onTap: _choosePersonality,
          ),

          _settingTile(
            icon: Icons.mic_rounded,
            title: 'Voice',
            subtitle: voice,
            onTap: _chooseVoice,
          ),

          const SizedBox(height: 24),

          _sectionTitle('Learning'),

          _settingTile(
            icon: Icons.flag_rounded,
            title: 'Daily Goal',
            subtitle: '$dailyGoal minutes',
            onTap: _chooseDailyGoal,
          ),

          _switchTile(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            subtitle: 'Daily learning reminders',
            value: notifications,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),

          const SizedBox(height: 24),

          _sectionTitle('Memory & Privacy'),

          _switchTile(
            icon: Icons.psychology_outlined,
            title: 'Learning Memory',
            subtitle: 'Let Meow remember your learning progress',
            value: learningMemory,
            onChanged: (value) {
              setState(() {
                learningMemory = value;
              });
            },
          ),

          _switchTile(
            icon: Icons.history_rounded,
            title: 'Conversation History',
            subtitle: 'Keep your conversations with Meow',
            value: conversationHistory,
            onChanged: (value) {
              setState(() {
                conversationHistory = value;
              });
            },
          ),

          _switchTile(
            icon: Icons.bookmark_outline_rounded,
            title: 'Saved English',
            subtitle: 'Save words and phrases you learn',
            value: savedEnglish,
            onChanged: (value) {
              setState(() {
                savedEnglish = value;
              });
            },
          ),

          _switchTile(
            icon: Icons.graphic_eq_rounded,
            title: 'Voice Data',
            subtitle: 'Allow voice data to be used for learning',
            value: voiceData,
            onChanged: (value) {
              setState(() {
                voiceData = value;
              });
            },
          ),

          const SizedBox(height: 24),

          _sectionTitle('Appearance'),

          _settingTile(
            icon: Icons.brightness_6_outlined,
            title: 'Theme',
            subtitle: theme,
            onTap: _chooseTheme,
          ),

          const SizedBox(height: 24),

          _sectionTitle('About'),

          _settingTile(
            icon: Icons.info_outline_rounded,
            title: 'About Meow AI',
            subtitle: 'English learning with Meow',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Meow AI',
                applicationVersion: '1.0.0',
                applicationLegalese: 'Learn English with Meow 🐱',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 10),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: lavender.withOpacity(0.16),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: lavender,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(subtitle),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        secondary: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: lavender.withOpacity(0.16),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: lavender,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(subtitle),
        ),
        value: value,
        activeThumbColor: lavender,
        onChanged: onChanged,
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
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
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
                const SizedBox(height: 12),
                ...options.map(
                  (option) {
                    final selected = option == current;

                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      title: Text(option),
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