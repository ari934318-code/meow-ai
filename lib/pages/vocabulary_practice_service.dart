import 'dart:math';

import 'vocabulary_practice_models.dart';

class VocabularyPracticeService {
  static final Random _random = Random();

  /// Creates a practice question from vocabulary data.
  static VocabularyPracticeQuestion createQuestion({
    required VocabularyPracticeItem item,
    required List<VocabularyPracticeItem> allItems,
    VocabularyPracticeType? type,
  }) {
    final selectedType =
        type ??
        VocabularyPracticeType.values[
          _random.nextInt(VocabularyPracticeType.values.length)
        ];

    switch (selectedType) {
      case VocabularyPracticeType.englishToPersian:
        return _englishToPersian(item, allItems);

      case VocabularyPracticeType.persianToEnglish:
        return _persianToEnglish(item, allItems);

      case VocabularyPracticeType.exampleToWord:
        return _exampleToWord(item, allItems);

      case VocabularyPracticeType.wordToExample:
        return _wordToExample(item, allItems);
    }
  }

  static VocabularyPracticeQuestion _englishToPersian(
    VocabularyPracticeItem item,
    List<VocabularyPracticeItem> allItems,
  ) {
    final options = _createOptions(
      correctAnswer: item.persian,
      candidates: allItems.map((e) => e.persian).toList(),
    );

    return VocabularyPracticeQuestion(
      type: VocabularyPracticeType.englishToPersian,
      item: item,
      question: 'What does "${item.english}" mean?',
      options: options,
      correctAnswer: item.persian,
    );
  }

  static VocabularyPracticeQuestion _persianToEnglish(
    VocabularyPracticeItem item,
    List<VocabularyPracticeItem> allItems,
  ) {
    final options = _createOptions(
      correctAnswer: item.english,
      candidates: allItems.map((e) => e.english).toList(),
    );

    return VocabularyPracticeQuestion(
      type: VocabularyPracticeType.persianToEnglish,
      item: item,
      question: 'Which English word means "${item.persian}"?',
      options: options,
      correctAnswer: item.english,
    );
  }

  static VocabularyPracticeQuestion _exampleToWord(
    VocabularyPracticeItem item,
    List<VocabularyPracticeItem> allItems,
  ) {
    final options = _createOptions(
      correctAnswer: item.english,
      candidates: allItems.map((e) => e.english).toList(),
    );

    return VocabularyPracticeQuestion(
      type: VocabularyPracticeType.exampleToWord,
      item: item,
      question: 'Which word completes this example?',
      options: options,
      correctAnswer: item.english,
    );
  }

  static VocabularyPracticeQuestion _wordToExample(
    VocabularyPracticeItem item,
    List<VocabularyPracticeItem> allItems,
  ) {
    final options = _createOptions(
      correctAnswer: item.example,
      candidates: allItems.map((e) => e.example).toList(),
    );

    return VocabularyPracticeQuestion(
      type: VocabularyPracticeType.wordToExample,
      item: item,
      question: 'Which example uses "${item.english}" correctly?',
      options: options,
      correctAnswer: item.example,
    );
  }

  static List<String> _createOptions({
    required String correctAnswer,
    required List<String> candidates,
  }) {
    final uniqueCandidates = candidates
        .where((value) => value.trim().isNotEmpty)
        .where((value) => value != correctAnswer)
        .toSet()
        .toList();

    uniqueCandidates.shuffle(_random);

    final options = <String>[
      correctAnswer,
      ...uniqueCandidates.take(3),
    ];

    options.shuffle(_random);

    return options;
  }

  /// Creates a shuffled practice session.
  static List<VocabularyPracticeQuestion> createSession({
    required List<VocabularyPracticeItem> items,
    int questionCount = 10,
  }) {
    if (items.isEmpty) {
      return [];
    }

    final shuffledItems = [...items]..shuffle(_random);

    final count = min(questionCount, shuffledItems.length);

    return List.generate(count, (index) {
      return createQuestion(
        item: shuffledItems[index],
        allItems: items,
      );
    });
  }
}