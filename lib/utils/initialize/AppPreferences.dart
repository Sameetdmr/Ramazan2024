import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAppPreferences {
  Future<void> init();
  Future<bool> isFirstOpen();
  Future<void> setFirstOpen(bool value);
  Future<bool> getNotificationPermission();
  Future<void> setNotificationPermission(bool value);
  Future<bool> getLocationPermission();
  Future<void> setLocationPermission(bool value);
}

class AppPreferences implements IAppPreferences {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Uygulamanın ilk kez açılıp açılmadığını kontrol et
  Future<bool> isFirstOpen() async {
    return _prefs.getBool(StringCommonConstant.isFirstOpenKey) ?? true;
  }

  // Uygulamanın ilk kez açıldığını işaretle
  Future<void> setFirstOpen(bool value) async {
    await _prefs.setBool(StringCommonConstant.isFirstOpenKey, value);
  }

  @override
  Future<bool> getNotificationPermission() async {
    return _prefs.getBool('Notification') ?? false;
  }

  @override
  Future<void> setNotificationPermission(bool value) async {
    await _prefs.setBool('Notification', value);
  }

  @override
  Future<bool> getLocationPermission() async {
    return _prefs.getBool('Location') ?? false;
  }

  @override
  Future<void> setLocationPermission(bool value) async {
    await _prefs.setBool('Location', value);
  }
}
