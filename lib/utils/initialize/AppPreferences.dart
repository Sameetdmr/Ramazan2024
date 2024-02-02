import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAppPreferences {
  Future<bool> isFirstOpen();
  Future<void> setFirstOpen(bool value);
}

class AppPreferences implements IAppPreferences {
  // Uygulamanın ilk kez açılıp açılmadığını kontrol et
  Future<bool> isFirstOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(StringCommonConstant.isFirstOpenKey) ?? true;
  }

  // Uygulamanın ilk kez açıldığını işaretle
  Future<void> setFirstOpen(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StringCommonConstant.isFirstOpenKey, value);
  }
}
