import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 100,
              color: Colors.red,
            ),
            const Text(
              'Error',
              style: TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to Home Page'),
            )
          ],
        ),
      ),
    );
  }
}
