import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openapi/api.dart';

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
    // return pictureDemo;
    try {
      final respons = await apiInstance
          .getMedia("Bearer 1234567890abcdefghijklmnopqrstuvwxyz");
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
