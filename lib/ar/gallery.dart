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
  bool isPlaing = false;

  Future<void> _onVideoEndListener() async {
    if (videoController.value.isInitialized &&
        !videoController.value.isBuffering &&
        !videoController.value.isPlaying &&
        videoController.value.duration <= videoController.value.position) {
      await videoController.pause();
      await videoController.seekTo(const Duration(seconds: 0));
      isPlaing = false;
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
          isPlaing
              ? AspectRatio(
                  aspectRatio: videoController.value.aspectRatio,
                  child: VideoPlayer(videoController),
                )
              : const SizedBox(),
          !isPlaing
              ? IconButton(
                  onPressed: () async {
                    if (!isPlaing) {
                      await videoController.play();
                      isPlaing = true;
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
