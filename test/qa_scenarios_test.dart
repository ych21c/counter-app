import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('앱 시작 시 숫자 0이 화면 중앙에 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.byType(Center), findsAtLeastNWidgets(1));
  });

  testWidgets('+ 버튼을 한 번 눌렀을 때 숫자가 1로 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });

  testWidgets('+ 버튼을 여러 번 눌렀을 때 계속 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('증가/감소/초기화 버튼이 모두 존재한다', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });

  testWidgets('화면 배경색이 디자인 스펙 색상이다', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    final scaffold = find.byType(Scaffold);
    expect(scaffold, findsOneWidget);

    final scaffoldWidget = tester.widget<Scaffold>(scaffold);
    expect(scaffoldWidget.backgroundColor, const Color(0xFFF0F4FF));
  });

  testWidgets('카운터 숫자가 96px 크기로 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    final counterText = find.byWidgetPredicate(
      (widget) => widget is Text && widget.data == '0',
    );

    expect(counterText, findsOneWidget);

    final textWidget = tester.widget<Text>(counterText);
    expect(textWidget.style?.fontSize, 96);
  });

  testWidgets('− 버튼으로 카운트가 감소한다', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('초기화 버튼을 누르면 카운터가 0으로 리셋된다', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}