import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_images.dart';
import '../../../utils/pallet.dart';
import '../../../utils/widget_extensions.dart';
import '../../base/base_ui.dart';
import 'bottom_bar.dart';
import 'dashboard_vm.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

final ValueNotifier<int> pageIndex = ValueNotifier(0);

class _BottomNavState extends State<BottomNav> {

  @override
  void initState() {
    pageIndex.value = widget.selectedIndex;
    super.initState();
  }

  void _onNavigationItem(index) {
    pageIndex.value = index;
  }


  @override
  Widget build(BuildContext context) {
    return BaseView<BottomNavViewModel>(
      notDefaultLoading: true,
      onModelReady: (model) async {
      },
      builder: (context, model,child) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor:AppColor.blacks,
          body: Container(
            width: width(context),
              height: height(context) / 0.4.sp,
              child:ValueListenableBuilder(
              valueListenable: pageIndex,
              builder: (BuildContext context, int value, _) {
                return model.children[value];
              }),
        ),
          bottomNavigationBar: BottomNavBar(
            onItemSelected: _onNavigationItem,
            selectedIndex: pageIndex.value,
          ),
        ),
      ),
    );
  }
}