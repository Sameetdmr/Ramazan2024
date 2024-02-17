import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/home/CustomNavigationPage.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/enums/LoginTypeEnum.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/popups/CustomDialog.dart';
import 'package:ramadan/utils/popups/CustomSnackBar.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';
import 'package:ramadan/utils/validator/LoginValidator.dart';

class LoginPageViewModel extends ViewModelBase {
  // TextEditingController
  final TextEditingController emailTextController = new TextEditingController();
  final TextEditingController passwordTextController = new TextEditingController();
  final TextEditingController forgotPasswordTextController = new TextEditingController();

  // Form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  // Password Icon Config
  RxBool obscureText = false.obs;

  IAuthService _authService = ServiceLocator().get<IAuthService>();

  LoginPageViewModel() {
    setCurrentScreen('Login Page');
    initPage();
  }

  initPage() {}

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  void clearTextController() {
    emailTextController.clear();
    passwordTextController.clear();
  }

  void loginTextFormFieldOnChanged(String? value, TextEditingController controller, LoginTypeEnum loginTypeEnum) {
    if (value!.isEmpty) {
      return;
    } else {
      final result = LoginValidator.validateLogin(value, loginTypeEnum);
      if (result == null) {
        controller.text = value;
      }
    }
  }

  Future<void> signInWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      CustomDialog.showLoadingDialog();
      User? user = await _authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        CustomDialog.dismiss();
        CustomNavigator().pushAndRemoveUntil(CustomNavigationPage());
      } else {
        CustomDialog.dismiss();
        CustomSnackBar.showSnackBar(context, CustomSnackBarType.ERROR, StringLoginConstant.snackbarErrorEmailPasswordControlText);
      }
    } catch (e) {
      exceptionHandlingService.handleException(e);
    }
  }

  Future<void> signInGoogle(BuildContext context) async {
    try {
      User? user = await _authService.signInWithGoogle();
      clearTextController();
      if (user != null) {
        CustomNavigator().pushAndRemoveUntil(CustomNavigationPage());
      } else {
        CustomSnackBar.showSnackBar(context, CustomSnackBarType.ERROR, StringLoginConstant.snackbarErrorRetryText);
      }
    } catch (e) {
      exceptionHandlingService.handleException(e);
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await _authService.resetPassword(email);
      CustomSnackBar.showSnackBar(context, CustomSnackBarType.SUCCESS, StringLoginConstant.snackbarErrorEmailControlText);
    } catch (e) {
      exceptionHandlingService.handleException(e);
      CustomSnackBar.showSnackBar(context, CustomSnackBarType.ERROR, StringLoginConstant.snackbarErrorRetryText);
    }
  }
}
