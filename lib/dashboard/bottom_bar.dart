import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_images.dart';
import '../../../utils/pallet.dart';
import '../../base/base_ui.dart';
import 'bar_item.dart';
import 'dashboard_vm.dart';

/* The Custom Navigation Bars */
// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  //handles the state changes
  final ValueChanged<int> onItemSelected;

  int selectedIndex;

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  late ScrollController scrollController;
  //handles selections between the screens
  void handleItemSelected(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  double barIconHeight = 24.sp;

  @override
  Widget build(BuildContext context) {
    return BaseView<BottomNavViewModel>(
        onModelReady: (model) async {},
        builder: (context, model, child) => Container(
          height: 80.h,
              padding: EdgeInsets.only(right: 20.sp, left: 20.sp, bottom: 1.sp),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: AppColor.greyColor, offset: Offset(10, 10),
                spreadRadius: 2, blurRadius: 12)],
               color: AppColor.white,),
              // color:  AppColor.blacks,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: NavigationBarItem(
                              label: "Home",
                              icon: Image.asset(AppIcons.home,
                                  height: 24.sp,
                                  color: widget.selectedIndex == 0
                                      ? AppColor.primary
                                      : AppColor.grey2),
                              isSelected: (widget.selectedIndex == 0),
                              index: 0,
                              onTap: handleItemSelected,
                            ),
                          ),
                          NavigationBarItem(
                            label: "Cards",
                            icon: Image.asset(AppIcons.card,
                                height: 24.sp,
                                color: widget.selectedIndex == 1
                                    ? AppColor.primary
                                    : AppColor.grey2),
                            isSelected: (widget.selectedIndex == 1),
                            index: 1,
                            onTap: handleItemSelected,
                          ),
                          NavigationBarItem(
                            label: "Account",
                            icon: Image.asset(AppIcons.account,
                                height:24.sp,
                                color: widget.selectedIndex == 2
                                    ? AppColor.primary
                                    : AppColor.grey2),
                            isSelected: (widget.selectedIndex == 2),
                            index: 2,
                            onTap: handleItemSelected,
                          ),
                          NavigationBarItem(
                            label: "Profile",
                            icon: Image.asset(AppIcons.profile,
                                height: 24.sp,
                              color: widget.selectedIndex == 3
                                ? AppColor.primary
                                  : AppColor.grey2
                            ),
                            isSelected: (widget.selectedIndex == 3),
                            index:3,
                            onTap: handleItemSelected,
                          ),
                        ]),
                  ),
                ],
              ),
            ));
  }
}
