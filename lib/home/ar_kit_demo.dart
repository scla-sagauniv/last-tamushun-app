import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ARKitDemo extends StatefulWidget {
  const ARKitDemo({super.key});

  @override
  ARKitDemoState createState() => ARKitDemoState();
}

class ARKitDemoState extends State<ARKitDemo> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ARKitSceneView(onARKitViewCreated: onARKitViewCreated);

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final node = ARKitNode(
        geometry: ARKitSphere(radius: 0.1), position: Vector3(0, 0, -0.5));
    this.arkitController.add(node);
  }
}
