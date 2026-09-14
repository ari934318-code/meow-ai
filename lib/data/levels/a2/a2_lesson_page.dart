import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'a2_data.dart';
import 'a2_models.dart';

class A2LessonsPage extends StatelessWidget {
  const A2LessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 Lessons'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: a2Lessons.length,
        itemBuilder: (context, index) {
          final lesson = a2Lessons[index];

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
                    builder: (_) => A2LessonDetailPage(
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

class A2LessonDetailPage extends StatefulWidget {
  final A2Lesson lesson;

  const A2LessonDetailPage({
    super.key,
    required this.lesson,
  });

  @override
  State<A2LessonDetailPage> createState() =>
      _A2LessonDetailPageState();
}

class _A2LessonDetailPageState
    extends State<A2LessonDetailPage> {
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _speechAvailable = false;
  bool _isListening = false;
  int? _listeningQuestionIndex;

  final Map<int, String> _recognizedTexts = {};
  final Map<int, bool?> _speakingResults = {};

  final Map<int, int> _questionAnswers = {};
  final Map<int, int> _fillBlankAnswers = {};

  @override
  void initState() {
    super.initState();
    _setupTts();
    _initializeSpeech();
  }

  Future<void> _setupTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
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
      _speakingResults[questionIndex] = null;
    });

    await _speech.listen(
      onResult: (result) {
        if (!mounted) return;

        final text = result.recognizedWords.trim();

        setState(() {
          _recognizedTexts[questionIndex] = text;
        });

        if (result.finalResult) {
          _checkSpeakingAnswer(questionIndex, text);
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

  void _checkSpeakingAnswer(
    int questionIndex,
    String spokenText,
  ) {
    final question =
        widget.lesson.speakingQuestions[questionIndex];

    final normalizedSpoken =
        _normalizeText(spokenText);

    if (normalizedSpoken.isEmpty) {
      return;
    }

    final normalizedQuestion =
        _normalizeText(question.question);

    final questionWords =
        normalizedQuestion.split(' ');

    final spokenWords =
        normalizedSpoken.split(' ');

    int matchedWords = 0;

    for (final word in questionWords) {
      if (spokenWords.contains(word)) {
        matchedWords++;
      }
    }

    final ratio = questionWords.isEmpty
        ? 0.0
        : matchedWords / questionWords.length;

    final isReasonablyRecognized = ratio >= 0.35;

    if (mounted) {
      setState(() {
        _speakingResults[questionIndex] =
            isReasonablyRecognized;

        _isListening = false;
        _listeningQuestionIndex = null;
      });
    }
  }

  String _normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(
          RegExp(r"[.,!?;:'\"()]"),
          ' ',
        )
        .replaceAll(
          RegExp(r'\s+'),
          ' ',
        )
        .trim();
  }

  @override
  void dispose() {
    _tts.stop();
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

          _sectionTitle(
            context,
            'Words',
            'کلمات',
          ),

          ...lesson.words.map(
            (word) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            word.word,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(word.meaning),
                          const SizedBox(height: 4),
                          Text(
                            word.pronunciation,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            word.example,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(word.exampleTranslation),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () => _speak(word.word),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // SENTENCES
          // =========================

          _sectionTitle(
            context,
            'Useful Sentences',
            'جمله‌های کاربردی',
          ),

          ...lesson.sentences.map(
            (sentence) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            sentence.english,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            sentence.pronunciation,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(sentence.translation),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () =>
                          _speak(sentence.english),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // GRAMMAR
          // =========================

          _sectionTitle(
            context,
            'Grammar',
            'گرامر',
          ),

          ...lesson.grammar.map(
            (grammar) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      grammar.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(grammar.explanation),
                    const SizedBox(height: 12),
                    ...grammar.examples.map(
                      (example) => Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 6,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                example,
                                style: const TextStyle(
                                  fontStyle:
                                      FontStyle.italic,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.volume_up,
                                size: 20,
                              ),
                              onPressed: () =>
                                  _speak(example),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // MULTIPLE CHOICE
          // =========================

          _sectionTitle(
            context,
            'Multiple Choice',
            'سؤالات چهارگزینه‌ای',
          ),

          ...lesson.questions.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final question = entry.value;

              final selected =
                  _questionAnswers[index];

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
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...question.options.asMap().entries.map(
                        (optionEntry) {
                          final optionIndex =
                              optionEntry.key;
                          final option =
                              optionEntry.value;

                          final isSelected =
                              selected == optionIndex;

                          final isCorrect =
                              optionIndex ==
                                  question.correctIndex;

                          Color? backgroundColor;

                          if (isSelected) {
                            backgroundColor = isCorrect
                                ? Colors.green
                                    .withOpacity(0.12)
                                : Colors.red
                                    .withOpacity(0.12);
                          }

                          return Padding(
                            padding:
                                const EdgeInsets.only(
                              bottom: 7,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                style:
                                    OutlinedButton.styleFrom(
                                  backgroundColor:
                                      backgroundColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _questionAnswers[
                                        index] =
                                        optionIndex;
                                  });
                                },
                                child: Align(
                                  alignment:
                                      Alignment.centerLeft,
                                  child: Text(option),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (selected != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          selected ==
                                  question.correctIndex
                              ? '✅ درست! 😼💜'
                              : '❌ هنوز درست نیست.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selected ==
                                    question.correctIndex
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(question.explanation),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // =========================
          // FILL BLANK
          // =========================

          _sectionTitle(
            context,
            'Fill in the Blank',
            'جای خالی را پر کن',
          ),

          ...lesson.fillBlanks.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final item = entry.value;

              final selected =
                  _fillBlankAnswers[index];

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
                        '${index + 1}. ${item.sentence}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: item.options
                            .asMap()
                            .entries
                            .map(
                          (optionEntry) {
                            final optionIndex =
                                optionEntry.key;
                            final option =
                                optionEntry.value;

                            return OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _fillBlankAnswers[
                                      index] =
                                      optionIndex;
                                });
                              },
                              child: Text(option),
                            );
                          },
                        ).toList(),
                      ),
                      if (selected != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          selected ==
                                  item.correctIndex
                              ? '✅ درست!'
                              : '❌ دوباره امتحان کن.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selected ==
                                    item.correctIndex
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // =========================
          // SENTENCE ORDERING
          // =========================

          _sectionTitle(
            context,
            'Sentence Ordering',
            'مرتب کردن جمله',
          ),

          ...lesson.sentenceOrdering.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final item = entry.value;

              final shuffled =
                  [...item.shuffledWords];

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
                        '${index + 1}. کلمات را به ترتیب درست بچین:',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: shuffled
                            .map(
                              (word) => Chip(
                                label: Text(word),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'پاسخ صحیح: ${item.sentence}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.volume_up,
                        ),
                        onPressed: () =>
                            _speak(item.sentence),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // =========================
          // MATCHING
          // =========================

          _sectionTitle(
            context,
            'Matching',
            'وصل کردن',
          ),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: lesson.matching.map(
                  (item) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.left,
                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(item.right),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // SENTENCE BUILDING
          // =========================

          _sectionTitle(
            context,
            'Build the Sentence',
            'جمله را بساز',
          ),

          ...lesson.sentenceBuilding.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final item = entry.value;

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
                        '${index + 1}. ${item.meaning}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: item.words
                            .map(
                              (word) => Chip(
                                label: Text(word),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item.correctSentence,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.pronunciation,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.volume_up,
                        ),
                        onPressed: () =>
                            _speak(item.correctSentence),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // =========================
          // REAL-LIFE CONVERSATION
          // =========================

          _sectionTitle(
            context,
            'Real-Life Conversation',
            'مکالمه واقعی',
          ),

          ...lesson.conversations.map(
            (line) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(8),
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer,
                      ),
                      child: Text(
                        line.speaker,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            line.english,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            line.pronunciation,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(line.translation),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.volume_up,
                      ),
                      onPressed: () =>
                          _speak(line.english),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // SPEAKING
          // =========================

          _sectionTitle(
            context,
            'Speaking Practice',
            'تمرین مکالمه',
          ),

          ...lesson.speakingQuestions.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final question = entry.value;

              final recognizedText =
                  _recognizedTexts[index] ?? '';

              final result =
                  _speakingResults[index];

              final isListening =
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
                        '${index + 1}. ${question.question}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        question.pronunciation,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: isListening
                              ? _stopListening
                              : () =>
                                  _startListening(index),
                          icon: Icon(
                            isListening
                                ? Icons.stop
                                : Icons.mic,
                          ),
                          label: Text(
                            isListening
                                ? 'توقف'
                                : 'صحبت کن',
                          ),
                        ),
                      ),
                      if (isListening) ...[
                        const SizedBox(height: 10),
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
                      if (recognizedText.isNotEmpty) ...[
                        const SizedBox(height: 12),
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
                          child: Text(
                            'میو شنید:\n$recognizedText',
                          ),
                        ),
                      ],
                      if (result != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          result
                              ? '✅ خوب بود! 😼💜'
                              : '❌ دوباره امتحان کن 😹',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: result
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // =========================
          // CHALLENGES
          // =========================

          _sectionTitle(
            context,
            'Meow Challenge',
            'چالش میو',
          ),

          ...lesson.challenges.map(
            (challenge) => Card(
              margin:
                  const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(challenge.instruction),
                    const SizedBox(height: 12),
                    ...challenge.tasks.map(
                      (task) => Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 7,
                        ),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text('• '),
                            Expanded(
                              child: Text(task),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // =========================
          // REVIEW
          // =========================

          _sectionTitle(
            context,
            'Review',
            'مرور',
          ),

          ...lesson.reviews.map(
            (review) => Card(
              margin:
                  const EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
                title: Text(
                  review.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: review.points
                    .map(
                      (point) => ListTile(
                        leading: const Icon(
                          Icons.check_circle_outline,
                        ),
                        title: Text(point),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTitle(
    BuildContext context,
    String english,
    String persian,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        '$english\n$persian',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}