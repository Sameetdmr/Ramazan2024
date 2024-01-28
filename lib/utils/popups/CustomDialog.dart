import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';

class CustomDialog {
  static showCustomDialog(Widget widget, [bool barrierDismissible = false]) async {
    await Future.delayed(Duration(milliseconds: 50));
    Get.dialog(widget, barrierDismissible: barrierDismissible);
  }

  static showLoadingDialog({bool isOpaqueBackground = false}) async {
    await Future.delayed(Duration(milliseconds: 50));
    Get.dialog(Container(child: Center(child: CupertinoActivityIndicator()), color: (isOpaqueBackground != false) ? Colors.white : Colors.transparent));
  }

  static dismiss() {
    if (Get.isDialogOpen!) {
      CustomNavigator().popFromMain();
    }
  }
}
