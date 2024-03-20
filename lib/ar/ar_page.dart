import 'dart:async';
import 'dart:math';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:last_tamushun_app/ar/gallery.dart';
import 'package:last_tamushun_app/repositorys/video_picture_repository.dart';
import 'package:openapi/api.dart';

class ARPage extends ConsumerStatefulWidget {
  const ARPage({super.key});

  @override
  ARPageState createState() => ARPageState();
}

class ARPageState extends ConsumerState<ARPage> {
  ARKitController? arkitController;
  late String referenceImageName = '';
  late Future<List<Media>> videoPicturesFuture;
  late Media videoPictures;
  Widget? galleryButton;

  @override
  void initState() {
    super.initState();
    final videoPictureRepository = ref.read(videoPictureRepositoryProvider);
    try {
      videoPicturesFuture = videoPictureRepository.getVideoPicture();
    } catch (e) {
      context.go('/error');
    }
  }

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: videoPicturesFuture,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: const Text('Picture Browsing'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        floatingActionButton: galleryButton ?? const SizedBox(),
        body: snapshot.connectionState == ConnectionState.done
            ? _builder(snapshot.data)
            : Column(
                children: [
                  const CircularProgressIndicator(),
                  Text(snapshot.connectionState.name)
                ],
              ),
      ),
    );
  }

  Widget _builder(List<Media>? videoPictures) {
    if (videoPictures == null) {
      context.go('/error');
      return const Text('Failed to get video pictures');
    }

    void onAnchorWasFound(ARKitAnchor anchor) {
      if (arkitController == null) {
        return;
      }

      if (anchor is ARKitImageAnchor) {
        setState(() {
          referenceImageName = anchor.referenceImageName ?? '';
        });
        if (referenceImageName == '') {
          return;
        }
        final referencedPictureVideoUrl = videoPictures
            .firstWhere((e) => e.imageUrl == referenceImageName)
            .movieUrl;
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
          name: 'ar_video',
        );
        arkitController?.add(node);
      }
    }

    void onNodeTapHandler(List<String> nodesList) {
      final nodeName = nodesList.first;
      if (nodeName == 'ar_video') {
        arkitController?.remove(nodeName);
      } else if (nodeName.startsWith('gallery/')) {
        galleryTapHandler(context, nodeName, videoPictures);
      }
    }

    void onARKitViewCreated(ARKitController arkitController) {
      this.arkitController = arkitController;
      arkitController.onAddNodeForAnchor = onAnchorWasFound;
      arkitController.onNodeTap = onNodeTapHandler;
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
                    name: e.imageUrl,
                    physicalWidth: 0.2,
                  ))
              .toList(),
          onARKitViewCreated: onARKitViewCreated,
          enableTapRecognizer: true,
          enablePanRecognizer: true,
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
