// ignore_for_file: cascade_invocations, public_member_api_docs, sort_unnamed_constructors_first, omit_local_variable_types, prefer_final_locals

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/main.dart';
import 'package:ramadan/ui/home/CustomNavigationPageViewModel.dart';
import 'package:ramadan/ui/home/hadith/HadithPage.dart';
import 'package:ramadan/ui/home/home/HomePage.dart';

class CustomNavigator {
  factory CustomNavigator() {
    return _singleton;
  }
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

  Future<T?> pushToMain<T>(Widget widget) async {
    Get.addKey(mainNavigatorKey);
    return await Get.to<T>(widget);
  }

  void popFromMain([dynamic result]) {
    Get.addKey(mainNavigatorKey);
    Get.back<dynamic>(result: result);
  }

  Future<void> pushAndRemoveUntil(Widget widget) async {
    Get.addKey(mainNavigatorKey);
    await Get.offAll<void>(widget);
  }

  void popUntilCurrentTab() {
    // ignore: no_leading_underscores_for_local_identifiers
    CustomNavigationPageViewModel _customNavigationPageViewModel = Get.find();
    Get.addKey(navigatorKeys[_customNavigationPageViewModel.currentStateIndex.value]);
    Get.until((route) => route.isFirst);
  }
}
