import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:last_tamushun_app/ar/ar_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_tamushun_app/authentication/login_page.dart';
import 'package:last_tamushun_app/error_page.dart';
import 'package:last_tamushun_app/home/home_page.dart';
import 'package:last_tamushun_app/registration/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/signup_page.dart';

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
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: '/registration',
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: '/ar',
        builder: (context, state) => const ARPage(),
      ),
      GoRoute(
        path: '/error',
        builder: (context, state) => const ErrorPage(),
      ),
    ],
    redirect: (context, state) async {
      final token = await _getToken();

      final isLoggingIn = state.matchedLocation == '/login';
      final isSigningUp = state.matchedLocation == '/signup';

      // トークンが存在し、ログインページまたはサインアップページにアクセスしようとしている場合は、そのまま許可
      if (token != null && (isLoggingIn || isSigningUp)) {
        return null;
      }

      // トークンが存在し、ログインやサインアップ以外のページにアクセスしようとしている場合はホームへリダイレクト
      if (token != null) {
        return null;
      }

      // トークンが存在しない場合は、ログインページにリダイレクト
      if (token == null && !isLoggingIn && !isSigningUp) {
        return '/login';
      }

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
            onTap: () => context.go('/login'),
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
