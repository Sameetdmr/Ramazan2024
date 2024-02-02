import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/home/HomePage.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/ui/slider/SliderPage.dart';
import 'package:ramadan/utils/initialize/AppPreferences.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class SplashPageViewModel extends ViewModelBase {
  IAuthService authService = ServiceLocator().get<IAuthService>();
  IAppPreferences appPreferences = ServiceLocator().get<IAppPreferences>();

  SplashPageViewModel() {}

  @override
  onInit() async {
    await _checkStartConditions();
    super.onInit();
  }

  Future<void> _checkStartConditions() async {
    bool isFirstOpen = await appPreferences.isFirstOpen();

    if (isFirstOpen) {
      await appPreferences.setFirstOpen(false);
      CustomNavigator().pushAndRemoveUntil(SliderPage());
    } else {
      bool isLoggedIn = await authService.isUserLoggedIn();
      if (isLoggedIn) {
        CustomNavigator().pushAndRemoveUntil(HomePage());
      } else {
        CustomNavigator().pushAndRemoveUntil(LoginPage());
      }
    }
  }
}
