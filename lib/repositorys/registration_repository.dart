import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationRepository {
  final apiInstance = DefaultApi();

  Future<String> postUploadFile(String imageURL, String movieURL) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final token = prefs.getString('token');
      final respons = await apiInstance.postMedia("Bearer $token",
          postMediaRequest: PostMediaRequest(
            lon: 0,
            lat: 0,
            imageUrl: imageURL,
            movieUrl: movieURL,
          ));
      if (respons == null) {
        throw Exception('Failed to get video picture');
      }
      print(respons.toString());
      return respons.toString();
    } catch (e) {
      print(e);
      throw Exception('Failed to get video picture');
    }
  }
}
