import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import '../services/hive_service.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/styles.dart';
import 'hive_service.dart';

const String kThemeModeBox = 'themeMode';
const String kThemeModeKey = 'themeMode';
const String kSystemMode = 'system';
const String kLightMode = 'light';
const String kDarkMode = 'dark';
const String kDefaultFontFamily = 'Poppins';

class AppThemeController extends GetxController {
  final _themeMode = kSystemMode.obs;

  @override
  void onInit() {
    super.onInit();
    getThemeMode();
  }

  static AppThemeController get find => Get.find();

  String get themeMode => _themeMode.value;

  void getSystemChromeData() {
    var themeBrightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;

    if (themeMode == kLightMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColor.lightBgColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.lightBgColor,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else if (themeMode == kDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColor.darkBgColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColor.darkBgColor,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      if (themeBrightness == Brightness.light) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: AppColor.lightBgColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColor.lightBgColor,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        );
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: AppColor.darkBgColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: AppColor.darkBgColor,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        );
      }
    }
  }

  ThemeData getLightThemeData() {
    getSystemChromeData();
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColor.primaryColor,
      iconTheme: const IconThemeData(color: AppColor.lightGrayColor),

      scaffoldBackgroundColor: Color(0xFFF9F9F9),
      appBarTheme: const AppBarTheme(backgroundColor: AppColor.lightBgColor),
      cardColor: AppColor.lightDialogColor,
      shadowColor: AppColor.shadowColor.withAlpha(12),
      // cardTheme: const CardTheme(color: AppColor.lightDialogColor),
      // dialogTheme:
      //     const DialogTheme(backgroundColor: AppColor.lightDialogColor),
      dialogBackgroundColor: AppColor.lightDialogColor,
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: AppColor.lightDialogColor,
        surfaceTintColor: AppColor.lightDialogColor,
        modalBackgroundColor: AppColor.lightDialogColor,
        modalBarrierColor: AppColor.blackColor.withOpacity(0.5),
      ),
      dividerColor: AppColor.lightDividerColor,
      disabledColor: AppColor.lightGrayColor,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColor.darkBgColor,
        contentTextStyle: AppStyles.style14Normal.copyWith(
          color: AppColor.darkBodyTextColor,
        ),
        actionTextColor: AppColor.primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: const ButtonStyle().copyWith(
          backgroundColor: WidgetStateProperty.all(AppColor.primaryColor),
          foregroundColor: WidgetStateProperty.all(AppColor.whiteColor),
          elevation: WidgetStateProperty.all(0.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: Dimens.edgeInsets16,
        constraints: BoxConstraints(
          maxWidth: ScreenUtil().screenWidth,
        ),
        labelStyle: AppStyles.p.copyWith(
          color: AppColor.lightBodyTextColor,
        ),
        floatingLabelStyle: AppStyles.p.copyWith(
          color: AppColor.lightBodyTextColor.withAlpha(140),
        ),
        hintStyle: AppStyles.p.copyWith(
          color: AppColor.lightBodyTextColor.withAlpha(140),
        ),
        errorStyle: AppStyles.p.copyWith(
          color: AppColor.errorColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.lightDividerColor,
            width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.lightDividerColor.withAlpha(20),
            width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.lightDividerColor,
           width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryColor,
            width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.errorColor,
           width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.errorColor,
           width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
      ),
      fontFamily: kDefaultFontFamily,
      textTheme: const TextTheme().copyWith(
        bodyLarge: const TextStyle(
          color: AppColor.lightBodyTextColor,
        ),
        bodyMedium: const TextStyle(
          color: AppColor.lightBodyTextColor,
        ),
        bodySmall: const TextStyle(
          color: AppColor.lightBodyTextColor,
        ),
        titleMedium: TextStyle(
          color: AppColor.lightBodyTextColor.withAlpha(180),
        ),
        titleSmall: TextStyle(
          color: AppColor.lightBodyTextColor.withAlpha(140),
        ),
      ),
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData getDarkThemeData() {
    getSystemChromeData();
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColor.primaryColor,
      iconTheme: const IconThemeData(color: AppColor.darkGrayColor),
      scaffoldBackgroundColor: AppColor.darkBgColor,
      shadowColor: AppColor.shadowColor.withAlpha(12),
      appBarTheme: const AppBarTheme(backgroundColor: AppColor.darkBgColor),
      cardColor: AppColor.darkDialogColor,
      // cardTheme: const CardTheme(color: AppColor.darkDialogColor),
      // dialogTheme:
      //     const DialogTheme(backgroundColor: AppColor.darkDialogColor),
      dialogBackgroundColor: AppColor.darkDialogColor,
      bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: AppColor.darkDialogColor,
        surfaceTintColor: AppColor.darkDialogColor,
        modalBackgroundColor: AppColor.darkDialogColor,
        modalBarrierColor: AppColor.blackColor.withOpacity(0.5),
      ),
      dividerColor: AppColor.darkDividerColor,
      disabledColor: AppColor.darkGrayColor,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColor.lightBgColor,
        contentTextStyle: TextStyle(
          color: AppColor.lightBodyTextColor,
        ),
        actionTextColor: AppColor.primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: const ButtonStyle().copyWith(
          backgroundColor: WidgetStateProperty.all(AppColor.primaryColor),
          foregroundColor: WidgetStateProperty.all(AppColor.whiteColor),
          elevation: WidgetStateProperty.all(0.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: Dimens.edgeInsets16,
        constraints: BoxConstraints(
          maxWidth: ScreenUtil().screenWidth,
        ),
        labelStyle: AppStyles.p.copyWith(
          color: AppColor.darkBodyTextColor,
        ),
        floatingLabelStyle: AppStyles.p.copyWith(
          color: AppColor.darkBodyTextColor.withAlpha(140),
        ),
        hintStyle: AppStyles.p.copyWith(
          color: AppColor.darkBodyTextColor.withAlpha(140),
        ),
        errorStyle: AppStyles.p.copyWith(
          color: AppColor.errorColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.darkDividerColor,
            width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.darkDividerColor,
            width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.darkDividerColor,
          width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.primaryColor,
           width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.errorColor,
            width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.errorColor,
           width: ScreenUtil().setWidth(Dimens.one),
          ),
          borderRadius: BorderRadius.circular(Dimens.twelve),
        ),
      ),
      fontFamily: kDefaultFontFamily,
      textTheme: const TextTheme().copyWith(
        bodyLarge: const TextStyle(
          color: AppColor.darkBodyTextColor,
        ),
        bodyMedium: const TextStyle(
          color: AppColor.darkBodyTextColor,
        ),
        bodySmall: const TextStyle(
          color: AppColor.darkBodyTextColor,
        ),
        titleMedium: TextStyle(
          color: AppColor.darkBodyTextColor.withAlpha(180),
        ),
        titleSmall: TextStyle(
          color: AppColor.darkBodyTextColor.withAlpha(140),
        ),
      ),
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  void setThemeMode(String mode) async {
    _themeMode.value = mode;
    await HiveService.put<String>(kThemeModeBox, kThemeModeKey, mode);
    update();
  }

  void getThemeMode() async {
    var themeMode = await HiveService.get<String>(kThemeModeBox, kThemeModeKey);

    switch (themeMode) {
      case kSystemMode:
        _themeMode.value = kSystemMode;
        break;
      case kLightMode:
        _themeMode.value = kLightMode;
        break;
      case kDarkMode:
        _themeMode.value = kDarkMode;
        break;
      default:
        _themeMode.value = kSystemMode;
        break;
    }
    update();
  }
}