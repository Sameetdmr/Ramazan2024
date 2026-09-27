import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:ramadan/services/common/ExceptionHandlingService.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class ViewModelBase extends GetxController {
  IExceptionHandlingService exceptionHandlingService = ServiceLocator().get<IExceptionHandlingService>();

  Future<void> setCurrentScreen(String screenName) async {
    await FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
      screenClass: screenName,
    );
  }
}
