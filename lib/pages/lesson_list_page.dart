import 'package:flutter/material.dart';

import '../services/lesson_service.dart';
import 'lesson_page.dart';

class LessonListPage extends StatelessWidget {
  const LessonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = LessonService.a1Lessons;

    return Scaffold(
      appBar: AppBar(
        title: const Text('A1 Lessons 📚'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                lesson.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(lesson.description),
              ),
              trailing: Text(
                '+${lesson.xp} XP',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                if (lesson.id == 'a1_01') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LessonPage(),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
