import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../data/levels/a1/a1_data.dart';
import '../data/levels/a1/a1_models.dart';
import '../data/levels/a1/a1_exam_data.dart';
import '../data/levels/a1/a1_exam_localization.dart';
import '../data/levels/a1/a1_exam_model.dart';
import '../localization.dart';

class A1ExamPage extends StatefulWidget {
  const A1ExamPage({super.key});

  @override
  State<A1ExamPage> createState() => _A1ExamPageState();
}

class _A1ExamPageState extends State<A1ExamPage> {
  static const lavender = Color(0xFF9B7EDE);

  late final List<A1ExamQuestion> examQuestions;
  late final List<A1SpeakingQuestion> speakingQuestions;

  int currentIndex = 0;
  String? selectedAnswer;
  bool answerSubmitted = false;

  String? recognizedText;
  bool isListening = false;
  bool speakingAnswerSubmitted = false;

  final List<A1ExamAnswer> answers = [];
  final stt.SpeechToText speech = stt.SpeechToText();
  bool speechAvailable = false;

  @override
  void initState() {
    super.initState();
    examQuestions = _createExamQuestions();
    speakingQuestions = _createSpeakingQuestions();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    speechAvailable = await speech.initialize();
    if (mounted) setState(() {});
  }

  List<A1ExamQuestion> _createExamQuestions() {
    final random = Random();
    final byLesson = <String, List<A1ExamQuestion>>{};

    for (final question in a1ExamQuestions) {
      byLesson.putIfAbsent(question.lessonId, () => []).add(question);
    }

    for (final questions in byLesson.values) {
      questions.shuffle(random);
    }

    final selected = <A1ExamQuestion>[];
    final lessonIds = byLesson.keys.toList();

    for (var i = 0; i < lessonIds.length; i++) {
      final questions = byLesson[lessonIds[i]]!;
      final amount = i < 8 ? 2 : 1;
      selected.addAll(questions.take(amount));
    }

    selected.shuffle(random);

    return selected.map((question) {
      final options = List<String>.from(question.options)..shuffle(random);
      return A1ExamQuestion(
        id: question.id,
        lessonId: question.lessonId,
        category: question.category,
        question: question.question,
        questionFa: question.questionFa ?? a1ExamQuestionFa[question.id],
        options: List.unmodifiable(options),
        correctAnswer: question.correctAnswer,
      );
    }).toList(growable: false);
  }

  List<A1SpeakingQuestion> _createSpeakingQuestions() {
    final random = Random();
    final all = <A1SpeakingQuestion>[];
    for (final lesson in a1Lessons) {
      all.addAll(lesson.speakingQuestions);
    }
    all.shuffle(random);
    return all.take(5).toList();
  }

  int get totalExamQuestions => examQuestions.length + speakingQuestions.length;
  bool get isSpeakingQuestion => currentIndex >= examQuestions.length;
  int get speakingIndex => currentIndex - examQuestions.length;

  String _text(String english, String persian, MeowLocalizations lang) => lang.isPersian ? persian : english;

  String _localizedQuestion(A1ExamQuestion question, MeowLocalizations lang) {
    return lang.isPersian ? (question.questionFa ?? a1ExamQuestionFa[question.id] ?? question.question) : question.question;
  }

  String _localizedCategory(String category, MeowLocalizations lang) {
    if (!lang.isPersian) return category;
    switch (category) {
      case 'Vocabulary': return 'واژگان';
      case 'Conversation': return 'مکالمه';
      case 'Grammar': return 'گرامر';
      default: return category;
    }
  }

  void _selectAnswer(String answer) {
    if (answerSubmitted) return;
    setState(() => selectedAnswer = answer);
  }

  void _submitAnswer() {
    if (selectedAnswer == null || answerSubmitted) return;
    final question = examQuestions[currentIndex];
    final isCorrect = selectedAnswer!.trim().toLowerCase() == question.correctAnswer.trim().toLowerCase();
    setState(() {
      answerSubmitted = true;
      answers.add(A1ExamAnswer(questionId: question.id, selectedAnswer: selectedAnswer!, correctAnswer: question.correctAnswer, isCorrect: isCorrect));
    });
  }

  String _normalize(String text) => text.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').replaceAll(RegExp(r'\s+'), ' ').trim();

  bool _isSpeakingAnswerCorrect(String answer, A1SpeakingQuestion question) {
    final normalized = _normalize(answer);
    if (normalized.isEmpty) return false;
    for (final acceptable in question.acceptableAnswers) {
      final expected = _normalize(acceptable);
      if (normalized == expected || normalized.contains(expected)) return true;
    }
    return false;
  }

  Future<void> _startListening() async {
    if (!speechAvailable) await _initSpeech();
    if (!speechAvailable || speakingAnswerSubmitted) return;
    setState(() { isListening = true; recognizedText = null; });
    await speech.listen(localeId: 'en_US', onResult: (result) {
      if (!mounted) return;
      setState(() => recognizedText = result.recognizedWords);
    });
  }

  Future<void> _stopListening() async {
    await speech.stop();
    if (mounted) setState(() => isListening = false);
  }

  void _submitSpeakingAnswer() {
    if (recognizedText == null || recognizedText!.trim().isEmpty || speakingAnswerSubmitted) return;
    final question = speakingQuestions[speakingIndex];
    final isCorrect = _isSpeakingAnswerCorrect(recognizedText!, question);
    setState(() {
      speakingAnswerSubmitted = true;
      answers.add(A1ExamAnswer(questionId: 'speaking_$speakingIndex', selectedAnswer: recognizedText!, correctAnswer: question.acceptableAnswers.first, isCorrect: isCorrect));
    });
  }

  void _nextQuestion() {
    if (isSpeakingQuestion) {
      if (!speakingAnswerSubmitted) return;
    } else if (!answerSubmitted) {
      return;
    }
    if (currentIndex >= totalExamQuestions - 1) { _showResult(); return; }
    setState(() {
      currentIndex++;
      selectedAnswer = null;
      answerSubmitted = false;
      recognizedText = null;
      isListening = false;
      speakingAnswerSubmitted = false;
    });
  }

  void _showResult() {
    final correct = answers.where((answer) => answer.isCorrect).length;
    final wrong = answers.length - correct;
    final score = totalExamQuestions == 0 ? 0 : ((correct / totalExamQuestions) * 100).round();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => A1ExamResultPage(result: A1ExamResult(totalQuestions: totalExamQuestions, correctAnswers: correct, wrongAnswers: wrong, score: score, answers: List.unmodifiable(answers)), speakingQuestions: speakingQuestions)));
  }

  @override
  void dispose() { speech.stop(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);
    final progress = (currentIndex + 1) / totalExamQuestions;
    return Scaffold(
      appBar: AppBar(title: Text(_text('A1 Final Exam 🎓', 'آزمون نهایی A1 🎓', lang)), centerTitle: true),
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(lang.isPersian ? 'سؤال ${currentIndex + 1} از $totalExamQuestions' : 'Question ${currentIndex + 1} of $totalExamQuestions', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        LinearProgressIndicator(value: progress, minHeight: 7, borderRadius: BorderRadius.circular(20), color: lavender),
        const SizedBox(height: 28),
        if (isSpeakingQuestion) _buildSpeakingQuestion(lang) else _buildMultipleChoiceQuestion(lang),
      ]))),
    );
  }

  Widget _buildMultipleChoiceQuestion(MeowLocalizations lang) {
    final question = examQuestions[currentIndex];
    return Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: lavender.withOpacity(0.12), borderRadius: BorderRadius.circular(20)), child: Text(_localizedCategory(question.category, lang), textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF7B5FC4), fontWeight: FontWeight.bold))),
      const SizedBox(height: 20),
      Text(_localizedQuestion(question, lang), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.4)),
      const SizedBox(height: 24),
      Expanded(child: ListView.separated(itemCount: question.options.length, separatorBuilder: (_, __) => const SizedBox(height: 12), itemBuilder: (context, index) {
        final option = question.options[index];
        final isSelected = selectedAnswer == option;
        final isCorrect = answerSubmitted && option == question.correctAnswer;
        final isWrong = answerSubmitted && isSelected && !isCorrect;
        Color? backgroundColor;
        Color? borderColor;
        if (isCorrect) { backgroundColor = Colors.green.withOpacity(0.12); borderColor = Colors.green; }
        else if (isWrong) { backgroundColor = Colors.red.withOpacity(0.12); borderColor = Colors.red; }
        else if (isSelected) { backgroundColor = lavender.withOpacity(0.12); borderColor = lavender; }
        return InkWell(borderRadius: BorderRadius.circular(16), onTap: answerSubmitted ? null : () => _selectAnswer(option), child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor ?? Theme.of(context).dividerColor, width: borderColor != null ? 2 : 1)), child: Row(children: [Expanded(child: Text(option, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500))), if (isCorrect) const Icon(Icons.check_circle, color: Colors.green), if (isWrong) const Icon(Icons.cancel, color: Colors.red)])));
      })),
      if (answerSubmitted) ...[
        const SizedBox(height: 10),
        Text(selectedAnswer == question.correctAnswer ? _text('Correct! 🎉', 'درست بود! 🎉', lang) : _text('Not quite. Keep going! 💪', 'این یکی درست نبود. ادامه بده! 💪', lang), textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: selectedAnswer == question.correctAnswer ? Colors.green : Colors.red)),
      ],
      const SizedBox(height: 14),
      _examButton(onPressed: selectedAnswer == null ? null : answerSubmitted ? _nextQuestion : _submitAnswer, label: answerSubmitted ? (currentIndex == totalExamQuestions - 1 ? _text('See Result', 'مشاهده نتیجه', lang) : _text('Next Question', 'سؤال بعدی', lang)) : _text('Check Answer', 'بررسی پاسخ', lang)),
    ]));
  }

  Widget _buildSpeakingQuestion(MeowLocalizations lang) {
    final question = speakingQuestions[speakingIndex];
    final isCorrect = speakingAnswerSubmitted && recognizedText != null && _isSpeakingAnswerCorrect(recognizedText!, question);
    return Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: lavender.withOpacity(0.12), borderRadius: BorderRadius.circular(20)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.mic, color: Color(0xFF7B5FC4), size: 20), const SizedBox(width: 8), Text(_text('SPEAKING', 'مکالمه و گفتار', lang), style: const TextStyle(color: Color(0xFF7B5FC4), fontWeight: FontWeight.bold))])),
      const SizedBox(height: 24),
      Text(lang.isPersian ? question.persian : question.question, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, height: 1.4)),
      if (!lang.isPersian) ...[const SizedBox(height: 12), Text(question.persian, style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.65)))],
      const Spacer(),
      if (recognizedText != null && recognizedText!.trim().isNotEmpty) _infoBox(title: _text('I heard:', 'چیزی که شنیدم:', lang), value: recognizedText!),
      if (speakingAnswerSubmitted) Container(padding: const EdgeInsets.all(14), margin: const EdgeInsets.only(bottom: 18), decoration: BoxDecoration(color: isCorrect ? Colors.green.withOpacity(0.12) : Colors.red.withOpacity(0.12), borderRadius: BorderRadius.circular(16)), child: Text(isCorrect ? _text('Correct! 🎉', 'درست بود! 🎉', lang) : _text('Not quite. Keep practicing! 💪', 'این یکی درست نبود. بیشتر تمرین کن! 💪', lang), textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: isCorrect ? Colors.green : Colors.red))),
      GestureDetector(onTap: speakingAnswerSubmitted ? null : (isListening ? _stopListening : _startListening), child: Container(width: 90, height: 90, decoration: BoxDecoration(shape: BoxShape.circle, color: isListening ? Colors.red.withOpacity(0.15) : lavender.withOpacity(0.15), border: Border.all(color: isListening ? Colors.red : lavender, width: 3)), child: Icon(isListening ? Icons.stop : Icons.mic, size: 40, color: isListening ? Colors.red : const Color(0xFF7B5FC4)))),
      const SizedBox(height: 12),
      Text(speakingAnswerSubmitted ? _text('Answer checked', 'پاسخ بررسی شد', lang) : isListening ? _text('Listening... Tap to stop', 'در حال شنیدن... برای توقف لمس کن', lang) : _text('Tap the microphone and speak', 'میکروفون را لمس کن و صحبت کن', lang), textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.65))),
      const Spacer(),
      _examButton(onPressed: recognizedText == null || recognizedText!.trim().isEmpty ? null : speakingAnswerSubmitted ? _nextQuestion : _submitSpeakingAnswer, label: speakingAnswerSubmitted ? (currentIndex == totalExamQuestions - 1 ? _text('See Result', 'مشاهده نتیجه', lang) : _text('Next Question', 'سؤال بعدی', lang)) : _text('Check Speaking', 'بررسی گفتار', lang)),
    ]));
  }

  Widget _infoBox({required String title, required String value}) => Container(padding: const EdgeInsets.all(16), margin: const EdgeInsets.only(bottom: 18), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.45), borderRadius: BorderRadius.circular(18)), child: Column(children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(value, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18))]));
  Widget _examButton({required VoidCallback? onPressed, required String label}) => SizedBox(height: 54, child: ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: lavender, foregroundColor: Colors.white, disabledBackgroundColor: Colors.grey.withOpacity(0.25), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))));
}

class A1ExamResultPage extends StatelessWidget {
  final A1ExamResult result;
  final List<A1SpeakingQuestion> speakingQuestions;
  const A1ExamResultPage({super.key, required this.result, required this.speakingQuestions});

  String _text(String english, String persian, MeowLocalizations lang) => lang.isPersian ? persian : english;
  String _speakingQuestionText(String questionId, MeowLocalizations lang) {
    if (!questionId.startsWith('speaking_')) return '';
    final index = int.tryParse(questionId.replaceFirst('speaking_', ''));
    if (index == null || index < 0 || index >= speakingQuestions.length) return '';
    final question = speakingQuestions[index];
    return lang.isPersian ? question.persian : question.question;
  }
  String _questionText(A1ExamAnswer answer, MeowLocalizations lang) {
    if (answer.questionId.startsWith('speaking_')) return _speakingQuestionText(answer.questionId, lang);
    final question = a1ExamQuestions.firstWhere((q) => q.id == answer.questionId);
    return lang.isPersian ? (a1ExamQuestionFa[answer.questionId] ?? question.question) : question.question;
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);
    final passed = result.passed;
    return Scaffold(
      appBar: AppBar(title: Text(_text('A1 Exam Result', 'نتیجه آزمون A1', lang)), centerTitle: true, automaticallyImplyLeading: false),
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
        const SizedBox(height: 20),
        Text(passed ? _text('A1 Passed! 🎉', 'A1 را با موفقیت گذراندی! 🎉', lang) : _text('Keep Practicing! 💜', 'به تمرین ادامه بده! 💜', lang), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        const SizedBox(height: 12),
        Text(passed ? _text('You passed the A1 final exam.', 'آزمون نهایی A1 را با موفقیت گذراندی.', lang) : _text('You need 70% to pass the A1 final exam.', 'برای قبولی در آزمون نهایی A1 به حداقل ۷۰٪ نیاز داری.', lang), textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 30),
        Container(width: 150, height: 150, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF9B7EDE), width: 8)), child: Center(child: Text('${result.score}%', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)))),
        const SizedBox(height: 30),
        Row(children: [Expanded(child: _StatCard(title: _text('Correct', 'درست', lang), value: '${result.correctAnswers}', icon: Icons.check_circle, iconColor: Colors.green)), const SizedBox(width: 12), Expanded(child: _StatCard(title: _text('Wrong', 'غلط', lang), value: '${result.wrongAnswers}', icon: Icons.cancel, iconColor: Colors.red))]),
        const SizedBox(height: 24),
        Expanded(child: result.wrongAnswerList.isEmpty ? Center(child: Text(_text('Perfect! No wrong answers 🎉', 'عالی! هیچ پاسخ اشتباهی نداشتی 🎉', lang), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center)) : ListView.builder(itemCount: result.wrongAnswerList.length, itemBuilder: (context, index) {
          final answer = result.wrongAnswerList[index];
          final isSpeaking = answer.questionId.startsWith('speaking_');
          return Container(margin: const EdgeInsets.only(bottom: 14), padding: const EdgeInsets.all(16), decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.red.withOpacity(0.3))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(isSpeaking ? _text('Speaking Question', 'سؤال گفتاری', lang) : '${_text('Question', 'سؤال', lang)} ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            const SizedBox(height: 8),
            Text(_questionText(answer, lang), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Text('${_text('Your answer', 'پاسخ تو', lang)}: ${answer.selectedAnswer}', style: const TextStyle(color: Colors.red)),
            if (!isSpeaking) ...[const SizedBox(height: 6), Text('${_text('Correct answer', 'پاسخ درست', lang)}: ${answer.correctAnswer}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600))],
          ]));
        })),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, height: 54, child: ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const A1ExamPage())), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9B7EDE), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text(_text('Take Exam Again', 'دوباره آزمون بده', lang), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)))),
        const SizedBox(height: 10),
        SizedBox(width: double.infinity, height: 54, child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF9B7EDE), side: const BorderSide(color: Color(0xFF9B7EDE)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text(_text('Back to Lessons', 'بازگشت به درس‌ها', lang), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)))),
      ])),),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  const _StatCard({required this.title, required this.value, required this.icon, required this.iconColor});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.45)), child: Column(children: [Icon(icon, color: iconColor, size: 30), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(title)]));
}
