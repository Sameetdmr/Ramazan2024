import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';

final class CustomSnackBar {
  static Future<void> showSnackBar(BuildContext context, CustomSnackBarType snackBarType, String text) async {
    switch (snackBarType) {
      case CustomSnackBarType.SUCCESS:
        await Flushbar<void>(
          flushbarPosition: FlushbarPosition.TOP,
          messageText: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFFa3c5a1),
          duration: const Duration(seconds: 3),
          isDismissible: false,
        ).show(context);
        return;
      case CustomSnackBarType.ERROR:
        await Flushbar<void>(
          flushbarPosition: FlushbarPosition.TOP,
          messageText: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xffe16e66),
          duration: const Duration(seconds: 3),
          isDismissible: false,
        ).show(context);
        return;
    }
  }
}
