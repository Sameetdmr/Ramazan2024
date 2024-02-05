import 'package:flutter/material.dart';
import 'package:ramadan/ui/common/button/CustomLoginButton.dart';
import 'package:ramadan/ui/login/components/CustomLoginButtonType.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function() onPressed;

  CustomDialogWidget(this.title, this.message, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: ColorBackgroundConstant.white,
      title: Text(title),
      content: Text(message),
      actions: [
        CustomButton.getButton(
          customLoginButtonType: CustomLoginButtonType.PRIMARY,
          text: StringCommonConstant.submit,
          textStyle: null,
          onPressed: () {
            onPressed();
          },
        ),
      ],
    );
  }
}
