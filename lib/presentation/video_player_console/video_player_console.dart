import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vece_player/presentation/video_player_console/video_player_vm.dart';
import 'package:vece_player/utils/constants.dart';
import 'package:vece_player/utils/widget_extensions.dart';
import 'package:video_player/video_player.dart';

import '../../utils/colors.dart';

class VideoPlayerScreen extends StatelessWidget {
  final File videoFile;
  final String title;

  const VideoPlayerScreen({super.key, required this.videoFile, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoViewModel>(
      init: VideoViewModel(videoFile),
      builder: (controller) {
        if (!controller.videoController.value.isInitialized) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: Colors.redAccent)),
          );
        }

        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  final width = MediaQuery.of(context).size.width;
                  if (details.globalPosition.dx < width / 2) {
                    controller.adjustBrightness(details.delta.dy);
                  } else {
                    controller.adjustVolume(details.delta.dy);
                  }
                },
                onDoubleTapDown: (details) {
                  final width = MediaQuery.of(context).size.width;
                  if (details.localPosition.dx < width / 2) {
                    controller.seekBackward();
                  } else {
                    controller.seekForward();
                  }
                },
                onTap: controller.toggleControlsVisibility,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /// Video player
                    Center(
                      child: AspectRatio(
                        aspectRatio: controller.videoController.value.aspectRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: VideoPlayer(controller.videoController),
                        ),
                      ),
                    ),

                    /// Gradient overlays (top + bottom)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// ⚙️ Console Overlay (Brightness/Volume)
                    if (controller.showFeedback)
                      Center(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: controller.showFeedback ? 1 : 0,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  controller.feedbackType == "brightness"
                                      ? Icons.brightness_6
                                      : Icons.volume_up,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                const SizedBox(height: 10),
                                AppText(
                                  controller.feedbackType == "brightness"
                                      ? "Brightness: ${(controller.brightness * 100).toInt()}%"
                                      : "Volume: ${(controller.volume * 100).toInt()}%",
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    /// Play/Pause Button
                    if (controller.showControls)
                      AnimatedOpacity(
                        opacity: controller.isPlaying ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: IconButton(
                          icon: Icon(
                            controller.isPlaying ? Icons.pause_circle : Icons.play_circle,
                            size: 80,
                            color: Colors.white.withOpacity(0.85),
                          ),
                          onPressed: controller.togglePlay,
                        ),
                      ),

                    /// Show Title and Back Button
                    if (controller.showControls)
                      Positioned(top: 0.sp,
                        left: 0.sp,
                        right: 0.sp,
                        child: AppBar(
                          backgroundColor: 
                          Theme.of(context).brightness == Brightness.dark?
                          AppColor.blackColor.withOpacity(.1):
                          AppColor.white.withOpacity(.9),
                        leading:
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              navigationService.goBack();
                            }, icon: Icon(Icons.arrow_back_ios_new_rounded),
                              color: Theme.of(context).brightness == Brightness.dark?
                              AppColor.white:
                              AppColor.blackColor,
                            ),
                          ],
                        ),
                        title:
                        Row(
                          children: [
                            AppText(controller.shortenTitle(title, max: 40),
                            )
                          ],
                        ),
                                            ),
                      ),
                    /// Bottom Controls
                    if (controller.showControls)
                      Positioned(
                        bottom: 30,
                        left: 16,
                        right: 16,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: VideoProgressIndicator(
                                controller.videoController,
                                allowScrubbing: true,
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                colors: const VideoProgressColors(
                                  playedColor: Colors.redAccent,
                                  bufferedColor: Colors.white30,
                                  backgroundColor: Colors.white10,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ValueListenableBuilder(
                              valueListenable: controller.videoController,
                              builder: (context, VideoPlayerValue value, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      _formatDuration(value.position),
                                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                                    ),
                                    AppText(
                                      _formatDuration(value.duration),
                                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = duration.inHours;
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return hours > 0 ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
  }
}
