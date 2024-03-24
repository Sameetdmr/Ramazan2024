import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/enums/LoginTypeEnum.dart';

final class LoginValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return StringCommonConstant.emptyEmailError;
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
      return StringCommonConstant.invalidEmailError;
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return StringCommonConstant.emptyPasswordError;
    } else if (value.length < 6) {
      return StringCommonConstant.emptyPasswordError;
    }
    return null;
  }

  static String? validatePasswordConfirmation(String password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return StringCommonConstant.emptyPasswordConfirmationError;
    } else if (confirmPassword != password) {
      return StringCommonConstant.mismatchedPasswordError;
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
