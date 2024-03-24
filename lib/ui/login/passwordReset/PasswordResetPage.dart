// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';

import 'package:ramadan/ui/common/button/CustomLoginButton.dart';
import 'package:ramadan/ui/login/components/CustomLoginButtonType.dart';
import 'package:ramadan/ui/login/components/CustomTextField.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/enums/LoginTypeEnum.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/validator/LoginValidator.dart';

class PasswordResetScreen extends StatelessWidget {
  final TextEditingController textEditingController;
  final GlobalKey<FormState> formKey;
  const PasswordResetScreen({
    required this.textEditingController,
    required this.formKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: context.padding.low,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      CustomNavigator().popFromMain([false]);
                      textEditingController.clear();
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(StringLoginConstant.passwordResetEmailText, style: context.textTheme.bodyMedium),
              SizedBox(height: 20.h),
              CustomTextField(
                textEditingController: textEditingController,
                hintText: StringLoginConstant.passwordResetEmailHintText,
                prefixIcon: Icons.mail_outlined,
                validator: (value) {
                  if (value != null) {
                    final result = LoginValidator.validateLogin(value, LoginTypeEnum.EMAIL);
                    if (result != null) {
                      return result;
                    }
                    return null;
                  } else {
                    return null;
                  }
                },
                onChanged: null,
              ),
              SizedBox(height: 20.h),
              CustomButton.getButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    CustomNavigator().popFromMain([true, textEditingController.text]);
                    textEditingController.clear();
                  }
                },
                customLoginButtonType: CustomLoginButtonType.PRIMARY,
                textStyle: context.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.white),
                text: StringLoginConstant.passwordResetApplyButton,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
