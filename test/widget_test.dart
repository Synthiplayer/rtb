// test/widget_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:rtb/app.dart'; // Pfad zu eurem App-Entry

void main() {
  testWidgets('HomePage zeigt Willkommens-Text', (WidgetTester tester) async {
    // App aufbauen
    await tester.pumpWidget(const App());

    // Prüfen, dass euer Text auf der HomePage zu sehen ist
    expect(find.text('Willkommen bei den Ragtag Birds!'), findsOneWidget);
  });
}
