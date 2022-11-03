import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final a = Provider.family.autoDispose<String, String>((ref, value) {
  return value;
});

final b = Provider.family.autoDispose<String, String>((ref, value) {
  return ref.watch(a(value));
}, dependencies: [a]);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Text(ref.watch(b('hello world'))),
    );
  }
}
