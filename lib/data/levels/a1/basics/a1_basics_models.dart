import '../../../../localization.dart';

class A1BasicVocabulary {
  final String english;
  final String persian;
  final String? pronunciation;
  final String example;
  final List<A1BasicVocabulary> vocabulary;

  const A1BasicVocabulary({
    required this.english,
    required this.persian,
    this.pronunciation,
    required this.example,
    this.vocabulary = const [],
  });
}

class A1BasicLesson {
  final String id;
  final String title;
  final String titleFa;
  final String topic;
  final String explanation;
  final List<A1BasicSection> _sections;
  final List<A1BasicLearningPhase> learningPhases;
  final List<A1BasicExample> examples;
  final List<A1BasicQuestion> questions;
  final List<A1BasicSpeakingQuestion> speakingQuestions;
  final List<A1BasicVocabulary> vocabulary;

  const A1BasicLesson({
    required this.id,
    required this.title,
    required this.titleFa,
    required this.topic,
    required this.explanation,
    required List<A1BasicSection> sections,
    this.learningPhases = const [],
    required this.examples,
    required this.questions,
    required this.speakingQuestions,
    this.vocabulary = const [],
  }) : _sections = sections;

  List<A1BasicSection> get sections => _sections;

  A1BasicLesson copyWithQuestions(List<A1BasicQuestion> newQuestions) {
    return A1BasicLesson(
      id: id,
      title: title,
      titleFa: titleFa,
      topic: topic,
      explanation: explanation,
      sections: _sections,
      learningPhases: learningPhases,
      examples: examples,
      questions: newQuestions,
      speakingQuestions: speakingQuestions,
      vocabulary: vocabulary,
    );
  }
}

class A1BasicSection {
  final String title;
  final String titleFa;
  final String explanation;
  final String explanationFa;
  final List<A1BasicExample> examples;

  const A1BasicSection({
    required this.title,
    required this.titleFa,
    required this.explanation,
    required this.explanationFa,
    required this.examples,
  });
}

class A1BasicLearningPhase {
  final String type;
  final String title;
  final String titleFa;
  final String body;
  final String bodyFa;
  final List<A1BasicExample> examples;
  final List<List<String>> tableRows;

  const A1BasicLearningPhase({
    required this.type,
    required this.title,
    required this.titleFa,
    required this.body,
    required this.bodyFa,
    this.examples = const [],
    this.tableRows = const [],
  });
}

class A1BasicExample {
  final String english;
  final String persian;
  final String? pronunciation;

  const A1BasicExample({
    required this.english,
    required this.persian,
    this.pronunciation,
  });
}

class A1BasicQuestion {
  static final Map<String, List<String>> _shuffledOptionsCache = {};

  final String _question;
  final String? questionFa;
  final List<String> _options;
  final String answer;
  final List<String> acceptableAnswers;
  final String? _explanation;
  final String? explanationFa;
  final String? hint;
  final String _type;

  const A1BasicQuestion({
    required String type,
    required String question,
    this.questionFa,
    required List<String> options,
    required this.answer,
    this.acceptableAnswers = const [],
    String? explanation,
    this.explanationFa,
    this.hint,
  })  : _type = type,
        _question = question,
        _options = options,
        _explanation = explanation;

  String get type {
    switch (_type.trim()) {
      case 'fill_blank':
      case 'fillInTheBlank':
        return 'fillInTheBlank';
      case 'multiple_choice':
      case 'multipleChoice':
      case 'true_false':
      case 'trueFalse':
      case 'translation':
      case 'word_order':
      case 'wordOrder':
        return 'multipleChoice';
      case 'typing':
        return 'typing';
      default:
        return 'multipleChoice';
    }
  }

  String get question {
    if (!MeowLocalizations.isPersianGlobal) return _question;
    if (questionFa != null && questionFa!.trim().isNotEmpty) return questionFa!;
    return _localizeQuestion(_question);
  }

  List<String> get options {
    if (_options.length < 2) return _options;
    final cacheKey = '$_question\u0000${_options.join('\u0000')}';
    return _shuffledOptionsCache.putIfAbsent(cacheKey, () {
      final shuffled = List<String>.from(_options)..shuffle();
      return List.unmodifiable(shuffled);
    });
  }

  String? get explanation {
    if (!MeowLocalizations.isPersianGlobal) return _explanation;
    if (explanationFa != null && explanationFa!.trim().isNotEmpty) return explanationFa;
    return _localizeExplanation(_explanation);
  }

  List<String> get allAcceptedAnswers {
    final answers = <String>[answer, ...acceptableAnswers];
    final result = <String>[];
    for (final item in answers) {
      final normalized = item.trim();
      if (normalized.isEmpty) continue;
      if (!result.contains(normalized)) result.add(normalized);
    }
    return result;
  }

  String _localizeQuestion(String value) {
    final q = value.trim();

    if (q.startsWith('Choose the correct form:')) {
      return 'شکل درست را انتخاب کن: ${_translateSentence(q.substring('Choose the correct form:'.length).trim())}';
    }
    if (q == 'Choose the correct sentence.') return 'جمله درست را انتخاب کن.';
    if (q == 'Choose the correct negative sentence.') return 'جمله منفی درست را انتخاب کن.';
    if (q == 'Choose the correct question.') return 'سؤال درست را انتخاب کن.';
    if (q == 'Which sentence is correct?') return 'کدام جمله درست است؟';
    if (q == 'Complete:') return 'جمله را کامل کن.';
    if (q.startsWith('Complete:')) {
      return 'کامل کن: ${_translateSentence(q.substring('Complete:'.length).trim())}';
    }
    if (q.startsWith('Put the words in order:')) {
      final rest = q.substring('Put the words in order:'.length).trim();
      return 'کلمات را به ترتیب درست بچین: $rest';
    }
    if (q.startsWith('What is the contraction of')) {
      final rest = q.substring('What is the contraction of'.length).trim();
      return 'شکل کوتاهِ $rest چیست؟';
    }
    if (q.startsWith('What does')) {
      return q.replaceFirst('What does', 'معنی').replaceFirst('mean?', 'چیست؟');
    }
    if (q.startsWith('We use ')) {
      return _translateRuleQuestion(q);
    }
    if (q.startsWith('"') && q.endsWith('" is correct.')) {
      return 'آیا $q';
    }
    if (q.startsWith('"') && q.endsWith('" is correct English.')) {
      return 'آیا $q';
    }
    if (q.startsWith('After ')) {
      return 'بعد از این عبارت چه چیزی استفاده می‌کنیم؟ ${_translateSentence(q)}';
    }
    if (q.startsWith('ترجمه کن:')) return q;

    return _translateSentence(q);
  }

  String _translateRuleQuestion(String q) {
    final rules = <String, String>{
      'We use "am" with I.': 'از «am» با I استفاده می‌کنیم.',
      'We use "is" with they.': 'از «is» با they استفاده می‌کنیم.',
      'We use "are" with you.': 'از «are» با you استفاده می‌کنیم.',
      'We use "has" with she.': 'از «has» با she استفاده می‌کنیم.',
      'We use "has" with they.': 'از «has» با they استفاده می‌کنیم.',
      'After "doesn’t", we use "have".': 'بعد از «doesn’t» از «have» استفاده می‌کنیم.',
    };
    return rules[q] ?? _translateSentence(q);
  }

  String _translateSentence(String input) {
    final exact = <String, String>{
      'I ___ a phone.': 'من ___ یک گوشی دارم.',
      'She ___ a cat.': 'او ___ یک گربه دارد.',
      'They ___ two children.': 'آنها ___ دو فرزند دارند.',
      'He ___ a new car.': 'او ___ یک ماشین جدید دارد.',
      'We ___ a problem.': 'ما ___ یک مشکل داریم.',
      'It ___ four legs.': 'آن ___ چهار پا دارد.',
      'You ___ a beautiful house.': 'تو ___ یک خانه زیبا داری.',
      'I ___ two sisters.': 'من ___ دو خواهر دارم.',
      'She ___ blue eyes.': 'او ___ چشم‌های آبی دارد.',
      'They ___ a big house.': 'آنها ___ یک خانه بزرگ دارند.',
      'I ___ from Iran.': 'من ___ اهل ایران هستم.',
      'She ___ my sister.': 'او ___ خواهر من است.',
      'We ___ at home.': 'ما ___ در خانه هستیم.',
      'Choose the correct form:': 'شکل درست را انتخاب کن:',
      'Are you okay?': 'حالت خوب است؟',
      'Is she your sister?': 'آیا او خواهر توست؟',
      'Are they ready?': 'آیا آنها آماده‌اند؟',
    };
    if (exact.containsKey(input)) return exact[input]!;

    var text = input;
    const words = <String, String>{
      'I': 'من', 'You': 'تو', 'He': 'او', 'She': 'او', 'It': 'آن',
      'We': 'ما', 'They': 'آنها', 'my': 'من', 'your': 'تو',
      'phone': 'گوشی', 'car': 'ماشین', 'cat': 'گربه', 'house': 'خانه',
      'home': 'خانه', 'brother': 'برادر', 'sister': 'خواهر',
      'children': 'بچه‌ها', 'child': 'بچه', 'problem': 'مشکل',
      'time': 'وقت', 'money': 'پول', 'ready': 'آماده', 'happy': 'خوشحال',
      'tired': 'خسته', 'busy': 'مشغول', 'friend': 'دوست', 'friends': 'دوستان',
      'student': 'دانش‌آموز / دانشجو', 'doctor': 'پزشک', 'teacher': 'معلم',
      'here': 'اینجا', 'there': 'آنجا', 'today': 'امروز', 'cold': 'سرد',
      'new': 'جدید', 'beautiful': 'زیبا', 'nice': 'خوب', 'big': 'بزرگ',
      'two': 'دو', 'three': 'سه', 'four': 'چهار', 'a': 'یک', 'an': 'یک',
      'have': 'دارم', 'has': 'دارد', 'am': 'هستم', 'is': 'است', 'are': 'هستند',
      'do': 'انجام می‌دهم', 'does': 'انجام می‌دهد', 'can': 'می‌تواند',
      'must': 'باید', 'not': 'نیست', 'with': 'با', 'from': 'از', 'at': 'در',
      'in': 'در', 'on': 'روی', 'and': 'و', 'or': 'یا',
    };
    for (final entry in words.entries) {
      text = text.replaceAllMapped(
        RegExp(r'(?<![A-Za-z])' + RegExp.escape(entry.key) + r'(?![A-Za-z])'),
        (_) => entry.value,
      );
    }
    return text;
  }

  String? _localizeExplanation(String? value) {
    if (value == null || value.trim().isEmpty) return value;
    final a = answer.trim().toLowerCase();
    switch (a) {
      case 'am': return 'با فاعل I از am استفاده می‌کنیم.';
      case 'is': return 'با he، she، it و فاعل مفرد از is استفاده می‌کنیم.';
      case 'are': return 'با you، we و they از are استفاده می‌کنیم.';
      case 'have': return 'با I، you، we و they از have استفاده می‌کنیم.';
      case 'has': return 'با he، she، it و فاعل مفرد از has استفاده می‌کنیم.';
      case 'do': return 'با I، you، we و they از do استفاده می‌کنیم.';
      case 'does': return 'با he، she، it و فاعل مفرد از does استفاده می‌کنیم.';
      case 'can': return 'بعد از can شکل پایه فعل می‌آید.';
      case 'must': return 'بعد از must شکل پایه فعل می‌آید و must معمولاً معنی «باید» می‌دهد.';
      case 'true': return 'این جمله درست است.';
      case 'false': return 'این جمله درست نیست.';
      default: return 'پاسخ درست «$answer» است.';
    }
  }
}

class A1BasicListeningQuestion {
  final String sentence;
  final String sentenceFa;
  final List<String> options;
  final String answer;

  const A1BasicListeningQuestion({
    required this.sentence,
    required this.sentenceFa,
    required this.options,
    required this.answer,
  });
}

class A1BasicSpeakingQuestion {
  final String question;
  final String persian;
  final List<String> acceptableAnswers;

  const A1BasicSpeakingQuestion({
    required this.question,
    required this.persian,
    required this.acceptableAnswers,
  });
}
