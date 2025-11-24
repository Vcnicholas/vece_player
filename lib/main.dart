import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:vece_player/presentation/video_list/video_list.dart';
import 'package:vece_player/presentation/video_list/video_list_vm.dart';
import 'package:vece_player/presentation/video_player_console/video_player_console.dart';
import 'package:vece_player/services/theme_service.dart';
import 'package:vece_player/utils/strings.dart';

import 'core/services/navigation_service.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection first
  setupLocator();

  // ✅ Correct Get.put() usage: pass an instance
  Get.put(VideoListViewModel(), permanent: true);
  Get.put(AppThemeController(), permanent: true);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeMode _handleAppTheme(String mode) {
    if (mode == kDarkMode) {
      return ThemeMode.dark;
    }
    if (mode == kLightMode) {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppThemeController>(
      builder: (logic) => OKToast(
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (ctx, child) => GetMaterialApp(
            home: const VideoListScreen(),
            title: AppStrings.appName,
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            themeMode: _handleAppTheme(logic.themeMode),
            theme: logic.getLightThemeData(),
            darkTheme: logic.getDarkThemeData(),
            // getPages: AppPages.pages,
            // initialRoute: AppRoutes.splashView, // Default route before redirection
            //translations: AppTranslation(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en', 'NG'),
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              );
            },
          ),
        ),
      ),
    );
    // return MaterialApp(
    //   title: 'Vece Player',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //   ),
    //   home: const VideoListScreen(),
    // );
  }
}
