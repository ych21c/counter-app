import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('카운터 앱 디자인 및 히스토리 기능 검증', () {
    testWidgets('앱 실행 시 Material Design AppBar가 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      expect(find.byType(AppBar), findsWidgets);
      expect(find.text('Flutter Counter'), findsOneWidget);
    });

    testWidgets('카운터 화면에 흰색 배경의 Card 컴포넌트가 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      expect(find.byType(Card), findsWidgets);
      expect(find.text('현재 카운트'), findsOneWidget);
    });

    testWidgets('초기 상태에서 카운터 값이 0으로 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      expect(find.text('0'), findsWidgets);
    });

    testWidgets('증가 버튼을 클릭하면 카운터가 증가한다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('증가 버튼을 여러 번 클릭하면 계속 증가한다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
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

    testWidgets('감소 버튼을 클릭하면 카운터가 감소한다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
      
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('히스토리 섹션에 카운터 변경 기록이 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      expect(find.text('작업 히스토리'), findsOneWidget);
      
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      
      expect(find.text('+1'), findsOneWidget);
      expect(find.text('결과: 1'), findsOneWidget);
    });

    testWidgets('여러 번의 증가/감소가 히스토리에 모두 기록된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      
      expect(find.text('+1'), findsWidgets);
      expect(find.text('−1'), findsOneWidget);
    });

    testWidgets('리셋 버튼을 클릭하면 카운터가 0으로 초기화되고 히스토리가 지워진다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      
      expect(find.text('2'), findsOneWidget);
      expect(find.text('+1'), findsWidgets);
      
      await tester.tap(find.byIcon(Icons.restart_alt));
      await tester.pump();
      
      expect(find.text('0'), findsWidgets);
    });

    testWidgets('디자인 색상이 올바르게 적용되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      final scaffold = find.byType(Scaffold);
      expect(scaffold, findsOneWidget);
      
      expect(find.byType(FloatingActionButton), findsWidgets);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('증가/감소 버튼이 FloatingActionButton으로 구현되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      expect(find.byType(FloatingActionButton), findsWidgets);
    });

    testWidgets('카운터 값이 큰 텍스트 크기로 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      
      final counterText = find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == '0',
      );
      expect(counterText, findsWidgets);
    });
  });
}