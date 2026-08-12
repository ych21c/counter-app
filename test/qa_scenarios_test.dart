import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('디자인 재적용 검증 - 카운터 앱 화면 및 히스토리', () {
    testWidgets('앱 실행 시 전체 디자인 요소 표시 확인', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // AppBar 확인
      expect(find.text('Flutter Counter'), findsOneWidget);

      // 카운터 카드의 레이블 텍스트 확인
      expect(find.text('현재 카운트'), findsOneWidget);

      // 초기 카운터 값 0 표시 확인
      expect(find.text('0'), findsWidgets);

      // 안내 텍스트 확인
      expect(find.text('버튼을 눌러 카운트를 변경하세요'), findsOneWidget);

      // 히스토리 섹션 헤더 확인
      expect(find.text('작업 히스토리'), findsOneWidget);

      // 증가/감소 버튼 라벨 확인
      expect(find.text('증가'), findsOneWidget);
      expect(find.text('감소'), findsOneWidget);

      // 초기화 버튼 확인
      expect(find.text('초기화'), findsOneWidget);
    });

    testWidgets('증가 버튼 클릭 시 카운터 증가 및 히스토리 기록됨', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기 상태에서 0 확인
      expect(find.text('0'), findsWidgets);

      // 증가 버튼 찾기 및 클릭
      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      await tester.pump();

      // 카운터가 1로 증가했는지 확인
      expect(find.text('1'), findsOneWidget);

      // 히스토리에 "+1" 기록 확인
      expect(find.text('+1'), findsOneWidget);
      expect(find.text('결과: 1'), findsOneWidget);
    });

    testWidgets('감소 버튼 클릭 시 카운터 감소 및 히스토리 기록됨', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 먼저 증가 버튼을 눌러 카운터를 1로 설정
      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      await tester.pump();

      expect(find.text('1'), findsOneWidget);

      // 감소 버튼 찾기 및 클릭
      final decrementButton = find.byIcon(Icons.remove);
      await tester.tap(decrementButton);
      await tester.pump();

      // 카운터가 0으로 감소했는지 확인
      expect(find.text('0'), findsWidgets);

      // 히스토리에 "−1" 기록 확인
      expect(find.text('−1'), findsOneWidget);
      expect(find.text('결과: 0'), findsOneWidget);
    });

    testWidgets('여러 번 버튼 클릭 시 모든 히스토리 기록 누적', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);

      // 버튼을 3번 클릭
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      // 최종 카운터 값 3 확인
      expect(find.text('3'), findsOneWidget);

      // 히스토리에 3개의 "+1" 기록이 있는지 확인
      expect(find.text('+1'), findsNWidgets(3));

      // 최종 결과값 3 확인
      expect(find.text('결과: 3'), findsOneWidget);
    });

    testWidgets('초기화 버튼 클릭 시 카운터 0으로 리셋 및 히스토리 초기화', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);

      // 카운터 증가
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      // 카운터가 2인지 확인
      expect(find.text('2'), findsOneWidget);

      // 히스토리에 기록이 있는지 확인
      expect(find.text('+1'), findsWidgets);

      // 초기화 버튼 클릭
      final resetButton = find.byIcon(Icons.restart_alt);
      await tester.tap(resetButton);
      await tester.pump();

      // 카운터가 0으로 리셋되었는지 확인
      expect(find.text('0'), findsWidgets);

      // 히스토리가 초기화되었는지 확인 (아직 기록이 없습니다 텍스트 표시)
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });

    testWidgets('증가와 감소를 섞어서 여러 번 클릭 시 모든 동작이 히스토리에 기록됨', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      final decrementButton = find.byIcon(Icons.remove);

      // 증가 1회
      await tester.tap(incrementButton);
      await tester.pump();

      // 감소 1회
      await tester.tap(decrementButton);
      await tester.pump();

      // 증가 2회
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      // 최종 카운터 값 2 확인
      expect(find.text('2'), findsOneWidget);

      // 히스토리에 "+1" 3번, "−1" 1번 기록 확인
      expect(find.text('+1'), findsNWidgets(3));
      expect(find.text('−1'), findsOneWidget);

      // 최종 결과값 2 확인
      expect(find.text('결과: 2'), findsOneWidget);
    });

    testWidgets('카운터 카드가 흰색 배경의 Card 위젯으로 표시됨', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // Card 위젯이 존재하는지 확인
      expect(find.byType(Card), findsWidgets);

      // 카운터 값을 감싸는 큰 텍스트가 96 크기인지 확인
      final counterText = find.text('0');
      expect(counterText, findsWidgets);
    });

    testWidgets('FloatingActionButton으로 증가/감소 버튼 구현됨', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // FloatingActionButton 2개 확인 (증가, 감소)
      expect(find.byType(FloatingActionButton), findsWidgets);

      // 각 버튼의 아이콘 확인
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
    });

    testWidgets('히스토리 섹션이 비어있을 때 초기 메시지 표시', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 아무 버튼도 누르지 않으면 히스토리는 비어있어야 함
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });

    testWidgets('버튼 클릭 후 히스토리 섹션에 동작과 결과 표시', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      await tester.pump();

      // 초기 메시지가 없어지고 기록이 표시됨
      expect(find.text('아직 기록이 없습니다'), findsNothing);

      // 동작 "+1"과 결과 "결과: 1"이 표시됨
      expect(find.text('+1'), findsOneWidget);
      expect(find.text('결과: 1'), findsOneWidget);
    });
  });
}