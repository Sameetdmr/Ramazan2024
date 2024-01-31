// ignore_for_file: cascade_invocations, public_member_api_docs, sort_unnamed_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigator {
  factory CustomNavigator() {
    return _singleton;
  }
  CustomNavigator._internal();
  static final CustomNavigator _singleton = CustomNavigator._internal();

  void pushToMain(Widget widget) {
    Get.to<void>(widget);
  }

  void popFromMain([dynamic result]) {
    Get.back<void>(result: result);
  }

  void pushAndRemoveUntil(Widget widget) {
    Get.offAll<void>(widget);
  }
}
