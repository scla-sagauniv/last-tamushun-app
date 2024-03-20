import 'package:crypt/crypt.dart';
import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final apiInstance = DefaultApi();

  Future<void> postLogin(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final hashedPassword =
        Crypt.sha256(password, salt: 'hgagjkdhgklajfklj').toString();
    print("raw password is $password");
    print("hashed password is $hashedPassword");
    try {
      final userLogin = UserLogin(
        email: email,
        // password: hashedPassword.toString(),
        hashedPassword: hashedPassword,
      );
      final result = await apiInstance.postLogin(userLogin: userLogin);
      if (result != null && result.token != null) {
        print("token is ${result.token}");
        await prefs.setString('token', result.token!);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Exception when calling DefaultApi->postLogin: $e\n');
      await prefs.remove('token');
      throw Exception('Failed to login');
    }
  }

  Future<void> postSignUp(String email, String password, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final hashedPassword =
        Crypt.sha256(password, salt: 'hgagjkdhgklajfklj').toString();
    print("raw password is $password");
    print("hashed password is $hashedPassword");
    try {
      final userCreate = UserCreate(
        email: email,
        hashedPassword: hashedPassword,
        name: name,
      );
      final result = await apiInstance.postUser(userCreate: userCreate);
      if (result != null && result.token != null) {
        print("token is ${result.token}");
        await prefs.setString('token', result.token!);
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      print('Exception when calling DefaultApi->postRegister: $e\n');
      await prefs.remove('token');
      throw Exception('Failed to register');
    }
  }
}
// $5$mYagyVfgIbkELDCv$Ape4G3du/rCMCfF7n690XNCxFhBanlZkSUa3N0UWuj2
// $5$911xrWeEvria8VhB$VFVYJP5kawNRWdq7/sM5udcAuYT8CPLHJgjRK5F35m4