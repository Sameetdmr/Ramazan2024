import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';
import 'package:ramadan/utils/theme/CustomTextTheme.dart';

class CustomSnackBar {
  static Future<void> showSnackBar(BuildContext context, CustomSnackBarType snackBarType, String text) async {
    Color backgroundColor;
    switch (snackBarType) {
      case CustomSnackBarType.success:
        backgroundColor = const Color(0xFFa3c5a1);
      case CustomSnackBarType.error:
        backgroundColor = const Color(0xffe16e66);
    }

    await Flushbar<void>(
      flushbarPosition: FlushbarPosition.TOP,
      messageText: Text(
        text,
        style: CustomTextTheme(context).bodyMedium.copyWith(fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      isDismissible: false,
    ).show(context);
  }
}
