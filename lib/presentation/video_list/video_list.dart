import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vece_player/presentation/video_list/video_list_vm.dart';
import 'package:vece_player/utils/colors.dart';
import 'package:vece_player/utils/widget_extensions.dart';
import '../../utils/constants.dart';
import '../video_player_console/video_player_console.dart';

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoListViewModel>(
      init: VideoListViewModel(),
      builder: (controller) {
        if (controller.isLoading) {
          return Scaffold(
            body: Center(child: customProgressIndicator()),
          );
        }

        if (controller.videos.isEmpty) {
          return const Scaffold(
            body: Center(
              child: AppText(
                "No videos found on your device.",
              ),
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              top: 60.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ---------- FIXED TITLE (does NOT scroll) ----------
                AppText(
                  'Vece Player',
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColor.white
                      : AppColor.textColor,
                  size: 18.sp,
                ),

                10.h.sbH,

                // ---------- SCROLLING VIDEOS ONLY ----------
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.videos.length,
                    itemBuilder: (context, index) {
                      final video = controller.videos[index];

                      return FutureBuilder(
                        future: video.asset.thumbnailDataWithSize(
                          const ThumbnailSize(200, 200),
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Padding(
                              padding: EdgeInsets.all(20.sp),
                              child: Center(child: customProgressIndicator()),
                            );
                          }

                          return GestureDetector(
                            onTap: () async {
                              final file = await video.asset.file;
                              if (file != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VideoPlayerScreen(videoFile: file, title: video.title!,),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.r),
                                          child: Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
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
                                  ),
                                  20.w.sbW,
                                  Expanded(
                                    child: AppText(controller.shortenTitle(video.title ?? "Untitled Video", max: 35)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
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
