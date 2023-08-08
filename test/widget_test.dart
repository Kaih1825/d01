// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:d01/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test", () {
    testWidgets('Step No:1,Application startup', (WidgetTester tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 10));
      // await tester.pumpAndSettle();
    });
    testWidgets('Step No:2,Open drawer menu by clicking the menu button', (WidgetTester tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 10));
      // await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
    });
  });
}
