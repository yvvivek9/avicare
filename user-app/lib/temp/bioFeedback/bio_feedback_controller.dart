import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:avicare/utils/utils.dart';
import 'painters/pose_painter.dart';
import 'painters/coordinates_translator.dart';

class BioFeedbackController extends GetxController {
  final RxInt leftCurrentDegree = 30.obs;
  final RxInt leftReps = 5.obs;
  final RxInt leftHoldTime = 6.obs;

  final RxInt rightCurrentDegree = 40.obs;
  final RxInt rightReps = 8.obs;
  final RxInt rightHoldTime = 10.obs;

  RxBool isPlaying = true.obs;
  RxDouble progress = 0.8.obs;
  RxDouble leftPressure = 0.5.obs;
  RxDouble rightPressure = 0.2.obs;
  RxString timeRemaining = "1:20:33".obs;
  RxBool isMenuOpen = false.obs;

  void toggleTimer() {
    isPlaying.value = !isPlaying.value;
  }

  void updatePressure(bool isLeft, double value) {
    if (isLeft) {
      leftPressure.value = value;
    } else {
      rightPressure.value = value;
    }
  }

  final PoseDetector _poseDetector = PoseDetector(options: PoseDetectorOptions());
  late CameraController cameraController;
  late CameraDescription camera;
  var isCameraInitialized = false.obs;
  final customPaint = CustomPaint().obs;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      camera = cameras[1];
      cameraController = CameraController(
        cameras[1],
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21 // for Android
            : ImageFormatGroup.bgra8888,
      );
      await cameraController.initialize();
      cameraController.startImageStream(_processImageFromCamera);
      isCameraInitialized.value = true;
    } else {
      safePrint("No cameras available");
    }
  }

  Future<void> changeCamera() async {
    final cameras = await availableCameras();
    for (final c in cameras) {
      if (c.lensDirection != cameraController.description.lensDirection) {
        isCameraInitialized.value = false;
        camera = c;
        cameraController = CameraController(
          c,
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: Platform.isAndroid
              ? ImageFormatGroup.nv21 // for Android
              : ImageFormatGroup.bgra8888,
        );
        await cameraController.initialize();
        isCameraInitialized.value = true;
        break;
      }
    }
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  void handleCloseControllers() {
    isCameraInitialized.value = false;
    cameraController.dispose();
    _poseDetector.close();
  }

  @override
  void onClose() {
    handleCloseControllers();
    super.onClose();
  }

  void _processPoseDetection(InputImage inputImage) async {
    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.metadata?.size == null && inputImage.metadata?.rotation == null) {
      // if any failure in pose detection
      customPaint.value = CustomPaint();
      return;
    }
    final painter = PosePainter(
      poses,
      inputImage.metadata!.size,
      inputImage.metadata!.rotation,
      camera.lensDirection,
    );
    customPaint.value = CustomPaint(painter: painter);
    leftCurrentDegree.value = calculateAngles(poses, PoseLandmarkType.leftElbow, PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip).round();
    rightCurrentDegree.value = calculateAngles(poses, PoseLandmarkType.rightElbow, PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip).round();
  }

  void _processImageFromCamera(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) {
      safePrint("image null");
      return;
    }
    _processPoseDetection(inputImage);
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = _orientations[cameraController.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation = (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null || (Platform.isAndroid && format != InputImageFormat.nv21) || (Platform.isIOS && format != InputImageFormat.bgra8888)) {
      safePrint(format);
      return null;
    }

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format!, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}

final _orientations = {
  DeviceOrientation.portraitUp: 0,
  DeviceOrientation.landscapeLeft: 90,
  DeviceOrientation.portraitDown: 180,
  DeviceOrientation.landscapeRight: 270,
};
