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
    if (questionFa != null && questionFa!.trim().isNotEmpty) {
      return questionFa!;
    }
    return _persianQuestionFallback(_question);
  }

  List<String> get options {
    if (_options.length < 2) return _options;

    final cacheKey = '$_question\u0000${_options.join('\u0000')}';
    return _shuffledOptionsCache.putIfAbsent(
      cacheKey,
      () {
        final shuffled = List<String>.from(_options)..shuffle();
        return List.unmodifiable(shuffled);
      },
    );
  }

  String? get explanation {
    if (!MeowLocalizations.isPersianGlobal) return _explanation;
    if (explanationFa != null && explanationFa!.trim().isNotEmpty) {
      return explanationFa;
    }
    return _persianExplanationFallback();
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

  String _persianQuestionFallback(String value) {
    var text = value.trim();

    const exact = <String, String>{
      'Choose the correct form:': 'شکل درست را انتخاب کن:',
      'Choose the correct sentence.': 'جمله درست را انتخاب کن.',
      'Choose the correct negative sentence.': 'جمله منفی درست را انتخاب کن.',
      'Choose the correct question.': 'سؤال درست را انتخاب کن.',
      'What is the contraction of': 'شکل کوتاهِ عبارت زیر چیست؟',
      'Complete:': 'جمله را کامل کن:',
      'We use "am" with I.': 'از «am» با I استفاده می‌کنیم.',
      'We use "is" with they.': 'از «is» با they استفاده می‌کنیم.',
      'We use "are" with you.': 'از «are» با you استفاده می‌کنیم.',
    };

    for (final entry in exact.entries) {
      if (text == entry.key) return entry.value;
      if (text.startsWith(entry.key)) {
        text = '${entry.value}${text.substring(entry.key.length)}';
        break;
      }
    }

    const words = <String, String>{
      'Choose': 'انتخاب کن',
      'correct': 'درست',
      'form': 'شکل',
      'sentence': 'جمله',
      'question': 'سؤال',
      'Complete': 'کامل کن',
      'What': 'چه',
      'is': 'است',
      'are': 'هستند',
      'am': 'هستم',
      'with': 'با',
      'I': 'من',
      'you': 'تو',
      'he': 'او',
      'she': 'او',
      'it': 'آن',
      'we': 'ما',
      'they': 'آنها',
      'happy': 'خوشحال',
      'tired': 'خسته',
      'ready': 'آماده',
      'busy': 'مشغول',
      'friend': 'دوست',
      'friends': 'دوستان',
      'sister': 'خواهر',
      'brother': 'برادر',
      'doctor': 'پزشک',
      'student': 'دانش‌آموز / دانشجو',
      'teacher': 'معلم',
      'phone': 'گوشی',
      'home': 'خانه',
      'school': 'مدرسه',
      'work': 'محل کار',
      'cold': 'سرد',
      'today': 'امروز',
      'here': 'اینجا',
      'there': 'آنجا',
      'my': 'من',
      'your': 'تو',
      'from': 'اهل',
      'at': 'در',
      'the': 'آن',
      'new': 'جدید',
      'kind': 'مهربان',
      'nice': 'خوب',
      'late': 'دیر',
      'not': 'نیست',
      'goes': 'می‌رود',
      'have': 'داشتن',
      'has': 'دارد',
      'do': 'انجام دادن',
      'does': 'انجام می‌دهد',
      'can': 'می‌تواند',
      'cannot': 'نمی‌تواند',
      'must': 'باید',
      'mustn’t': 'نباید',
      'one': 'یک',
      'two': 'دو',
      'three': 'سه',
      'four': 'چهار',
      'parents': 'والدین',
      'children': 'بچه‌ها',
      'person': 'شخص',
      'people': 'افراد',
      'thing': 'چیز',
      'things': 'چیزها',
    };

    for (final entry in words.entries) {
      text = text.replaceAllMapped(
        RegExp(r'(?<![A-Za-z])' + RegExp.escape(entry.key) + r'(?![A-Za-z])', caseSensitive: false),
        (_) => entry.value,
      );
    }

    return text;
  }

  String _persianExplanationFallback() {
    final normalized = answer.trim().toLowerCase();

    switch (normalized) {
      case 'am':
        return 'با فاعل I از am استفاده می‌کنیم.';
      case 'is':
        return 'با he، she، it و فاعل مفرد از is استفاده می‌کنیم.';
      case 'are':
        return 'با you، we، they و فاعل جمع از are استفاده می‌کنیم.';
      case 'have':
        return 'با I، you، we و they از have استفاده می‌کنیم.';
      case 'has':
        return 'با he، she، it و فاعل مفرد از has استفاده می‌کنیم.';
      case 'do':
        return 'با I، you، we و they از do استفاده می‌کنیم.';
      case 'does':
        return 'با he، she، it و فاعل مفرد از does استفاده می‌کنیم.';
      case 'can':
        return 'بعد از can همیشه شکل پایه فعل می‌آید.';
      case 'must':
        return 'بعد از must همیشه شکل پایه فعل می‌آید و must معمولاً معنی «باید» می‌دهد.';
      case 'mustn’t':
      case 'mustnt':
        return 'mustn’t برای گفتن ممنوعیت یا «نباید» استفاده می‌شود و بعد از آن شکل پایه فعل می‌آید.';
      case 'he':
        return 'برای یک شخص مذکر از he استفاده می‌کنیم.';
      case 'she':
        return 'برای یک شخص مؤنث از she استفاده می‌کنیم.';
      case 'it':
        return 'برای یک چیز یا حیوان مفرد معمولاً از it استفاده می‌کنیم.';
      case 'they':
        return 'برای دو یا چند نفر یا چیز از they استفاده می‌کنیم.';
      case 'we':
        return 'برای خودمان همراه با افراد دیگر از we استفاده می‌کنیم.';
      case 'i':
        return 'I برای صحبت درباره خودمان استفاده می‌شود.';
      default:
        if (normalized == 'true') return 'این جمله درست است.';
        if (normalized == 'false') return 'این جمله درست نیست.';
        return 'پاسخ درست «$answer» است.';
    }
  }
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
