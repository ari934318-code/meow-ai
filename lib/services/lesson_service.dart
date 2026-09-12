import '../models/lesson.dart';

class LessonService {
  static const List<Lesson> a1Lessons = [
    Lesson(
      id: 'a1_01',
      title: 'Greetings',
      level: 'A1',
      description: 'Learn how to say hello and introduce yourself.',
      xp: 20,
    ),
    Lesson(
      id: 'a1_02',
      title: 'Introducing Yourself',
      level: 'A1',
      description: 'Talk about your name, age and basic information.',
      xp: 25,
    ),
    Lesson(
      id: 'a1_03',
      title: 'Everyday Words',
      level: 'A1',
      description: 'Learn useful English words for daily life.',
      xp: 20,
    ),
    Lesson(
      id: 'a1_04',
      title: 'Simple Sentences',
      level: 'A1',
      description: 'Build your first simple English sentences.',
      xp: 30,
    ),
  ];
}
