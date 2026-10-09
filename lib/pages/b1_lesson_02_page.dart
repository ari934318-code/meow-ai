import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/levels/b1/b1_lesson_02_data.dart';
import '../services/progress_service.dart';

class B1Lesson02Page extends StatefulWidget {
  const B1Lesson02Page({super.key});
  @override
  State<B1Lesson02Page> createState() => _B1Lesson02PageState();
}

class _B1Lesson02PageState extends State<B1Lesson02Page> {
  static const _progressKey = 'b1_lesson_progress_b1_lesson_02';
  static const _completedKey = 'b1_completed_lessons';
  final Map<int, String> _answers = {};
  final _typed = TextEditingController();
  bool _completed = false;
  bool _saved = false;

  String _normalize(String value) => value.toLowerCase()
      .replaceAll(RegExp(r'''[.,!?;:'"()]'''), '')
      .replaceAll(RegExp(r'\s+'), ' ').trim();

  @override
  void initState() { super.initState(); _restore(); }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_progressKey);
    if (raw != null) {
      for (final part in raw.split('|')) {
        final pieces = part.split(':');
        if (pieces.length == 2) {
          final index = int.tryParse(pieces[0]);
          if (index != null) _answers[index] = pieces[1];
        }
      }
    }
    if (!mounted) return;
    setState(() => _saved = true);
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = _answers.entries.map((e) => '${e.key}:${e.value}').join('|');
    await prefs.setString(_progressKey, raw);
  }

  bool get _allCorrect => B1Lesson02Data.examples.asMap().entries.every(
    (entry) => _answers[entry.key] == entry.value.answer,
  ) && B1Lesson02Data.acceptedTypedAnswers.any(
    (answer) => _normalize(answer) == _normalize(_typed.text),
  );

  Future<void> _finish() async {
    if (!_allCorrect) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Answer every question correctly, including the translation, to complete this lesson.'),
      ));
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList(_completedKey) ?? <String>[];
    if (!completed.contains(B1Lesson02Data.id)) {
      completed.add(B1Lesson02Data.id);
      await prefs.setStringList(_completedKey, completed);
      await ProgressService.addXp(50);
      await ProgressService.recordStudyDay();
    }
    if (!mounted) return;
    setState(() => _completed = true);
  }

  @override
  void dispose() { _typed.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (!_saved) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final doneCount = _answers.entries.where((e) =>
      B1Lesson02Data.examples[e.key].answer == e.value).length;
    return Scaffold(
      appBar: AppBar(title: const Text('B1 · Lesson 2')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text(B1Lesson02Data.titleEn, style: Theme.of(context).textTheme.headlineSmall),
        Text(B1Lesson02Data.titleFa),
        const SizedBox(height: 18),
        const Text('Vocabulary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...B1Lesson02Data.vocabulary.map((word) => Card(child: ListTile(
          title: Text(word.word), subtitle: Text('${word.meaningFa}\n${word.exampleEn}'),
          isThreeLine: true,
        ))),
        const SizedBox(height: 12),
        const Text('Grammar: making plans', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(B1Lesson02Data.grammarEn),
        Text(B1Lesson02Data.grammarFa),
        const SizedBox(height: 12),
        const Text('Choose the correct answer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...B1Lesson02Data.examples.asMap().entries.map((entry) {
          final i = entry.key; final q = entry.value;
          return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(q.prompt),
              ...q.options.map((option) => RadioListTile<String>(
                value: option, groupValue: _answers[i], title: Text(option),
                onChanged: (value) async { if (value == null) return; setState(() => _answers[i] = value); await _save(); },
              )),
              if (_answers.containsKey(i))
                Text(_answers[i] == q.answer ? 'Correct: ${q.explanationFa}' : 'Try again. ${q.explanationFa}',
                  style: TextStyle(color: _answers[i] == q.answer ? Colors.green : Colors.orange)),
            ],
          )));
        }),
        const SizedBox(height: 12),
        Text(B1Lesson02Data.typedPromptEn, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(B1Lesson02Data.typedPromptFa),
        TextField(controller: _typed, decoration: const InputDecoration(hintText: 'We are leaving...')),
        const SizedBox(height: 16),
        Text('Correct choices: $doneCount / ${B1Lesson02Data.examples.length}'),
        FilledButton(onPressed: _finish, child: Text(_completed ? 'Lesson completed ✓' : 'Check and complete lesson')),
      ]),
    );
  }
}
