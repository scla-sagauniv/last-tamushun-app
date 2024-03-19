import 'dart:async';
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
  double distance = 4;
  double r = 4.0;
  double lastPanTranslationX = 0;
  double lastPanTranslationXIncrement = 0;
  bool isPanning = false;
  final stpowatch = Stopwatch();
  Timer? panTimer;

  void initValueForPan() {
    lastPanTranslationX = 0;
    lastPanTranslationXIncrement = 0;
    isPanning = false;
  }

  @override
  void initState() {
    super.initState();
    widget.arkitController.onNodePan = galleryPanHandler;
    r = widget.videoPictures.length / 3;
    distance = r;
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
    stpowatch.start();
  }

  @override
  void dispose() {
    widget.arkitController.onNodePan = null;
    stpowatch.stop();
    panTimer?.cancel();
    super.dispose();
  }

  void showHandler() async {
    if (isShowing) {
      panTimer?.cancel();
      for (int i = 0; i < widget.videoPictures.length; i++) {
        widget.arkitController.remove("gallery/$i");
      }
      widget.arkitController.remove("centerAnchorNode");
    } else {
      panTimer?.cancel();
      panWatcher();
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
        final thisNodeAngle =
            videoPicture.key * (pi / (widget.videoPictures.length / 2));
        const pictureNodeWidth = 640 / 1000;
        final pictureNode = ARKitNode(
          geometry: ARKitPlane(
            width: pictureNodeWidth,
            height: pictureNodeWidth * (9 / 16),
            materials: [
              ARKitMaterial(
                diffuse: ARKitMaterialImage(videoPicture.value.imageUrl),
                doubleSided: false,
              ),
            ],
          ),
          position: vector.Vector3(
            centerAnchor.x - r / 2 * sin(thisNodeAngle),
            centerAnchor.y,
            centerAnchor.z - r / 2 * cos(thisNodeAngle),
          ),
          eulerAngles: vector.Vector3(thisNodeAngle - pi, 0, 0),
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
    isPanning = true;
    if (stpowatch.elapsedMilliseconds > 100) {
      lastPanTranslationX = 0;
    }
    ARKitNodePanResult? panNode = [...pan, null].firstWhere(
      (e) => e != null && e.nodeName == "centerAnchorNode",
      orElse: () => null,
    );
    if (panNode == null) {
      return;
    }
    final oldCenterAnchorAngleX = centerAnchorNode.eulerAngles.x;
    final newAngleX = panNode.translation.x / 100;
    centerAnchorNode.eulerAngles = vector.Vector3(
        oldCenterAnchorAngleX + (newAngleX - lastPanTranslationX), 0, 0);
    lastPanTranslationX = newAngleX;
    lastPanTranslationXIncrement = newAngleX - lastPanTranslationX;

    for (final (idx, pictureNode) in pictureNodes.indexed) {
      final oldPictureNode = pictureNode.eulerAngles;
      final newNodeAngleX = centerAnchorNode.eulerAngles.x -
          idx * (pi / (widget.videoPictures.length / 2));
      pictureNode.position = vector.Vector3(
        centerAnchorNode.position.x - r / 2 * sin(newNodeAngleX),
        centerAnchorNode.position.y,
        centerAnchorNode.position.z - r / 2 * cos(newNodeAngleX),
      );
      pictureNode.transform.rotateY(newNodeAngleX - oldPictureNode.x - pi);
    }
    stpowatch.reset();
  }

  void panWatcher() {
    double lastObservedValue = 0;
    panTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (!isPanning) return;
      if (lastPanTranslationX == lastObservedValue) {
        initValueForPan();
        panInertia(lastObservedValue);
        lastObservedValue = 0;
        return;
      }
      lastObservedValue = lastPanTranslationX;
    });
  }

  void panInertia(double translationXIncrement) {
    if (translationXIncrement.abs() < 0.3) {
      return;
    }
    double decelerationRatio = 0.1;
    final isMinus = translationXIncrement < 0;
    double lastIncrementValue = translationXIncrement;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (isMinus) {
        if (lastIncrementValue > -0.05) {
          timer.cancel();
        }
      } else {
        if (lastIncrementValue < 0.05) {
          timer.cancel();
        }
      }
      if (lastIncrementValue.abs() < 0.05) {
        timer.cancel();
      }

      final oldCenterAnchorAngleX = centerAnchorNode.eulerAngles.x;
      centerAnchorNode.eulerAngles =
          vector.Vector3(oldCenterAnchorAngleX + lastIncrementValue, 0, 0);

      for (final (idx, pictureNode) in pictureNodes.indexed) {
        final oldPictureNode = pictureNode.eulerAngles;
        final newNodeAngleX = centerAnchorNode.eulerAngles.x -
            idx * (pi / (widget.videoPictures.length / 2));
        pictureNode.position = vector.Vector3(
          centerAnchorNode.position.x - r / 2 * sin(newNodeAngleX),
          centerAnchorNode.position.y,
          centerAnchorNode.position.z - r / 2 * cos(newNodeAngleX),
        );
        pictureNode.transform.rotateY(newNodeAngleX - oldPictureNode.x - pi);
      }

      if (isMinus) {
        lastIncrementValue += decelerationRatio;
      } else {
        lastIncrementValue -= decelerationRatio;
      }
      decelerationRatio = lastIncrementValue.abs() * 0.35;
    });
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
