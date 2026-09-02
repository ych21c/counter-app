import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:counter_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('카운터 앱 - 디자인 재작업 (히스토리 포함)', () {
  testWidgets('앱 최초 실행 시 초기 상태', (tester) async {
    await tester.pumpWidget(const CounterApp());
    
    expect(find.text('Flutter Counter'), findsOneWidget);
    expect(find.text('현재 카운트'), findsOneWidget);
    expect(find.text('0').evaluate().isNotEmpty, true);
    expect(find.text('버튼을 눌러 카운트를 변경하세요'), findsOneWidget);
    expect(find.text('작업 히스토리'), findsOneWidget);
    expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    expect(find.text('감소'), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);
    expect(find.text('초기화'), findsOneWidget);
  });
  
  testWidgets('+ 버튼 클릭으로 카운트 증가 및 히스토리 기록', (tester) async {
    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();
    
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    
    expect(find.text('1').evaluate().isNotEmpty, true);
    expect(find.text('+1'), findsOneWidget);
    expect(find.textContaining('결과: 1'), findsOneWidget);
  });
  
  testWidgets('− 버튼 클릭으로 카운트 감소 및 히스토리 기록', (tester) async {
    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();
    
    // 먼저 + 버튼 3번으로 카운터를 3으로 설정
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    
    // − 버튼 클릭
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();
    
    expect(find.text('2').evaluate().isNotEmpty, true);
    expect(find.text('−1'), findsOneWidget);
  });
  
  testWidgets('복수 작업 히스토리 표시', (tester) async {
    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();
    
    // + 버튼 2번, − 버튼 1번 클릭
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();
    
    // 히스토리에 각 작업이 기록됨
    expect(find.text('+1'), findsNWidgets(2));
    expect(find.text('−1'), findsOneWidget);
    expect(find.textContaining('결과:'), findsWidgets);
  });
  
  testWidgets('초기화 버튼으로 카운터와 히스토리 리셋', (tester) async {
    await tester.pumpWidget(const CounterApp());
    await tester.pumpAndSettle();
    
    // + 버튼 5번 클릭
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
    }
    
    // 초기화 버튼 클릭
    await tester.tap(find.text('초기화'));
    await tester.pumpAndSettle();
    
    expect(find.text('0').evaluate().isNotEmpty, true);
    expect(find.text('아직 기록이 없습니다'), findsOneWidget);
  });
  });
}