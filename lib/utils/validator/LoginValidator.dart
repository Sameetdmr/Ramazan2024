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

  static String? validateLogin(value, LoginTypeEnum loginTypeEnum) {
    switch (loginTypeEnum) {
      case LoginTypeEnum.EMAIL:
        return LoginValidator.validateEmail(value);
      case LoginTypeEnum.PASSWORD:
        return LoginValidator.validatePassword(value);
    }
  }
}
