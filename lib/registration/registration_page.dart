import 'dart:async';
import 'dart:io';
import 'dart:core';

import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:last_tamushun_app/hooks/logout.dart';
import 'package:last_tamushun_app/repositorys/registration_repository.dart';
import 'package:last_tamushun_app/repositorys/storage_repository.dart';
import 'package:video_player/video_player.dart';

import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

final outputPath = "${Directory.systemTemp.path}/trimmed_video.mp4";

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
  bool isLiblaryPressed = false;
  bool isPickToMovie = false;

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
    _initializeControllerFuture = _controller.initialize().then((_) async {
      // カメラ初期化後にビデオ撮影を開始
      if (_controller.value.isInitialized) {
        setState(() {
          isCameraPressed = true;
        });
        await _controller.startVideoRecording();
        setState(() {
          isCameraPressed = false;
        });
      }
    }).onError((error, stackTrace) {
      print('Error: $error');
      print('Stack: $stackTrace');
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

    // 5秒前の動画をトリミング
    await trimLastFiveSeconds(movie.path);
    // 撮影した写真とビデオのファイルパスを次の画面に渡す
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(
          imagePath: image.path,
          cameraController: _controller,
        ),
        fullscreenDialog: true,
      ),
    );
    setState(() {
      isCameraPressed = false;
    });
  }

  // 画像と動画をライブラリから選択
  Future<void> onOpenLibraryButtonPressed() async {
    setState(() {
      isLiblaryPressed = true;
    });

    final ImagePicker picker = ImagePicker();

    // 画像を選択
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    _controller.value.isRecordingVideo
        ? _controller.stopVideoRecording()
        : print("---------Not recording");
    // 画像が選択されたかどうかを確認
    if (image != null) {
      isPickToMovie = true;
      print("HOGEHOGE IS RECO ${_controller.value.isRecordingVideo}");
      // _controller.stopVideoRecording();
      sleep(const Duration(milliseconds: 500));
      isPickToMovie = false;
      print("Image selected: ${image.path}");

      // 画像が選択された後に動画を選択
      final XFile? movie = await picker.pickVideo(source: ImageSource.gallery);
      // 動画が選択されたかどうかを確認
      if (movie != null) {
        print("Movie selected: ${movie.path}");

        // 5秒前の動画をトリミング
        await trimLastFiveSeconds(movie.path);

        // 撮影した画像とビデオのファイルパスを次の画面に渡す
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(
              imagePath: image.path,
              cameraController: _controller,
            ),
            fullscreenDialog: true,
          ),
        );
      } else {
        print("No movie selected.");
        !_controller.value.isRecordingVideo
            ? _controller.startVideoRecording()
            : print("---------recording");
      }
    } else {
      print("No image selected.");
    }

    setState(() {
      isLiblaryPressed = false;
    });
  }

  Future<String> calculateStartTime(String videoPath) async {
    String startTime = "0"; // デフォルトの開始時間

    // FFprobeを使用して動画のメタデータを取得
    await FFprobeKit.getMediaInformation(videoPath).then((session) async {
      final information = await session.getMediaInformation();

      final Map<dynamic, dynamic>? properties = information?.getAllProperties();

      // メタデータから動画の長さ（duration）を取得
      final duration = properties?["format"]["duration"];
      if (duration != null) {
        final durationInSeconds = double.parse(duration).floor(); // 秒単位に変換
        if (durationInSeconds > 5) {
          // 動画の長さが5秒より長い場合、最後の5秒を抽出
          startTime = (durationInSeconds - 5).toString();
        } else {
          // 動画の長さが5秒以下の場合、エラーメッセージを表示
          print("Video is too short.");
        }
      } else {
        print("Failed to get video duration.");
      }
    });

    return startTime;
  }

  Future<void> trimLastFiveSeconds(String moviePath) async {
    String time = "5";
    String startTime = await calculateStartTime(moviePath);

    // FFmpegKitを使用して動画をトリミング
    // `ss`オプションで開始時間を指定し、`t`オプションで持続時間を5秒に設定
    // 実際には動画の総再生時間から5秒前のタイムスタンプを計算して`ss`オプションに指定
    String command =
        "-y -i $moviePath -ss $startTime -t $time -c copy $outputPath";
    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (returnCode!.isValueSuccess()) {
        print("Video trimmed successfully: $outputPath");
      } else {
        print("Failed to trim video");
      }
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
                        _controller.value.isInitialized &&
                        isPickToMovie == false) {
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: CameraPreview(
                          _controller,
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
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
                      ? () {}
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
                  onPressed: isLiblaryPressed
                      ? () {}
                      : () async {
                          await onOpenLibraryButtonPressed();
                        },
                ),
              ),
            ),
          ],
        ));
  }
}

class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen({
    super.key,
    required this.imagePath,
    required this.cameraController,
  });
  final String imagePath;
  final CameraController cameraController;

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool isImagePressed = false;
  late VideoPlayerController _controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(outputPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // 動画を自動再生
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('撮れた写真'),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                await widget.cameraController.startVideoRecording();
                Navigator.of(context).pop();
              }),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onLongPressStart: (_) {
                    setState(() {
                      _controller.play();
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      sleep(const Duration(milliseconds: 500));
                      isImagePressed = true;
                    });
                  },
                  onLongPressEnd: (_) {
                    setState(() {
                      isImagePressed = false;
                      _controller.seekTo(const Duration(milliseconds: 300));
                    });
                  },
                  child: _controller.value.isInitialized
                      ? isImagePressed == false
                          ? Image.file(File(widget.imagePath))
                          : AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            )
                      : const CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: ProgressButton.icon(
          iconedButtons: {
            ButtonState.idle: const IconedButton(
                text: "Upload",
                icon: Icon(Icons.cloud_upload, color: Colors.white),
                color: Colors.blue),
            ButtonState.loading: const IconedButton(
              text: "Loading",
              color: Colors.blue,
              icon: Icon(Icons.refresh, color: Colors.white),
            ),
            ButtonState.fail: IconedButton(
                text: "Failed",
                icon: const Icon(Icons.cancel, color: Colors.white),
                color: Colors.red.shade300),
            ButtonState.success: IconedButton(
                text: "Success",
                icon: const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                color: Colors.green.shade400)
          },
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            final storageRepository = StorageRepository();
            final uploadedImageURL = await storageRepository.uploadFile(
              widget.imagePath,
              '${DateTime.now().millisecondsSinceEpoch}',
            );
            final uploadedVideoURL = await storageRepository.uploadFile(
              outputPath,
              '${DateTime.now().millisecondsSinceEpoch}',
            );

            final registrationRepository = RegistrationRepository();
            await registrationRepository.postUploadFile(
              uploadedImageURL!,
              uploadedVideoURL!,
            );
            await widget.cameraController.startVideoRecording();
            Navigator.of(context).pop();
            setState(() {
              isLoading = false;
            });
          },
          state: (isLoading ? ButtonState.loading : ButtonState.idle),
        ));
  }
}
