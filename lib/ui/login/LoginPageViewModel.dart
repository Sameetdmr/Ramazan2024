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
  LoginPageViewModel(BuildContext context) {
    setCurrentScreen('Login Page');
    _context = context;
  }
  late final BuildContext _context;

  // TextEditingController
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController forgotPasswordTextController = TextEditingController();

  // Form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  // Password Icon Config
  RxBool obscureText = false.obs;

  final IAuthService _authService = ServiceLocator().get<IAuthService>();

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

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      CustomDialog.showLoadingDialog();
      final user = await _authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        CustomDialog.dismiss();
        CustomNavigator().pushAndRemoveUntil(CustomNavigationPage());
      } else {
        CustomDialog.dismiss();
        await CustomSnackBar.showSnackBar(_context, CustomSnackBarType.ERROR, StringLoginConstant.snackbarErrorEmailPasswordControlText);
      }
    } catch (e) {
      await exceptionHandlingService.handleException(e);
    }
  }

  Future<void> signInGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      clearTextController();
      if (user != null) {
        CustomNavigator().pushAndRemoveUntil(CustomNavigationPage());
      } else {
        await CustomSnackBar.showSnackBar(_context, CustomSnackBarType.ERROR, StringLoginConstant.snackbarErrorRetryText);
      }
    } catch (e) {
      await exceptionHandlingService.handleException(e);
    }
  }

  void withoutSignIn(BuildContext context) {
    try {
      CustomNavigator().pushAndRemoveUntil(CustomNavigationPage());
    } catch (e) {
      exceptionHandlingService.handleException(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
      await CustomSnackBar.showSnackBar(_context, CustomSnackBarType.SUCCESS, StringLoginConstant.snackbarErrorEmailControlText);
    } catch (e) {
      await exceptionHandlingService.handleException(e);
      await CustomSnackBar.showSnackBar(_context, CustomSnackBarType.ERROR, StringLoginConstant.snackbarErrorRetryText);
    }
  }
}
