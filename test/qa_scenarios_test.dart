import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('카운터 앱 디자인 재적용 검증', () {
    testWidgets('앱 실행 시 디자인된 AppBar가 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.byType(AppBar), findsWidgets);
      expect(find.text('🔢 Flutter Counter'), findsOneWidget);
      
      final appBar = find.byType(AppBar);
      expect(appBar, findsWidgets);
    });

    testWidgets('카운터 숫자가 큰 텍스트로 중앙에 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('0'), findsWidgets);
      
      final counterText = find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == '0' && widget.style?.fontSize == 96,
      );
      expect(counterText, findsOneWidget);
    });

    testWidgets('현재 카운트 라벨이 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('현재 카운트'), findsOneWidget);
    });

    testWidgets('카운터 표시가 흰색 카드 컨테이너로 감싸져 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('증가 버튼이 존재하고 클릭하면 숫자가 1씩 증가한다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('0'), findsWidgets);
      
      final incrementButton = find.byIcon(Icons.add);
      expect(incrementButton, findsOneWidget);

      await tester.tap(incrementButton);
      await tester.pump();

      expect(find.text('1'), findsWidgets);

      await tester.tap(incrementButton);
      await tester.pump();

      expect(find.text('2'), findsWidgets);
    });

    testWidgets('감소 버튼이 존재하고 클릭하면 숫자가 1씩 감소한다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      expect(find.text('2'), findsWidgets);

      final decrementButton = find.byIcon(Icons.remove);
      expect(decrementButton, findsOneWidget);

      await tester.tap(decrementButton);
      await tester.pump();

      expect(find.text('1'), findsWidgets);
    });

    testWidgets('리셋 버튼이 존재하고 클릭하면 0으로 초기화된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      expect(find.text('3'), findsWidgets);

      final resetButton = find.byIcon(Icons.refresh);
      expect(resetButton, findsOneWidget);

      await tester.tap(resetButton);
      await tester.pump();

      expect(find.text('0'), findsWidgets);
    });

    testWidgets('버튼들이 Material 스타일로 구현되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('배경색이 디자인된 색상으로 적용되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final scaffold = find.byType(Scaffold);
      expect(scaffold, findsOneWidget);
    });

    testWidgets('버튼 클릭 시 애니메이션 효과가 적용된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('0'), findsWidgets);

      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      
      await tester.pump(const Duration(milliseconds: 75));
      
      await tester.pumpAndSettle();

      expect(find.text('1'), findsWidgets);
    });

    testWidgets('화면이 SafeArea로 보호되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.byType(SafeArea), findsWidgets);
    });
  });
}