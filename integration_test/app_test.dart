import 'package:d01/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var time = 10;
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Test Group", () {
    testWidgets('Step No:1,Application startup', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.menu), findsOneWidget);
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets('Step No:2,Open drawer menu by clicking the menu button', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(); //不斷pump直到所有幀都繪製完成
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.text("Skills"), findsOneWidget);
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:3,Click the skill type \"Information and Communication Technology\"", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Information and Communication Technology"));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Information Network Cabling").at(1));
      await tester.pumpAndSettle();
      expect(find.text("Information Network Cabling").first, findsOneWidget);
      expect(find.text("Skills"), findsNothing);
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:4,Show the Information Network Cabling News List by clicking \"Information Network Cabling\"", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Information and Communication Technology"));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Information Network Cabling").at(1));
      await tester.pumpAndSettle();
      expect(find.text("Information Network Cabling").first, findsOneWidget);
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:5,Scroll the news list until there appears a piece of news with the title including \"London\"", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Information and Communication Technology"));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Information Network Cabling").at(1));
      await tester.pumpAndSettle();
      while (true) {
        await tester.drag(find.byType(ListView), const Offset(0, -50));
        await tester.pump();
        try {
          expect(find.textContaining("London"), findsOneWidget);
          await tester.drag(find.byType(ListView), const Offset(0, -100));
          await tester.pumpAndSettle();
          break;
        } catch (ex) {}
      }
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:6,Open drawer menu by clicking the menu button", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.text("Skills"), findsOneWidget);
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:7,Click \"Search Now\" Button", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Search Now"));
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:8,Input text into the Input box of the news title", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Search Now"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, "web");
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:9,Input text into the Input box of skill", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Search Now"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, "web");
      await tester.enterText(find.byType(TextField).at(1), "Mobile");
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:10,Input start date and end date into the input boxes of date", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Search Now"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, "web");
      await tester.enterText(find.byType(TextField).at(1), "Mobile");
      await tester.enterText(find.byType(TextField).at(2), "03/21/2022");
      await tester.enterText(find.byType(TextField).at(3), "09/30/2022");
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:11,Click the search icon button", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Search Now"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, "web");
      await tester.enterText(find.byType(TextField).at(1), "Mobile");
      await tester.enterText(find.byType(TextField).at(2), "03/21/2022");
      await tester.enterText(find.byType(TextField).at(3), "09/30/2022");
      await tester.tap(find.byKey(const Key("Search Button")));
      await tester.pumpAndSettle();
      expect(find.text("Search Results"), findsOneWidget);
      expect(find.text("Skills"), findsNothing);
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:12,Scroll the news list until the tenth news appears", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Search Now"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, "web");
      await tester.enterText(find.byType(TextField).at(1), "Mobile");
      await tester.enterText(find.byType(TextField).at(2), "03/21/2022");
      await tester.enterText(find.byType(TextField).at(3), "09/30/2022");
      await tester.tap(find.byKey(const Key("Search Button")));
      await tester.pumpAndSettle();
      expect(find.text("Search Results"), findsOneWidget);
      expect(find.text("Skills"), findsNothing);
      while (true) {
        await tester.drag(find.byType(ListView), const Offset(0, -100));
        await tester.pumpAndSettle();
        try {
          expect(find.text("10"), findsOneWidget);
          await tester.drag(find.byType(ListView), const Offset(0, -100));
          await tester.pumpAndSettle();
          break;
        } catch (ex) {}
      }
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:13,Click the tenth news", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Search Now"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, "web");
      await tester.enterText(find.byType(TextField).at(1), "Mobile");
      await tester.enterText(find.byType(TextField).at(2), "03/21/2022");
      await tester.enterText(find.byType(TextField).at(3), "09/30/2022");
      await tester.tap(find.byKey(const Key("Search Button")));
      await tester.pumpAndSettle();
      expect(find.text("Search Results"), findsOneWidget);
      expect(find.text("Skills"), findsNothing);
      while (true) {
        await tester.drag(find.byType(ListView), const Offset(0, -100));
        await tester.pumpAndSettle();
        try {
          expect(find.text("10"), findsOneWidget);
          await tester.drag(find.byType(ListView), const Offset(0, -100));
          await tester.pumpAndSettle();
          break;
        } catch (ex) {}
      }
      await tester.tap(find.text("10"));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.close), findsOneWidget);
      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:14,Click the \"+\" Button", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Search Now"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, "web");
      await tester.enterText(find.byType(TextField).at(1), "Mobile");
      await tester.enterText(find.byType(TextField).at(2), "03/21/2022");
      await tester.enterText(find.byType(TextField).at(3), "09/30/2022");
      await tester.tap(find.byKey(const Key("Search Button")));
      await tester.pumpAndSettle();
      expect(find.text("Search Results"), findsOneWidget);
      expect(find.text("Skills"), findsNothing);
      while (true) {
        await tester.drag(find.byType(ListView), const Offset(0, -100));
        await tester.pumpAndSettle();
        try {
          expect(find.text("10"), findsOneWidget);
          await tester.drag(find.byType(ListView), const Offset(0, -100));
          await tester.pumpAndSettle();
          break;
        } catch (ex) {}
      }
      await tester.tap(find.text("10"));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await Future.delayed(Duration(seconds: time));
    });

    testWidgets("Step No:15,Click the close icon button", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Search Now"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, "web");
      await tester.enterText(find.byType(TextField).at(1), "Mobile");
      await tester.enterText(find.byType(TextField).at(2), "03/21/2022");
      await tester.enterText(find.byType(TextField).at(3), "09/30/2022");
      await tester.tap(find.byKey(const Key("Search Button")));
      await tester.pumpAndSettle();
      expect(find.text("Search Results"), findsOneWidget);
      expect(find.text("Skills"), findsNothing);
      while (true) {
        await tester.drag(find.byType(ListView), const Offset(0, -100));
        await tester.pumpAndSettle();
        try {
          expect(find.text("10"), findsOneWidget);
          await tester.drag(find.byType(ListView), const Offset(0, -100));
          await tester.pumpAndSettle();
          break;
        } catch (ex) {}
      }
      await tester.tap(find.text("10"));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.close), findsNothing);
      await Future.delayed(Duration(seconds: time));
    });
  });
}
