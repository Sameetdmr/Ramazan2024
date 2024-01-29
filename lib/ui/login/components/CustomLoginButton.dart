import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ramadan/ui/login/components/CustomLoginButtonType.dart';
import 'package:ramadan/utils/constants/color_constant.dart';

class CustomButton {
  static Widget getButton({required CustomLoginButtonType customLoginButtonType, required String text, required TextStyle? textStyle, required Function() onPressed}) {
    switch (customLoginButtonType) {
      case CustomLoginButtonType.PRIMARY:
        return InkWell(
          onTap: onPressed,
          child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: ColorBackgroundConstant.black),
              width: 30.sw,
              height: 50.h,
              child: Center(
                child: Text(
                  text,
                  style: textStyle,
                ),
              )),
        );

      case CustomLoginButtonType.TEXT:
        return InkWell(
          onTap: onPressed,
          child: Text(
            text,
            style: textStyle,
          ),
        );
    }
  }
}
