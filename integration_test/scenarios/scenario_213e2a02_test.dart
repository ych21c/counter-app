import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:counter_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('카운터 앱 - 디자인 및 히스토리 검증', () {
    testWidgets('초기 화면 렌더링 확인', (tester) async {
      await tester.pumpWidget(const CounterApp());

      expect(find.text('Flutter Counter'), findsOneWidget);
      expect(find.text('현재 카운트'), findsOneWidget);
      expect(find.text('0'), findsWidgets);
      expect(find.text('버튼을 눌러 카운트를 변경하세요'), findsOneWidget);
      expect(find.text('작업 히스토리'), findsOneWidget);
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.restart_alt), findsOneWidget);
    });

    testWidgets('증가 버튼 클릭 시 카운터 증가 및 히스토리 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 300));

      expect(find.text('1'), findsWidgets);
      expect(find.text('+1'), findsOneWidget);
      expect(find.text('결과: 1'), findsOneWidget);
      expect(find.text('아직 기록이 없습니다'), findsNothing);
    });

    testWidgets('감소 버튼 클릭 시 카운터 감소 및 히스토리 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 300));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 300));
      expect(find.text('2'), findsWidgets);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle(const Duration(milliseconds: 300));

      expect(find.text('1'), findsWidgets);
      expect(find.text('−1'), findsOneWidget);
      expect(find.text('결과: 1'), findsNWidgets(2)); // +1,+1,−1 → 결과: 1이 두 번(1번째 증가, 감소 후) 기록된다
      expect(find.text('결과: 2'), findsOneWidget);
    });

    testWidgets('여러 번 클릭 시 모든 히스토리 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());

      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));
      }

      expect(find.text('3'), findsWidgets);
      expect(find.text('+1'), findsNWidgets(3));
      expect(find.text('결과: 1'), findsOneWidget);
      expect(find.text('결과: 2'), findsOneWidget);
      expect(find.text('결과: 3'), findsOneWidget);
    });

    testWidgets('초기화 버튼으로 카운터 및 히스토리 초기화', (tester) async {
      await tester.pumpWidget(const CounterApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 300));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 300));

      await tester.tap(find.byIcon(Icons.restart_alt));
      await tester.pumpAndSettle(const Duration(milliseconds: 300));

      expect(find.text('0'), findsWidgets);
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
      expect(find.text('+1'), findsNothing);
      expect(find.text('결과: 1'), findsNothing);
    });

    testWidgets('증가 후 감소 시 최종 히스토리 확인', (tester) async {
      await tester.pumpWidget(const CounterApp());

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 300));
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle(const Duration(milliseconds: 300));

      expect(find.text('0'), findsWidgets);
      expect(find.text('+1'), findsOneWidget);
      expect(find.text('−1'), findsOneWidget);
      expect(find.text('결과: 1'), findsOneWidget);
      expect(find.text('결과: 0'), findsOneWidget);
    });
  });
}