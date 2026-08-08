import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/main.dart';

void main() {
  testWidgets('앱 시작 시 숫자 0이 중앙에 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.text('0'), findsOneWidget);
    expect(find.byType(Center), findsOneWidget);
  });

  testWidgets('버튼을 한 번 누르면 숫자가 1로 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.text('0'), findsOneWidget);
    
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('버튼을 여러 번 누르면 숫자가 계속 증가한다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
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

  testWidgets('증가 버튼이 화면에 표시된다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('증가'), findsOneWidget);
  });

  testWidgets('숫자와 버튼이 Column으로 세로 정렬되어 있다', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}