import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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

  bool _speechEnabled = false;
  bool _isListening = false;

  String _recognizedText = '';

  // جمله‌ای که فعلاً برای تمرین گفتاری استفاده می‌شود.
  String _practiceSentence = 'I’d like a drink, please.';

  final List<Map<String, String>> messages = [
    {
      'sender': 'meow',
      'text': 'Hi! I am Meow 🐱',
    },
    {
      'sender': 'meow',
      'text': 'Let’s practice English together!',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize(
      onStatus: _onSpeechStatus,
      onError: (error) {
        if (!mounted) return;

        setState(() {
          _isListening = false;
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
      if (!mounted) return;

      _showMessage(
        'Speech recognition is not available on this device.',
      );

      return;
    }

    setState(() {
      _recognizedText = '';
      _isListening = true;
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

  void _checkSpeakingResult() {
    if (_recognizedText.trim().isEmpty) {
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
      resultMessage = 'Excellent! 😻 Your sentence was very close!';
    } else if (score >= 70) {
      resultMessage = 'Good job! 😺 A little more practice!';
    } else if (score >= 40) {
      resultMessage = 'Keep practicing! 🐱 Try the sentence again.';
    } else {
      resultMessage = 'Let’s try again together. 💜';
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

  void _sendMessage() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add({
        'sender': 'user',
        'text': text,
      });

      messages.add({
        'sender': 'meow',
        'text': 'Nice! Let’s keep practicing 😺',
      });
    });

    _controller.clear();
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

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lang.meow,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: lavender.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: lavender,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  20,
                ),
                children: [
                  _meowHeader(context, lang),

                  const SizedBox(height: 24),

                  ...messages.map((message) {
                    final isUser =
                        message['sender'] == 'user';

                    return _messageBubble(
                      context,
                      message['text']!,
                      isUser,
                    );
                  }),

                  const SizedBox(height: 20),

                  _speakingPracticeCard(
                    context,
                    lang,
                  ),
                ],
              ),
            ),
            _inputArea(context, lang),
          ],
        ),
      ),
    );
  }

  Widget _meowHeader(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lavender.withOpacity(0.10),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: lavender.withOpacity(0.14),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: lavender.withOpacity(0.16),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '🐱',
                style: TextStyle(fontSize: 31),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  lang.isPersian
                      ? 'میو اینجاست 😼'
                      : 'Meow is here 😼',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  lang.isPersian
                      ? 'با میو انگلیسی تمرین کن'
                      : 'Practice English with Meow',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    height: 1.35,
                  ),
                ),
              ],
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
  ) {
    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
        constraints: const BoxConstraints(
          maxWidth: 310,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? lavender
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft:
                Radius.circular(isUser ? 20 : 6),
            bottomRight:
                Radius.circular(isUser ? 6 : 20),
          ),
          border: isUser
              ? null
              : Border.all(
                  color: Colors.grey.withOpacity(0.14),
                ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            height: 1.4,
            color: isUser
                ? Colors.white
                : Theme.of(context)
                    .colorScheme
                    .onSurface,
          ),
        ),
      ),
    );
  }

  Widget _speakingPracticeCard(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: lavender.withOpacity(0.18),
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
              ),
              const SizedBox(width: 10),
              Text(
                lang.isPersian
                    ? 'تمرین صحبت کردن'
                    : 'Speaking Practice',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            lang.isPersian
                ? 'این جمله را با صدای بلند بگو:'
                : 'Say this sentence out loud:',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            _practiceSentence,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isListening
                      ? _stopListening
                      : _startListening,
                  icon: Icon(
                    _isListening
                        ? Icons.stop_rounded
                        : Icons.mic_rounded,
                  ),
                  label: Text(
                    _isListening
                        ? (lang.isPersian
                            ? 'توقف'
                            : 'Stop')
                        : (lang.isPersian
                            ? 'شروع تمرین'
                            : 'Practice'),
                  ),
                ),
              ),
            ],
          ),

          if (_recognizedText.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              lang.isPersian
                  ? 'صدای شما:'
                  : 'You said:',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _recognizedText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _inputArea(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        16,
        10,
        16,
        12,
      ),
      decoration: BoxDecoration(
        color:
            Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.10),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: lang.isPersian
                    ? 'با میو حرف بزن...'
                    : 'Talk to Meow...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                filled: true,
                fillColor:
                    Theme.of(context)
                        .colorScheme
                        .surface,
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(22),
                  borderSide: BorderSide(
                    color:
                        Colors.grey.withOpacity(0.12),
                  ),
                ),
                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(22),
                  borderSide: BorderSide(
                    color:
                        Colors.grey.withOpacity(0.12),
                  ),
                ),
                focusedBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(22),
                  borderSide: BorderSide(
                    color:
                        lavender.withOpacity(0.65),
                    width: 1.4,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 9),

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: lavender,
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 21,
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