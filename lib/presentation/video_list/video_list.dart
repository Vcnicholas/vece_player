import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vece_player/presentation/video_list/video_list_vm.dart';
import '../video_player_console/video_player_console.dart';

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoListViewModel>(
      init: VideoListViewModel(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.videos.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text(
                "No videos found on your device.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text("Your Videos"),
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: controller.videos.length,
            itemBuilder: (context, index) {
              final video = controller.videos[index];

              return FutureBuilder(
                future: video.asset.thumbnailDataWithSize(
                  const ThumbnailSize(200, 200),
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GestureDetector(
                    onTap: () async {
                      final file = await video.asset.file;
                      if (file != null) {
                        Get.to(() => VideoPlayerScreen(videoFile: file));
                      }
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.memory(snapshot.data!, fit: BoxFit.cover),
                        const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}


class VideoModel {
  final AssetEntity asset;
  final String? title;

  VideoModel({required this.asset, this.title});
}
