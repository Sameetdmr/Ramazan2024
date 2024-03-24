import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/ui/common/button/CustomLoginButton.dart';
import 'package:ramadan/ui/login/components/CustomLoginButtonType.dart';
import 'package:ramadan/ui/login/components/CustomTextField.dart';
import 'package:ramadan/ui/login/register/RegisterPageViewModel.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/enums/LoginTypeEnum.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/validator/LoginValidator.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  late RegisterPageViewModel _registerPageViewModel;

  @override
  Widget build(BuildContext context) {
    _registerPageViewModel = Get.put(RegisterPageViewModel());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorBackgroundConstant.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            CustomNavigator().popFromMain();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: ColorBackgroundConstant.black,
          ),
        ),
        backgroundColor: ColorBackgroundConstant.white,
        elevation: 0,
        title: Text(
          StringLoginConstant.registerAppBarTitle,
          style: context.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: context.padding.low,
        child: Form(
          key: _registerPageViewModel.formKey,
          child: Column(
            children: [
              CustomTextField(
                textEditingController: _registerPageViewModel.emailTextController,
                hintText: StringLoginConstant.registerEmailHintText,
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
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => CustomTextField(
                  textEditingController: _registerPageViewModel.passwordTextController,
                  hintText: StringLoginConstant.registerCreatePasswordHintText,
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: InkWell(
                    onTap: () {
                      _registerPageViewModel.obscureText.value = !_registerPageViewModel.obscureText.value;
                    },
                    child: Icon(_registerPageViewModel.obscureText.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  ),
                  obscureText: !_registerPageViewModel.obscureText.value,
                  validator: (value) {
                    if (value != null) {
                      final result = LoginValidator.validateLogin(value, LoginTypeEnum.PASSWORD);
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
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => CustomTextField(
                  textEditingController: _registerPageViewModel.confirmPasswordController,
                  hintText: StringLoginConstant.registerConfirmPasswordHintText,
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: InkWell(
                    onTap: () {
                      _registerPageViewModel.obscureText.value = !_registerPageViewModel.obscureText.value;
                    },
                    child: Icon(_registerPageViewModel.obscureText.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  ),
                  obscureText: !_registerPageViewModel.obscureText.value,
                  validator: (value) {
                    if (value != null) {
                      final result = LoginValidator.validateLogin(_registerPageViewModel.passwordTextController.text, LoginTypeEnum.CONFIRM, value);
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
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton.getButton(
                      onPressed: () async {
                        if (_registerPageViewModel.formKey.currentState!.validate()) {
                          await _registerPageViewModel.register(context, _registerPageViewModel.emailTextController.text, _registerPageViewModel.passwordTextController.text);
                        }
                      },
                      customLoginButtonType: CustomLoginButtonType.PRIMARY,
                      text: StringLoginConstant.registerAppBarTitle,
                      textStyle: context.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
