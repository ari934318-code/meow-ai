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
  final List<A1BasicExample> examples;
  final List<A1BasicQuestion> questions;
  final List<A1BasicSpeakingQuestion> speakingQuestions;
  final List<A1BasicVocabulary> vocabulary;

  const A1BasicLesson({required this.id, required this.title, required this.titleFa, required this.topic, required this.explanation, required List<A1BasicSection> sections, required this.examples, required this.questions, required this.speakingQuestions, this.vocabulary = const []}) : _sections = sections;
  List<A1BasicSection> get sections => _sections;
  A1BasicLesson copyWithQuestions(List<A1BasicQuestion> newQuestions) => A1BasicLesson(id:id,title:title,titleFa:titleFa,topic:topic,explanation:explanation,sections:_sections,examples:examples,questions:newQuestions,speakingQuestions:speakingQuestions,vocabulary:vocabulary);
}

class A1BasicSection {
  final String title;
  final String titleFa;
  final String explanation;
  final String explanationFa;
  final List<A1BasicExample> examples;
  const A1BasicSection({required this.title,required this.titleFa,required this.explanation,required this.explanationFa,required this.examples});
}
class A1BasicExample {
  final String english; final String persian; final String? pronunciation;
  const A1BasicExample({required this.english,required this.persian,this.pronunciation});
}
class A1BasicQuestion {
  static final Map<String,List<String>> _shuffledOptionsCache={};
  final String _question; final String? questionFa; final List<String> _options; final String answer; final List<String> acceptableAnswers; final String? _explanation; final String? explanationFa; final String? hint; final String _type;
  const A1BasicQuestion({required String type,required String question,this.questionFa,required List<String> options,required this.answer,this.acceptableAnswers=const [],String? explanation,this.explanationFa,this.hint}):_type=type,_question=question,_options=options,_explanation=explanation;
  String get type {switch(_type.trim()){case 'fill_blank':case 'fillInTheBlank':return 'fillInTheBlank';case 'multiple_choice':case 'multipleChoice':case 'true_false':case 'trueFalse':case 'translation':case 'word_order':case 'wordOrder':return 'multipleChoice';case 'typing':return 'typing';default:return 'multipleChoice';}}
  String get question=>MeowLocalizations.isPersianGlobal&&questionFa!=null&&questionFa!.trim().isNotEmpty?questionFa!: _question;
  List<String> get options {if(_options.length<2)return _options;final cacheKey='$_question\u0000${_options.join('\u0000')}';return _shuffledOptionsCache.putIfAbsent(cacheKey,(){final shuffled=List<String>.from(_options)..shuffle();return List.unmodifiable(shuffled);});}
  String? get explanation=>MeowLocalizations.isPersianGlobal&&explanationFa!=null&&explanationFa!.trim().isNotEmpty?explanationFa:_explanation;
  List<String> get allAcceptedAnswers {final answers=<String>[answer,...acceptableAnswers];final result=<String>[];for(final item in answers){final normalized=item.trim();if(normalized.isEmpty)continue;if(!result.contains(normalized))result.add(normalized);}return result;}
}
class A1BasicSpeakingQuestion {final String question;final String persian;final List<String> acceptableAnswers;const A1BasicSpeakingQuestion({required this.question,required this.persian,required this.acceptableAnswers});}
