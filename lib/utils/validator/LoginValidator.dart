import 'package:ramadan/utils/enums/LoginTypeEnum.dart';

class LoginValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'E-posta boş olamaz.';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
      return 'Geçerli bir e-posta giriniz.';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Şifre boş olamaz.';
    } else if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır.';
    }
    return null;
  }

  static String? validatePasswordConfirmation(String password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Şifre tekrar boş olamaz';
    } else if (confirmPassword != password) {
      return 'Şifreler uyuşmuyor';
    }
    return null;
  }

  static String? validateLogin(String value, LoginTypeEnum loginTypeEnum, [String? confirmPassword]) {
    switch (loginTypeEnum) {
      case LoginTypeEnum.EMAIL:
        return LoginValidator.validateEmail(value);
      case LoginTypeEnum.PASSWORD:
        return LoginValidator.validatePassword(value);
      case LoginTypeEnum.CONFIRM:
        return LoginValidator.validatePasswordConfirmation(value, confirmPassword);
    }
  }
}
