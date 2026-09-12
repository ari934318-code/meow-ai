import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:meow_ai/main.dart';

void main() {
  testWidgets('App launches and shows title', (WidgetTester tester) async {
    await tester.pumpWidget(const MeowApp());
    expect(find.text('Meow AI - Foundation'), findsOneWidget);
  });
}
