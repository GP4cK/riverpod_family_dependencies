import 'package:flutter/widgets.dart';
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

  testWidgets('test scoping family provider with overrideWith', (tester) async {
    const text = 'hello riverpod';
    const family = 'hello world';
    final a =
        Provider.family.autoDispose<String, String>((ref, value) => value);

    final b = Provider.family.autoDispose<String, String>(
      (ref, value) => ref.watch(a(value)),
      dependencies: [a],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: ProviderScope(
          overrides: [
            a.overrideWith((ref, value) => text)
          ], // Overrides `a` entirely.
          child: Consumer(
            builder: (_, ref, __) => Text(
              ref.watch(b(family)),
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
    );
    expect(find.text(text), findsOneWidget);
  });

  testWidgets('test scoping a provider with overrideWith', (tester) async {
    const text = 'hello riverpod';
    const family = 'hello world';
    final a =
        Provider.family.autoDispose<String, String>((ref, value) => value);

    final b = Provider.family.autoDispose<String, String>(
      (ref, value) => ref.watch(a(value)),
      dependencies: [a],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: ProviderScope(
          overrides: [
            a(family).overrideWith((ref) => text)
          ], // Only override a(family).
          child: Consumer(
            builder: (_, ref, __) => Text(
              ref.watch(b(family)),
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ),
    );
    expect(find.text(text), findsOneWidget);
  });
}
