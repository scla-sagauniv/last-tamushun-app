import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_tamushun_app/router.dart';

void main() => runApp(const ProviderScope(child: MaterialApp(home: MyApp())));

/// The main app.
class MyApp extends ConsumerWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // GoRouterオブジェクトをProviderから取得
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      // routeInformationParser: router.routeInformationParser,
      // routerDelegate: router.routerDelegate,
      routerConfig: router,
    );
  }
}
