import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_tamushun_app/demo_data/picture_demo.dart';
import 'package:last_tamushun_app/models/video_picture.dart';
import 'package:openapi/api.dart';

final videoPictureRepositoryProvider = Provider<VideoPictureRepository>(
  (ref) => VideoPictureRepositoryImpl(),
);

abstract class VideoPictureRepository {
  Future<List<VideoPicture>> getVideoPicture();
}

class VideoPictureRepositoryImpl implements VideoPictureRepository {
  final apiInstance = DefaultAPI
  @override
  Future<List<VideoPicture>> getVideoPicture() async {
    // return pictureDemo;
    return ;
  }
}
