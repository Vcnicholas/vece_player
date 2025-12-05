import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../presentation/video_list/video_list.dart';


class BottomNavViewModel extends BaseViewModel {
  bool? isPremium;
  bool isButtonPressed = false;
  // UserResponse? userResponse;

  List<Widget> children = [
    VideoListScreen()
  ];

  //Pops the app back
  static Future<void> pop({bool? animated}) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', animated);
  }
}

