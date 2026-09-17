import 'a1_basics_models.dart';

import 'a1_01_pronouns.dart';
import 'a1_01_pronouns_extra.dart';
import 'a1_02_to_be.dart';
import 'a1_03_have_has.dart';
import 'a1_04_do_does.dart';
import 'a1_05_regular_verbs.dart';
import 'a1_06_irregular_verbs.dart';
import 'a1_06_irregular_verbs_questions_localized.dart';
import 'a1_07_can_cant.dart';
import 'a1_07_can_cant_questions_localized.dart';
import 'a1_08_must_mustnt.dart';
import 'a1_08_must_mustnt_questions_localized.dart';
import 'a1_09_object_pronouns.dart';
import 'a1_09_object_pronouns_questions_localized.dart';
import 'a1_10_possessive_adjectives.dart';
import 'a1_10_possessive_adjectives_questions_localized.dart';
import 'a1_11_present_simple.dart';
import 'a1_11_present_simple_questions_localized.dart';

final List<A1BasicLesson> a1BasicsLessons = [
  a1BasicPronouns.copyWithQuestions([
    ...a1BasicPronouns.questions,
    ...a1PronounExtraQuestions,
  ]),
  a1BasicToBe,
  a1BasicHaveHas,
  a1BasicDoDoes,
  a1BasicRegularVerbs,
  a1BasicIrregularVerbs.copyWithQuestions(a1IrregularVerbsQuestions),
  a1BasicCanCant.copyWithQuestions(a1CanCantQuestions),
  a1BasicMustMustnt.copyWithQuestions(a1MustMustntQuestions),
  a1BasicObjectPronouns.copyWithQuestions(a1ObjectPronounsQuestions),
  a1BasicPossessiveAdjectives.copyWithQuestions(
    a1PossessiveAdjectivesQuestions,
  ),
  a1BasicPresentSimple.copyWithQuestions(a1PresentSimpleQuestions),
];
