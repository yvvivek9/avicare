import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class WorkoutCompletionController extends GetxController {
  late VideoPlayerController videoController;
  final isVideoInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeVideo();
  }

  void initializeVideo() {
    // Replace with your actual video asset path
    videoController =
        VideoPlayerController.asset('assets/videos/clapping_hands.mp4')
          ..initialize().then((_) {
            isVideoInitialized.value = true;
            videoController.play();
            videoController.setLooping(true);
          });
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
