import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../data/meow_brain.dart';
import '../localization.dart';

class MeowPage extends StatefulWidget {
  const MeowPage({super.key});

  @override
  State<MeowPage> createState() => _MeowPageState();
}

class _MeowPageState extends State<MeowPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  final TextEditingController _controller = TextEditingController();

  final stt.SpeechToText _speech = stt.SpeechToText();
  final ImagePicker _imagePicker = ImagePicker();

  bool _speechEnabled = false;
  bool _isListening = false;

  String _recognizedText = '';

  String _practiceSentence = "I'd like a drink, please.";

  MeowMood _mood = MeowMood.calm;

  XFile? _homeworkImage;

  final List<Map<String, String>> messages = [
    {
      'sender': 'meow',
      'text': 'Hi! I am Meow 😼',
    },
    {
      'sender': 'meow',
      'text': "Let's practice English together!",
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  String get _moodAsset {
    switch (_mood) {
      case MeowMood.calm:
        return 'assets/images/meow_calm.png';

      case MeowMood.happy:
        return 'assets/images/meow_happy.png';

      case MeowMood.surprised:
        return 'assets/images/meow_surprised.png';

      case MeowMood.angry:
        return 'assets/images/meow_angry.png';

      case MeowMood.cheering:
        return 'assets/images/meow_cheering.png';
    }
  }

  String _statusText(MeowLocalizations lang) {
    if (_isListening) {
      return lang.isPersian
          ? 'دارم گوش می‌دم...'
          : 'Listening...';
    }

    switch (_mood) {
      case MeowMood.calm:
        return lang.isPersian
            ? 'آماده‌ام باهات حرف بزنم'
            : 'Ready to talk';

      case MeowMood.happy:
        return lang.isPersian
            ? 'آفرین! 😺'
            : 'Good job!';

      case MeowMood.surprised:
        return lang.isPersian
            ? 'هوم... دوباره امتحان کن!'
            : 'Hmm... try again!';

      case MeowMood.angry:
        return lang.isPersian
            ? 'بجنب، می‌تونی! 😾'
            : 'Come on, you can do it!';

      case MeowMood.cheering:
        return lang.isPersian
            ? 'عالی بود! 😻'
            : 'Excellent!';
    }
  }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize(
      onStatus: _onSpeechStatus,
      onError: (error) {
        if (!mounted) return;

        setState(() {
          _isListening = false;
          _mood = MeowMood.surprised;
        });
      },
    );

    if (!mounted) return;

    setState(() {
      _speechEnabled = available;
    });
  }

  void _onSpeechStatus(String status) {
    if (!mounted) return;

    setState(() {
      _isListening = status == 'listening';

      if (_isListening) {
        _mood = MeowMood.calm;
      }
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) return;

    setState(() {
      _recognizedText = result.recognizedWords;
    });
  }

  Future<void> _startListening() async {
    if (!_speechEnabled) {
      await _initializeSpeech();
    }

    if (!_speechEnabled) {
      _showMessage(
        'Speech recognition is not available on this device.',
      );
      return;
    }

    setState(() {
      _recognizedText = '';
      _isListening = true;
      _mood = MeowMood.calm;
    });

    await _speech.listen(
      onResult: _onSpeechResult,
      localeId: 'en_US',
      listenFor: const Duration(seconds: 15),
      pauseFor: const Duration(seconds: 3),
      partialResults: true,
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();

    if (!mounted) return;

    setState(() {
      _isListening = false;
    });

    _checkSpeakingResult();
  }

  void _toggleListening() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  void _checkSpeakingResult() {
    if (_recognizedText.trim().isEmpty) {
      setState(() {
        _mood = MeowMood.surprised;
      });

      _showMessage(
        'I could not hear you. Try speaking again. 🎤',
      );

      return;
    }

    final targetWords = _normalizeText(_practiceSentence)
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    final spokenWords = _normalizeText(_recognizedText)
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (targetWords.isEmpty) return;

    int matchedWords = 0;

    for (final word in spokenWords) {
      if (targetWords.contains(word)) {
        matchedWords++;
      }
    }

    final score = ((matchedWords / targetWords.length) * 100)
        .round()
        .clamp(0, 100);

    String resultMessage;

    if (score >= 90) {
      resultMessage = 'Excellent! 😻 Your sentence was very close.';

      setState(() {
        _mood = MeowMood.cheering;
      });
    } else if (score >= 70) {
      resultMessage = 'Good job! 😺 A little more practice!';

      setState(() {
        _mood = MeowMood.happy;
      });
    } else if (score >= 40) {
      resultMessage = 'Keep practicing! 🐱 Try the sentence again.';

      setState(() {
        _mood = MeowMood.surprised;
      });
    } else {
      resultMessage = "Let's try again together. 💜";

      setState(() {
        _mood = MeowMood.angry;
      });
    }

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        final lang = MeowLocalizations.of(context);

        return AlertDialog(
          title: Text(
            lang.isPersian
                ? 'نتیجه تمرین 🎤'
                : 'Speaking Result 🎤',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.isPersian
                    ? 'جمله هدف:'
                    : 'Target sentence:',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(_practiceSentence),
              const SizedBox(height: 16),
              Text(
                lang.isPersian
                    ? 'چیزی که شنیدم:'
                    : 'I heard:',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(_recognizedText),
              const SizedBox(height: 16),
              Text(
                '$score%',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: lavender,
                ),
              ),
              const SizedBox(height: 6),
              Text(resultMessage),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                lang.isPersian ? 'باشه' : 'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  String _normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r"[^\w\s']"), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  // ─────────────────────────────
  // MEOW BRAIN CONNECTION
  // ─────────────────────────────

  void _sendText() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    final response = MeowBrain.respond(text);
    final lang = MeowLocalizations.of(context);

    final meowText = _buildBrainMessage(
      response,
      lang,
    );

    setState(() {
      messages.add({
        'sender': 'user',
        'text': text,
      });

      messages.add({
        'sender': 'meow',
        'text': meowText,
      });

      _mood = response.mood;

      if (response.english.trim().isNotEmpty &&
          response.intent != MeowIntent.unknown) {
        _practiceSentence = response.english;
      }
    });

    _controller.clear();
  }

  String _buildBrainMessage(
    MeowResponse response,
    MeowLocalizations lang,
  ) {
    final buffer = StringBuffer();

    if (lang.isPersian) {
      buffer.writeln(response.persian);

      if (response.english.trim().isNotEmpty) {
        buffer.writeln();
        buffer.writeln('🇬🇧 ${response.english}');
      }

      if (response.pronunciation != null &&
          response.pronunciation!.trim().isNotEmpty) {
        buffer.writeln();
        buffer.writeln(
          '🔊 ${response.pronunciation}',
        );
      }
    } else {
      buffer.writeln(response.english);

      if (response.persian.trim().isNotEmpty) {
        buffer.writeln();
        buffer.writeln('🇮🇷 ${response.persian}');
      }

      if (response.pronunciation != null &&
          response.pronunciation!.trim().isNotEmpty) {
        buffer.writeln();
        buffer.writeln(
          '🔊 ${response.pronunciation}',
        );
      }
    }

    if (response.examples.isNotEmpty) {
      buffer.writeln();
      buffer.writeln(
        lang.isPersian
            ? 'مثال‌ها:'
            : 'Examples:',
      );

      for (final example in response.examples.take(3)) {
        buffer.writeln('• $example');
      }
    }

    if (response.note != null &&
        response.note!.trim().isNotEmpty) {
      buffer.writeln();
      buffer.writeln(
        lang.isPersian
            ? '💡 ${response.note}'
            : '💡 ${response.note}',
      );
    }

    return buffer.toString().trim();
  }

  Future<void> _openHomeworkPicker() async {
    final lang = MeowLocalizations.of(context);

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final theme = Theme.of(context);
        final colors = theme.colorScheme;

        return Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            18,
            20,
            28,
          ),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colors.onSurface.withValues(
                      alpha: 0.15,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  lang.isPersian
                      ? 'عکس تکلیف را اضافه کن'
                      : 'Add homework photo',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 18),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: lavender,
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    lang.isPersian
                        ? 'دوربین'
                        : 'Camera',
                  ),
                  subtitle: Text(
                    lang.isPersian
                        ? 'یک عکس جدید بگیر'
                        : 'Take a new photo',
                  ),
                  onTap: () {
                    Navigator.pop(
                      context,
                      ImageSource.camera,
                    );
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: lavender,
                    child: Icon(
                      Icons.photo_library_rounded,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    lang.isPersian
                        ? 'گالری'
                        : 'Gallery',
                  ),
                  subtitle: Text(
                    lang.isPersian
                        ? 'یک عکس از گوشی انتخاب کن'
                        : 'Choose a photo from your phone',
                  ),
                  onTap: () {
                    Navigator.pop(
                      context,
                      ImageSource.gallery,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null) return;

    await _pickHomeworkImage(source);
  }

  Future<void> _pickHomeworkImage(
    ImageSource source,
  ) async {
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (image == null) return;

      if (!mounted) return;

      setState(() {
        _homeworkImage = image;
        _mood = MeowMood.happy;
      });

      final lang = MeowLocalizations.of(context);

      setState(() {
        messages.add({
          'sender': 'meow',
          'text': lang.isPersian
              ? 'عکس تکلیفت دریافت شد 📸😼'
              : 'I received your homework photo 📸😼',
        });
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _mood = MeowMood.surprised;
      });

      _showMessage(
        'Could not select the image.',
      );
    }
  }

  void _removeHomeworkImage() {
    setState(() {
      _homeworkImage = null;
    });
  }

  void _showMessage(String text) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = isDark
        ? Color.alphaBlend(
            Colors.white.withValues(alpha: 0.045),
            colors.surface,
          )
        : colors.surface;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        title: Text(
          lang.meow,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  24,
                ),
                children: [
                  _meowTopCard(
                    context,
                    cardColor,
                    lang,
                  ),
                  const SizedBox(height: 20),
                  ...messages.map((message) {
                    final isUser =
                        message['sender'] == 'user';

                    return _messageBubble(
                      context,
                      message['text']!,
                      isUser,
                      cardColor,
                    );
                  }),
                  if (_homeworkImage != null) ...[
                    const SizedBox(height: 10),
                    _homeworkPreview(
                      context,
                      cardColor,
                      lang,
                    ),
                  ],
                  const SizedBox(height: 28),
                  _liveMeow(
                    context,
                    lang,
                  ),
                  const SizedBox(height: 30),
                  _speakingPracticeCard(
                    context,
                    lang,
                    cardColor,
                  ),
                ],
              ),
            ),
            _messageInput(
              context,
              lang,
            ),
          ],
        ),
      ),
    );
  }

  Widget _meowTopCard(
    BuildContext context,
    Color cardColor,
    MeowLocalizations lang,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: lavender.withValues(alpha: 0.13),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: lavender.withValues(alpha: 0.11),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: lavender,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  lang.isPersian
                      ? 'میو آماده است'
                      : 'Meow is ready',
                  style:
                      theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  lang.isPersian
                      ? 'طبیعی انگلیسی تمرین کن'
                      : 'Practice speaking naturally',
                  style:
                      theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurface.withValues(
                      alpha: 0.55,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageBubble(
    BuildContext context,
    String text,
    bool isUser,
    Color cardColor,
  ) {
    final theme = Theme.of(context);

    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 320,
        ),
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: isUser ? lavender : cardColor,
          borderRadius: BorderRadius.circular(18),
          border: isUser
              ? null
              : Border.all(
                  color: theme.colorScheme.onSurface
                      .withValues(alpha: 0.065),
                ),
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: isUser
                ? Colors.white
                : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _liveMeow(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    final theme = Theme.of(context);

    return Column(
      children: [
        AnimatedScale(
          scale: _isListening ? 1.06 : 1.0,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 300,
            ),
            width: 190,
            height: 190,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: lavender.withValues(
                alpha: _isListening ? 0.14 : 0.075,
              ),
              boxShadow: [
                BoxShadow(
                  color: lavender.withValues(
                    alpha: _isListening ? 0.22 : 0.08,
                  ),
                  blurRadius:
                      _isListening ? 38 : 22,
                  spreadRadius:
                      _isListening ? 5 : 0,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                _moodAsset,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return const Icon(
                    Icons.pets_rounded,
                    color: lavender,
                    size: 72,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 220,
          ),
          child: Text(
            _statusText(lang),
            key: ValueKey(
              _statusText(lang),
            ),
            style:
                theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          _isListening
              ? (lang.isPersian
                  ? 'واضح انگلیسی صحبت کن'
                  : 'Speak clearly in English')
              : (lang.isPersian
                  ? 'برای صحبت روی میکروفون بزن'
                  : 'Tap the microphone to talk'),
          textAlign: TextAlign.center,
          style:
              theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface
                .withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: 18),
        GestureDetector(
          onTap: _toggleListening,
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 250,
            ),
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: lavender,
              boxShadow: [
                BoxShadow(
                  color: lavender.withValues(
                    alpha:
                        _isListening ? 0.35 : 0.18,
                  ),
                  blurRadius:
                      _isListening ? 28 : 17,
                  spreadRadius:
                      _isListening ? 3 : 0,
                ),
              ],
            ),
            child: Icon(
              _isListening
                  ? Icons.stop_rounded
                  : Icons.mic_rounded,
              color: Colors.white,
              size: 29,
            ),
          ),
        ),
      ],
    );
  }

  Widget _speakingPracticeCard(
    BuildContext context,
    MeowLocalizations lang,
    Color cardColor,
  ) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        17,
        18,
        17,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: theme.colorScheme.onSurface
              .withValues(alpha: 0.065),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.record_voice_over_rounded,
                color: lavender,
                size: 21,
              ),
              const SizedBox(width: 9),
              Text(
                lang.isPersian
                    ? 'تمرین سریع صحبت کردن'
                    : 'Quick speaking practice',
                style:
                    theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            lang.isPersian
                ? 'این جمله را بگو:'
                : 'Try saying:',
            style:
                theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface
                  .withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _practiceSentence,
            style:
                theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: _toggleListening,
              icon: Icon(
                _isListening
                    ? Icons.stop_rounded
                    : Icons.mic_none_rounded,
                size: 20,
              ),
              label: Text(
                _isListening
                    ? (lang.isPersian
                        ? 'توقف'
                        : 'Stop')
                    : (lang.isPersian
                        ? 'تمرین این جمله'
                        : 'Practice this sentence'),
              ),
              style:
                  OutlinedButton.styleFrom(
                foregroundColor: lavender,
                side: BorderSide(
                  color: lavender.withValues(
                    alpha: 0.60,
                  ),
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(17),
                ),
              ),
            ),
          ),
          if (_recognizedText.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              lang.isPersian
                  ? 'صدای شما:'
                  : 'You said:',
              style:
                  theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface
                    .withValues(alpha: 0.55),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _recognizedText,
              style:
                  theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _homeworkPreview(
    BuildContext context,
    Color cardColor,
    MeowLocalizations lang,
  ) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: lavender.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.assignment_turned_in_rounded,
                color: lavender,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  lang.isPersian
                      ? 'تکلیف ثبت شد 📸'
                      : 'Homework submitted 📸',
                  style:
                      theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: _removeHomeworkImage,
                icon: const Icon(
                  Icons.close_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              File(_homeworkImage!.path),
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  height: 180,
                  alignment: Alignment.center,
                  color: theme.colorScheme
                      .surfaceContainerHighest,
                  child: const Icon(
                    Icons.image_rounded,
                    size: 50,
                    color: lavender,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Text(
            lang.isPersian
                ? 'این عکس فعلاً فقط به‌عنوان ثبت انجام تکلیف استفاده می‌شود.'
                : 'This photo is currently used only as a homework check-in.',
            style:
                theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface
                  .withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageInput(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        15,
        9,
        15,
        12,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(
            color: colors.onSurface.withValues(
              alpha: 0.06,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Material(
            color: colors.surfaceContainerHighest
                .withValues(alpha: 0.50),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: _openHomeworkPicker,
              customBorder: const CircleBorder(),
              child: const SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: lavender,
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 48,
                maxHeight: 105,
              ),
              decoration: BoxDecoration(
                color: colors
                    .surfaceContainerHighest
                    .withValues(alpha: 0.42),
                borderRadius:
                    BorderRadius.circular(25),
                border: Border.all(
                  color: colors.onSurface.withValues(
                    alpha: 0.06,
                  ),
                ),
              ),
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                textInputAction:
                    TextInputAction.send,
                onSubmitted: (_) => _sendText(),
                decoration: InputDecoration(
                  hintText: lang.isPersian
                      ? 'با میو حرف بزن...'
                      : 'Talk to Meow...',
                  hintStyle:
                      theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface
                        .withValues(alpha: 0.46),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 13,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          Material(
            color: lavender,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: _sendText,
              customBorder: const CircleBorder(),
              child: const SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _speech.stop();
    _controller.dispose();
    super.dispose();
  }
}