import 'package:flutter/material.dart';

import '../localization.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color lavender = Color(0xFFB9A7E8);

  String name = '';
  String age = '';
  String gender = 'female';
  String level = 'A1';

  void _editName(BuildContext context, MeowLocalizations lang) {
    final controller = TextEditingController(text: name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            lang.isPersian ? 'اسمت رو وارد کن' : 'Enter your name',
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: lang.isPersian ? 'مثلاً سارا' : 'e.g. Sara',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                lang.isPersian ? 'لغو' : 'Cancel',
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: lavender,
              ),
              onPressed: () {
                setState(() {
                  name = controller.text.trim();
                });
                Navigator.pop(context);
              },
              child: Text(
                lang.isPersian ? 'ذخیره' : 'Save',
              ),
            ),
          ],
        );
      },
    );
  }

  void _editAge(BuildContext context, MeowLocalizations lang) {
    final controller = TextEditingController(text: age);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            lang.isPersian ? 'سنت رو وارد کن' : 'Enter your age',
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: lang.isPersian ? 'مثلاً 20' : 'e.g. 20',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                lang.isPersian ? 'لغو' : 'Cancel',
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: lavender,
              ),
              onPressed: () {
                setState(() {
                  age = controller.text.trim();
                });
                Navigator.pop(context);
              },
              child: Text(
                lang.isPersian ? 'ذخیره' : 'Save',
              ),
            ),
          ],
        );
      },
    );
  }

  void _selectGender(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lang.isPersian
                      ? 'جنسیت رو انتخاب کن'
                      : 'Select your gender',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                _optionTile(
                  context,
                  icon: Icons.female_rounded,
                  title: lang.isPersian ? 'خانم' : 'Female',
                  selected: gender == 'female',
                  onTap: () {
                    setState(() {
                      gender = 'female';
                    });
                    Navigator.pop(context);
                  },
                ),
                _optionTile(
                  context,
                  icon: Icons.male_rounded,
                  title: lang.isPersian ? 'آقا' : 'Male',
                  selected: gender == 'male',
                  onTap: () {
                    setState(() {
                      gender = 'male';
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectLevel(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    const levels = [
      'A1',
      'A2',
      'B1',
      'B2',
      'C1',
      'C2',
    ];

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lang.isPersian
                      ? 'سطح انگلیسیت رو انتخاب کن'
                      : 'Choose your English level',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                ...levels.map(
                  (item) => _optionTile(
                    context,
                    icon: item == level
                        ? Icons.check_circle_rounded
                        : Icons.circle_outlined,
                    title: _levelName(item, lang),
                    selected: level == item,
                    onTap: () {
                      setState(() {
                        level = item;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _levelName(
    String value,
    MeowLocalizations lang,
  ) {
    if (!lang.isPersian) {
      switch (value) {
        case 'A1':
          return 'A1 • Beginner';
        case 'A2':
          return 'A2 • Elementary';
        case 'B1':
          return 'B1 • Intermediate';
        case 'B2':
          return 'B2 • Upper-Intermediate';
        case 'C1':
          return 'C1 • Advanced';
        case 'C2':
          return 'C2 • Proficiency';
      }
    }

    switch (value) {
      case 'A1':
        return 'A1 • مبتدی';
      case 'A2':
        return 'A2 • مقدماتی';
      case 'B1':
        return 'B1 • متوسط';
      case 'B2':
        return 'B2 • متوسط رو به بالا';
      case 'C1':
        return 'C1 • پیشرفته';
      case 'C2':
        return 'C2 • تسلط کامل';
      default:
        return value;
    }
  }

  String _genderName(MeowLocalizations lang) {
    if (lang.isPersian) {
      return gender == 'female' ? 'خانم' : 'آقا';
    }

    return gender == 'female' ? 'Female' : 'Male';
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    final displayName = name.isEmpty
        ? (lang.isPersian ? 'اسم خودت رو اضافه کن' : 'Add your name')
        : name;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${lang.profile} 👤',
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
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: lavender.withOpacity(0.10),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: lavender.withOpacity(0.15),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 94,
                        height: 94,
                        decoration: BoxDecoration(
                          color: lavender.withOpacity(0.16),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          gender == 'female'
                              ? Icons.face_3_rounded
                              : Icons.face_rounded,
                          size: 52,
                          color: lavender,
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: lavender.withOpacity(0.18),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit_rounded,
                          size: 16,
                          color: lavender,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Text(
                    displayName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: name.isEmpty
                          ? Colors.grey
                          : Theme.of(context)
                              .colorScheme
                              .onSurface,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    _levelName(level, lang),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              lang.isPersian
                  ? 'اطلاعات شخصی'
                  : 'Personal Information',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            _profileCard(
              context,
              icon: Icons.person_outline_rounded,
              title: lang.isPersian ? 'نام' : 'Name',
              value: name.isEmpty
                  ? (lang.isPersian ? 'اضافه نشده' : 'Not set')
                  : name,
              onTap: () => _editName(context, lang),
              color: lavender,
            ),

            _profileCard(
              context,
              icon: Icons.cake_outlined,
              title: lang.isPersian ? 'سن' : 'Age',
              value: age.isEmpty
                  ? (lang.isPersian ? 'اضافه نشده' : 'Not set')
                  : age,
              onTap: () => _editAge(context, lang),
              color: const Color(0xFFE477A8),
            ),

            _profileCard(
              context,
              icon: gender == 'female'
                  ? Icons.female_rounded
                  : Icons.male_rounded,
              title: lang.isPersian ? 'جنسیت' : 'Gender',
              value: _genderName(lang),
              onTap: () => _selectGender(context, lang),
              color: const Color(0xFF8C72D8),
            ),

            const SizedBox(height: 10),

            Text(
              lang.isPersian
                  ? 'یادگیری'
                  : 'Learning',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            _profileCard(
              context,
              icon: Icons.language_rounded,
              title: lang.englishLevel,
              value: _levelName(level, lang),
              onTap: () => _selectLevel(context, lang),
              color: const Color(0xFF4CAF50),
            ),

            _profileCard(
              context,
              icon: Icons.volume_up_rounded,
              title: lang.voice,
              value: lang.defaultVoice,
              onTap: () {},
              color: const Color(0xFF5C8DDE),
            ),

            const SizedBox(height: 10),

            _profileCard(
              context,
              icon: Icons.settings_rounded,
              title: lang.settings,
              value: lang.isPersian
                  ? 'تنظیمات برنامه'
                  : 'App settings',
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
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
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
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

  Widget _optionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        tileColor: selected
            ? lavender.withOpacity(0.10)
            : Theme.of(context).colorScheme.surface,
        leading: Icon(
          icon,
          color: selected ? lavender : Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight:
                selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        trailing: selected
            ? const Icon(
                Icons.check_rounded,
                color: lavender,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}