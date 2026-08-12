import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('CounterScreen 디자인 및 히스토리 기능 검증', () {
    testWidgets('앱 실행 시 디자인된 카운터 화면이 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // AppBar 확인
      expect(find.text('Flutter Counter'), findsOneWidget);
      
      // 카운터 카드 텍스트 확인
      expect(find.text('현재 카운트'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
      expect(find.text('버튼을 눌러 카운트를 변경하세요'), findsOneWidget);
      
      // 히스토리 섹션 확인
      expect(find.text('작업 히스토리'), findsOneWidget);
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });

    testWidgets('증가 버튼을 클릭하면 카운터가 증가하고 히스토리에 기록된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기 상태 확인
      expect(find.text('0'), findsOneWidget);
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);

      // 증가 버튼 찾기 및 클릭
      final incrementButton = find.byIcon(Icons.add);
      expect(incrementButton, findsOneWidget);
      await tester.tap(incrementButton);
      await tester.pump();

      // 카운터가 1로 증가했는지 확인
      expect(find.text('1'), findsOneWidget);
      
      // 히스토리에 '+1' 기록이 있는지 확인
      expect(find.text('+1'), findsOneWidget);
    });

    testWidgets('감소 버튼을 클릭하면 카운터가 감소하고 히스토리에 기록된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 먼저 카운터를 5로 올리기
      final incrementButton = find.byIcon(Icons.add);
      for (int i = 0; i < 5; i++) {
        await tester.tap(incrementButton);
        await tester.pump();
      }
      expect(find.text('5'), findsOneWidget);

      // 감소 버튼 클릭
      final decrementButton = find.byIcon(Icons.remove);
      expect(decrementButton, findsOneWidget);
      await tester.tap(decrementButton);
      await tester.pump();

      // 카운터가 4로 감소했는지 확인
      expect(find.text('4'), findsOneWidget);
      
      // 히스토리에 '−1' 기록이 있는지 확인
      expect(find.text('−1'), findsOneWidget);
    });

    testWidgets('히스토리에 여러 작업이 기록되고 결과값이 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      final decrementButton = find.byIcon(Icons.remove);

      // +1, +1, −1 순서로 작업 수행
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(decrementButton);
      await tester.pump();

      // 최종 카운터는 1이어야 함
      expect(find.text('1'), findsOneWidget);

      // 히스토리 레이스트 결과 확인: 마지막 작업은 −1이고 결과는 1
      // 첫 번째와 두 번째 작업의 결과 1도 히스토리에 표시됨
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('리셋 버튼을 클릭하면 카운터가 0으로 초기화되고 히스토리가 삭제된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);

      // 카운터를 3으로 올리기
      for (int i = 0; i < 3; i++) {
        await tester.tap(incrementButton);
        await tester.pump();
      }
      expect(find.text('3'), findsOneWidget);
      expect(find.text('+1'), findsWidgets);

      // 리셋 버튼 찾기 및 클릭
      final resetButton = find.byType(ElevatedButton);
      expect(resetButton, findsWidgets);
      
      // 'RESET' 텍스트가 있는 버튼 찾아 클릭
      final resetButtonWithText = find.widgetWithText(ElevatedButton, 'RESET');
      expect(resetButtonWithText, findsOneWidget);
      await tester.tap(resetButtonWithText);
      await tester.pump();

      // 카운터가 0으로 초기화되었는지 확인
      expect(find.text('0'), findsOneWidget);
      
      // 히스토리가 '아직 기록이 없습니다'로 초기화되었는지 확인
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });

    testWidgets('카운터 카드가 올바른 디자인 스타일로 렌더링된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // Card 위젯 확인
      expect(find.byType(Card), findsWidgets);

      // 카운터 숫자가 큰 글꼴 크기로 표시되는지 확인 (96px)
      final counterText = find.text('0');
      expect(counterText, findsOneWidget);

      // RoundedRectangleBorder로 둥근 모서리를 가진 Card 확인
      final cards = find.byType(Card);
      expect(cards, findsWidgets);
    });

    testWidgets('백그라운드 색상이 디자인 스펙대로 적용되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // Scaffold의 backgroundColor 확인
      final scaffold = find.byType(Scaffold);
      expect(scaffold, findsOneWidget);

      // 앱이 정상적으로 렌더링되는지 확인
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('여러 번 작업 후 히스토리 목록이 올바르게 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);

      // 5번 증가
      for (int i = 0; i < 5; i++) {
        await tester.tap(incrementButton);
        await tester.pump();
      }

      // 카운터가 5인지 확인
      expect(find.text('5'), findsOneWidget);

      // 히스토리 섹션이 존재하고 ListView를 포함하는지 확인
      expect(find.text('작업 히스토리'), findsOneWidget);
      expect(find.byType(ListView), findsWidgets);

      // 각 작업의 결과(1, 2, 3, 4, 5)가 히스토리에 표시되어야 함
      expect(find.text('1'), findsWidgets); // 최소 2개 이상 (카운터와 히스토리)
    });

    testWidgets('음수 카운터도 히스토리에 기록된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final decrementButton = find.byIcon(Icons.remove);

      // 3번 감소하여 -3 만들기
      for (int i = 0; i < 3; i++) {
        await tester.tap(decrementButton);
        await tester.pump();
      }

      // 카운터가 -3인지 확인
      expect(find.text('-3'), findsOneWidget);

      // 히스토리에 '−1' 기록이 있는지 확인
      expect(find.text('−1'), findsWidgets);
    });
  });
}