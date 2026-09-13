import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'data/real_english_data.dart';

class RealEnglishPage extends StatelessWidget {
  const RealEnglishPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Abbreviations',
      'Idioms & Slang',
      'Short Forms',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Real English'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'English people actually use 😼',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          for (final category in categories)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(18),
                  leading: Icon(
                    category == 'Abbreviations'
                        ? Icons.short_text
                        : category == 'Idioms & Slang'
                            ? Icons.forum_outlined
                            : Icons.record_voice_over_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 32,
                  ),
                  title: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${realEnglishItems.where((item) => item.category == category).length} items',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RealEnglishListPage(
                          category: category,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RealEnglishListPage extends StatelessWidget {
  final String category;

  const RealEnglishListPage({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final items = realEnglishItems
        .where((item) => item.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                item.term,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  item.fullForm != null
                      ? '${item.fullForm}\n${item.meaning}'
                      : item.meaning,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RealEnglishDetailPage(
                      item: item,
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

class RealEnglishDetailPage extends StatefulWidget {
  final RealEnglishItem item;

  const RealEnglishDetailPage({
    super.key,
    required this.item,
  });

  @override
  State<RealEnglishDetailPage> createState() =>
      _RealEnglishDetailPageState();
}

class _RealEnglishDetailPageState extends State<RealEnglishDetailPage> {
  final FlutterTts _tts = FlutterTts();
  final SpeechToText _speech = SpeechToText();

  bool _speechAvailable = false;
  bool _isListening = false;
  String _recognizedText = '';

  RealEnglishItem get item => widget.item;

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize(
      onStatus: (status) {
        if (!mounted) return;

        setState(() {
          _isListening = _speech.isListening;
        });
      },
      onError: (error) {
        if (!mounted) return;

        setState(() {
          _isListening = false;
        });
      },
    );

    if (!mounted) return;

    setState(() {
      _speechAvailable = available;
    });
  }

  Future<void> _listenToMeow() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);

    await _tts.speak(item.example);
  }

  Future<void> _startListening() async {
    if (!_speechAvailable) {
      final available = await _speech.initialize();

      if (!available) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Speech recognition is not available on this device.',
            ),
          ),
        );

        return;
      }

      if (!mounted) return;

      setState(() {
        _speechAvailable = true;
      });
    }

    setState(() {
      _recognizedText = '';
      _isListening = true;
    });

    await _speech.listen(
      onResult: (result) {
        if (!mounted) return;

        setState(() {
          _recognizedText = result.recognizedWords;
        });
      },
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
  }

  @override
  void dispose() {
    _speech.stop();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.term),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            item.term,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (item.fullForm != null) ...[
            const SizedBox(height: 8),
            Text(
              '→ ${item.fullForm}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],

          const SizedBox(height: 20),

          Text(
            item.meaning,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          if (item.literalMeaning != null)
            Text('🗿 Literal: ${item.literalMeaning}'),

          if (item.explanation != null) ...[
            const SizedBox(height: 14),
            Text(item.explanation!),
          ],

          const SizedBox(height: 20),

          Text(
            '🔊 ${item.pronunciation}',
            style: const TextStyle(fontSize: 17),
          ),

          const SizedBox(height: 20),

          const Text(
            'Example',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            item.example,
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 6),

          Text(item.exampleMeaning),

          const SizedBox(height: 28),

          ElevatedButton.icon(
            onPressed: _listenToMeow,
            icon: const Icon(Icons.volume_up),
            label: const Text('Listen to Meow'),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: _speechAvailable
                ? (_isListening ? _stopListening : _startListening)
                : null,
            icon: Icon(
              _isListening ? Icons.stop : Icons.mic,
            ),
            label: Text(
              _isListening
                  ? 'Stop listening'
                  : 'Speak your pronunciation',
            ),
          ),

          if (_isListening) ...[
            const SizedBox(height: 12),
            const Text(
              '🎙️ Listening...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],

          if (_recognizedText.isNotEmpty) ...[
            const SizedBox(height: 20),

            const Text(
              'You said:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _recognizedText,
                  style: const TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}