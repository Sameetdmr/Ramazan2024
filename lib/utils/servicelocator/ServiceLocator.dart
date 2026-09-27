import 'package:get_it/get_it.dart';
import 'package:ramadan/rest/ramadan/RamadanDataProvider.dart';
import 'package:ramadan/services/common/ExceptionHandlingService.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/services/common/core/ConfigurationService.dart';
import 'package:ramadan/services/common/core/LocationService.dart';
import 'package:ramadan/services/common/core/PermissionManager.dart';
import 'package:ramadan/services/common/notification/LocalNotificationService.dart';
import 'package:ramadan/services/common/performance/PerformanceMonitoringService.dart';
import 'package:ramadan/services/home/HadithService.dart';
import 'package:ramadan/utils/initialize/AppPreferences.dart';
import 'package:ramadan/utils/initialize/AppVersionChecker.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  factory ServiceLocator() => _singleton;

  ServiceLocator._internal();
  static final ServiceLocator _singleton = ServiceLocator._internal();

  T get<T extends Object>() => getIt<T>();

  void init() {
    if (getIt.isRegistered<IExceptionHandlingService>()) {
      return;
    }

    getIt.registerLazySingleton<IExceptionHandlingService>(ExceptionHandlingService.new);
    getIt.registerLazySingleton<ILocalNotificationService>(LocalNotificationService.new);
    getIt.registerLazySingleton<IPerformanceMonitoringService>(PerformanceMonitoringService.new);
    getIt.registerLazySingleton<IAuthService>(AuthService.new);
    getIt.registerLazySingleton<IPermissionManager>(PermissionManager.new);
    getIt.registerLazySingleton<IAppVersionChecker>(AppVersionChecker.new);
    getIt.registerLazySingleton<IAppPreferences>(AppPreferences.new);
    getIt.registerLazySingleton<IConfigurationService>(ConfigurationService.new);
    getIt.registerLazySingleton<IRamadanDataProvider>(RamadanDataProvider.new);
    getIt.registerLazySingleton<ILocationService>(LocationService.new);
    getIt.registerLazySingleton<IHadithService>(HadithService.new);
  }
}
