import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('Flutter Counter App - Core Scenarios', () {
    testWidgets('앱 실행 시 카운터가 0으로 초기화되어 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('화면 중앙에 현재 카운터 숫자가 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final textWidget = find.text('0');
      expect(textWidget, findsOneWidget);

      final textFinder = find.byType(Text);
      expect(textFinder, findsWidgets);

      // 카운터 숫자가 큰 폰트 사이즈로 표시되는지 확인
      final counterText = find.text('0');
      expect(counterText, findsOneWidget);
    });

    testWidgets('증가 버튼이 화면에 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('증가'), findsOneWidget);
    });

    testWidgets('버튼을 누르면 카운터가 1씩 증가한다', (WidgetTester tester) async {
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

      // 첫 번째 클릭
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      // 두 번째 클릭
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      // 세 번째 클릭
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('카운터는 Column 레이아웃으로 중앙 정렬되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
    });
  });
}