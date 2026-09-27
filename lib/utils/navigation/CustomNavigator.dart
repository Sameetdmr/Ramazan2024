import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan/core/router/app_router.dart';
import 'package:ramadan/main.dart';
import 'package:ramadan/ui/home/CustomNavigationPage.dart';
import 'package:ramadan/ui/home/CustomNavigationPageViewModel.dart';
import 'package:ramadan/ui/home/hadith/HadithPage.dart';
import 'package:ramadan/ui/home/home/HomePage.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/ui/login/register/RegisterPage.dart';
import 'package:ramadan/ui/slider/SliderPage.dart';

class CustomNavigator {
  factory CustomNavigator() => _singleton;

  CustomNavigator._internal();
  static final CustomNavigator _singleton = CustomNavigator._internal();

  static List<Widget> navigators = [
    Navigator(
      key: navigatorKeys[0],
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => HomePage(),
      ),
    ),
    Navigator(
      key: navigatorKeys[1],
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => HadithPage(),
      ),
    ),
  ];

  BuildContext? get _rootContext => mainNavigatorKey.currentContext;

  Future<T?> pushToMain<T>(Widget widget) async {
    final context = _rootContext;
    if (context == null) {
      return null;
    }

    if (widget is RegisterPage) {
      return Navigator.of(context).push<T>(
        MaterialPageRoute(builder: (_) => widget),
      );
    }

    return Navigator.of(context).push<T>(
      MaterialPageRoute(builder: (_) => widget),
    );
  }

  void popFromMain([dynamic result]) {
    final context = _rootContext;
    if (context == null) {
      return;
    }
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
    }
  }

  Future<void> pushAndRemoveUntil(Widget widget) async {
    final context = _rootContext;
    if (context == null) {
      return;
    }

    final route = _routeFor(widget);
    if (route != null) {
      context.go(route);
      return;
    }

    await Navigator.of(context).pushAndRemoveUntil<void>(
      MaterialPageRoute<void>(builder: (_) => widget),
      (_) => false,
    );
  }

  String? _routeFor(Widget widget) {
    return switch (widget) {
      SliderPage() => AppRoutes.slider,
      LoginPage() => AppRoutes.login,
      CustomNavigationPage() => AppRoutes.home,
      _ => null,
    };
  }

  void popUntilCurrentTab() {
    final navigationViewModel = Get.find<CustomNavigationPageViewModel>();
    final tabNavigatorKey = navigatorKeys[navigationViewModel.currentStateIndex.value];
    final context = tabNavigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}
