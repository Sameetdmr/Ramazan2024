import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAppPreferences {
  Future<void> init();
  Future<bool> isFirstOpen();
  Future<void> setFirstOpen({required bool value});
  Future<bool> getNotificationPermission();
  Future<void> setNotificationPermission({required bool value});
}

class AppPreferences implements IAppPreferences {
  late SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Uygulamanın ilk kez açılıp açılmadığını kontrol et
  @override
  Future<bool> isFirstOpen() async {
    return _prefs.getBool(StringCommonConstant.isFirstOpenKey) ?? true;
  }

  // Uygulamanın ilk kez açıldığını işaretle
  @override
  Future<void> setFirstOpen({required bool value}) async {
    await _prefs.setBool(StringCommonConstant.isFirstOpenKey, value);
  }

  @override
  Future<bool> getNotificationPermission() async {
    return _prefs.getBool('Notification') ?? false;
  }

  @override
  Future<void> setNotificationPermission({required bool value}) async {
    await _prefs.setBool('Notification', value);
  }
}
