import 'dart:async';
import 'dart:math';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_tamushun_app/ar/gallery.dart';
import 'package:last_tamushun_app/models/video_picture.dart';
import 'package:last_tamushun_app/repositorys/video_picture_repository.dart';

class ARPage extends ConsumerStatefulWidget {
  const ARPage({super.key});

  @override
  ARPageState createState() => ARPageState();
}

class ARPageState extends ConsumerState<ARPage> {
  late ARKitController arkitController;
  late String referenceImageName = '';
  late Future<List<VideoPicture>> videoPicturesFuture;
  late VideoPicture videoPictures;
  Widget? galleryButton;

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
        floatingActionButton: galleryButton ?? const SizedBox(),
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

        final detectedTransform = anchor.transform;
        detectedTransform.rotateX(pi / 2);
        final node = ARKitNode(
          geometry: plane,
          transformation: detectedTransform,
        );
        arkitController.add(node);
      }
    }

    void onARKitViewCreated(ARKitController arkitController) {
      this.arkitController = arkitController;
      arkitController.onAddNodeForAnchor = onAnchorWasFound;
      setState(() {
        galleryButton = Gallery(
          videoPictures: videoPictures,
          arkitController: arkitController,
        );
      });
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
