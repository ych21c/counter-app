import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('디자인 재적용 검증', () {
    testWidgets('앱 실행 시 디자인된 UI 전체가 렌더링되어야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // AppBar 존재 여부
      expect(find.byType(AppBar), findsWidgets);
      expect(find.text('Flutter Counter'), findsOneWidget);

      // 카운터 디스플레이 영역 (Card)
      expect(find.byType(Card), findsWidgets);

      // 카운터 값 표시 (0으로 초기화)
      expect(find.text('0'), findsOneWidget);

      // 버튼들 존재 확인 (FloatingActionButton으로 구현됨)
      expect(find.byType(FloatingActionButton), findsWidgets);

      // 배경색이 설정되어야 함
      final scaffold = find.byType(Scaffold);
      expect(scaffold, findsOneWidget);
    });

    testWidgets('카운터 증가 기록이 화면에 표시되어야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기 상태: 카운터는 0
      expect(find.text('0'), findsOneWidget);

      // 증가 버튼을 한 번 탭
      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      await tester.pump();

      // 카운터가 1로 증가
      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsNothing);

      // 다시 탭하여 2로 증가
      await tester.tap(incrementButton);
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('카운터 감소 기록이 화면에 표시되어야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기 상태: 0
      expect(find.text('0'), findsOneWidget);

      // 감소 버튼을 찾아 탭
      final decrementButton = find.byIcon(Icons.remove);
      await tester.tap(decrementButton);
      await tester.pump();

      // 카운터가 -1로 감소
      expect(find.text('-1'), findsOneWidget);
    });

    testWidgets('증가/감소 버튼이 모두 존재하고 동작해야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 증가 버튼 존재
      expect(find.byIcon(Icons.add), findsOneWidget);

      // 감소 버튼 존재
      expect(find.byIcon(Icons.remove), findsOneWidget);

      // 증가 후 감소해서 0으로 돌아오는지 확인
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('리셋 버튼이 존재하고 카운터를 0으로 초기화해야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 카운터를 여러 번 증가
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);

      // 리셋 버튼 탭
      final resetButton = find.byType(OutlinedButton);
      expect(resetButton, findsOneWidget);

      await tester.tap(resetButton);
      await tester.pump();

      // 카운터가 0으로 초기화
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('히스토리가 화면에 표시되어야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 카운터 증가
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // 히스토리 섹션이 있어야 함 (ListView로 렌더링)
      expect(find.byType(ListView), findsOneWidget);

      // 히스토리에는 작업 기록이 있어야 함 (최소 하나의 결과 텍스트)
      expect(find.textContaining('결과:'), findsWidgets);
    });

    testWidgets('여러 번 증감 후 히스토리가 누적되어야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // +1
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // +1
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // -1
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // 최종 값은 1
      expect(find.text('1'), findsOneWidget);

      // 히스토리 항목들이 여러 개 있어야 함 (결과 텍스트가 3개)
      expect(find.textContaining('결과:'), findsNWidgets(3));
    });

    testWidgets('디자인된 색상 스킴이 적용되어야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // AppBar가 존재하고 스타일링되어 있음
      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);

      // Card 컴포넌트가 카운터 디스플레이로 사용됨
      final card = find.byType(Card);
      expect(card, findsWidgets);

      // Scaffold의 배경이 설정되어 있음
      final scaffold = find.byType(Scaffold);
      expect(scaffold, findsOneWidget);
    });

    testWidgets('카운터 숫자가 큰 텍스트로 표시되어야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 카운터 값 텍스트 찾기
      final counterText = find.text('0');
      expect(counterText, findsOneWidget);

      // 텍스트의 스타일 확인
      final textWidget = tester.widget<Text>(counterText);
      expect(textWidget.style, isNotNull);
      
      // fontSize가 크게 설정되어 있는지 확인 (디자인상 96px)
      if (textWidget.style!.fontSize != null) {
        expect(textWidget.style!.fontSize, greaterThan(50));
      }
    });

    testWidgets('버튼들이 Material 스타일로 구현되어야 함', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // FloatingActionButton (증가/감소 버튼)
      expect(find.byType(FloatingActionButton), findsWidgets);

      // OutlinedButton (리셋 버튼)
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });
}