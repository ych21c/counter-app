import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:counter_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('카운터 앱 - 기본 기능 및 히스토리', () {
    testWidgets('앱 초기 실행 시 카운터 0 표시', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // AppBar 확인
      expect(find.text('Flutter Counter'), findsOneWidget);

      // 카운터 표시 확인
      expect(find.text('현재 카운트'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);

      // 버튼 확인
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.restart_alt), findsOneWidget);

      // 초기화 버튼 라벨
      expect(find.text('초기화'), findsOneWidget);

      // 히스토리: 아직 기록 없음
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });

    testWidgets('증가 버튼 클릭 시 카운터 1 증가 및 히스토리 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기 상태 확인
      expect(find.text('0'), findsOneWidget);

      // 증가 버튼 클릭
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // 카운터가 1로 변함
      expect(find.text('1'), findsOneWidget);

      // 히스토리에 기록됨
      expect(find.text('+1'), findsOneWidget);
      expect(find.text('결과: 1'), findsOneWidget);
    });

    testWidgets('증가 버튼 5회 클릭 시 카운터 5 증가 및 히스토리 누적', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // 증가 버튼 5회 클릭
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
      }

      // 카운터가 5로 변함
      expect(find.text('5'), findsOneWidget);

      // 히스토리에 모두 기록됨
      expect(find.text('+1'), findsNWidgets(5));
      expect(find.text('결과: 5'), findsOneWidget);
    });

    testWidgets('감소 버튼 클릭 시 카운터 1 감소 및 히스토리 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // 먼저 증가 2회로 카운터를 2로 설정
      for (int i = 0; i < 2; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
      }

      // 카운터가 2 확인
      expect(find.text('2'), findsOneWidget);

      // 감소 버튼 클릭
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      // 카운터가 1로 변함
      expect(find.text('1'), findsOneWidget);

      // 히스토리에 감소 기록됨
      expect(find.text('−1'), findsOneWidget);
    });

    testWidgets('초기화 버튼 클릭 시 카운터 0으로 리셋 및 히스토리 초기화', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // 증가 3회로 카운터를 3으로 설정
      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
      }

      // 카운터가 3 확인
      expect(find.text('3'), findsOneWidget);

      // 히스토리에 3개 기록 확인
      expect(find.text('+1'), findsNWidgets(3));

      // 초기화 버튼 클릭
      await tester.tap(find.byIcon(Icons.restart_alt));
      await tester.pumpAndSettle();

      // 카운터가 0으로 돌아감
      expect(find.text('0'), findsOneWidget);

      // 히스토리가 비워짐
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });
  });
}