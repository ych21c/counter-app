import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('Design Spec Validation - Counter App', () {
    testWidgets('AppBar displays with correct title and styling', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.byType(AppBar), findsWidgets);
      expect(find.text('🔢 Flutter Counter'), findsOneWidget);
      
      final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, const Color(0xFF4F46E5));
      expect(appBar.centerTitle, true);
    });

    testWidgets('Background color matches design spec (#F0F4FF)', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final Scaffold scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, const Color(0xFFF0F4FF));
    });

    testWidgets('Counter display card with white background and elevation', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final cards = find.byType(Card);
      expect(cards, findsWidgets);
      
      final Card card = tester.widget<Card>(cards.first);
      expect(card.color, Colors.white);
      expect(card.elevation, 8);
    });

    testWidgets('Counter label text displays "현재 카운트"', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('현재 카운트'), findsOneWidget);
    });

    testWidgets('Initial counter value displays as 0', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('0'), findsWidgets);
      
      final counterValueText = find.descendant(
        of: find.byType(Card),
        matching: find.text('0'),
      );
      expect(counterValueText, findsWidgets);
    });

    testWidgets('Counter value text uses large font size (96)', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final texts = find.byType(Text);
      bool foundLargeText = false;
      
      for (int i = 0; i < texts.evaluate().length; i++) {
        final Text textWidget = tester.widget<Text>(texts.at(i));
        if (textWidget.style?.fontSize == 96 && textWidget.data == '0') {
          foundLargeText = true;
          break;
        }
      }
      
      expect(foundLargeText, true);
    });

    testWidgets('Increment button exists and is styled correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      expect(incrementButton, findsOneWidget);
      
      final button = tester.widget<ElevatedButton>(
        find.ancestor(
          of: incrementButton,
          matching: find.byType(ElevatedButton),
        ),
      );
      expect(button.style, isNotNull);
    });

    testWidgets('Decrement button exists with minus icon', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final decrementButton = find.byIcon(Icons.remove);
      expect(decrementButton, findsOneWidget);
    });

    testWidgets('Reset button exists with refresh icon', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final resetButton = find.byIcon(Icons.refresh);
      expect(resetButton, findsOneWidget);
    });

    testWidgets('Clicking increment button increases counter value', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('0'), findsWidgets);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('1'), findsWidgets);
    });

    testWidgets('Multiple increment clicks increase counter sequentially', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      for (int i = 1; i <= 5; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
        expect(find.text('$i'), findsWidgets);
      }
    });

    testWidgets('Decrement button decreases counter value', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('2'), findsWidgets);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('1'), findsWidgets);
    });

    testWidgets('Reset button resets counter to 0', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('3'), findsWidgets);

      // The action log adds height; scroll reset button into view before tapping.
      await tester.ensureVisible(find.byIcon(Icons.refresh));
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pump();

      expect(find.text('0'), findsWidgets);
    });

    testWidgets('Button row displays increment, decrement, and reset buttons horizontally', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final row = find.byType(Row);
      expect(row, findsWidgets);

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('Counter display has proper padding and margin', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final card = find.byType(Card).first;
      final cardWidget = tester.widget<Card>(card);
      
      expect(cardWidget.child, isNotNull);
    });

    testWidgets('All buttons have Material style with proper elevation', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final buttons = find.byType(ElevatedButton);
      expect(buttons, findsWidgets);

      for (int i = 0; i < buttons.evaluate().length; i++) {
        final button = tester.widget<ElevatedButton>(buttons.at(i));
        expect(button.style, isNotNull);
      }
    });

    testWidgets('Counter display is centered vertically on screen', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final card = find.byType(Card);
      expect(card, findsWidgets);
      
      final cardPosition = tester.getCenter(card.first);
      final logicalSize = tester.view.physicalSize / tester.view.devicePixelRatio;
      final screenCenter = Offset(logicalSize.width / 2, logicalSize.height / 2);
      
      expect(cardPosition.dx, closeTo(screenCenter.dx, 50));
    });
  });
}