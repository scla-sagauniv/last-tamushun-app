import 'package:openapi/api.dart';

class RegistrationRepository {
  final apiInstance = DefaultApi();

  Future<String> postUploadFile(String imageURL, String movieURL) async {
    try {
      final respons = await apiInstance.postMedia(
          "Bearer 1234567890abcdefghijklmnopqrstuvwxyz",
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
