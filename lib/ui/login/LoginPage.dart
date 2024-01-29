// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/ui/login/LoginPageViewModel.dart';
import 'package:ramadan/ui/login/components/CustomLoginButton.dart';
import 'package:ramadan/ui/login/components/CustomLoginButtonType.dart';
import 'package:ramadan/ui/login/components/CustomTextField.dart';
import 'package:ramadan/ui/login/components/SocialLoginButton.dart';

import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';
import 'package:ramadan/utils/enums/LoginTypeEnum.dart';
import 'package:ramadan/utils/validator/LoginValidator.dart';

class LoginPage extends StatelessWidget {
  late LoginPageViewModel _loginPageViewModel;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    _loginPageViewModel = Get.put(LoginPageViewModel());
    return Scaffold(
      backgroundColor: ColorBackgroundConstant.white,
      appBar: AppBar(
        backgroundColor: ColorBackgroundConstant.white,
        elevation: 0,
        title: Text(
          'Sign In',
          style: context.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: context.padding.low,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              CustomTextField(
                textEditingController: _loginPageViewModel.emailTextController,
                hintText: 'Email-Adress',
                prefixIcon: Icons.mail_outlined,
                validator: (value) {
                  final result = LoginValidator.validateLogin(value, LoginTypeEnum.EMAIL);
                  if (result != null) {
                    return result;
                  }
                  return null;
                },
                onChanged: (String? value) {
                  _loginPageViewModel.loginTextFormFieldOnChanged(value, _loginPageViewModel.emailTextController, LoginTypeEnum.EMAIL);
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => CustomTextField(
                  textEditingController: _loginPageViewModel.passwordTextController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: InkWell(
                      onTap: () {
                        _loginPageViewModel.obscureText.value = !_loginPageViewModel.obscureText.value;
                      },
                      child: Icon(_loginPageViewModel.obscureText.value ? Icons.visibility_outlined : Icons.visibility_off_outlined)),
                  obscureText: !_loginPageViewModel.obscureText.value,
                  validator: (value) {
                    final result = LoginValidator.validateLogin(value, LoginTypeEnum.PASSWORD);
                    if (result != null) {
                      return result;
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    _loginPageViewModel.loginTextFormFieldOnChanged(
                      value,
                      _loginPageViewModel.passwordTextController,
                      LoginTypeEnum.PASSWORD,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton.getButton(
                    onPressed: () {},
                    customLoginButtonType: CustomLoginButtonType.TEXT,
                    text: 'Forgot password?',
                    textStyle: context.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.black),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton.getButton(
                onPressed: () async {
                  await _loginPageViewModel.signInWithEmailAndPassword(_loginPageViewModel.emailTextController.text, _loginPageViewModel.passwordTextController.text);
                },
                customLoginButtonType: CustomLoginButtonType.PRIMARY,
                text: 'Sign In',
                textStyle: context.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.white),
              ),
              _CustomDivider(),
              _SocialLoginRow(),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not registered yet? '),
                  CustomButton.getButton(
                    onPressed: () {},
                    customLoginButtonType: CustomLoginButtonType.TEXT,
                    text: 'Create Account',
                    textStyle: context.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline, color: ColorTextConstant.black, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLoginRow extends StatelessWidget {
  const _SocialLoginRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginButton(
          onTap: () {},
          imageUrl: AppImageConstant.facebook.toPng,
        ),
        SizedBox(width: 30.w),
        SocialLoginButton(
          onTap: () {},
          imageUrl: AppImageConstant.google.toPng,
        ),
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(),
          ),
          Padding(
            padding: context.padding.medium,
            child: Text("Or"),
          ),
          Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
