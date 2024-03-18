import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String infoText = ''; // エラーメッセージ用の変数

  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // final response = await http.post(
      //   Uri.parse('http://localhost:3001/login'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({
      //     'username': nameController.text,
      //     'password': passwordController.text,
      //   }),
      // );

      var statusCode;
      statusCode = 200;
      if (statusCode == 200) {
        // final responseData = json.decode(response.body);
        Map<String, dynamic> responseData = {}; // 既存のMapオブジェクトがあると仮定
        responseData['accessToken'] =
            "hogehoge"; // 'accessToken'キーに"hogehoge"を代入
        if (responseData['accessToken'] != null) {
          await prefs.setString('token', responseData['accessToken']);
          GoRouter.of(context).go('/route_list');
        } else {
          setState(() {
            infoText = responseData['message'] ?? 'Unknown error occurred.';
          });
          Error();
        }
      } else {
        setState(() {
          // infoText = 'Error: ${response.statusCode}';
          infoText = 'Error: ${statusCode}';
        });
        Error();
      }
    } catch (e) {
      setState(() {
        infoText = 'Login failed: ${e.toString()}';
      });
      await prefs.setString('token', '');
      GoRouter.of(context).go('/auth');
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
                  controller: nameController,
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
                // ユーザー登録ボタンの処理は省略
              ],
            ),
          ),
        ),
      );
}
