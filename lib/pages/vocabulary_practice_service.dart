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
  ///
  /// When [basicsMode] is true, A1 Basics uses:
  /// - 60% Persian -> English
  /// - 20% English -> Persian
  /// - 10% Example -> Word
  /// - 10% Word -> Example
  ///
  /// When [basicsMode] is false, question types remain fully random.
  static List<VocabularyPracticeQuestion> createSession({
    required List<VocabularyPracticeItem> items,
    int questionCount = 10,
    bool basicsMode = false,
  }) {
    if (items.isEmpty || questionCount <= 0) {
      return [];
    }

    final shuffledItems = [...items]..shuffle(_random);
    final count = min(questionCount, shuffledItems.length);

    if (!basicsMode) {
      return List.generate(count, (index) {
        return createQuestion(
          item: shuffledItems[index],
          allItems: items,
        );
      });
    }

    final types = _createBasicsQuestionTypes(count);
    types.shuffle(_random);

    return List.generate(count, (index) {
      return createQuestion(
        item: shuffledItems[index],
        allItems: items,
        type: types[index],
      );
    });
  }

  /// Creates the closest possible Basics distribution for the requested
  /// number of questions.
  ///
  /// For 10 questions:
  /// - 6 Persian -> English
  /// - 2 English -> Persian
  /// - 1 Example -> Word
  /// - 1 Word -> Example
  static List<VocabularyPracticeType> _createBasicsQuestionTypes(
    int count,
  ) {
    if (count <= 0) {
      return [];
    }

    const weights = <VocabularyPracticeType, double>{
      VocabularyPracticeType.persianToEnglish: 0.60,
      VocabularyPracticeType.englishToPersian: 0.20,
      VocabularyPracticeType.exampleToWord: 0.10,
      VocabularyPracticeType.wordToExample: 0.10,
    };

    final counts = <VocabularyPracticeType, int>{
      for (final type in weights.keys) type: 0,
    };

    final exactTargets = <VocabularyPracticeType, double>{
      for (final entry in weights.entries)
        entry.key: count * entry.value,
    };

    var assigned = 0;

    // First assign the integer parts.
    for (final entry in exactTargets.entries) {
      final whole = entry.value.floor();

      counts[entry.key] = whole;
      assigned += whole;
    }

    // Give remaining questions to the largest fractional parts.
    final fractionalTypes = exactTargets.entries.toList()
      ..sort((a, b) {
        final aFraction = a.value - a.value.floor();
        final bFraction = b.value - b.value.floor();

        return bFraction.compareTo(aFraction);
      });

    var index = 0;

    while (assigned < count) {
      final type = fractionalTypes[index % fractionalTypes.length].key;

      counts[type] = counts[type]! + 1;

      assigned++;
      index++;
    }

    final result = <VocabularyPracticeType>[];

    for (final entry in counts.entries) {
      for (var i = 0; i < entry.value; i++) {
        result.add(entry.key);
      }
    }

    return result;
  }
}