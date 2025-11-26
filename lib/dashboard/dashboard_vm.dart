import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../base/base.vm.dart';
import '../accounts/account_details.dart';
import '../cards/cards.dart';
import '../home.dart';
import '../profiles/profiles.dart';


class BottomNavViewModel extends BaseViewModel {
  bool? isPremium;
  bool isButtonPressed = false;
  // UserResponse? userResponse;

  List<Widget> children = [
    Home(),
    Cards(),
    AccountDetails(),
    const Profiles(),
  ];

  //Pops the app back
  static Future<void> pop({bool? animated}) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', animated);
  }
}

