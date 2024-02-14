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

  Future<T?> pushToMain<T>(Widget widget) async {
    Get.addKey(mainNavigatorKey);
    return await Get.to<T>(widget);
  }

  void popFromMain([dynamic result]) {
    Get.addKey(mainNavigatorKey);
    Get.back<void>(result: result);
  }

  void pushAndRemoveUntil(Widget widget) {
    Get.addKey(mainNavigatorKey);
    Get.offAll<void>(widget);
  }
}
