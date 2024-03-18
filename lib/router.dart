import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_tamushun_app/ar_gallery/ar_gallery_page.dart';
import 'package:last_tamushun_app/authentication/auth_page.dart';
import 'package:last_tamushun_app/home/home_page.dart';
import 'package:last_tamushun_app/location_browsing/location_browsing_page.dart';
import 'package:last_tamushun_app/picture_browsing/picture_browsing_page.dart';
import 'package:last_tamushun_app/registration/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

class AuthNotifier extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  void setToken(String? newToken) {
    _token = newToken;
    notifyListeners();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }
}

// AuthNotifierのProvider
final authNotifierProvider = ChangeNotifierProvider((ref) => AuthNotifier());

// GoRouter configuration
final routerProvider = Provider((ref) {
  final authNotifier = ref.watch(authNotifierProvider);
  return GoRouter(
    routes: [
      GoRoute(
        path: '/route_list',
        builder: (context, state) => const RouteListPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) {
          print("HOME");
          return const HomePage();
        },
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
    ],
    redirect: (context, state) async {
      final token = await _getToken();

      print(token);

      final loggingIn = state.matchedLocation == '/auth';

      if (token == null && !loggingIn) return '/auth';
      if (token != null && loggingIn) return '/';

      return null;
    },
    refreshListenable: authNotifier,
  );
});

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
        ],
      ),
    );
  }
}
