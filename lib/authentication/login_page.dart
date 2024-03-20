import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:last_tamushun_app/repositorys/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String infoText = ''; // エラーメッセージ用の変数
  final AuthRepository authRepository = AuthRepository();

  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await authRepository.postLogin(
          emailController.text, passwordController.text);
      GoRouter.of(context).go('/route_list');
    } catch (e) {
      setState(() {
        infoText = 'Login failed: ${e.toString()}';
      });
      await prefs.setString('token', '');
      GoRouter.of(context).go('/login');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Auth Page'),
          leadingWidth: 110,
          leading: TextButton(
            child: const Text('＜ route_list'),
            onPressed: () => context.go('/route_list'),
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'メールアドレス'),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                ),
                Text(infoText),
                ElevatedButton(
                  child: Text('ログイン'),
                  onPressed: login, // ログイン関数を呼び出す
                ),
                ElevatedButton(
                  onPressed: () => context.go('/signup'),
                  child: const Text('新規登録'),
                )
                // ユーザー登録ボタンの処理は省略
              ],
            ),
          ),
        ),
      );
}
