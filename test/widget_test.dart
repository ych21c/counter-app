import 'package:flutter_test/flutter_test.dart';

import 'package:counter_app/main.dart';

void main() {
  testWidgets('Counter starts at 0 and increments on button tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.text('증가'));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
