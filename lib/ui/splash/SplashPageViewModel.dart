import 'package:get/get.dart';
import 'package:ramadan/services/common/core/PermissionManager.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/home/CustomNavigationPage.dart';
import 'package:ramadan/ui/slider/SliderPage.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';
import 'package:ramadan/utils/initialize/AppPreferences.dart';
import 'package:ramadan/utils/initialize/AppVersionChecker.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class SplashPageViewModel extends ViewModelBase {
  SplashPageViewModel() {
    setCurrentScreen('Splash Page');
  }
  final IAppPreferences _appPreferences = ServiceLocator().get<IAppPreferences>();
  final IPermissionManager _iPermissionManager = ServiceLocator().get<IPermissionManager>();
  final IAppVersionChecker _appVersionChecker = ServiceLocator().get<IAppVersionChecker>();

  RxBool isCurrentVersionOk = true.obs;
  RxString appVersion = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      final result = await _appVersionChecker.checkAppVersion();
      appVersion.value = await _appVersionChecker.getAppVersion();
      if (result) {
        isCurrentVersionOk.value = true;
        await _checkStartConditions();
      } else {
        isCurrentVersionOk.value = false;
      }
    } catch (e) {
      await exceptionHandlingService.handleException(e);
    }
  }

  Future<void> _checkStartConditions() async {
    try {
      await _appPreferences.init();
      final isFirstOpen = await _appPreferences.isFirstOpen();
      final hasNotificationPermission = await _iPermissionManager.checkAndRequestNotificationPermission();
      await _appPreferences.setNotificationPermission(value: hasNotificationPermission);

      if (isFirstOpen) {
        // Uygulama ilk defa mı açıldı.
        await _appPreferences.setFirstOpen(value: false);
        await CustomNavigator().pushAndRemoveUntil(SliderPage());
      } else {
        await CustomNavigator().pushAndRemoveUntil(CustomNavigationPage());
      }
    } catch (e) {
      throw CustomException(StringHomeConstant.loginError);
    }
  }
}
