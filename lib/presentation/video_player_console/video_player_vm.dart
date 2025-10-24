import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoViewModel extends GetxController {
  late VideoPlayerController videoController;
  bool isPlaying = false;
  bool isFullscreen = false;

  @override
  void onInit() {
    super.onInit();
    videoController = VideoPlayerController.asset(
      'assets/videos/sample.mp4',
    )..initialize().then((_) {
      update(); // Refresh UI when initialized
    });
  }

  void togglePlay() {
    if (isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    isPlaying = !isPlaying;
    update();
  }

  void seekForward() async {
    final newPos = videoController.value.position + const Duration(seconds: 10);
    await videoController.seekTo(newPos);
    update();
  }

  void seekBackward() async {
    final newPos = videoController.value.position - const Duration(seconds: 10);
    await videoController.seekTo(newPos < Duration.zero ? Duration.zero : newPos);
    update();
  }

  void toggleFullscreen() {
    isFullscreen = !isFullscreen;
    update();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
