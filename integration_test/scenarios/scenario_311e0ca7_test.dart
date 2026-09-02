import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:counter_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('카운터 앱 - 초기 상태, 증가/감소, 히스토리', () {
    testWidgets('앱 최초 실행 시 초기 상태 확인', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // AppBar 제목 확인
      expect(find.text('Flutter Counter'), findsOneWidget);

      // 카운트 초기값 0 확인
      expect(find.text('0'), findsOneWidget);

      // 카운트 레이블 확인
      expect(find.text('현재 카운트'), findsOneWidget);

      // 힌트 텍스트 확인
      expect(
        find.text('버튼을 눌러 카운트를 변경하세요'),
        findsOneWidget,
      );

      // 히스토리 섹션 헤더 확인
      expect(find.text('작업 히스토리'), findsOneWidget);

      // 초기 상태: 히스토리 없음 메시지 확인
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);

      // 감소/증가/초기화 버튼 아이콘 확인
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.restart_alt), findsOneWidget);

      // 버튼 라벨 확인
      expect(find.text('감소'), findsOneWidget);
      expect(find.text('증가'), findsOneWidget);
      expect(find.text('초기화'), findsOneWidget);
    });

    testWidgets('+ 버튼 클릭으로 카운트 증가 및 히스토리 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기 상태 확인
      expect(find.text('0'), findsOneWidget);

      // + 버튼(증가) 클릭
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump(const Duration(milliseconds: 200));

      // 카운트 1로 증가 확인
      expect(find.text('1'), findsOneWidget);

      // 히스토리에 +1 액션 기록 확인
      expect(find.text('+1'), findsOneWidget);

      // 히스토리에 결과 기록 확인
      expect(find.text('결과: 1'), findsOneWidget);

      // 히스토리 비어있음 메시지는 사라져야 함
      expect(find.text('아직 기록이 없습니다'), findsNothing);
    });

    testWidgets('여러 번 증가 시 히스토리 누적 표시', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // + 버튼 3회 클릭
      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump(const Duration(milliseconds: 200));
      }

      // 최종 카운트 3 확인
      expect(find.text('3'), findsOneWidget);

      // 히스토리: +1이 3개 누적되어야 함
      expect(find.text('+1'), findsNWidgets(3));

      // 최종 결과 확인
      expect(find.text('결과: 3'), findsOneWidget);
    });

    testWidgets('− 버튼 클릭으로 카운트 감소 및 히스토리 기록', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // 초기에 + 버튼 클릭하여 카운트를 1로 만들기
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('1'), findsOneWidget);

      // − 버튼(감소) 클릭
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump(const Duration(milliseconds: 200));

      // 카운트 0으로 감소 확인
      expect(find.text('0'), findsOneWidget);

      // 히스토리에 −1 액션 기록 확인
      expect(find.text('−1'), findsOneWidget);

      // 히스토리에 결과 기록 확인
      expect(find.text('결과: 0'), findsOneWidget);
    });

    testWidgets('초기화 버튼으로 카운트와 히스토리 완전 초기화', (tester) async {
      await tester.pumpWidget(const CounterApp());

      // + 버튼 2회 클릭하여 카운트 = 2, 히스토리에 기록 생성
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump(const Duration(milliseconds: 200));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump(const Duration(milliseconds: 200));

      // 카운트 = 2 확인
      expect(find.text('2'), findsOneWidget);

      // 히스토리에 +1이 2개 확인
      expect(find.text('+1'), findsNWidgets(2));

      // 초기화 버튼 클릭
      await tester.tap(find.byIcon(Icons.restart_alt));
      await tester.pump(const Duration(milliseconds: 200));

      // 카운트 = 0으로 초기화 확인
      expect(find.text('0'), findsOneWidget);

      // 히스토리 비어있음 메시지 다시 표시 확인
      expect(find.text('아직 기록이 없습니다'), findsOneWidget);

      // 이전 히스토리 기록 모두 삭제되어야 함
      expect(find.text('+1'), findsNothing);
    });
  });
}
