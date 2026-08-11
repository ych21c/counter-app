import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('앱 실행 시 화면 중앙에 초기값 0이 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.byType(Center), findsOneWidget);
  });

  testWidgets('화면 중앙에 증가 버튼이 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);
  });

  testWidgets('버튼을 누르면 카운터 숫자가 1 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
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

  testWidgets('카운터 숫자가 큰 폰트 크기(64)로 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final textWidget = find.byWidgetPredicate(
      (widget) => widget is Text && widget.data == '0',
    );
    expect(textWidget, findsOneWidget);

    final text = tester.widget<Text>(textWidget);
    expect(text.style?.fontSize, equals(64));
  });

  testWidgets('전체 레이아웃이 Scaffold로 구성되어 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
  });

  testWidgets('카운터와 버튼이 수직으로 중앙에 배치되어 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final column = find.byType(Column);
    expect(column, findsOneWidget);

    final columnWidget = tester.widget<Column>(column);
    expect(columnWidget.mainAxisAlignment, equals(MainAxisAlignment.center));
  });
}