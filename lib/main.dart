// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ramadan/ui/splash/SplashPage.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/initialize/ProjectInitialize.dart';
import 'package:ramadan/utils/localization/CustomTranslations.dart';

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey();

Future<void> main() async {
  await ProjectInitialize().make();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (__, _) {
        return GetMaterialApp(
          title: StringCommonConstant.appName,
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
          translations: CustomTranslations(),
          locale: Get.deviceLocale,
          fallbackLocale: Locale('en', 'US'),
          navigatorKey: mainNavigatorKey,
        );
      },
    );
  }
}
