// ignore_for_file: public_member_api_docs

import 'package:get/get.dart';
import 'package:ramadan/services/common/ExceptionHandlingService.dart';
import 'package:ramadan/services/common/core/AuthService.dart';

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
    Get.lazyPut<IAuthService>(() => AuthService(), fenix: true);
  }
}
