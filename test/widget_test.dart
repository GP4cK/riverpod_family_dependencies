import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_family_dependencies/main.dart';

void main() {
  testWidgets('Test scoping provider', (WidgetTester tester) async {
    const text = 'please help me Remi';
    await tester.pumpWidget(
      ProviderScope(
        child: ProviderScope(
          overrides: [a('hello world').overrideWithValue(text)],
          child: const MyApp(),
        ),
      ),
    );
    expect(find.text(text), findsOneWidget);
  });
}
