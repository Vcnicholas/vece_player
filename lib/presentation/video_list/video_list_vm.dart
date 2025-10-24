import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vece_player/presentation/video_list/video_list.dart';

class VideoListViewModel extends GetxController {
  final videos = <VideoModel>[].obs;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    isLoading = true;
    update();

    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      isLoading = false;
      update();
      PhotoManager.openSetting();
      return;
    }

    final List<AssetPathEntity> albums =
    await PhotoManager.getAssetPathList(type: RequestType.video);

    final List<AssetEntity> videoAssets =
    await albums.first.getAssetListPaged(page: 0, size: 100);

    videos.assignAll(
      videoAssets
          .map((e) => VideoModel(asset: e, title: e.title))
          .toList(),
    );

    isLoading = false;
    update();
  }
}
