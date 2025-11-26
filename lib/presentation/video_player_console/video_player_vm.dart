import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoViewModel extends GetxController {
  late VideoPlayerController videoController;
  final File videoFile;
  bool isPlaying = false;
  bool showControls = true;
  double brightness = 0.5;
  double volume = 0.5;
  bool showFeedback = false;
  String feedbackType = ""; // 'brightness' or 'volume'

  VideoViewModel(this.videoFile);

  @override
  void onInit() {
    super.onInit();
    videoController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        update();
      });

    _initValues();
  }

  Future<void> _initValues() async {
    brightness = await ScreenBrightness().current;
    volume = await VolumeController().getVolume();
    update();
  }

  void togglePlay() {
    if (videoController.value.isPlaying) {
      videoController.pause();
      isPlaying = false;
    } else {
      videoController.play();
      isPlaying = true;
    }
    update();
  }

  void toggleControlsVisibility() {
    showControls = !showControls;
    update();
  }

  void seekForward() {
    final newPosition = videoController.value.position + const Duration(seconds: 10);
    videoController.seekTo(newPosition);
  }

  void seekBackward() {
    final newPosition = videoController.value.position - const Duration(seconds: 10);
    videoController.seekTo(newPosition);
  }

  Future<void> adjustBrightness(double dy) async {
    final delta = -dy / 300; // swipe up = increase
    brightness = (brightness + delta).clamp(0.0, 1.0);
    await ScreenBrightness().setScreenBrightness(brightness);
    _showFeedback("brightness");
  }

  Future<void> adjustVolume(double dy) async {
    final delta = -dy / 300;
    volume = (volume + delta).clamp(0.0, 1.0);
    VolumeController().setVolume(volume);
    _showFeedback("volume");
  }

  void _showFeedback(String type) {
    feedbackType = type;
    showFeedback = true;
    update();
    Future.delayed(const Duration(seconds: 1), () {
      showFeedback = false;
      update();
    });
  }

  String shortenTitle(String text, {int max = 20}) {
    if (text.length <= max) return text;

    // Show first 10 characters and last 7 characters
    const int startCount = 10;
    const int endCount = 7;

    return "${text.substring(0, startCount)}...${text.substring(text.length - endCount)}";
  }


  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
