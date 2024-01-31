import 'package:firebase_auth/firebase_auth.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/home/HomePage.dart';
import 'package:ramadan/ui/slider/SliderPage.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class SplashPageViewModel extends ViewModelBase {
  IAuthService authService = ServiceLocator().get<IAuthService>();

  SplashPageViewModel() {
    initPage();
  }

  initPage() async {
    await checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    bool isLoggedIn = await authService.isUserLoggedIn();
    if (isLoggedIn) {
      CustomNavigator().pushAndRemoveUntil(HomePage());
    } else {
      CustomNavigator().pushAndRemoveUntil(SliderPage());
    }
  }
}
