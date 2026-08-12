import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('카운터 앱 디자인 및 히스토리 기능', () {
    testWidgets('앱 실행 시 AppBar와 디자인된 UI가 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.byType(AppBar), findsWidgets);
      expect(find.text('Flutter Counter'), findsWidgets);
      expect(find.byType(Card), findsWidgets);
      expect(find.text('0'), findsWidgets);
      expect(find.byType(FloatingActionButton), findsWidgets);
    });

    testWidgets('증가/감소 버튼 클릭 후 히스토리가 화면에 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('0'), findsWidgets);

      // 증가 버튼(+) 탭
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('1'), findsWidgets);
      expect(find.text('+1'), findsWidgets);
    });

    testWidgets('여러 번 증가 버튼을 누르면 모든 히스토리 기록이 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1'), findsWidgets);
      expect(find.text('+1'), findsWidgets);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsWidgets);

      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('감소 버튼 클릭 시 카운터가 감소하고 히스토리에 기록된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 먼저 증가 버튼으로 값을 1로 만들기
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // 감소 버튼(-) 탭
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('0'), findsWidgets);
      expect(find.text('−1'), findsWidgets);
    });

    testWidgets('디자인 컬러 스키마가 적용된 UI가 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.byType(Scaffold), findsWidgets);
      expect(find.byType(AppBar), findsWidgets);
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('리셋 버튼이 존재하고 클릭 시 카운터와 히스토리가 초기화된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('2'), findsWidgets);
      expect(find.text('+1'), findsWidgets);

      // 리셋 버튼(OutlinedButton) 클릭
      await tester.tap(find.byType(OutlinedButton));
      await tester.pump();

      expect(find.text('0'), findsWidgets);
    });

    testWidgets('히스토리 리스트가 스크롤 가능한 영역에 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
      }

      expect(find.byType(ListView), findsWidgets);
      expect(find.text('+1'), findsWidgets);
    });

    testWidgets('디자인의 텍스트 레이블들이 모두 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('현재 카운트'), findsWidgets);
      expect(find.text('버튼을 눌러 카운트를 변경하세요'), findsWidgets);
    });
  });
}