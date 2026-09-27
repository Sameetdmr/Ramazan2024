import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan/ui/home/CustomNavigationPage.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/ui/slider/SliderPage.dart';
import 'package:ramadan/ui/splash/SplashPage.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const slider = '/slider';
  static const login = '/login';
  static const home = '/home';
}

GoRouter createAppRouter({
  required GlobalKey<NavigatorState> navigatorKey,
}) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.slider,
        builder: (_, __) => SliderPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) => CustomNavigationPage(),
      ),
    ],
  );
}
