import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/popups/CustomSnackBar.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class RegisterPageViewModel extends ViewModelBase {
  final TextEditingController emailTextController = new TextEditingController();
  final TextEditingController passwordTextController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  IAuthService _authService = ServiceLocator().get<IAuthService>();

  RxBool obscureText = false.obs;
  RegisterPageViewModel() {
    initPage();
  }

  initPage() {}

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register(BuildContext context, String email, String password) async {
    try {
      UserCredential? userCredential = await _authService.register(email, password);

      if (userCredential != null) {
        CustomNavigator().popFromMain();
        CustomSnackBar.showSnackBar(context, CustomSnackBarType.SUCCESS, StringLoginConstant.snackbarSuccessRegisterText);
      } else {
        CustomSnackBar.showSnackBar(context, CustomSnackBarType.ERROR, StringLoginConstant.snackbarErrorEmailControlText);

        emailTextController.clear();
        passwordTextController.clear();
        confirmPasswordController.clear();
      }
    } catch (e) {
      exceptionHandlingService.handleException(e);
    }
  }
}
