import 'dart:async';
import 'dart:math';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_tamushun_app/models/video_picture.dart';
import 'package:last_tamushun_app/repositorys/video_picture_repository.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class PictureBrowsingPage extends ConsumerStatefulWidget {
  const PictureBrowsingPage({super.key});

  @override
  PictureBrowsingPageState createState() => PictureBrowsingPageState();
}

class PictureBrowsingPageState extends ConsumerState<PictureBrowsingPage> {
  late ARKitController arkitController;
  late String referenceImageName = '';
  late Future<List<VideoPicture>> videoPicturesFuture;
  late VideoPicture videoPictures;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    final videoPictureRepository = ref.read(videoPictureRepositoryProvider);
    videoPicturesFuture = videoPictureRepository.getVideoPicture();
  }

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: videoPicturesFuture,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: const Text('Picture Browsing'),
        ),
        body: snapshot.connectionState == ConnectionState.done
            ? _builder(snapshot.data!)
            : Column(
                children: [
                  const CircularProgressIndicator(),
                  Text(snapshot.connectionState.name)
                ],
              ),
      ),
    );
  }

  Widget _builder(List<VideoPicture> videoPictures) {
    vector.Vector3 rotationMatrixToEulerAngles(vector.Matrix3 R) {
      double pitch, roll, yaw;

      pitch = asin(-R.getRow(2)[0]);

      if (R.getRow(2)[0].abs() < 0.999) {
        yaw = asin(R.getRow(1)[0] / cos(pitch));
        roll = asin(R.getRow(2)[1] / cos(pitch));
      } else if (R.getRow(2)[0] > 0) {
        yaw = asin(-R.getRow(0)[1]);
        roll = 0;
      } else {
        yaw = asin(-R.getRow(0)[1]);
        roll = 0;
      }

      return vector.Vector3(pitch, roll + pi / 2, yaw);
    }

    void onAnchorWasFound(ARKitAnchor anchor) {
      if (anchor is ARKitImageAnchor) {
        setState(() {
          referenceImageName = anchor.referenceImageName ?? '';
        });
        if (referenceImageName == '') {
          return;
        }
        final referencedPictureVideoUrl = videoPictures
            .firstWhere((e) => e.pictureUrl == referenceImageName)
            .videoUrl;
        final imageSize = anchor.referenceImagePhysicalSize;

        final video = ARKitMaterialProperty.video(
          url: referencedPictureVideoUrl,
          width: 640,
          height: 320,
          autoplay: true,
        );

        final material = ARKitMaterial(
          diffuse: video,
          doubleSided: true,
        );

        final plane = ARKitPlane(
          width: imageSize.x,
          height: imageSize.y,
          materials: [material],
        );

        final detectPosition = anchor.transform.getTranslation();
        final detectRotation = anchor.transform.getRotation();
        final detectEulerAngles = rotationMatrixToEulerAngles(detectRotation);
        final node = ARKitNode(
          geometry: plane,
          position: vector.Vector3(
              detectPosition.x, detectPosition.y, detectPosition.z),
          eulerAngles: detectEulerAngles,
        );
        arkitController.add(node);
      }
    }

    void onARKitViewCreated(ARKitController arkitController) {
      this.arkitController = arkitController;
      arkitController.onAddNodeForAnchor = onAnchorWasFound;
    }

    return Stack(
      children: [
        ARKitSceneView(
          detectionImages: videoPictures
              .map((e) => ARKitReferenceImage(
                    name: e.pictureUrl,
                    physicalWidth: 0.2,
                  ))
              .toList(),
          onARKitViewCreated: onARKitViewCreated,
        ),
        Text(
          "referenceImageName: $referenceImageName",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
