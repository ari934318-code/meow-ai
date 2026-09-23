import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../data/levels/a1/basics/a1_basics_data.dart';
import '../data/levels/a1/basics/a1_basics_listening_data.dart';
import '../data/levels/a1/basics/a1_basics_models.dart';
import '../localization.dart';

enum A1PracticeSkill { speaking, writing, listening }

class A1PracticeSkillPage extends StatefulWidget {
  final A1PracticeSkill skill;
  const A1PracticeSkillPage({super.key, required this.skill});
  @override
  State<A1PracticeSkillPage> createState() => _A1PracticeSkillPageState();
}

class _A1PracticeSkillPageState extends State<A1PracticeSkillPage> {
  static const lavender = Color(0xFFB9A7E8);
  final _tts = FlutterTts();
  final _speech = stt.SpeechToText();
  final _controller = TextEditingController();
  final _random = Random();
  late final List<_SpeakingItem> speaking;
  late final List<_WritingItem> writing;
  late final List<_ListeningItem> listening;
  int index = 0;
  bool answered = false;
  bool correct = false;
  bool recording = false;
  bool speechAvailable = false;
  String recognized = '';

  @override
  void initState() {
    super.initState();
    speaking = [];
    writing = [];
    listening = [];
    for (final lesson in a1BasicsLessons) {
      for (final q in lesson.speakingQuestions) {
        speaking.add(_SpeakingItem(lesson.title, lesson.titleFa, q.question, q.persian, q.acceptableAnswers));
      }
      for (final q in lesson.questions) {
        if (q.type == 'typing' || q.type == 'fillInTheBlank') {
          writing.add(_WritingItem(lesson.title, lesson.titleFa, q.question, q.answer, q.allAcceptedAnswers, q.explanation));
        }
      }
      for (final q in a1BasicsListeningQuestionsFor(lesson.id)) {
        listening.add(_ListeningItem(lesson.title, lesson.titleFa, q.sentence, q.sentenceFa, q.options, q.answer));
      }
    }
    speaking.shuffle(_random);
    writing.shuffle(_random);
    listening.shuffle(_random);
    _tts.setSpeechRate(0.45);
    if (widget.skill == A1PracticeSkill.speaking) _initSpeech();
  }

  Future<void> _initSpeech() async {
    speechAvailable = await _speech.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _speech.stop();
    _tts.stop();
    _controller.dispose();
    super.dispose();
  }

  String _normalize(String s) => s.toLowerCase().trim()
      .replaceAll(RegExp(r'[?.!,;:]+'), '')
      .replaceAll(RegExp(r'\\s+'), ' ');

  void _next() => setState(() {
    index++;
    answered = false;
    correct = false;
    recording = false;
    recognized = '';
    _controller.clear();
  });

  Future<void> _startRecording() async {
    if (!speechAvailable || recording) return;
    setState(() { recording = true; recognized = ''; answered = false; });
    await _speech.listen(
      localeId: 'en_US',
      listenFor: const Duration(seconds: 8),
      pauseFor: const Duration(seconds: 2),
      onResult: (r) { if (mounted) setState(() => recognized = r.recognizedWords); },
    );
  }

  Future<void> _stopRecording() async {
    await _speech.stop();
    if (!mounted) return;
    final item = speaking[index % speaking.length];
    final spoken = _normalize(recognized);
    final accepted = item.acceptableAnswers.map(_normalize);
    setState(() {
      recording = false;
      answered = true;
      correct = accepted.any((a) => a == spoken || (a.isNotEmpty && spoken.contains(a)));
    });
  }

  void _checkWriting() {
    if (answered) return;
    final item = writing[index % writing.length];
    final input = _normalize(_controller.text);
    final accepted = item.accepted.map(_normalize).toSet();
    setState(() { answered = true; correct = accepted.contains(input) || input == _normalize(item.answer); });
  }

  Future<void> _play(String text) async {
    await _tts.stop();
    await _tts.setLanguage('en-US');
    await _tts.speak(text);
  }

  void _checkListening(String answer) {
    if (answered) return;
    final item = listening[index % listening.length];
    setState(() { answered = true; correct = answer == item.answer; });
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);
    final items = widget.skill == A1PracticeSkill.speaking ? speaking
        : widget.skill == A1PracticeSkill.writing ? writing : listening;
    return Scaffold(
      appBar: AppBar(title: Text(_title(lang))),
      body: items.isEmpty
          ? Center(child: Text(lang.isPersian ? 'فعلاً تمرینی موجود نیست.' : 'No practice items yet.'))
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                Text(
                  (lang.isPersian ? 'تمرین ' : 'Practice ') +
                  (index % items.length + 1).toString() +
                  (lang.isPersian ? ' از ' : ' of ') + items.length.toString() +
                  (lang.isPersian ? ' • مبانی A1' : ' • A1 Basics'),
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                if (widget.skill == A1PracticeSkill.speaking) _speaking(context, lang)
                else if (widget.skill == A1PracticeSkill.writing) _writing(context, lang)
                else _listening(context, lang),
              ],
            ),
    );
  }

  String _title(MeowLocalizations l) {
    if (widget.skill == A1PracticeSkill.speaking) return l.isPersian ? 'تمرین مکالمه' : 'Speaking Practice';
    if (widget.skill == A1PracticeSkill.writing) return l.isPersian ? 'تمرین نوشتن' : 'Writing Practice';
    return l.isPersian ? 'تمرین شنیداری' : 'Listening Practice';
  }

  Widget _chip(BuildContext c, MeowLocalizations l, String en, String fa) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(color: lavender.withOpacity(.10), borderRadius: BorderRadius.circular(14)),
    child: Text(l.isPersian ? fa : en, style: const TextStyle(color: lavender, fontWeight: FontWeight.w700)),
  );

  Widget _card(BuildContext c, Widget child) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Theme.of(c).colorScheme.surface,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: lavender.withOpacity(.14)),
    ),
    child: child,
  );

  Widget _speaking(BuildContext c, MeowLocalizations l) {
    final x = speaking[index % speaking.length];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _chip(c, l, x.enLesson, x.faLesson),
      const SizedBox(height: 12),
      _card(c, Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(x.question, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
        if (l.isPersian) Padding(padding: const EdgeInsets.only(top: 8), child: Text(x.persian, style: const TextStyle(color: Colors.grey))),
        const SizedBox(height: 20),
        Icon(Icons.mic_rounded, size: 48, color: lavender),
        const SizedBox(height: 10),
        Text(recognized.isEmpty ? (l.isPersian ? 'جمله را با صدای بلند بگو' : 'Say it aloud') : recognized, textAlign: TextAlign.center),
        const SizedBox(height: 14),
        FilledButton.icon(
          onPressed: speechAvailable ? (recording ? _stopRecording : _startRecording) : null,
          icon: Icon(recording ? Icons.stop_rounded : Icons.mic_rounded),
          label: Text(recording ? (l.isPersian ? 'توقف' : 'Stop') : (l.isPersian ? 'شروع ضبط' : 'Start')),
        ),
        if (!speechAvailable) const Text('Speech recognition is not available on this device.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
      ])),
      if (answered) _feedback(l, null),
      if (answered) _nextButton(l),
    ]);
  }

  Widget _writing(BuildContext c, MeowLocalizations l) {
    final x = writing[index % writing.length];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _chip(c, l, x.enLesson, x.faLesson),
      const SizedBox(height: 12),
      _card(c, Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(x.question, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        TextField(
          controller: _controller,
          enabled: !answered,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _checkWriting(),
          decoration: InputDecoration(
            hintText: l.isPersian ? 'پاسخت را انگلیسی بنویس...' : 'Type your answer in English...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        const SizedBox(height: 14),
        FilledButton(onPressed: answered ? null : _checkWriting, child: Text(l.isPersian ? 'بررسی پاسخ' : 'Check answer')),
      ])),
      if (answered) _feedback(l, x),
      if (answered) _nextButton(l),
    ]);
  }

  Widget _listening(BuildContext c, MeowLocalizations l) {
    final x = listening[index % listening.length];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _chip(c, l, x.enLesson, x.faLesson),
      const SizedBox(height: 12),
      _card(c, Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        IconButton.filledTonal(onPressed: () => _play(x.sentence), icon: const Icon(Icons.volume_up_rounded), iconSize: 30),
        Text(l.isPersian ? 'گوش بده و جمله درست را انتخاب کن.' : 'Listen and choose the sentence you hear.', textAlign: TextAlign.center),
        const SizedBox(height: 16),
        ...x.options.map((o) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: OutlinedButton(onPressed: answered ? null : () => _checkListening(o), child: Text(o)),
        )),
      ])),
      if (answered) _feedback(l, null),
      if (answered) _nextButton(l),
    ]);
  }

  Widget _feedback(MeowLocalizations l, _WritingItem? x) => Container(
    margin: const EdgeInsets.only(top: 14),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: (correct ? Colors.green : Colors.red).withOpacity(.08),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(correct
        ? (l.isPersian ? 'درست بود! 🎉' : 'Correct! 🎉')
        : (l.isPersian
            ? 'پاسخ درست: ' + (x?.answer ?? 'جمله را دوباره تمرین کن.')
            : 'Correct answer: ' + (x?.answer ?? 'Practice the sentence again.'))),
  );

  Widget _nextButton(MeowLocalizations l) => Padding(
    padding: const EdgeInsets.only(top: 14),
    child: FilledButton.tonal(onPressed: _next, child: Text(l.isPersian ? 'تمرین بعدی' : 'Next practice')),
  );
}

class _SpeakingItem {
  final String enLesson, faLesson, question, persian;
  final List<String> acceptableAnswers;
  _SpeakingItem(this.enLesson, this.faLesson, this.question, this.persian, this.acceptableAnswers);
}

class _WritingItem {
  final String enLesson, faLesson, question, answer;
  final List<String> accepted;
  final String? explanation;
  _WritingItem(this.enLesson, this.faLesson, this.question, this.answer, this.accepted, this.explanation);
}

class _ListeningItem {
  final String enLesson, faLesson, sentence, sentenceFa, answer;
  final List<String> options;
  _ListeningItem(this.enLesson, this.faLesson, this.sentence, this.sentenceFa, this.options, this.answer);
}
