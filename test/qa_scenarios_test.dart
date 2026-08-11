import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('앱 시작 시 화면에 0이 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('버튼을 한 번 누르면 숫자가 1로 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.text('0'), findsOneWidget);
    
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });

  testWidgets('버튼을 여러 번 누르면 계속 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);
    
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('버튼이 FloatingActionButton으로 구현되어 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('숫자가 큰 텍스트 크기(80)로 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    final textWidget = find.byWidgetPredicate(
      (widget) => widget is Text && widget.data == '0',
    );
    
    expect(textWidget, findsOneWidget);
    
    final Text counterText = tester.widget<Text>(textWidget);
    expect(counterText.style?.fontSize, equals(80));
  });

  testWidgets('화면이 중앙에 정렬되어 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    final centerWidget = find.byType(Center);
    expect(centerWidget, findsAtLeastNWidgets(1));
  });
}