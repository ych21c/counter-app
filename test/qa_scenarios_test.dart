import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('앱 실행 시 초기값 0이 화면 중앙에 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsWidgets);
    expect(find.byType(Text), findsWidgets);
  });

  testWidgets('버튼을 누르면 카운터가 1씩 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsWidgets);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('1'), findsWidgets);
  });

  testWidgets('버튼을 여러 번 누르면 카운터가 계속 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsWidgets);

    for (int i = 0; i < 5; i++) {
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
    }

    expect(find.text('5'), findsWidgets);
  });

  testWidgets('증가 버튼이 화면에 표시되고 누를 수 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('1'), findsWidgets);
  });

  testWidgets('화면이 Scaffold로 구성되어 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('카운터 숫자가 큰 폰트 크기로 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final textWidget = find.byType(Text);
    expect(textWidget, findsWidgets);

    final counterText = tester.widget<Text>(find.text('0'));
    expect(counterText.style?.fontSize, 64);
  });

  testWidgets('카운터와 버튼이 중앙에 수직으로 배치되어 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Center), findsWidgets);
    expect(find.text('0'), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('버튼을 10번 누르면 카운터가 10까지 정상 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    for (int i = 0; i < 10; i++) {
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
    }

    expect(find.text('10'), findsWidgets);
  });
}