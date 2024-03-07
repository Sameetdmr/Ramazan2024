// ignore_for_file: public_member_api_docs

import 'package:get/get.dart';
import 'package:ramadan/rest/ramadan/RamadanDataProvider.dart';
import 'package:ramadan/services/common/ExceptionHandlingService.dart';
import 'package:ramadan/services/common/ads/GoogleAdsenseManager.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/services/common/core/ConfigurationService.dart';
import 'package:ramadan/services/common/notification/LocalNotificationService.dart';
import 'package:ramadan/services/common/ramadan/LocationService.dart';
import 'package:ramadan/services/home/HadithService.dart';
import 'package:ramadan/utils/initialize/AppPreferences.dart';
import 'package:ramadan/utils/initialize/AppVersionChecker.dart';

class ServiceLocator {
  factory ServiceLocator() {
    return _singleton;
  }

  ServiceLocator._internal();
  static final ServiceLocator _singleton = ServiceLocator._internal();

  T get<T>() {
    return Get.find<T>();
  }

  void init() {
    Get.lazyPut<IExceptionHandlingService>(() => ExceptionHandlingService(), fenix: true);
    Get.lazyPut<ILocalNotificationService>(() => LocalNotificationService(), fenix: true);

    Get.lazyPut<IAuthService>(() => AuthService(), fenix: true);
    Get.lazyPut<IAppVersionChecker>(() => AppVersionChecker(), fenix: true);
    Get.lazyPut<IAppPreferences>(() => AppPreferences(), fenix: true);
    Get.lazyPut<IConfigurationService>(() => ConfigurationService(), fenix: true);
    Get.lazyPut<IRamadanDataProvider>(() => RamadanDataProvider(), fenix: true);
    Get.lazyPut<ILocationService>(() => LocationService(), fenix: true);
    Get.lazyPut<IHadithService>(() => HadithService(), fenix: true);
    Get.lazyPut<IGoogleAdsenseManager>(() => GoogleAdsenseManager(), fenix: true);
  }
}
