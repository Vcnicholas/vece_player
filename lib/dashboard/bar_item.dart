import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';
import '../../../utils/pallet.dart';
import '../../base/base_ui.dart';
import '../utils/colors.dart';
import 'dashboard_vm.dart';


// ignore: must_be_immutable
class NavigationBarItem extends StatelessWidget {
  NavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    this.isSelected = false,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final int index;
  final bool isSelected;
  ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BaseView<BottomNavViewModel>(
        onModelReady: (model) async {},
        builder: (context, model, child) => InkWell(
          splashColor: AppColor.warningColor,
          onTap: () {
            onTap(index);
          },
          borderRadius: BorderRadius.circular(
              40.sp), // Half the height of the container for a circular shape
          child: Container(
            color: AppColor.white,
            padding: EdgeInsets.only(left: 8.w, right: 8.w,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                AppText(
                  label,
                  size: 14.sp,
                  color: isSelected ? AppColor.primary : AppColor.grey2,),

              ],
            ),
          ),
        ));
  }
}