import 'package:flutter/material.dart';

class RealEnglishPage extends StatelessWidget {
  const RealEnglishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real English'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Learn the English people actually use 😼',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            _RealEnglishCard(
              icon: Icons.short_text,
              title: 'Abbreviations',
              subtitle: 'ASAP • BTW • IDK • TBH • OMG • LOL',
              onTap: () {},
            ),

            const SizedBox(height: 14),

            _RealEnglishCard(
              icon: Icons.forum_outlined,
              title: 'Idioms & Slang',
              subtitle: 'Piece of cake • Ghosting • Red flag...',
              onTap: () {},
            ),

            const SizedBox(height: 14),

            _RealEnglishCard(
              icon: Icons.record_voice_over_outlined,
              title: 'Short Forms',
              subtitle: 'Gonna • Wanna • Gotta • Kinda • Lemme...',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _RealEnglishCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RealEnglishCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}