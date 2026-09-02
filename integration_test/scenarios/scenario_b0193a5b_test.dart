import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:counter_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('카운터 앱 - 히스토리 표시 검증', () {
  testWidgets('앱 시작 시 초기 상태 (count=0, 히스토리 비어있음)', (tester) async {
    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();

    // 카운터 표시 확인
    expect(find.text('현재 카운트'), findsOneWidget);
    expect(find.text('0'), findsWidgets);
    expect(find.text('버튼을 눌러 카운트를 변경하세요'), findsOneWidget);

    // 히스토리 확인 - 초기 상태는 "아직 기록이 없습니다" 표시
    expect(find.text('작업 히스토리'), findsOneWidget);
    expect(find.text('아직 기록이 없습니다'), findsOneWidget);

    // 버튼 확인
    expect(find.byIcon(Icons.remove), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('감소'), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);
    expect(find.text('초기화'), findsOneWidget);
  });

  testWidgets('증가 버튼 클릭 시 카운트 증가 및 히스토리 기록', (tester) async {
    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsWidgets);
    expect(find.text('아직 기록이 없습니다'), findsNothing);
    expect(find.text('+1'), findsOneWidget);
    expect(find.text('결과: 1'), findsOneWidget);
  });

  testWidgets('여러 번 증가 후 모든 히스토리 기록 표시', (tester) async {
    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();

    for (int i = 0; i < 5; i++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
    }

    expect(find.text('5'), findsWidgets);
    expect(find.text('+1'), findsNWidgets(5));
    for (int i = 1; i <= 5; i++) {
      expect(find.text('결과: $i'), findsOneWidget);
    }
  });

  testWidgets('감소 버튼 클릭 시 카운트 감소 및 히스토리 기록', (tester) async {
    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsWidgets);
    expect(find.text('+1'), findsOneWidget);
    expect(find.text('−1'), findsOneWidget);
    expect(find.text('결과: 0'), findsOneWidget);
  });

  testWidgets('초기화 버튼 클릭 시 카운트 리셋 및 히스토리 클리어', (tester) async {
    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();

    for (int i = 0; i < 3; i++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.text('초기화'));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsWidgets);
    expect(find.text('+1'), findsNothing);
    expect(find.text('아직 기록이 없습니다'), findsOneWidget);
  });
});
}
