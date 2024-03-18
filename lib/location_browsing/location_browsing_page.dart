import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocationBrowsingPage extends StatelessWidget {
  const LocationBrowsingPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('LocationBrowsing Page'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop('/'),
          ),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to Home Page'),
            ),
          ],
        ),
      );
}
