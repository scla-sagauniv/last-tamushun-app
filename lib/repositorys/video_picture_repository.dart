import 'package:last_tamushun_app/demo_data/picture_demo.dart';
import 'package:last_tamushun_app/models/video_picture.dart';

class VideoPictureProvider {
  final VideoPictureRepository _videopictureRepository =
      VideoPictureRepository();

  Future<List<VideoPicture>> getVideoPicture() async {
    return await _videopictureRepository.getVideoPicture();
  }
}

class VideoPictureRepository {
  Future<List<VideoPicture>> getVideoPicture() async {
    return pictureDemo;
  }
}
