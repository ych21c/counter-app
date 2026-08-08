import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('앱 시작 시 숫자 0 표시', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('버튼 클릭 후 숫자 1로 증가', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.text('0'), findsOneWidget);
    
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });

  testWidgets('버튼 여러 번 클릭 시 숫자 누적 증가', (WidgetTester tester) async {
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

  testWidgets('화면 중앙에 숫자와 버튼이 배치됨', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('증가 버튼이 존재함', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);
  });
}