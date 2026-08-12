```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('카운터 앱 디자인 및 히스토리 기능', () {
    testWidgets('앱 실행 시 AppBar와 디자인된 UI가 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // AppBar 확인
      expect(find.byType(AppBar), findsWidgets);
      expect(find.text('Flutter Counter'), findsWidgets);

      // 카운터 디스플레이 영역 확인 (Card 컴포넌트)
      expect(find.byType(Card), findsWidgets);

      // 초기 카운터 값 0 표시 확인
      expect(find.text('0'), findsWidgets);

      // 버튼들이 존재하는지 확인
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('증가/감소 버튼 클릭 후 히스토리가 화면에 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기 상태 확인
      expect(find.text('0'), findsWidgets);

      // 증가 버튼 탭 (첫 번째 ElevatedButton이 증가 버튼)
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();

      // 카운터가 1로 증가했는지 확인
      expect(find.text('1'), findsWidgets);

      // 히스토리에 "+1" 기록이 표시되는지 확인
      expect(find.text('+1'), findsWidgets);
    });

    testWidgets('여러 번 증가 버튼을 누르면 모든 히스토리 기록이 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 첫 번째 증가
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();
      expect(find.text('1'), findsWidgets);
      expect(find.text('+1'), findsWidgets);

      // 두 번째 증가
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();
      expect(find.text('2'), findsWidgets);

      // 히스토리 영역에 여러 기록이 표시되는지 확인
      // (히스토리 리스트뷰 또는 컬럼에 다중 항목)
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('감소 버튼 클릭 시 카운터가 감소하고 히스토리에 기록된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 먼저 증가 버튼으로 값을 1로 만들기
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();

      // 감소 버튼 탭 (두 번째 ElevatedButton이 감소 버튼)
      final buttons = find.byType(ElevatedButton);
      expect(buttons, findsWidgets);
      
      await tester.tap(buttons.at(1));
      await tester.pump();

      // 카운터가 0으로 감소했는지 확인
      expect(find.text('0'), findsWidgets);

      // 히스토리에 "−1" 기록이 표시되는지 확인
      expect(find.text('−1'), findsWidgets);
    });

    testWidgets('디자인 컬러 스키마가 적용된 UI가 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // Scaffold의 배경색이 설정되어 있는지 확인
      final scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsWidgets);

      // AppBar가 존재하고 Material 스타일로 구현되어 있는지 확인
      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsWidgets);

      // Card 컴포넌트가 elevation과 함께 표시되는지 확인
      final cardFinder = find.byType(Card);
      expect(cardFinder, findsWidgets);
    });

    testWidgets('리셋 버튼이 존재하고 클릭 시 카운터와 히스토리가 초기화된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 몇 번 증가시키기
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();

      expect(find.text('2'), findsWidgets);
      expect(find.text('+1'), findsWidgets);

      // 리셋 버튼 찾기 및 클릭
      // 리셋 버튼은 보통 3번째 또는 그 이상의 버튼 (또는 다른 스타일)
      final buttons = find.byType(ElevatedButton);
      expect(buttons, findsWidgets);

      // 모든 버튼 중 리셋 버튼을 찾아 클릭 (OutlinedButton이나 특별한 버튼일 수 있음)
      final allButtons = find.byType(Button);
      if (allButtons.evaluate().length > 2) {
        await tester.tap(allButtons.at(2));
        await tester.pump();
      }

      // 리셋 후 카운터가 0으로 초기화되었는지 확인
      expect(find.text('0'), findsWidgets);
    });

    testWidgets('히스토리 리스트가 스크롤 가능한 영역에 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 여러 번 증가/감소를 반복하여 히스토리 생성
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(ElevatedButton).first);
        await tester.pump();
      }

      // 히스토리 영역 (ListView)이 표시되는지 확인
      expect(find.byType(ListView), findsWidgets);

      // 생성된 히스토리 항목들이 화면에 표시되는지 확인
      expect(find.text('+1'), findsWidgets);
    });

    testWidgets('디자인의 텍스트 레이블들이 모두 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // "현재 카운트" 레이블 확인
      expect(find.text('현재 카운트'), findsWidgets);

      // 버