import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('앱 실행 시 카운터 초기값 0 표시', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('버튼을 누르면 카운터가 1씩 증가', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget);
    
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('버튼을 여러 번 누르면 카운터가 계속 증가', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget);
    
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
    
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('증가 버튼이 화면에 표시되고 누를 수 있음', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);
    
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('카운터와 버튼이 중앙에 배치됨', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    final centerFinder = find.byType(Center);
    expect(centerFinder, findsOneWidget);
    
    final columnFinder = find.byType(Column);
    expect(columnFinder, findsOneWidget);
    
    final textFinder = find.byType(Text);
    expect(textFinder, findsWidgets);
  });

  testWidgets('화면이 Scaffold로 구성됨', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('카운터 숫자가 큰 폰트 크기로 표시됨', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    final textWidget = find.byType(Text).first;
    expect(textWidget, findsOneWidget);
    
    final textWidgetState = tester.widget<Text>(textWidget);
    expect(textWidgetState.style?.fontSize, 64);
  });
}