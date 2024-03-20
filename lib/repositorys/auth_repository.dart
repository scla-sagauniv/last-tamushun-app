import 'package:crypt/crypt.dart';
import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final apiInstance = DefaultApi();

  Future<void> postLogin(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final hashedPassword = Crypt.sha256(password);

    try {
      final postLoginRequest = PostLoginRequest(
        email: email,
        // password: hashedPassword.toString(),
        password: password,
      );
      final result =
          await apiInstance.postLogin(postLoginRequest: postLoginRequest);
      if (result != null && result.token != null) {
        await prefs.setString('token', result.token!);
      }
      throw Exception('Failed to login');
    } catch (e) {
      print('Exception when calling DefaultApi->postLogin: $e\n');
      await prefs.remove('token');
      throw Exception('Failed to login');
    }
  }

  Future<void> postSignUp(String email, String password, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final hashedPassword = Crypt.sha256(password);
    try {
      final postUserRequest = PostUserRequest(
        email: email,
        hashedPassword: hashedPassword.toString(),
        name: name,
      );
      await apiInstance.postUser(postUserRequest: postUserRequest);
    } catch (e) {
      print('Exception when calling DefaultApi->postRegister: $e\n');
      await prefs.remove('token');
      throw Exception('Failed to register');
    }
  }
}
