import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meow AI 🐱',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Welcome back! 👋',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Ready to learn English with Meow?',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Level',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'A1 • Beginner',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0.25,
                    minHeight: 9,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 8),
                  const Text('25% completed'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _statCard(
                  '🔥',
                  'Streak',
                  '0 days',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  '⭐',
                  'XP',
                  '0 XP',
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          _mainButton(
            context,
            '📚 Learn',
            'Continue your English lessons',
            '/learn',
          ),

          _mainButton(
            context,
            '🎯 Practice',
            'Practice speaking, writing & more',
            '/practice',
          ),

          _mainButton(
            context,
            '🐱 Talk to Meow',
            'Practice English with your AI teacher',
            '/meow',
          ),

          _mainButton(
            context,
            '📈 Progress',
            'See your learning progress',
            '/progress',
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    String icon,
    String title,
    String value,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainButton(
    BuildContext context,
    String title,
    String subtitle,
    String route,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
