import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:last_tamushun_app/hooks/logout.dart';
import 'package:last_tamushun_app/repositorys/storage_repository.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  CameraDescription? camera;
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  bool isCameraPressed = false;

  @override
  void initState() {
    super.initState();
    setupCamera();
  }

  Future<void> setupCamera() async {
    final cameras = await availableCameras();
    camera = cameras.first;
    _controller = CameraController(
      camera!,
      ResolutionPreset.veryHigh,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      // カメラ初期化後にビデオ撮影を開始
      if (_controller.value.isInitialized) {
        _controller.startVideoRecording();
      }
    });
    setState(() {
      _controller = _controller;
    });
  }

  // 写真撮影ボタンが押されたときの処理
  Future<void> onCaptureButtonPressed() async {
    setState(() {
      isCameraPressed = true;
    });
    // ビデオ撮影を停止
    final movie = await _controller.stopVideoRecording();
    // 写真撮影
    final image = await _controller.takePicture();

    // 撮影した写真とビデオのファイルパスを次の画面に渡す
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            DisplayPictureScreen(imagePath: image.path, moviePath: movie.path),
        fullscreenDialog: true,
      ),
    );
    setState(() {
      isCameraPressed = false;
    });
  }

  final StorageRepository storageRepository = StorageRepository();

  @override
  void dispose() {
    // ウィジェットが破棄されたら、コントローラーを破棄
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration Page'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () => context.go('/auth'),
            ),
            IconButton(
                icon: const Icon(Icons.close),
                onPressed: () async {
                  await logout(context);
                })
          ],
        ),
        body: Stack(
          children: <Widget>[
            if (_initializeControllerFuture != null)
              Container(
                width: double.infinity,
                height: double.infinity,
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        _controller.value.isInitialized) {
                      // setState(() {});
                      print(_controller.value.isRecordingVideo);
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: CameraPreview(
                          _controller,
                        ),
                      );
                    } else {
                      // final connState = snapshot.connectionState;
                      return const Center(child: CircularProgressIndicator());
                      // return Text("Camera conn$connState");
                    }
                  },
                ),
              ),
            Positioned(
              bottom: 70.0,
              left: 0.0,
              right: 0.0,
              child: CircleAvatar(
                radius: 30.0, // Increase the overall size of the button
                backgroundColor: Colors.blue, // Set the background color
                child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  color: Colors.white, // Set the icon color
                  iconSize: 24.0, // Increase the size of the icon
                  // onPressed: () => _getImage(ImageSource.camera),
                  onPressed: isCameraPressed
                      ? null
                      : () async {
                          await onCaptureButtonPressed();
                        },
                ),
              ),
            ),
            Positioned(
              bottom: 70.0,
              right: 30.0,
              child: CircleAvatar(
                radius: 30.0, // Increase the overall size of the button
                backgroundColor: Colors.blue, // Set the background color
                child: IconButton(
                  icon: const Icon(Icons.photo),
                  color: Colors.white, // Set the icon color
                  iconSize: 24.0, // Increase the size of the icon
                  // onPressed: () => _getImage(ImageSource.gallery),
                  onPressed: () => print('camera'),
                ),
              ),
            ),
          ],
        ));
  }
}

// 撮影した写真を表示する画面
class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen(
      {super.key, required this.imagePath, required this.moviePath});

  final String imagePath;
  final String moviePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('撮れた写真')),
      body: Column(
        children: <Widget>[
          // 画像と動画を表示
          Image.file(File(imagePath)),
          Text(imagePath),
          Text(moviePath),

          TextButton(
            onPressed: () {
              context.go('/registration');
            },
            child: const Text('再撮影'),
          ),
          TextButton(
            onPressed: () {
              context.go('/registration');
            },
            child: const Text('登録'),
          ),
        ],
      ),
    );
  }
}

  // Future<void> _getImage(ImageSource source) async {
  //   final pickedFile = await picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });

  //     // 画像を選択した後、即座にFirebaseにアップロード
  //     await storageRepository.uploadFile(_image!.path, 'imageFileName.jpg');
  //   }
  // }