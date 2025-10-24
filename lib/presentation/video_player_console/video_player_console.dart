import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vece_player/presentation/video_player_console/video_player_vm.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key, required videoFile});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoViewModel>(
      init: VideoViewModel(),
      builder: (controller) {
        if (!controller.videoController.value.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onDoubleTap: controller.seekForward,
                onDoubleTapDown: (details) {
                  final width = MediaQuery.of(context).size.width;
                  if (details.localPosition.dx < width / 2) {
                    controller.seekBackward();
                  } else {
                    controller.seekForward();
                  }
                },
                child: Center(
                  child: AspectRatio(
                    aspectRatio:
                    controller.videoController.value.aspectRatio,
                    child: VideoPlayer(controller.videoController),
                  ),
                ),
              ),

              // Play / Pause button
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    VideoProgressIndicator(
                      controller.videoController,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.red,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                      icon: Icon(
                        controller.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                      onPressed: controller.togglePlay,
                    ),
                  ],
                ),
              ),

              // Fullscreen toggle
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    controller.isFullscreen
                        ? Icons.fullscreen_exit
                        : Icons.fullscreen,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: controller.toggleFullscreen,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
