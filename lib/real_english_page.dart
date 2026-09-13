import 'package:flutter/material.dart';
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

class RealEnglishDetailPage extends StatelessWidget {
  final RealEnglishItem item;

  const RealEnglishDetailPage({
    super.key,
    required this.item,
  });

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
            onPressed: () {},
            icon: const Icon(Icons.volume_up),
            label: const Text('Listen to Meow'),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.mic),
            label: const Text('Record your pronunciation'),
          ),
        ],
      ),
    );
  }
}