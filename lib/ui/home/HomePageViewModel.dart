import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/popups/CustomSnackBar.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class HomePageViewModel extends ViewModelBase {
  IAuthService authService = ServiceLocator().get<IAuthService>();
  RxBool isLoggedIn = false.obs;

  HomePageViewModel() {
    initPage();
  }

  initPage() async {
    await checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    isLoggedIn.value = await authService.isUserLoggedIn();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await authService.signOut();
      CustomNavigator().pushAndRemoveUntil(LoginPage());
      CustomSnackBar.showSnackBar(context, CustomSnackBarType.SUCCESS, 'Çıkış yapıldı.');
    } catch (e) {
      CustomSnackBar.showSnackBar(context, CustomSnackBarType.ERROR, 'Çıkış yapılırken hata oluştu.');
      throw e;
    }
  }
}
