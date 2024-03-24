// ignore_for_file: avoid_void_async

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';

final class CustomDialog {
  static void showCustomDialog(Widget widget, {bool barrierDismissible = false}) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await Get.dialog<void>(widget, barrierDismissible: barrierDismissible);
  }

  static void showLoadingDialog({bool isOpaqueBackground = false}) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await Get.dialog<void>(ColoredBox(color: (isOpaqueBackground != false) ? ColorCommonConstant.white : ColorCommonConstant.transparent, child: const Center(child: CupertinoActivityIndicator())));
  }

  static void dismiss() {
    if (Get.isDialogOpen!) {
      CustomNavigator().popFromMain();
    }
  }
}
