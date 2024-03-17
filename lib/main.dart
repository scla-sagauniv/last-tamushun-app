import 'package:flutter/material.dart';
import 'package:last_tamushun_app/router.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
