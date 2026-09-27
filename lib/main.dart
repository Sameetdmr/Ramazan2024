// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan/core/router/app_router.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/initialize/ProjectInitialize.dart';
import 'package:ramadan/utils/localization/CustomTranslations.dart';
import 'package:ramadan/utils/theme/AppThemeLight.dart';

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey();
GlobalKey<NavigatorState> _navigatorKeyHome = GlobalKey();
GlobalKey<NavigatorState> _navigatorKeyProfile = GlobalKey();

List<GlobalKey<NavigatorState>> navigatorKeys = [_navigatorKeyHome, _navigatorKeyProfile];

late final GoRouter appRouter;

Future<void> main() async {
  await ProjectInitialize().make();
  appRouter = createAppRouter(navigatorKey: mainNavigatorKey);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (__, _) {
        return GetMaterialApp.router(
          title: StringCommonConstant.appName,
          debugShowCheckedModeBanner: false,
          translations: CustomTranslations(),
          theme: AppThemeLight.theme,
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          routerDelegate: appRouter.routerDelegate,
          routeInformationParser: appRouter.routeInformationParser,
          routeInformationProvider: appRouter.routeInformationProvider,
        );
      },
    );
  }
}
