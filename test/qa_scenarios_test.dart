import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('앱 시작 시 숫자 0이 화면 중앙에 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.byType(Center), findsAtLeastNWidgets(1));
  });

  testWidgets('버튼을 한 번 눌렀을 때 숫자가 1로 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });

  testWidgets('버튼을 여러 번 눌렀을 때 계속 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);

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

  testWidgets('FloatingActionButton이 존재하고 탭 가능하다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
<<<<<<< HEAD

    expect(find.byType(FloatingActionButton), findsOneWidget);

    final button = find.byType(FloatingActionButton);
    expect(tester.widget(button), isNotNull);
=======
    
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
>>>>>>> 542853f (AI Implement: Flutter 앱: 화면 1개, 중앙에 숫자(0부터 시작)와 버튼 하나. 버튼 누르면 숫자 1씩 증가. 그)
  });

  testWidgets('화면 배경색이 흰색이다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    final scaffold = find.byType(Scaffold);
    expect(scaffold, findsOneWidget);
    
    final scaffoldWidget = tester.widget<Scaffold>(scaffold);
    expect(scaffoldWidget.backgroundColor, const Color(0xFFFFFFFF));
  });

  testWidgets('숫자가 큰 텍스트 크기로 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final counterText = find.byWidgetPredicate(
      (widget) => widget is Text && widget.data == '0',
    );

    expect(counterText, findsOneWidget);

    final textWidget = tester.widget<Text>(counterText);
    expect(textWidget.style?.fontSize, 80);
  });

  testWidgets('버튼이 올바른 색상으로 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final button = find.byType(FloatingActionButton);
    final buttonWidget = tester.widget<FloatingActionButton>(button);

    expect(buttonWidget.backgroundColor, const Color(0xFF6200EE));
  });

  testWidgets('버튼에 더하기 아이콘이 포함되어 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}