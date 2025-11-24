import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vece_player/presentation/video_list/video_list_vm.dart';
import 'package:vece_player/services/theme_service.dart';

import 'core/services/navigation_service.dart';


GetIt getIt = GetIt.I;

void setupLocator() {
  setupDio();

  //Services
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  // getIt.registerLazySingleton<StorageService>(() => StorageService());
  // getIt.registerLazySingleton<AppCache>(() => AppCache());
  // getIt.registerLazySingleton<UserServices>(() => UserServices());
  // getIt.registerLazySingleton<RemoteServices>(
  //         () => RemoteServices(getIt<Dio>(), getIt<UserServices>()));
  // registerViewModel();
}

void setupDio() {
  getIt.registerFactory(() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  });
}

void registerViewModel() {
  //View Model
  // getIt.registerFactory<BaseViewModel>(() => BaseViewModel());
  // getIt.registerFactory<SplashViewModel>(() => SplashViewModel());
  getIt.registerFactory<AppThemeController>(() =>AppThemeController());
  // getIt.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  // getIt.registerFactory<SignInViewModel>(() => SignInViewModel());
  // //getIt.registerFactory<SecureAccountViewModel>(() => SecureAccountViewModel());
  // getIt.registerFactory<OnboardingViewModel>(() => OnboardingViewModel());
  // getIt.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
  // getIt.registerFactory<CardsViewModel>(()=> CardsViewModel());
  // getIt.registerFactory<ProfilesViewModel>(() => ProfilesViewModel());
  // getIt.registerFactory<HomeViewModel>(() => HomeViewModel());
  // getIt.registerFactory<BottomNavViewModel>(() => BottomNavViewModel());
  // getIt.registerFactory<SendMoneyViewModel>(() => SendMoneyViewModel());
  getIt.registerFactory<VideoListViewModel>(() => VideoListViewModel());
  // getIt.registerFactory<AccountsViewModel>(() =>AccountsViewModel());
  // getIt.registerFactory<AddMoneyViewModel>(() => AddMoneyViewModel());
  // getIt.registerFactory<SendToBankViewModel>(() =>SendToBankViewModel());
  // getIt.registerFactory<SendToCryptoViewModel>(() =>SendToCryptoViewModel());
  // getIt.registerFactory<SendToBucxUserViewModel>(() =>SendToBucxUserViewModel());
  // getIt.registerFactory<AddBankAccountViewModel>(() =>AddBankAccountViewModel());

}
