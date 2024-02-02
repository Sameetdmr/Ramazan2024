import 'package:get/get.dart';
import 'package:ramadan/utils/localization/CustomTranslationKeys.dart';

class CustomTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // Splash Slider
          CustomTranslationKeys.splashSlider1TitleText: "Welcome to Ramadan",
          CustomTranslationKeys.splashSlider1SubTitleText:
              "A peaceful month begins with the setting sun. Are you ready to discover the joy of Ramadan? Each evening, Ramadan envelops everything in a unique beauty. With this mobile app, Ramadan becomes even more special. Come on, step inside!",
          CustomTranslationKeys.splashSlider2TitleText: "Explore Prayer Times",
          CustomTranslationKeys.splashSlider2SubTitleText:
              "Travel from city to city, feel the prayer times. Capture the sacred atmosphere of Ramadan, don't miss the prayer times. With our app, always by your side. Don't forget the prayer times, enhance the spirituality! Click the Start button and experience the Ramadan month in the best way. Our app is ready to share every moment with you.",
          CustomTranslationKeys.splashSlider3TitleText: "Enjoy Ramadan with Our App",
          CustomTranslationKeys.splashSlider3SubTitleText:
              "Enjoy the taste of Ramadan! Easily learn the prayer times with our app, make your worship more efficient. Evaluate every moment with intercity prayer times, experience the spiritual atmosphere to the fullest.",
          CustomTranslationKeys.splashSliderNextButtonText: "Next",
          CustomTranslationKeys.splashSliderPrevButtonText: "Previous",
          CustomTranslationKeys.splashSliderDoneButtonText: "Get Started",

          // Login
          CustomTranslationKeys.loginAppBarTitle: "Log In",
          CustomTranslationKeys.loginEmailHintText: "Email Address",
          CustomTranslationKeys.loginPasswordHintText: "Password",
          CustomTranslationKeys.loginForgotPasswordButtonText: "Forgot Password",
          CustomTranslationKeys.loginNewUserText1: "Don't have an account? ",
          CustomTranslationKeys.loginNewUserText2: "Register for Free",
          CustomTranslationKeys.loginDividerText: "OR",

          // Register
          CustomTranslationKeys.registerAppBarTitle: "Register",
          CustomTranslationKeys.registerEmailHintText: "Email Address",
          CustomTranslationKeys.registerCreatePasswordHintText: "Create Password",
          CustomTranslationKeys.registerConfirmPasswordHintText: "Confirm Password",
          CustomTranslationKeys.registerErrorText: "An error occurred during registration: ",

          // Password Reset
          CustomTranslationKeys.passwordResetEmailText: "Enter your email address to reset your password:",
          CustomTranslationKeys.passwordResetEmailHintText: "Email Address",
          CustomTranslationKeys.passwordResetApplyButton: "Reset Password",

          // Error Login SnackBar Text
          CustomTranslationKeys.snackbarErrorEmailPasswordControlText: "Check your email and password.",
          CustomTranslationKeys.snackbarErrorRetryText: "Retry.",
          CustomTranslationKeys.snackbarErrorEmailControlText: "Check your email.",
          CustomTranslationKeys.snackbarErrorRegisterText: "Check your email.",

          // Success Login SnackBar Text
          CustomTranslationKeys.snackbarSuccessRegisterText: "Check your email.",

          //
          CustomTranslationKeys.firebaseLoginError: "An error occurred while logging in.",
          CustomTranslationKeys.googleLoginError: "An error occurred while logging in with your Google account.",
          CustomTranslationKeys.resetPasswordError: "An error occurred while resetting your password.",
          CustomTranslationKeys.registerError: "An error occurred while creating an account.",

          // Shared Preferences
          CustomTranslationKeys.firebaseLoginErrorCode: "invalid-credential",
          CustomTranslationKeys.checkLocationPermissionError: "Check Location Permission Error",
          CustomTranslationKeys.getCurrentLocationError: "Check Get Current Location Error",
          CustomTranslationKeys.isFirstOpenKey: "is_first_open",

          //
          CustomTranslationKeys.successSignOutText: "Sign out successful",
          CustomTranslationKeys.errorSignOutText: "An error occurred while signing out",

          // Validation
          CustomTranslationKeys.emptyEmailError: 'Email cannot be empty.',
          CustomTranslationKeys.invalidEmailError: 'Please enter a valid email.',
          CustomTranslationKeys.emptyPasswordError: 'Password cannot be empty.',
          CustomTranslationKeys.shortPasswordError: 'Password must be at least 6 characters.',
          CustomTranslationKeys.emptyPasswordConfirmationError: 'Password confirmation cannot be empty.',
          CustomTranslationKeys.mismatchedPasswordError: 'Passwords do not match.',
        },
        'tr_TR': {
          // Splash Slider
          CustomTranslationKeys.splashSlider1TitleText: "Ramazan'a Hoş Geldin",
          CustomTranslationKeys.splashSlider1SubTitleText:
              "Güneşin batışıyla birlikte huzur dolu bir ay başlıyor. Ramazan'ın coşkusunu keşfetmeye hazır mısın? Her bir akşamı bir başka güzellikte saran Ramazan, bu mobil uygulama ile daha özel. Hadi, içeri adım at!",
          CustomTranslationKeys.splashSlider2TitleText: "Oruç Vaktini Keşfet",
          CustomTranslationKeys.splashSlider2SubTitleText:
              "Şehir şehir dolaş, oruç vaktini hisset. Ramazan'ın kutsal atmosferini yakala, oruç vaktini kaçırma. Uygulamamızla her an yanında. Oruç saatlerini unutma, maneviyatı artır! Başla butonuna tıkla ve Ramazan ayını en iyi şekilde yaşa. Uygulamamız, seninle birlikte her anı paylaşmaya hazır.",
          CustomTranslationKeys.splashSlider3TitleText: "Uygulamamızla Ramazan'ın Keyfini Çıkar",
          CustomTranslationKeys.splashSlider3SubTitleText:
              "Ramazan ayının tadını çıkar! Uygulamamızla oruç saatlerini kolayca öğren, ibadetini daha verimli hale getir. Şehirler arası oruç vakitleriyle her anı değerlendir, manevi atmosferi doyasıya yaşa.",
          CustomTranslationKeys.splashSliderNextButtonText: "Sonraki",
          CustomTranslationKeys.splashSliderPrevButtonText: "Önceki",
          CustomTranslationKeys.splashSliderDoneButtonText: "Başla",

          // Login
          CustomTranslationKeys.loginAppBarTitle: "Giriş Yap",
          CustomTranslationKeys.loginEmailHintText: "E-posta Adresi",
          CustomTranslationKeys.loginPasswordHintText: "Şifre",
          CustomTranslationKeys.loginForgotPasswordButtonText: "Şifremi unuttum",
          CustomTranslationKeys.loginNewUserText1: "Hesabınız yok mu? ",
          CustomTranslationKeys.loginNewUserText2: "Ücretsiz Kayıt Olun",
          CustomTranslationKeys.loginDividerText: "VEYA",

          // Register
          CustomTranslationKeys.registerAppBarTitle: "Kayıt Ol",
          CustomTranslationKeys.registerEmailHintText: "E-posta Adresi",
          CustomTranslationKeys.registerCreatePasswordHintText: "Şifre oluşturun",
          CustomTranslationKeys.registerConfirmPasswordHintText: "Şifrenizi onaylayın",
          CustomTranslationKeys.registerErrorText: "Kayıt sırasında bir hata oluştu: ",

          // Password Reset
          CustomTranslationKeys.passwordResetEmailText: "Şifrenizi sıfırlamak için e-posta adresinizi giriniz:",
          CustomTranslationKeys.passwordResetEmailHintText: "E-posta Adresi",
          CustomTranslationKeys.passwordResetApplyButton: "Şifre Sıfırla",

          // Error Login SnackBar Text
          CustomTranslationKeys.snackbarErrorEmailPasswordControlText: "E-posta & Şifrenizi kontrol ediniz.",
          CustomTranslationKeys.snackbarErrorRetryText: "Tekrar deneyiniz.",
          CustomTranslationKeys.snackbarErrorEmailControlText: "E-postanızı kontrol ediniz.",
          CustomTranslationKeys.snackbarErrorRegisterText: "E-postanızı kontrol ediniz.",

          // Success Login SnackBar Text
          CustomTranslationKeys.snackbarSuccessRegisterText: "E-postanızı kontrol ediniz.",

          //
          CustomTranslationKeys.firebaseLoginError: "Giriş yapılırken bir hata oluştu.",
          CustomTranslationKeys.googleLoginError: "Google Hesabınız ile giriş yapılırken bir hata oluştu.",
          CustomTranslationKeys.resetPasswordError: "Şifreniz sıfırlanırken bir hata oluştu.",
          CustomTranslationKeys.registerError: "Kayıt oluşturulurken bir hata oluştu.",

          // Shared Preferences
          CustomTranslationKeys.firebaseLoginErrorCode: "invalid-credential",
          CustomTranslationKeys.checkLocationPermissionError: "Konum İzin Hatası",
          CustomTranslationKeys.getCurrentLocationError: "Mevcut Konumu Alma Hatası",
          CustomTranslationKeys.isFirstOpenKey: "is_first_open",

          //
          CustomTranslationKeys.successSignOutText: "Çıkış Başarılı",
          CustomTranslationKeys.errorSignOutText: "Çıkış yapılırken hata oluştu.",

          // Validation
          CustomTranslationKeys.emptyEmailError: 'E-posta boş olamaz.',
          CustomTranslationKeys.invalidEmailError: 'Geçerli bir e-posta giriniz.',
          CustomTranslationKeys.emptyPasswordError: 'Şifre boş olamaz.',
          CustomTranslationKeys.shortPasswordError: 'Şifre en az 6 karakter olmalıdır.',
          CustomTranslationKeys.emptyPasswordConfirmationError: 'Şifre tekrar boş olamaz',
          CustomTranslationKeys.mismatchedPasswordError: 'Şifreler uyuşmuyor',
        },
      };

  static String getText(String? key) {
    if (key != null) {
      return key.tr;
    } else {
      return "";
    }
  }
}
