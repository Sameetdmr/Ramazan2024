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
  RegisterPageViewModel() {
    setCurrentScreen('Register Page');
  }
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final IAuthService _authService = ServiceLocator().get<IAuthService>();

  RxBool obscureText = false.obs;

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register(BuildContext context, String email, String password) async {
    try {
      final userCredential = await _authService.register(email, password);

      if (userCredential != null) {
        CustomNavigator().popFromMain();
        if (context.mounted) await CustomSnackBar.showSnackBar(context, CustomSnackBarType.success, StringLoginConstant.snackbarSuccessRegisterText);
      } else {
        if (context.mounted) await CustomSnackBar.showSnackBar(context, CustomSnackBarType.error, StringLoginConstant.snackbarErrorEmailControlText);

        emailTextController.clear();
        passwordTextController.clear();
        confirmPasswordController.clear();
      }
    } catch (e) {
      await exceptionHandlingService.handleException(e);
    }
  }
}
