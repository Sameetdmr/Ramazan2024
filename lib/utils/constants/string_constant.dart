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

  // Remote Config
  static String get appVersion => CustomTranslations.getText(CustomTranslationKeys.appVersion);

  // Validation
  static String get emptyEmailError => CustomTranslations.getText(CustomTranslationKeys.emptyEmailError);
  static String get invalidEmailError => CustomTranslations.getText(CustomTranslationKeys.invalidEmailError);
  static String get emptyPasswordError => CustomTranslations.getText(CustomTranslationKeys.emptyPasswordError);
  static String get shortPasswordError => CustomTranslations.getText(CustomTranslationKeys.shortPasswordError);
  static String get emptyPasswordConfirmationError => CustomTranslations.getText(CustomTranslationKeys.emptyPasswordConfirmationError);
  static String get mismatchedPasswordError => CustomTranslations.getText(CustomTranslationKeys.mismatchedPasswordError);

  // Rest Service Error
  static String get anErrorOccured => CustomTranslations.getText(CustomTranslationKeys.anErrorOccured);

  // Hadith Service Error
  static String get anErrorHadithService => CustomTranslations.getText(CustomTranslationKeys.anErrorHadithService);

  // Custom Dialog
  static String get submit => CustomTranslations.getText(CustomTranslationKeys.submit);

  // App
  static String get appName => CustomTranslations.getText(CustomTranslationKeys.appName);
}

@immutable
class StringHomeConstant {
  const StringHomeConstant._();

  //
  static String get successSignOutText => CustomTranslations.getText(CustomTranslationKeys.successSignOutText);
  static String get errorSignOutText => CustomTranslations.getText(CustomTranslationKeys.errorSignOutText);

  //
  static String get coordinateError => CustomTranslations.getText(CustomTranslationKeys.coordinateError);
  static String get prayerTimesError => CustomTranslations.getText(CustomTranslationKeys.prayerTimesError);
  static String get loginError => CustomTranslations.getText(CustomTranslationKeys.loginError);

  // Date
  static String get jan => CustomTranslations.getText(CustomTranslationKeys.jan);
  static String get feb => CustomTranslations.getText(CustomTranslationKeys.feb);
  static String get mar => CustomTranslations.getText(CustomTranslationKeys.mar);
  static String get apr => CustomTranslations.getText(CustomTranslationKeys.apr);
  static String get may => CustomTranslations.getText(CustomTranslationKeys.may);
  static String get jun => CustomTranslations.getText(CustomTranslationKeys.jun);
  static String get jul => CustomTranslations.getText(CustomTranslationKeys.jul);
  static String get aug => CustomTranslations.getText(CustomTranslationKeys.aug);
  static String get sep => CustomTranslations.getText(CustomTranslationKeys.sep);
  static String get oct => CustomTranslations.getText(CustomTranslationKeys.oct);
  static String get nov => CustomTranslations.getText(CustomTranslationKeys.nov);
  static String get dec => CustomTranslations.getText(CustomTranslationKeys.dec);

  static String get sun => CustomTranslations.getText(CustomTranslationKeys.sun);
  static String get mon => CustomTranslations.getText(CustomTranslationKeys.mon);
  static String get tue => CustomTranslations.getText(CustomTranslationKeys.tue);
  static String get wed => CustomTranslations.getText(CustomTranslationKeys.wed);
  static String get thu => CustomTranslations.getText(CustomTranslationKeys.thu);
  static String get fri => CustomTranslations.getText(CustomTranslationKeys.fri);
  static String get sat => CustomTranslations.getText(CustomTranslationKeys.sat);

  // Prayer Times
  static String get fajr => CustomTranslations.getText(CustomTranslationKeys.fajr);
  static String get sunrise => CustomTranslations.getText(CustomTranslationKeys.sunrise);
  static String get dhuhr => CustomTranslations.getText(CustomTranslationKeys.dhuhr);
  static String get asr => CustomTranslations.getText(CustomTranslationKeys.asr);
  static String get sunset => CustomTranslations.getText(CustomTranslationKeys.sunset);
  static String get isha => CustomTranslations.getText(CustomTranslationKeys.isha);

  // Countdown Title
  static String get hours => CustomTranslations.getText(CustomTranslationKeys.hours);
  static String get minutes => CustomTranslations.getText(CustomTranslationKeys.minutes);
  static String get seconds => CustomTranslations.getText(CustomTranslationKeys.seconds);
  static String get timeUntilFajr => CustomTranslations.getText(CustomTranslationKeys.timeUntilFajr);
  static String get timeUntilSunset => CustomTranslations.getText(CustomTranslationKeys.timeUntilSunset);
}

class StringHadithConstant {
  const StringHadithConstant._();

  static String get allCategory => CustomTranslations.getText(CustomTranslationKeys.allCategory);
  static String get hadithAppBarTitle => CustomTranslations.getText(CustomTranslationKeys.hadithAppBarTitle);
}

class ProjectConstant {
  const ProjectConstant._();

  static String get hadithJsonPath => 'assets/json/hadiths.json';
}
