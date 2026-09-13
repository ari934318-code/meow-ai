import 'package:flutter/material.dart';
import '../app.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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

  static const lavender = Color(0xFFB9A7E8);

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);
    final isPersian = lang.isPersian;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _sectionTitle(
            isPersian ? 'عمومی' : 'General',
          ),

          _settingCard(
            icon: Icons.language,
            title: lang.appLanguage,
            subtitle: isPersian ? 'فارسی' : 'English',
            onTap: _chooseLanguage,
          ),

          _settingCard(
            icon: Icons.public,
            title: isPersian ? 'لهجه' : 'Accent',
            subtitle: accent,
            onTap: _chooseAccent,
          ),

          _settingCard(
            icon: Icons.psychology,
            title: isPersian ? 'شخصیت میو' : 'Meow Personality',
            subtitle: personality,
            onTap: _choosePersonality,
          ),

          _settingCard(
            icon: Icons.record_voice_over,
            title: isPersian ? 'صدا' : 'Voice',
            subtitle: voice,
            onTap: _chooseVoice,
          ),

          _sectionTitle(
            isPersian ? 'یادگیری' : 'Learning',
          ),

          _settingCard(
            icon: Icons.flag,
            title: isPersian ? 'هدف روزانه' : 'Daily Goal',
            subtitle: '$dailyGoal ${isPersian ? 'دقیقه' : 'minutes'}',
            onTap: _chooseDailyGoal,
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.notifications_outlined),
            title: Text(
              isPersian ? 'اعلان‌ها' : 'Notifications',
            ),
            subtitle: Text(
              isPersian
                  ? 'یادآوری برای تمرین روزانه'
                  : 'Daily learning reminders',
            ),
            value: notifications,
            activeColor: lavender,
            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),

          _sectionTitle(
            isPersian ? 'حافظه و حریم خصوصی' : 'Memory & Privacy',
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.memory),
            title: Text(
              isPersian ? 'حافظه یادگیری' : 'Learning Memory',
            ),
            subtitle: Text(
              isPersian
                  ? 'میو چیزهایی که درباره انگلیسی تو یاد می‌گیرد ذخیره می‌کند'
                  : 'Meow remembers things about your English',
            ),
            value: learningMemory,
            activeColor: lavender,
            onChanged: (value) {
              setState(() {
                learningMemory = value;
              });
            },
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.chat_bubble_outline),
            title: Text(
              isPersian ? 'تاریخچه مکالمات' : 'Conversation History',
            ),
            value: conversationHistory,
            activeColor: lavender,
            onChanged: (value) {
              setState(() {
                conversationHistory = value;
              });
            },
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.bookmark_outline),
            title: Text(
              isPersian ? 'انگلیسی‌های ذخیره‌شده' : 'Saved English',
            ),
            value: savedEnglish,
            activeColor: lavender,
            onChanged: (value) {
              setState(() {
                savedEnglish = value;
              });
            },
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.mic_none),
            title: Text(
              isPersian ? 'داده‌های صوتی' : 'Voice Data',
            ),
            subtitle: Text(
              isPersian
                  ? 'ذخیره‌سازی صدای تمرین‌ها'
                  : 'Store voice practice data',
            ),
            value: voiceData,
            activeColor: lavender,
            onChanged: (value) {
              setState(() {
                voiceData = value;
              });
            },
          ),

          _sectionTitle(
            isPersian ? 'ظاهر' : 'Appearance',
          ),

          _settingCard(
            icon: Icons.brightness_6_outlined,
            title: isPersian ? 'تم' : 'Theme',
            subtitle: theme,
            onTap: _chooseTheme,
          ),

          const SizedBox(height: 30),

          Text(
            'Meow AI',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _settingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  void _chooseLanguage() {
    final current = appLocale.value.languageCode;

    _showOptions(
      title: 'App Language',
      options: const [
        'English',
        'فارسی',
      ],
      selected: current == 'fa' ? 'فارسی' : 'English',
      onSelected: (value) {
        appLocale.value = value == 'فارسی'
            ? const Locale('fa')
            : const Locale('en');
      },
    );
  }

  void _chooseAccent() {
    _showOptions(
      title: 'Accent',
      options: const [
        'American',
        'British',
      ],
      selected: accent,
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
      options: const [
        'Funny',
        'Serious',
      ],
      selected: personality,
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
      options: const [
        'Female',
        'Male',
      ],
      selected: voice,
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
      options: const [
        '10',
        '20',
        '30',
        '45',
      ],
      selected: '$dailyGoal',
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
      options: const [
        'System',
        'Light',
        'Dark',
      ],
      selected: theme,
      onSelected: (value) {
        setState(() {
          theme = value;
        });
      },
    );
  }

  void _showOptions({
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ...options.map(
                (option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selected,
                  activeColor: lavender,
                  onChanged: (value) {
                    if (value == null) return;

                    onSelected(value);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}