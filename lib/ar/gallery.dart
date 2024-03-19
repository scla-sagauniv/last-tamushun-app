import 'dart:math';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Gallery extends StatefulWidget {
  const Gallery(
      {super.key, required this.videoPictures, required this.arkitController});

  final ARKitController arkitController;
  final List<Media> videoPictures;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  bool isShowing = false;

  void showHandler() async {
    if (isShowing) {
      for (int i = 0; i < widget.videoPictures.length; i++) {
        widget.arkitController.remove(i.toString());
      }
    } else {
      vector.Vector3 cameraPosition =
          await widget.arkitController.cameraPosition() ??
              vector.Vector3(0, 0, 0);
      vector.Vector3 cameraEulerAngle =
          await widget.arkitController.getCameraEulerAngles();
      final List<ARKitNode> pictureNodes =
          widget.videoPictures.asMap().entries.map((videoPicture) {
        const distance = 4;
        final thisNodeAngleY = cameraEulerAngle.y - videoPicture.key * (pi / 8);
        const pictureNodeWidth = 640 / 100 / 5;
        final pictureNode = ARKitNode(
          geometry: ARKitPlane(
            width: pictureNodeWidth,
            height: pictureNodeWidth * (9 / 16),
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialImage(videoPicture.value.imageUrl),
                doubleSided: true,
              ),
            ],
          ),
          position: vector.Vector3(
            cameraPosition.x - distance * sin(thisNodeAngleY),
            cameraPosition.y,
            cameraPosition.z - distance * cos(thisNodeAngleY),
          ),
          eulerAngles: vector.Vector3(thisNodeAngleY, 0, 0),
          name: "gallery/${videoPicture.key}",
        );
        return pictureNode;
      }).toList();
      for (final pictureNode in pictureNodes) {
        widget.arkitController.add(pictureNode);
      }
    }
    isShowing = !isShowing;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showHandler(),
      child: const Icon(Icons.photo_album),
    );
  }
}

void galleryTapHandler(
    BuildContext context, String nodeName, List<Media> videoPictures) {
  final pictureIndex = int.parse(nodeName.split("/").last);
  final imageUrl = videoPictures[pictureIndex].imageUrl;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          content: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            imageUrl,
            width: 640,
            height: 480,
            fit: BoxFit.fitWidth,
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(Icons.close),
          ),
        ],
      ));
    },
  );
}
