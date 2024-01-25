// ignore_for_file: cascade_invocations, public_member_api_docs, sort_unnamed_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/main.dart';

class CustomNavigator {
  factory CustomNavigator() {
    return _singleton;
  }
  CustomNavigator._internal();
  static final CustomNavigator _singleton = CustomNavigator._internal();

  void pushToMain(Widget widget) {
    Get.addKey(mainNavigatorKey);
    Get.to<void>(widget);
  }

  void popFromMain() {
    Get.addKey(mainNavigatorKey);
    Get.back<void>();
  }

  void pushAndRemoveUntil(Widget widget) {
    Get.addKey(mainNavigatorKey);
    Get.offAll<void>(widget);
  }
}
