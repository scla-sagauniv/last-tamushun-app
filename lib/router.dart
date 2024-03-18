import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:last_tamushun_app/ar/ar_page.dart';
import 'package:last_tamushun_app/ar_gallery/ar_gallery_page.dart';
import 'package:last_tamushun_app/authentication/auth_page.dart';
import 'package:last_tamushun_app/home/home_page.dart';
import 'package:last_tamushun_app/location_browsing/location_browsing_page.dart';
import 'package:last_tamushun_app/picture_browsing/picture_browsing_page.dart';
import 'package:last_tamushun_app/registration/registration_page.dart';

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
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) => const RegistrationPage(),
    ),
    GoRoute(
      path: '/ar-gallery',
      builder: (context, state) => const ARGalleryPage(),
    ),
    GoRoute(
      path: '/picture-browsing',
      builder: (context, state) => const PictureBrowsingPage(),
    ),
    GoRoute(
      path: '/location-browsing',
      builder: (context, state) => const LocationBrowsingPage(),
    ),
    GoRoute(
      path: '/ar',
      builder: (context, state) => const ARPage(),
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
            title: const Text('home'),
            onTap: () => context.go('/'),
          ),
          ListTile(
            title: const Text('auth'),
            onTap: () => context.go('/auth'),
          ),
          ListTile(
            title: const Text('registration'),
            onTap: () => context.go('/registration'),
          ),
          ListTile(
            title: const Text('ar-gallery'),
            onTap: () => context.go('/ar-gallery'),
          ),
          ListTile(
            title: const Text('picture-browsing'),
            onTap: () => context.go('/picture-browsing'),
          ),
          ListTile(
            title: const Text('location-browsing'),
            onTap: () => context.go('/location-browsing'),
          ),
          ListTile(
            title: const Text('ar'),
            onTap: () => context.go('/ar'),
          ),
        ],
      ),
    );
  }
}
