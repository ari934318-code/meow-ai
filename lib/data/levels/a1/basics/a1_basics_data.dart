import 'a1_basics_models.dart';

import 'a1_01_pronouns.dart';
import 'a1_01_pronouns_extra.dart';
import 'a1_02_to_be.dart';
import 'a1_03_have_has.dart';
import 'a1_04_do_does.dart';
import 'a1_05_regular_verbs.dart';
import 'a1_06_irregular_verbs.dart';
import 'a1_07_can_cant.dart';
import 'a1_08_must_mustnt.dart';
import 'a1_09_object_pronouns.dart';
import 'a1_10_possessive_adjectives.dart';
import 'a1_11_present_simple.dart';

final List<A1BasicLesson> a1BasicsLessons = [
  a1BasicPronouns.copyWithQuestions([
    ...a1BasicPronouns.questions,
    ...a1PronounExtraQuestions,
  ]),
  a1BasicToBe,
  a1BasicHaveHas,
  a1BasicDoDoes,
  a1BasicRegularVerbs,
  a1BasicIrregularVerbs,
  a1BasicCanCant,
  a1BasicMustMustnt,
  a1BasicObjectPronouns,
  a1BasicPossessiveAdjectives,
  a1BasicPresentSimple,
];
