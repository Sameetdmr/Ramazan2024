import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';

final FirebaseRemoteConfig _firebaseRemoteConfig = FirebaseRemoteConfig.instance;

abstract class IAppVersionChecker {
  Future<bool> checkAppVersion();
  Future<String> getAppVersion();
}

class AppVersionChecker implements IAppVersionChecker {
  @override
  Future<bool> checkAppVersion() async {
    try {
      await _firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 30),
          minimumFetchInterval: const Duration(seconds: 30),
        ),
      );
      await _firebaseRemoteConfig.fetchAndActivate();

      final currentAppVersion = ''.ext.version;
      final activeAppVersion = _firebaseRemoteConfig.getString(StringCommonConstant.appVersion);

      return isVersionLessThan(currentAppVersion, activeAppVersion);
    } catch (e) {
      throw CustomException('message');
    }
  }

  // Versiyonları karşılaştıran yardımcı bir fonksiyon
  bool isVersionLessThan(String currentVersion, String newVersion) {
    return newVersion.compareTo(currentVersion) <= 0;
  }

  @override
  Future<String> getAppVersion() async {
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 12),
      ),
    );
    await _firebaseRemoteConfig.fetchAndActivate();

    return _firebaseRemoteConfig.getString(StringCommonConstant.appVersion);
  }
}
