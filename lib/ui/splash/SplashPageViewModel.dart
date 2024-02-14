import 'package:get/get.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/services/common/core/PermissionManager.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/home/HomePage.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/ui/slider/SliderPage.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';
import 'package:ramadan/utils/initialize/AppPreferences.dart';
import 'package:ramadan/utils/initialize/AppVersionChecker.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class SplashPageViewModel extends ViewModelBase {
  IAuthService _authService = ServiceLocator().get<IAuthService>();
  IAppPreferences _appPreferences = ServiceLocator().get<IAppPreferences>();
  IAppVersionChecker _appVersionChecker = ServiceLocator().get<IAppVersionChecker>();

  RxBool isCurrentVersionOk = true.obs;
  RxString appVersion = ''.obs;

  SplashPageViewModel() {}

  @override
  onInit() async {
    super.onInit();
    try {
      bool result = await _appVersionChecker.checkAppVersion();
      appVersion.value = await _appVersionChecker.getAppVersion();
      if (result) {
        isCurrentVersionOk.value = true;
        await _checkStartConditions();
      } else {
        isCurrentVersionOk.value = false;
      }
    } catch (e) {
      exceptionHandlingService.handleException(e);
    }
  }

  Future<void> _checkStartConditions() async {
    try {
      await _appPreferences.init();
      bool isFirstOpen = await _appPreferences.isFirstOpen();
      bool isLocationOk = await _appPreferences.getLocationPermission();
      bool hasNotificationPermission = await PermissionManager.checkAndRequestNotificationPermission();
      _appPreferences.setNotificationPermission(hasNotificationPermission);

      if (isFirstOpen) {
        // Uygulama ilk defa mı açıldı.
        await _appPreferences.setFirstOpen(false);
        CustomNavigator().pushAndRemoveUntil(SliderPage());
      } else {
        if (!isLocationOk) {
          // Konum izni alabilmek için tekrardan slider sayfasına yönlendiriyorum.
          CustomNavigator().pushAndRemoveUntil(SliderPage());
        } else {
          bool isLoggedIn = await _authService.isUserLoggedIn();
          if (isLoggedIn) {
            CustomNavigator().pushAndRemoveUntil(HomePage());
          } else {
            CustomNavigator().pushAndRemoveUntil(LoginPage());
          }
        }
      }
    } catch (e) {
      throw CustomException(StringHomeConstant.loginError);
    }
  }
}
