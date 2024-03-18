import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:last_tamushun_app/models/video_picture.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Gallery extends StatefulWidget {
  const Gallery(
      {super.key, required this.videoPictures, required this.arkitController});

  final ARKitController arkitController;
  final List<VideoPicture> videoPictures;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  bool isShowing = false;

  void showHandler(List<ARKitNode> pictureNodes) {
    if (isShowing) {
      for (var pictureNode in pictureNodes) {
        widget.arkitController.remove(pictureNode.name);
      }
    } else {
      for (var pictureNode in pictureNodes) {
        widget.arkitController.add(pictureNode);
      }
    }
    isShowing = !isShowing;
  }

  @override
  Widget build(BuildContext context) {
    final List<ARKitNode> pictureNodes =
        widget.videoPictures.asMap().entries.map((videoPicture) {
      const pictureNodeWidth = 640 / 100 / 5;
      final pictureNode = ARKitNode(
        geometry: ARKitPlane(
          width: pictureNodeWidth,
          height: pictureNodeWidth * (9 / 16),
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialImage(videoPicture.value.pictureUrl),
            ),
          ],
        ),
        position: vector.Vector3(videoPicture.key * pictureNodeWidth, 0.5, -1),
        eulerAngles: vector.Vector3(0, 0, 0),
        name: videoPicture.key.toString(),
      );
      return pictureNode;
    }).toList();
    return ElevatedButton(
      onPressed: () => showHandler(pictureNodes),
      child: const Icon(Icons.photo_album),
    );
  }
}
