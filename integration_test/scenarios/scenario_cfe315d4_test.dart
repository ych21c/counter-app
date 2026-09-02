import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:counter_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('카운터 앱 - 히스토리 및 디자인 검증', () {
    testWidgets('초기 화면: 카운트 0, 빈 히스토리 표시', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      // AppBar 제목 확인
      expect(find.text('Flutter Counter'), findsOneWidget);
      
      // 카운터 라벨 확인
      expect(find.text('현재 카운트'), findsOneWidget);
      
      // 카운터 숫자 0 확인
      expect(find.text('0'), findsWidgets);
      
      // 힌트 텍스트 확인
      expect(find.text('버튼을 눌러 카운트를 변경하세요'), findsOneWidget);
      
      // 버튼 아이콘 확인
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.restart_alt), findsOneWidget);
      
      // 히스토리 섹션 확인
      expect(find.text('작업 히스토리'), findsOneWidget);
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });

    testWidgets('증가 버튼 클릭: 카운트 1 증가, 히스토리에 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      // 증가 버튼 클릭
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // 카운트 1 확인
      expect(find.text('1'), findsWidgets);
      
      // 히스토리 기록 확인
      expect(find.text('+1'), findsOneWidget);
      expect(find.text('결과: 1'), findsOneWidget);
      
      // 빈 메시지는 사라져야 함
      expect(find.text('아직 기록이 없습니다'), findsNothing);
    });

    testWidgets('감소 버튼 클릭: 카운트 감소, 히스토리에 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      // 증가 후 감소
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();

      // 카운트 0 확인
      expect(find.text('0'), findsWidgets);
      
      // 히스토리에 두 액션 모두 있어야 함
      expect(find.text('+1'), findsOneWidget);
      expect(find.text('−1'), findsOneWidget);
      expect(find.text('결과: 0'), findsOneWidget);
    });

    testWidgets('리셋 버튼 클릭: 카운트 0으로, 히스토리 초기화', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      // 여러 번 증가
      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
      }

      // 리셋 버튼 클릭
      await tester.tap(find.byIcon(Icons.restart_alt));
      await tester.pumpAndSettle();

      // 카운트 0 확인
      expect(find.text('0'), findsWidgets);
      
      // 히스토리 초기화 확인
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);
    });

    testWidgets('다중 클릭: 히스토리에 모든 액션 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      // 5회 증가
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
      }

      // 카운트 5 확인
      expect(find.text('5'), findsWidgets);
      
      // 히스토리에 "+1"이 5번 기록되어야 함
      expect(find.text('+1'), findsNWidgets(5));
      
      // 최종 결과 확인
      expect(find.text('결과: 5'), findsOneWidget);
    });
  });
}