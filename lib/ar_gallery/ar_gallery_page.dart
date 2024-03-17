import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ARGalleryPage extends StatelessWidget {
  const ARGalleryPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ARGallery Page'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
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
