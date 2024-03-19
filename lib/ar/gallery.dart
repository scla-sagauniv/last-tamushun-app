import 'dart:math';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:video_player/video_player.dart';

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
  late ARKitNode centerAnchorNode;
  List<ARKitNode> pictureNodes = [];
  final distance = 4;
  final r = 4.0;

  @override
  void initState() {
    super.initState();
    widget.arkitController.onNodePan = galleryPanHandler;
    centerAnchorNode = ARKitNode(
      geometry: ARKitSphere(
        radius: r / 2,
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.image('assets/earth.jpg'),
            doubleSided: true,
            transparency: 0,
          ),
        ],
      ),
      position: vector.Vector3(0, 0, 0),
      name: "centerAnchorNode",
    );
  }

  void showHandler() async {
    if (isShowing) {
      for (int i = 0; i < widget.videoPictures.length; i++) {
        widget.arkitController.remove("gallery/$i");
      }
      widget.arkitController.remove("centerAnchorNode");
    } else {
      vector.Vector3 cameraPosition =
          await widget.arkitController.cameraPosition() ??
              vector.Vector3(0, 0, 0);
      vector.Vector3 cameraEulerAngle =
          await widget.arkitController.getCameraEulerAngles();
      final centerAnchor = vector.Vector3(
        cameraPosition.x - distance * sin(cameraEulerAngle.y),
        cameraPosition.y,
        cameraPosition.z - distance * cos(cameraEulerAngle.y),
      );
      centerAnchorNode.position = centerAnchor;
      widget.arkitController.add(centerAnchorNode);
      pictureNodes = widget.videoPictures.asMap().entries.map((videoPicture) {
        final thisNodeAngle = videoPicture.key * (pi / 8);
        const pictureNodeWidth = 640 / 1000;
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
            centerAnchor.x - r / 2 * sin(thisNodeAngle),
            centerAnchor.y,
            centerAnchor.z - r / 2 * cos(thisNodeAngle),
          ),
          eulerAngles: vector.Vector3(thisNodeAngle, 0, 0),
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

  void galleryPanHandler(List<ARKitNodePanResult> pan) {
    ARKitNodePanResult? panNode = [...pan, null].firstWhere(
      (e) => e != null && e.nodeName == "centerAnchorNode",
      orElse: () => null,
    );
    if (panNode == null) {
      return;
    }
    final oldCenterAnchorNode = centerAnchorNode.eulerAngles;
    final newAngleX = panNode.translation.x * pi / 500;
    centerAnchorNode.eulerAngles = vector.Vector3(
      oldCenterAnchorNode.x + newAngleX,
      oldCenterAnchorNode.y,
      oldCenterAnchorNode.z,
    );

    for (final (idx, pictureNode) in pictureNodes.indexed) {
      final oldPictureNode = pictureNode.eulerAngles;
      final newNodeAngleX = centerAnchorNode.eulerAngles.x - idx * (pi / 8);
      pictureNode.position = vector.Vector3(
        centerAnchorNode.position.x - r / 2 * sin(newNodeAngleX),
        centerAnchorNode.position.y,
        centerAnchorNode.position.z - r / 2 * cos(newNodeAngleX),
      );
      pictureNode.transform.rotateY(newNodeAngleX - oldPictureNode.x);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showHandler(),
      child: const Icon(Icons.photo_album),
    );
  }
}

class GalleryDialog extends StatefulWidget {
  const GalleryDialog(
      {super.key, required this.videoPictures, required this.nodeName});

  final String nodeName;
  final List<Media> videoPictures;

  @override
  State<GalleryDialog> createState() => _GalleryDialogState();
}

class _GalleryDialogState extends State<GalleryDialog> {
  late VideoPlayerController videoController;
  late String imageUrl;
  bool isPlaying = false;

  Future<void> _onVideoEndListener() async {
    if (videoController.value.isInitialized &&
        !videoController.value.isBuffering &&
        !videoController.value.isPlaying &&
        videoController.value.duration <= videoController.value.position) {
      await videoController.pause();
      await videoController.seekTo(const Duration(seconds: 0));
      isPlaying = false;
      if (!mounted) return;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    final pictureIndex = int.parse(widget.nodeName.split("/").last);
    imageUrl = widget.videoPictures[pictureIndex].imageUrl;
    final movieUrl = widget.videoPictures[pictureIndex].movieUrl;
    videoController = VideoPlayerController.networkUrl(Uri.parse(movieUrl));
    videoController.addListener(_onVideoEndListener);
    videoController.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: videoController.initialize(),
      builder: (context, snapshot) => AlertDialog(
        content: Stack(alignment: Alignment.center, children: [
          Image.network(
            imageUrl,
            width: 640,
            height: 480,
            fit: BoxFit.fitWidth,
          ),
          isPlaying
              ? AspectRatio(
                  aspectRatio: videoController.value.aspectRatio,
                  child: VideoPlayer(videoController),
                )
              : const SizedBox(),
          !isPlaying
              ? IconButton(
                  onPressed: () async {
                    if (!isPlaying) {
                      await videoController.play();
                      isPlaying = true;
                    }
                    setState(() {});
                  },
                  icon: const Icon(Icons.play_circle_outlined),
                  iconSize: 80,
                  color: Colors.white60,
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}

void galleryTapHandler(
    BuildContext context, String nodeName, List<Media> videoPictures) {
  showDialog(
    context: context,
    builder: (BuildContext context) =>
        GalleryDialog(videoPictures: videoPictures, nodeName: nodeName),
  );
}
