import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('Flutter Counter App - 이번 라운드 검증', () {
    testWidgets('앱 실행 시 카운터 초기값 0 표시', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('화면 중앙에 카운터 숫자 표시됨', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final counterText = find.text('0');
      expect(counterText, findsOneWidget);

      final textWidget = tester.widget<Text>(counterText);
      expect(textWidget.style?.fontSize, 64);
    });

    testWidgets('버튼 1개 표시됨', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final button = find.byType(ElevatedButton);
      expect(button, findsOneWidget);

      final buttonChild = tester.widget<ElevatedButton>(button);
      expect(buttonChild.child, isA<Text>());
    });

    testWidgets('버튼을 누르면 숫자 1씩 증가', (WidgetTester tester) async {
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

    testWidgets('화면이 Scaffold로 구성됨', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('카운터와 버튼이 중앙에 배치됨', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final center = find.byType(Center);
      expect(center, findsOneWidget);

      final column = find.byType(Column);
      expect(column, findsOneWidget);

      final columnWidget = tester.widget<Column>(column);
      expect(columnWidget.mainAxisAlignment, MainAxisAlignment.center);
    });
  });
}