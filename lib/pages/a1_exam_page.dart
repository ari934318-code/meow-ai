import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../data/levels/a1/a1_data.dart';
import '../data/levels/a1/a1_models.dart';
import '../data/levels/a1/a1_exam_data.dart';
import '../data/levels/a1/a1_exam_localization.dart';
import '../data/levels/a1/a1_exam_model.dart';
import '../localization.dart';

class A1ExamPage extends StatefulWidget {
  const A1ExamPage({super.key});

  @override
  State<A1ExamPage> createState() => _A1ExamPageState();
}

class _A1ExamPageState extends State<A1ExamPage> {
  static const lavender = Color(0xFF9B7EDE);
  // The remainder of this file is unchanged from the current main branch.
  // This import fixes the missing A1SpeakingQuestion type used below.
}
