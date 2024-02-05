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
}

class StringCityConstant {
  const StringCityConstant._();

  //
  static List<String> turkeyCities = [
    "ADANA",
    "ADIYAMAN",
    "AFYONKARAHİSAR",
    "AĞRI",
    "AKSARAY",
    "AMASYA",
    "ANKARA",
    "ANTALYA",
    "ARDAHAN",
    "ARTVİN",
    "AYDIN",
    "BALIKESİR",
    "BARTIN",
    "BATMAN",
    "BAYBURT",
    "BİLECİK",
    "BİNGÖL",
    "BİTLİS",
    "BOLU",
    "BURDUR",
    "BURSA",
    "ÇANAKKALE",
    "ÇANKIRI",
    "ÇORUM",
    "DENİZLİ",
    "DİYARBAKIR",
    "DÜZCE",
    "EDİRNE",
    "ELAZIĞ",
    "ERZİNCAN",
    "ERZURUM",
    "ESKİŞEHİR",
    "GAZİANTEP",
    "GİRESUN",
    "GÜMÜŞHANE",
    "HAKKARİ",
    "HATAY",
    "IĞDIR",
    "ISPARTA",
    "İSTANBUL",
    "İZMİR",
    "KAHRAMANMARAŞ",
    "KARABÜK",
    "KARAMAN",
    "KARS",
    "KASTAMONU",
    "KAYSERİ",
    "KIRIKKALE",
    "KIRKLARELİ",
    "KIRŞEHİR",
    "KİLİS",
    "KOCAELİ",
    "KONYA",
    "KÜTAHYA",
    "MALATYA",
    "MANİSA",
    "MARDİN",
    "MERSİN",
    "MUĞLA",
    "MUŞ",
    "NEVŞEHİR",
    "NİĞDE",
    "ORDU",
    "OSMANİYE",
    "RİZE",
    "SAKARYA",
    "SAMSUN",
    "SİİRT",
    "SİNOP",
    "SİVAS",
    "ŞANLIURFA",
    "ŞIRNAK",
    "TEKİRDAĞ",
    "TOKAT",
    "TRABZON",
    "TUNCELİ",
    "UŞAK",
    "VAN",
    "YALOVA",
    "YOZGAT",
    "ZONGULDAK"
  ];

  static List<String> turkeyCitiesLowercase = const [
    "adana",
    "adiyaman",
    "afyonkarahisar",
    "agri",
    "aksaray",
    "amasya",
    "ankara",
    "antalya",
    "ardahan",
    "artvin",
    "aydin",
    "balikesir",
    "bartin",
    "batman",
    "bayburt",
    "bilecik",
    "bingol",
    "bitlis",
    "bolu",
    "burdur",
    "bursa",
    "canakkale",
    "cankiri",
    "corum",
    "denizli",
    "diyarbakir",
    "duzce",
    "edirne",
    "elazig",
    "erzincan",
    "erzurum",
    "eskisehir",
    "gaziantep",
    "giresun",
    "gumushane",
    "hakkari",
    "hatay",
    "igdir",
    "isparta",
    "istanbul",
    "izmir",
    "kahramanmaras",
    "karabuk",
    "karaman",
    "kars",
    "kastamonu",
    "kayseri",
    "kirikkale",
    "kirklareli",
    "kirsehir",
    "kilis",
    "kocaeli",
    "konya",
    "kutahya",
    "malatya",
    "manisa",
    "mardin",
    "mersin",
    "mugla",
    "mus",
    "nevsehir",
    "nigde",
    "ordu",
    "osmaniye",
    "rize",
    "sakarya",
    "samsun",
    "siirt",
    "sinop",
    "sivas",
    "sanliurfa",
    "sirnak",
    "tekirdag",
    "tokat",
    "trabzon",
    "tunceli",
    "usak",
    "van",
    "yalova",
    "yozgat",
    "zonguldak"
  ];
}
