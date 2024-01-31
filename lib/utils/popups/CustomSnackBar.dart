import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';

class CustomSnackBar {
  static showSnackBar(BuildContext context, CustomSnackBarType snackBarType, String text) {
    switch (snackBarType) {
      case CustomSnackBarType.SUCCESS:
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          messageText: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFFa3c5a1),
          duration: Duration(seconds: 3),
          isDismissible: false,
        )..show(context);
        return;
      case CustomSnackBarType.ERROR:
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          messageText: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xffe16e66),
          duration: Duration(seconds: 3),
          isDismissible: false,
        )..show(context);
        return;
    }
  }
}
