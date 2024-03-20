import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:last_tamushun_app/repositorys/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String infoText = ''; // エラーメッセージ用の変数
  final AuthRepository authRepository = AuthRepository();

  Future<void> signup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await authRepository.postSignUp(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      GoRouter.of(context).go('/route_list');
    } catch (e) {
      setState(() {
        infoText = 'SignUp failed: ${e.toString()}';
      });
      await prefs.setString('token', '');
      GoRouter.of(context).go('/signup');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('SignUp Page'),
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
                  controller: nameController,
                  decoration: InputDecoration(labelText: '名前'),
                ),
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
                  child: Text('サインアップ'),
                  onPressed: signup, // ログイン関数を呼び出す
                ),
                ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () => context.go('/login'),
                )

                // ユーザー登録ボタンの処理は省略
              ],
            ),
          ),
        ),
      );
}
