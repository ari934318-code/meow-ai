import 'package:flutter/material.dart';

import '../localization.dart';

class MeowPage extends StatefulWidget {
  const MeowPage({super.key});

  @override
  State<MeowPage> createState() => _MeowPageState();
}

class _MeowPageState extends State<MeowPage> {
  static const Color lavender = Color(0xFFB9A7E8);

  final TextEditingController _controller = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final lang = MeowLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                children: [
                  _meowHeader(context, lang),
                  const SizedBox(height: 24),

                  ...messages.map(
                    (message) {
                      final isUser = message['sender'] == 'user';

                      return _messageBubble(
                        context,
                        message['text']!,
                        isUser,
                      );
                    },
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
            bottomLeft: Radius.circular(isUser ? 20 : 6),
            bottomRight: Radius.circular(isUser ? 6 : 20),
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
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _inputArea(
    BuildContext context,
    MeowLocalizations lang,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
                    Theme.of(context).colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.12),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.12),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(
                    color: lavender.withOpacity(0.65),
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
              borderRadius: BorderRadius.circular(18),
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
    _controller.dispose();
    super.dispose();
  }
}