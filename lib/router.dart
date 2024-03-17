import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:last_tamushun_app/home/home_page.dart';

// GoRouter configuration
GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/route_list',
      builder: (context, state) => const RouteListPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);

class RouteListPage extends StatelessWidget {
  const RouteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route List'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('root'),
            onTap: () => context.go('/'),
          ),
        ],
      ),
    );
  }
}
