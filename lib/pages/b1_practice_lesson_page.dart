import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/levels/b1/b1_practice_lessons_data.dart';
import '../services/progress_service.dart';

/// Reusable, data-driven player for B1 lessons 3–6.
class B1PracticeLessonPage extends StatefulWidget {
  final String lessonId;
  const B1PracticeLessonPage({super.key, required this.lessonId});

  @override
  State<B1PracticeLessonPage> createState() => _B1PracticeLessonPageState();
}

class _B1PracticeLessonPageState extends State<B1PracticeLessonPage> {
  static const _completedKey = 'b1_completed_lessons';
  final Map<int, String> _answers = {};
  final TextEditingController _translation = TextEditingController();
  bool _loaded = false;
  bool _completed = false;

  B1PracticeLessonData get _lesson => b1PracticeLessons[widget.lessonId]!;

  String get _progressKey => 'b1_lesson_progress_${widget.lessonId}';
  String get _translationKey => '${widget.lessonId}_typed_answer';

  String _normalize(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'''[.,!?;:'"()\[\]{}]'''), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  bool get _translationCorrect => _lesson.acceptedTranslations.any(
        (answer) => _normalize(answer) == _normalize(_translation.text),
      );

  bool get _allCorrect =>
      _lesson.questions.asMap().entries.every(
        (entry) => _answers[entry.key] == entry.value.answer,
      ) &&
      _translationCorrect;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_progressKey);
    _translation.text = prefs.getString(_translationKey) ?? '';
    _completed = (prefs.getStringList(_completedKey) ?? <String>[])
        .contains(widget.lessonId);
    if (raw != null) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          final answers = decoded['answers'];
          if (answers is Map<String, dynamic>) {
            for (final entry in answers.entries) {
              final index = int.tryParse(entry.key);
              if (index != null && entry.value is String) {
                _answers[index] = entry.value as String;
              }
            }
          }
        }
      } on FormatException {
        // A corrupted local save must not prevent the lesson from opening.
      }
    }
    if (mounted) setState(() => _loaded = true);
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_progressKey, jsonEncode({
      'answers': _answers.map((key, value) => MapEntry(key.toString(), value)),
    }));
    await prefs.setString(_translationKey, _translation.text);
  }

  Future<void> _finish() async {
    if (!_allCorrect) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('همهٔ سؤال‌ها و ترجمه باید درست باشند تا درس کامل شود.'),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList(_completedKey) ?? <String>[];
    if (!completed.contains(widget.lessonId)) {
      completed.add(widget.lessonId);
      await prefs.setStringList(_completedKey, completed);
      await ProgressService.addXp(50);
      await ProgressService.recordStudyDay();
    }
    if (!mounted) return;
    setState(() => _completed = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('درس کامل شد! ۵۰ XP دریافت کردی. 🐱')),
    );
  }

  @override
  void dispose() {
    _translation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final correctCount = _lesson.questions.asMap().entries
        .where((entry) => _answers[entry.key] == entry.value.answer)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text('B1 · Lesson ${int.parse(widget.lessonId.substring(widget.lessonId.length - 2))}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(_lesson.titleEn,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  )),
          const SizedBox(height: 4),
          Text(_lesson.titleFa,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 20),
          Text('Vocabulary · واژگان',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ..._lesson.vocabulary.map((word) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(word.word,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16)),
                      Text(word.meaningFa),
                      const SizedBox(height: 5),
                      Text(word.exampleEn),
                      Text(word.exampleFa,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 16),
          Text('Grammar · گرامر',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_lesson.grammarEn),
                  const SizedBox(height: 8),
                  Text(_lesson.grammarFa),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Practice · تمرین',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ..._lesson.questions.asMap().entries.map((entry) {
            final index = entry.key;
            final question = entry.value;
            final selected = _answers[index];
            final isCorrect = selected == question.answer;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${index + 1}. ${question.prompt}',
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    ...question.options.map((option) => RadioListTile<String>(
                          value: option,
                          groupValue: selected,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(option),
                          onChanged: (value) async {
                            if (value == null) return;
                            setState(() => _answers[index] = value);
                            await _save();
                          },
                        )),
                    if (selected != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        isCorrect
                            ? 'درست است! ${question.explanationFa}'
                            : 'پاسخ درست: ${question.answer}\n${question.explanationFa}',
                        style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.deepOrange,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          Text(_lesson.translationPromptFa,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          TextField(
            controller: _translation,
            minLines: 1,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Write your English translation…',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14)),
              helperText: _translation.text.isEmpty
                  ? null
                  : _translationCorrect
                      ? 'ترجمه درست است.'
                      : 'ترجمه هنوز با پاسخ‌های قابل قبول مطابقت ندارد.',
              helperStyle: TextStyle(
                  color: _translationCorrect ? Colors.green : Colors.grey),
            ),
            onChanged: (_) {
              setState(() {});
              _save();
            },
          ),
          const SizedBox(height: 16),
          Text('Correct answers: $correctCount / ${_lesson.questions.length}'),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _finish,
            icon: Icon(_completed ? Icons.check_circle : Icons.task_alt),
            label: Text(_completed ? 'Lesson completed ✓' : 'Check and complete · بررسی و تکمیل'),
          ),
        ],
      ),
    );
  }
}
