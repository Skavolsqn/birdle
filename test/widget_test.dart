import 'package:flutter_test/flutter_test.dart';

import 'package:birdle/main.dart';

void main() {
  testWidgets('Birdle abre com título e campo de texto', (tester) async {
    await tester.pumpWidget(const BirdleApp());

    expect(find.text('Birdle'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}