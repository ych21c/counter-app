import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  group('Counter App - Design & History Implementation', () {
    testWidgets('디자인 적용: AppBar 및 기본 레이아웃 표시', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // AppBar 존재 확인
      expect(find.byType(AppBar), findsWidgets);
      expect(find.text('Flutter Counter'), findsOneWidget);

      // 배경색 확인 (F0F4FF = 밝은 파란색 배경)
      expect(find.byType(Scaffold), findsOneWidget);

      // 카운터 디스플레이 영역 존재 확인
      expect(find.text('현재 카운트'), findsOneWidget);
      expect(find.text('0'), findsWidgets); // 초기값 0
    });

    testWidgets('디자인 적용: 카운터 숫자 큰 텍스트로 표시', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 카운터 값을 찾기 위해 Text 위젯의 TextStyle 확인
      final counterValueFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data != null &&
            widget.data == '0' &&
            (widget.style?.fontSize ?? 0) > 50,
      );

      expect(counterValueFinder, findsWidgets);
    });

    testWidgets('디자인 적용: 증가/감소 버튼 표시', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 증가 버튼 (+ 아이콘)
      expect(find.byIcon(Icons.add), findsOneWidget);

      // 감소 버튼 (- 아이콘)
      expect(find.byIcon(Icons.remove), findsOneWidget);

      // 리셋 버튼 (새로고침 아이콘)
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('히스토리 기록: 증가 버튼 클릭 후 히스토리에 기록됨',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기 상태: 카운터 0
      expect(find.text('0'), findsWidgets);

      // 증가 버튼 클릭
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // 카운터 1로 증가
      expect(find.text('1'), findsWidgets);

      // 히스토리에 "+1" 기록 표시 확인
      expect(find.text('+1'), findsWidgets);
    });

    testWidgets('히스토리 기록: 감소 버튼 클릭 후 히스토리에 기록됨',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기 상태: 카운터 0
      expect(find.text('0'), findsWidgets);

      // 증가 버튼을 먼저 눌러서 카운터를 1로 만들기
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('1'), findsWidgets);

      // 감소 버튼 클릭
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // 카운터 0으로 감소
      expect(find.text('0'), findsWidgets);

      // 히스토리에 "−1" 기록 표시 확인
      expect(find.text('−1'), findsWidgets);
    });

    testWidgets('히스토리 기록: 여러 번 증가 시 모든 기록이 표시됨',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 증가 버튼 3번 클릭
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // 카운터 3으로 증가
      expect(find.text('3'), findsWidgets);

      // 히스토리에 3개의 "+1" 기록 표시 확인
      expect(find.text('+1'), findsWidgets);
    });

    testWidgets('히스토리 기록: 리셋 후 히스토리 초기화됨',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // 증가 버튼 2번 클릭
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // 히스토리에 "+1" 기록 2개 표시
      expect(find.text('+1'), findsWidgets);

      // 리셋 버튼 클릭
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pump();

      // 카운터 0으로 초기화
      expect(find.text('0'), findsWidgets);

      // 히스토리 기록이 초기화되었는지 확인
      // (히스토리 텍스트 개수 감소 또는 특정 항목 사라짐)
      expect(find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data != null &&
            (widget.data == '+1' || widget.data == '−1'),
      ), findsNothing);
    });

    testWidgets('디자인 적용: 히스토리 영역이 스크롤 가능',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const CounterApp());

      // 많은 횟수로 증가하여 히스토리 추적
      for (int i = 0; i < 15; i++) {
        await tester.ensureVisible(find.byIcon(Icons.add));
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
      }

      // 카운터 15로 증가 확인
      expect(find.text('15'), findsWidgets);

      // ListView 또는 SingleChildScrollView 존재 확인 (히스토리 스크롤)
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SingleChildScrollView ||
              widget is ListView ||
              widget is CustomScrollView,
        ),
        findsWidgets,
      );
    });

    testWidgets('디자인 적용: 카드 스타일 컨테이너로 카운터 표시',
        (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());

      // Card 위젯 존재 확인 (카운터 디스플레이가 카드로 감싸짐)
      expect(find.byType(Card), findsWidgets);

      // 카운터 레이블과 숫자 함께 표시
      expect(find.text('현재 카운트'), findsOneWidget);
      expect(find.text('0'), findsWidgets);
    });
  });
}