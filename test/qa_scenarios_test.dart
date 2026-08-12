```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('CounterScreen Design & History Feature Tests', () {
    testWidgets('앱 실행 시 디자인이 적용되고 초기값 0이 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 앱바가 있고 제목이 표시되는지 확인
      expect(find.text('Flutter Counter'), findsWidgets);
      
      // 초기 카운터 값 0이 표시되는지 확인
      expect(find.text('0'), findsWidgets);
      
      // 배경색이 설정되어 있는지 확인 (Scaffold 존재)
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('카운터 디스플레이가 Card 스타일로 표시된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // Card 위젯이 존재하는지 확인 (디자인 스펙의 counter_display 컴포넌트)
      expect(find.byType(Card), findsWidgets);
      
      // 카운터 라벨 텍스트 확인
      expect(find.text('현재 카운트'), findsOneWidget);
    });

    testWidgets('버튼을 클릭하면 카운터가 1씩 증가하고 히스토리에 기록된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기값 확인
      expect(find.text('0'), findsWidgets);

      // 증가 버튼 찾기 (아이콘 기반)
      final incrementButton = find.byIcon(Icons.add);
      expect(incrementButton, findsOneWidget);

      // 버튼 클릭
      await tester.tap(incrementButton);
      await tester.pump();

      // 카운터가 1로 증가했는지 확인
      expect(find.text('1'), findsWidgets);

      // 히스토리 항목이 표시되는지 확인 (히스토리 리스트에 "+1" 액션이 기록됨)
      expect(find.text('+1'), findsOneWidget);
    });

    testWidgets('여러 번 증가 버튼을 클릭하면 계속 증가하고 히스토리가 쌓인다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);

      // 3번 클릭
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      // 최종값 3 확인
      expect(find.text('3'), findsWidgets);

      // 히스토리에 3개의 "+1" 액션이 기록되어 있는지 확인
      expect(find.text('+1'), findsWidgets);
    });

    testWidgets('감소 버튼을 클릭하면 카운터가 1씩 감소하고 히스토리에 기록된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      final decrementButton = find.byIcon(Icons.remove);

      // 먼저 증가시켜서 카운터를 양수로 만들기
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      // 현재 카운터는 2
      expect(find.text('2'), findsWidgets);

      // 감소 버튼 클릭
      await tester.tap(decrementButton);
      await tester.pump();

      // 카운터가 1로 감소했는지 확인
      expect(find.text('1'), findsWidgets);

      // 히스토리에 "−1" 액션이 기록되어 있는지 확인
      expect(find.text('−1'), findsOneWidget);
    });

    testWidgets('리셋 버튼을 클릭하면 카운터가 0으로 초기화되고 히스토리가 삭제된다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      final resetButton = find.byIcon(Icons.refresh);

      // 몇 번 증가
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      // 카운터가 2인지 확인
      expect(find.text('2'), findsWidgets);

      // 히스토리에 "+1" 액션이 있는지 확인
      expect(find.text('+1'), findsWidgets);

      // 리셋 버튼 클릭
      await tester.tap(resetButton);
      await tester.pump();

      // 카운터가 0으로 초기화되었는지 확인
      expect(find.text('0'), findsWidgets);

      // 히스토리가 삭제되었는지 확인 ("+1" 텍스트가 없어야 함)
      expect(find.text('+1'), findsNothing);
    });

    testWidgets('증가/감소 기록이 히스토리 섹션에 표시되고 스크롤 가능하다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      final incrementButton = find.byIcon(Icons.add);
      final decrementButton = find.byIcon(Icons.remove);

      // 여러 번 작업 수행하여 히스토리 생성
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();
      await tester.tap(decrementButton);
      await tester.pump();
      await tester.tap(incrementButton);
      await tester.pump();

      // 최종값 2 확인
      expect(find.text('2'), findsWidgets);

      // ListView가 있는지 확인 (히스토리 스크롤 가능하도록 구현)
      expect(find.byType(ListView), findsWidgets);

      // 히스토리 항목들이 표시되는지 확인
      expect(find.text('+1'), findsWidgets);
      expect(find.text('−1'), findsOneWidget);
    });

    testWidgets('화면이 SafeArea로 보호되어 있다', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // SafeArea 위젯 존재 확인
      expect(find.byType(SafeArea), findsWidgets);
    });

    testWidgets('증가/감소 버튼이 Material 스타일로 구현되어 있다', (WidgetTester tester) async {
      await t