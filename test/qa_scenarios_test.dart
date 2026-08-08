import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('Flutter Counter App - 이번 라운드 검증', () {
    testWidgets('앱 실행 시 카운터 초기값 0 표시', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('화면 중앙에 카운터 숫자 표시', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final textFinder = find.text('0');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, equals(64));
    });

    testWidgets('증가 버튼이 화면에 표시됨', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('증가'), findsOneWidget);
    });

    testWidgets('버튼 누르면 숫자 1씩 증가', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('0'), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });

    testWidgets('버튼 여러 번 누르면 계속 증가', (WidgetTester tester) async {
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

    testWidgets('카운터와 버튼이 중앙에 배치됨', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final centerFinder = find.byType(Center);
      expect(centerFinder, findsOneWidget);

      final columnFinder = find.byType(Column);
      expect(columnFinder, findsOneWidget);

      final columnWidget = tester.widget<Column>(columnFinder);
      expect(columnWidget.mainAxisAlignment, equals(MainAxisAlignment.center));
    });
  });
}