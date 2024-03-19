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
    _initializeControllerFuture = _controller.initialize();
    print(_controller);

    setState(() {
      _controller = _controller;
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
                  onPressed: () {
                    final image = _controller.takePicture();
                    print(image);
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