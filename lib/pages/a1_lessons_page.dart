import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'a1_data.dart';
import 'a1_models.dart';
import 'localization.dart';

class A1LessonsPage extends StatelessWidget {
  const A1LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('A1 Lessons', 'درس‌های A1'),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: a1Lessons.length,
        itemBuilder: (context, index) {
          final lesson = a1Lessons[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(lesson.title),
              subtitle: Text(lesson.topic),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => A1LessonDetailPage(
                      lesson: lesson,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class A1LessonDetailPage extends StatefulWidget {
  final A1Lesson lesson;

  const A1LessonDetailPage({
    super.key,
    required this.lesson,
  });

  @override
  State<A1LessonDetailPage> createState() =>
      _A1LessonDetailPageState();
}

class _A1LessonDetailPageState
    extends State<A1LessonDetailPage> {
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _speechAvailable = false;
  bool _isListening = false;

  int? _listeningQuestionIndex;

  final Map<int, String> _recognizedTexts = {};
  final Map<int, bool?> _results = {};

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          if (mounted) {
            setState(() {
              _isListening = false;
              _listeningQuestionIndex = null;
            });
          }
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() {
            _isListening = false;
            _listeningQuestionIndex = null;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'مشکل در تشخیص صدا: ${error.errorMsg}',
              ),
            ),
          );
        }
      },
    );

    if (mounted) {
      setState(() {
        _speechAvailable = available;
      });
    }
  }

  Future<void> _startListening(int questionIndex) async {
    if (!_speechAvailable) {
      await _initializeSpeech();
    }

    if (!_speechAvailable) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'تشخیص صدا روی این دستگاه در دسترس نیست.',
            ),
          ),
        );
      }
      return;
    }

    if (_isListening) {
      await _stopListening();
    }

    setState(() {
      _isListening = true;
      _listeningQuestionIndex = questionIndex;
      _recognizedTexts[questionIndex] = '';
      _results[questionIndex] = null;
    });

    await _speech.listen(
      onResult: (result) {
        if (!mounted) return;

        final text = result.recognizedWords.trim();

        setState(() {
          _recognizedTexts[questionIndex] = text;
        });

        if (result.finalResult) {
          _checkAnswer(questionIndex, text);
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 4),
      partialResults: true,
      localeId: 'en_US',
      cancelOnError: true,
      listenMode: stt.ListenMode.dictation,
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();

    if (mounted) {
      setState(() {
        _isListening = false;
        _listeningQuestionIndex = null;
      });
    }
  }

  void _checkAnswer(
    int questionIndex,
    String spokenText,
  ) {
    final question =
        widget.lesson.speakingQuestions[questionIndex];

    final normalizedSpoken =
        _normalizeText(spokenText);

    bool isCorrect = false;

    for (final acceptableAnswer
        in question.acceptableAnswers) {
      final normalizedAnswer =
          _normalizeText(acceptableAnswer);

      if (normalizedAnswer.isEmpty) {
        continue;
      }

      // Exact match
      if (normalizedSpoken == normalizedAnswer) {
        isCorrect = true;
        break;
      }

      // اگر جواب قابل قبول یک عبارت ناقص/الگو باشد.
      // مثال:
      // acceptableAnswer = "my name is"
      // spokenText = "my name is sara"
      if (_matchesFlexibleAnswer(
        normalizedSpoken,
        normalizedAnswer,
      )) {
        isCorrect = true;
        break;
      }
    }

    if (mounted) {
      setState(() {
        _results[questionIndex] = isCorrect;
        _isListening = false;
        _listeningQuestionIndex = null;
      });
    }
  }

  bool _matchesFlexibleAnswer(
    String spoken,
    String acceptable,
  ) {
    // پاسخ‌هایی که با عبارت مشخصی شروع می‌شوند.
    //
    // مثال:
    // "my name is"
    // "i am"
    //
    // در این حالت هر چیزی بعد از عبارت هم قابل قبول است.

    if (acceptable == 'my name is' &&
        spoken.startsWith('my name is ')) {
      return spoken.length > acceptable.length;
    }

    if (acceptable == 'i am' &&
        spoken.startsWith('i am ')) {
      return spoken.length > acceptable.length;
    }

    // الگوی سن:
    // "i am years old"
    //
    // مثال:
    // i am 18 years old
    if (acceptable == 'i am years old') {
      final pattern = RegExp(
        r'^i am \d+ years old$',
      );

      if (pattern.hasMatch(spoken)) {
        return true;
      }
    }

    // بعضی جواب‌ها ممکن است با "my" یا "i" شروع شوند
    // و ادامه‌ی طبیعی داشته باشند.
    if (acceptable.endsWith('...')) {
      final prefix =
          acceptable.replaceAll('...', '').trim();

      return spoken.startsWith('$prefix ');
    }

    return false;
  }

  String _normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r"[.,!?;:'\"()]"), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            lesson.topic,
            style: Theme.of(context)
                .textTheme
                .headlineSmall,
          ),

          const SizedBox(height: 24),

          // =========================
          // WORDS
          // =========================

          Text(
            context.tr('Words', 'کلمات'),
            style: Theme.of(context)
                .textTheme
                .titleLarge,
          ),

          const SizedBox(height: 10),

          ...lesson.words.map(
            (word) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(word.english),
                subtitle: Text(
                  '${word.persian}\n${word.pronunciation}\n${word.example}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {
                    // TTS را بعداً به این دکمه وصل می‌کنیم.
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // SENTENCES
          // =========================

          Text(
            context.tr('Sentences', 'جمله‌ها'),
            style: Theme.of(context)
                .textTheme
                .titleLarge,
          ),

          const SizedBox(height: 10),

          ...lesson.sentences.map(
            (sentence) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(sentence.english),
                subtitle: Text(sentence.persian),
                trailing: IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {
                    // TTS را بعداً به این دکمه وصل می‌کنیم.
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // MULTIPLE CHOICE
          // =========================

          Text(
            context.tr(
              'Multiple Choice',
              'سؤالات چهارگزینه‌ای',
            ),
            style: Theme.of(context)
                .textTheme
                .titleLarge,
          ),

          const SizedBox(height: 10),

          ...lesson.questions.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final question = entry.value;

              return Card(
                margin:
                    const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}. ${question.question}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      ...question.options.map(
                        (option) => Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              final correct =
                                  option ==
                                      question.answer;

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    correct
                                        ? '✅ درست! 😼💜'
                                        : '❌ نههه، دوباره امتحان کن 😹',
                                  ),
                                ),
                              );
                            },
                            child: Align(
                              alignment:
                                  Alignment.centerLeft,
                              child: Text(option),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // =========================
          // SPEAKING
          // =========================

          Text(
            context.tr(
              'Speaking Practice',
              'تمرین مکالمه',
            ),
            style: Theme.of(context)
                .textTheme
                .titleLarge,
          ),

          const SizedBox(height: 10),

          ...lesson.speakingQuestions.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final speakingQuestion = entry.value;

              final recognizedText =
                  _recognizedTexts[index] ?? '';

              final result = _results[index];

              final isThisQuestionListening =
                  _isListening &&
                  _listeningQuestionIndex == index;

              return Card(
                margin:
                    const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}. ${speakingQuestion.question}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        speakingQuestion.persian,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // =========================
                      // MICROPHONE BUTTON
                      // =========================

                      Center(
                        child: ElevatedButton.icon(
                          onPressed: isThisQuestionListening
                              ? _stopListening
                              : () => _startListening(index),
                          icon: Icon(
                            isThisQuestionListening
                                ? Icons.stop
                                : Icons.mic,
                          ),
                          label: Text(
                            isThisQuestionListening
                                ? 'توقف'
                                : 'صحبت کن',
                          ),
                        ),
                      ),

                      if (isThisQuestionListening) ...[
                        const SizedBox(height: 12),

                        Center(
                          child: Text(
                            '🎤 میو داره گوش می‌ده... 😼',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],

                      // =========================
                      // RECOGNIZED TEXT
                      // =========================

                      if (recognizedText.isNotEmpty) ...[
                        const SizedBox(height: 16),

                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(12),
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'میو شنید:',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                recognizedText,
                              ),
                            ],
                          ),
                        ),
                      ],

                      // =========================
                      // RESULT
                      // =========================

                      if (result != null) ...[
                        const SizedBox(height: 12),

                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(14),
                            color: result
                                ? Colors.green
                                    .withOpacity(0.12)
                                : Colors.red
                                    .withOpacity(0.12),
                            border: Border.all(
                              color: result
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                result
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: result
                                    ? Colors.green
                                    : Colors.red,
                                size: 28,
                              ),
                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  result
                                      ? 'درسته! 😼💜'
                                      : '❌ هنوز درست نیست، دوباره امتحان کن 😹',
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    color: result
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}