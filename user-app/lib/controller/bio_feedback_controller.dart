import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

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

  late CameraController cameraController;
  var isCameraInitialized = false.obs;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraController = CameraController(cameras[1], ResolutionPreset.high);
      await cameraController.initialize();
      isCameraInitialized.value = true;
    } else {
      print("No cameras available");
    }
  }
  
  Future<void> changeCamera() async {
    final cameras = await availableCameras();
    for (final c in cameras) {
      if (c.lensDirection != cameraController.description.lensDirection) {
        cameraController = CameraController(c, ResolutionPreset.high);
        await cameraController.initialize();
        isCameraInitialized.refresh();
        break;
      }
    }
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
