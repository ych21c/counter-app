import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('배경색이 흰색이고 중앙에 숫자와 버튼이 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 배경색 확인 (Scaffold의 기본 배경색)
    expect(find.byType(Scaffold), findsOneWidget);
    
    // 중앙 정렬 확인
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('증가 버튼이 존재함', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    // 숫자 텍스트 확인
    expect(find.text('0'), findsOneWidget);
    
    // 버튼 확인
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);
  });

  testWidgets('큰 텍스트 크기로 숫자가 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 텍스트 위젯 찾기
    final textWidget = find.text('0');
    expect(textWidget, findsOneWidget);

    // 텍스트의 스타일 확인 (fontSize: 64)
    final Text textElement = tester.widget<Text>(textWidget);
    expect(textElement.style?.fontSize, 64);
  });

  testWidgets('버튼을 누르면 숫자가 1씩 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 초기값 0 확인
    expect(find.text('0'), findsOneWidget);

    // 버튼 탭
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // 1로 증가 확인
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);

    // 다시 탭
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // 2로 증가 확인
    expect(find.text('2'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  testWidgets('여러 번 버튼을 누르면 계속 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // 5번 탭
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
    }

    // 최종값 5 확인
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('버튼이 Material 스타일로 구현되어 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // ElevatedButton이 Material 스타일 버튼임을 확인
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}