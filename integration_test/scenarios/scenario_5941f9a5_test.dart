import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:counter_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('카운터 앱 - 히스토리 표시', () {
    testWidgets('초기 상태: 히스토리 비어있음', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });

    testWidgets('증가 버튼 클릭 시 히스토리에 기록 표시', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.text('+1'), findsWidgets);
      expect(find.text('결과: 1'), findsOneWidget);
    });

    testWidgets('감소 버튼 클릭 시 히스토리에 기록 표시', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.text('−1'), findsWidgets);
      expect(find.text('결과: 0'), findsOneWidget);
    });

    testWidgets('여러 번 클릭 시 모든 기록 표시', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));
      }

      expect(find.text('+1'), findsNWidgets(3));
    });

    testWidgets('초기화 버튼 클릭 후 히스토리 비우기', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await tester.tap(find.byIcon(Icons.restart_alt));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });
  });
}