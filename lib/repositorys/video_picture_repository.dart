import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

final videoPictureRepositoryProvider = Provider<VideoPictureRepository>(
  (ref) => VideoPictureRepositoryImpl(),
);

abstract class VideoPictureRepository {
  Future<List<Media>> getVideoPicture();
}

class VideoPictureRepositoryImpl implements VideoPictureRepository {
  final apiInstance = DefaultApi();

  @override
  Future<List<Media>> getVideoPicture() async {
    final prefs = await SharedPreferences.getInstance();
    // return pictureDemo;
    try {
      final token = prefs.getString('token');
      if (token == null) {
        throw Exception('Token is null');
      }
      final respons = await apiInstance.getMedia('Bearer $token');
      if (respons == null) {
        throw Exception('Failed to get video picture');
      }
      return respons.medium;
    } catch (e) {
      print(e);
      throw Exception('Failed to get video picture');
    }
  }
}
