import 'package:flutter/material.dart';
import 'package:ramadan/utils/localization/CustomTranslationKeys.dart';
import 'package:ramadan/utils/localization/CustomTranslations.dart';

@immutable
class StringSplashSliderConstant {
  const StringSplashSliderConstant._();

  //
  static String get splashSlider1TitleText => CustomTranslations.getText(CustomTranslationKeys.splashSlider1TitleText);
  static String get splashSlider1SubTitleText => CustomTranslations.getText(CustomTranslationKeys.splashSlider1SubTitleText);
  static String get splashSlider2TitleText => CustomTranslations.getText(CustomTranslationKeys.splashSlider2TitleText);
  static String get splashSlider2SubTitleText => CustomTranslations.getText(CustomTranslationKeys.splashSlider2SubTitleText);
  static String get splashSlider3TitleText => CustomTranslations.getText(CustomTranslationKeys.splashSlider3TitleText);
  static String get splashSlider3SubTitleText => CustomTranslations.getText(CustomTranslationKeys.splashSlider3SubTitleText);
  static String get splashSliderNextButtonText => CustomTranslations.getText(CustomTranslationKeys.splashSliderNextButtonText);
  static String get splashSliderPrevButtonText => CustomTranslations.getText(CustomTranslationKeys.splashSliderPrevButtonText);
  static String get splashSliderDoneButtonText => CustomTranslations.getText(CustomTranslationKeys.splashSliderDoneButtonText);
}

@immutable
class StringLoginConstant {
  const StringLoginConstant._();

  // Login
  static String get loginAppBarTitle => CustomTranslations.getText(CustomTranslationKeys.loginAppBarTitle);
  static String get loginEmailHintText => CustomTranslations.getText(CustomTranslationKeys.loginEmailHintText);
  static String get loginPasswordHintText => CustomTranslations.getText(CustomTranslationKeys.loginPasswordHintText);
  static String get loginForgotPasswordButtonText => CustomTranslations.getText(CustomTranslationKeys.loginForgotPasswordButtonText);
  static String get loginNewUserText1 => CustomTranslations.getText(CustomTranslationKeys.loginNewUserText1);
  static String get loginNewUserText2 => CustomTranslations.getText(CustomTranslationKeys.loginNewUserText2);
  static String get loginDividerText => CustomTranslations.getText(CustomTranslationKeys.loginDividerText);

  // Register
  static String get registerAppBarTitle => CustomTranslations.getText(CustomTranslationKeys.registerAppBarTitle);
  static String get registerEmailHintText => CustomTranslations.getText(CustomTranslationKeys.registerEmailHintText);
  static String get registerCreatePasswordHintText => CustomTranslations.getText(CustomTranslationKeys.registerCreatePasswordHintText);
  static String get registerConfirmPasswordHintText => CustomTranslations.getText(CustomTranslationKeys.registerConfirmPasswordHintText);
  static String get registerErrorText => CustomTranslations.getText(CustomTranslationKeys.registerErrorText);

  // Password Reset
  static String get passwordResetEmailText => CustomTranslations.getText(CustomTranslationKeys.passwordResetEmailText);
  static String get passwordResetEmailHintText => CustomTranslations.getText(CustomTranslationKeys.passwordResetEmailHintText);
  static String get passwordResetApplyButton => CustomTranslations.getText(CustomTranslationKeys.passwordResetApplyButton);

  // Error Login SnackBar Text
  static String get snackbarErrorEmailPasswordControlText => CustomTranslations.getText(CustomTranslationKeys.snackbarErrorEmailPasswordControlText);
  static String get snackbarErrorRetryText => CustomTranslations.getText(CustomTranslationKeys.snackbarErrorRetryText);
  static String get snackbarErrorEmailControlText => CustomTranslations.getText(CustomTranslationKeys.snackbarErrorEmailControlText);
  static String get snackbarErrorRegisterText => CustomTranslations.getText(CustomTranslationKeys.snackbarErrorRegisterText);

  // Success Login SnackBar Text
  static String get snackbarSuccessRegisterText => CustomTranslations.getText(CustomTranslationKeys.snackbarSuccessRegisterText);
}

@immutable
class StringCommonConstant {
  const StringCommonConstant._();

  //
  static String get firebaseLoginError => CustomTranslations.getText(CustomTranslationKeys.firebaseLoginError);
  static String get googleLoginError => CustomTranslations.getText(CustomTranslationKeys.googleLoginError);
  static String get resetPasswordError => CustomTranslations.getText(CustomTranslationKeys.resetPasswordError);
  static String get registerError => CustomTranslations.getText(CustomTranslationKeys.registerError);

  // Shared Preferences
  static String get firebaseLoginErrorCode => CustomTranslations.getText(CustomTranslationKeys.firebaseLoginErrorCode);
  static String get checkLocationPermissionError => CustomTranslations.getText(CustomTranslationKeys.checkLocationPermissionError);
  static String get getCurrentLocationError => CustomTranslations.getText(CustomTranslationKeys.getCurrentLocationError);
  static String get isFirstOpenKey => CustomTranslations.getText(CustomTranslationKeys.isFirstOpenKey);

  // Validation
  static String get emptyEmailError => CustomTranslations.getText(CustomTranslationKeys.emptyEmailError);
  static String get invalidEmailError => CustomTranslations.getText(CustomTranslationKeys.invalidEmailError);
  static String get emptyPasswordError => CustomTranslations.getText(CustomTranslationKeys.emptyPasswordError);
  static String get shortPasswordError => CustomTranslations.getText(CustomTranslationKeys.shortPasswordError);
  static String get emptyPasswordConfirmationError => CustomTranslations.getText(CustomTranslationKeys.emptyPasswordConfirmationError);
  static String get mismatchedPasswordError => CustomTranslations.getText(CustomTranslationKeys.mismatchedPasswordError);
}

@immutable
class StringHomeConstant {
  const StringHomeConstant._();

  //
  static String get successSignOutText => CustomTranslations.getText(CustomTranslationKeys.successSignOutText);
  static String get errorSignOutText => CustomTranslations.getText(CustomTranslationKeys.errorSignOutText);
}
