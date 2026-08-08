import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('앱 실행 시 카운터가 0에서 시작한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('버튼을 누르면 카운터가 1씩 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('버튼을 여러 번 누르면 카운터가 계속 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('카운터 숫자가 중앙에 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final textFinder = find.text('0');
    expect(textFinder, findsOneWidget);

    final counterText = tester.widget<Text>(textFinder);
    expect(counterText.style?.fontSize, 64);
  });

  testWidgets('증가 버튼이 화면에 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);
  });
}