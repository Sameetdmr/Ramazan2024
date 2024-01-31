import 'package:flutter/material.dart';
import 'package:ramadan/ui/login/components/CustomLoginButtonType.dart';
import 'package:ramadan/utils/constants/color_constant.dart';

class CustomButton {
  static Widget getButton({required CustomLoginButtonType customLoginButtonType, required String text, required TextStyle? textStyle, required Function()? onPressed}) {
    switch (customLoginButtonType) {
      case CustomLoginButtonType.PRIMARY:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorBackgroundConstant.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          child: Text(
            text,
            style: textStyle,
          ),
        );

      case CustomLoginButtonType.TEXT:
        return TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: textStyle,
          ),
        );
    }
  }
}
