import 'package:bucx/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/services/navigation_service.dart';
import '../data/services/storage-service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../locator.dart';
import 'font_manager.dart';

final StorageService storageService = getIt<StorageService>();
final NavigationService navigationService = getIt<NavigationService>();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class AppBottomSheet {
  static void bottomSheetBuilder(Widget bottomSheetView, BuildContext context) {
    showModalBottomSheet(

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        isScrollControlled: false,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) => bottomSheetView);
  }
}

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextOverflow? overflow;
  final double? size;
  final double? height;
  final double? letterSpacing;
  final double? wordSpacing;
  final int? maxLine;
  final String? family;
  final bool? isBold;
  final bool? isHeader;
  final bool? isSubHeader;
  final TextStyle? style;
  final Locale? locale;
  final FontWeight? weight;
  final TextAlign? align;

  const AppText(this.text,
      {Key? key,
      this.color,
      this.overflow,
      this.size,
      this.weight,
      this.align,
      this.maxLine,
      this.locale,
      this.height,
      this.family,
      this.style,
      this.isBold,
      this.isHeader,
      this.isSubHeader,
      this.letterSpacing,
      this.wordSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          TextStyle(
            color: isHeader == true
                ? const Color(0xFF585858)
                : isSubHeader == true
                    ? const Color(0xFF999999)
                    : color?? AppColor.textColor,
            fontSize: size ?? 14.sp,
            fontFamily: family ?? FontConstants.fontFamily,
            height: height,
            wordSpacing: wordSpacing,
            letterSpacing: letterSpacing,
            fontWeight: weight ??
                (isBold == true
                    ? FontWeight.w700
                    : isSubHeader == true
                        ? FontWeight.w500
                        : FontWeight.w500),
          ),
      textAlign: align ?? TextAlign.start,
      selectionColor: AppColor.warningColor.withOpacity(0.5),
      maxLines: maxLine,
    );
  }
}

Widget customProgressIndicator() {

  return SpinKitCircle(
    color: AppColor.white,
    size: 30.0.sp,
  );
}
