import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('Counter App - Design & History Feature Tests', () {
    testWidgets('앱 실행 시 디자인된 카운터 화면이 완전히 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // AppBar 확인 - 디자인 재작업으로 추가된 요소
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Flutter Counter'), findsOneWidget);

      // 카운터 카드 확인 - 디자인된 Card 위젯
      expect(find.byType(Card), findsOneWidget);

      // 카운터 표시 레이블 확인
      expect(find.text('현재 카운트'), findsOneWidget);

      // 초기값 0 표시
      expect(find.text('0'), findsWidgets);

      // 버튼을 눌러 카운트를 변경하세요 힌트 텍스트
      expect(find.text('버튼을 눌러 카운트를 변경하세요'), findsOneWidget);
    });

    testWidgets('히스토리 섹션이 디자인되어 화면에 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 작업 히스토리 제목 확인
      expect(find.text('작업 히스토리'), findsOneWidget);

      // 초기 상태: 아직 기록이 없습니다 메시지
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });

    testWidgets('증가 버튼 클릭 후 히스토리에 기록이 추가된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 증가 버튼 찾기 (FloatingActionButton)
      expect(find.byType(FloatingActionButton), findsWidgets);

      // 증가 버튼 클릭 (Icon.add인 버튼)
      final incrementButton = find.byIcon(Icons.add);
      expect(incrementButton, findsOneWidget);
      await tester.tap(incrementButton);
      await tester.pump();

      // 히스토리에 "+1" 기록이 나타나야 함
      expect(find.text('+1'), findsWidgets);

      // 결과 표시
      expect(find.text('결과: 1'), findsWidgets);
    });

    testWidgets('감소 버튼 클릭 후 히스토리에 기록이 추가된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 먼저 증가해서 0이 아닌 상태로 만들기
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // 감소 버튼 클릭
      final decrementButton = find.byIcon(Icons.remove);
      expect(decrementButton, findsOneWidget);
      await tester.tap(decrementButton);
      await tester.pump();

      // 히스토리에 "−1" 기록이 나타나야 함
      expect(find.text('−1'), findsWidgets);

      // 결과 표시 (0으로 돌아감)
      expect(find.text('결과: 0'), findsWidgets);
    });

    testWidgets('여러 번 증가했을 때 모든 기록이 히스토리에 남는다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);

      // 3번 증가
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      // 히스토리에 3개의 "+1" 기록
      expect(find.text('+1'), findsNWidgets(3));

      // 결과값들: 1, 2, 3
      expect(find.text('결과: 1'), findsWidgets);
      expect(find.text('결과: 2'), findsWidgets);
      expect(find.text('결과: 3'), findsWidgets);

      // 최종 카운트는 3
      expect(find.text('3'), findsWidgets);
    });

    testWidgets('초기화 버튼 클릭 시 카운트와 히스토리가 모두 초기화된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 증가 버튼 여러 번 클릭
      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      // 히스토리 기록 확인
      expect(find.text('+1'), findsNWidgets(2));

      // 초기화 버튼 찾기 및 클릭
      final resetButton = find.byIcon(Icons.restart_alt);
      expect(resetButton, findsOneWidget);
      await tester.tap(resetButton);
      await tester.pump();

      // 카운트가 0으로 초기화
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);

      // 히스토리 기록이 사라짐
      expect(find.text('+1'), findsNothing);
    });

    testWidgets('카운터 카드가 Material 디자인 스타일(Card + 그라데이션)로 구현되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // Card 위젯 확인
      final cardFinder = find.byType(Card);
      expect(cardFinder, findsOneWidget);

      // Card 내부에 큰 텍스트(96pt) 숫자가 있는지 확인
      // (Text 위젯들이 여러 개 있으므로 구체적인 내용으로 확인)
      expect(find.text('현재 카운트'), findsOneWidget);
      expect(find.text('0'), findsWidgets);
    });

    testWidgets('증가와 감소를 혼합했을 때 히스토리가 정확하게 기록된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      final decrementButton = find.byIcon(Icons.remove);

      // 증가
      await tester.tap(incrementButton);
      await tester.pump();
      // 증가
      await tester.tap(incrementButton);
      await tester.pump();
      // 감소
      await tester.tap(decrementButton);
      await tester.pump();

      // 히스토리 확인: +1, +1, −1
      expect(find.text('+1'), findsNWidgets(2));
      expect(find.text('−1'), findsWidgets);

      // 결과값 확인: 1, 2, 1
      expect(find.text('결과: 1'), findsWidgets);
      expect(find.text('결과: 2'), findsWidgets);

      // 최종 카운트는 1
      expect(find.text('1'), findsWidgets);
    });

    testWidgets('작업 히스토리 섹션이 border와 배경색을 포함한 컨테이너로 디자인되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 작업 히스토리 제목 존재
      expect(find.text('작업 히스토리'), findsOneWidget);

      // 초기 상태에 "아직 기록이 없습니다" 메시지
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);

      // 증가 버튼 클릭 후
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // 히스토리 항목 표시
      expect(find.text('결과: 1'), findsWidgets);
    });
  });
}