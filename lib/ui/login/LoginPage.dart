// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/ui/common/button/CustomLoginButton.dart';
import 'package:ramadan/ui/login/LoginPageViewModel.dart';
import 'package:ramadan/ui/login/components/CustomLoginButtonType.dart';
import 'package:ramadan/ui/login/components/CustomTextField.dart';
import 'package:ramadan/ui/login/components/SocialLoginButton.dart';
import 'package:ramadan/ui/login/passwordReset/PasswordResetPage.dart';
import 'package:ramadan/ui/login/register/RegisterPage.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/enums/LoginTypeEnum.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/theme/CustomTextTheme.dart';
import 'package:ramadan/utils/validator/LoginValidator.dart';

class LoginPage extends StatelessWidget {
  late LoginPageViewModel _loginPageViewModel;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    _loginPageViewModel = Get.put(LoginPageViewModel(context));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorBackgroundConstant.white,
      appBar: AppBar(
        backgroundColor: ColorBackgroundConstant.white,
        elevation: 0,
        title: Text(
          StringLoginConstant.loginAppBarTitle,
          style: CustomTextTheme(context).bodyMedium.copyWith(color: ColorTextConstant.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: context.padding.low,
        child: Form(
          key: _loginPageViewModel.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  textEditingController: _loginPageViewModel.emailTextController,
                  hintText: StringLoginConstant.loginEmailHintText,
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
                    hintText: StringLoginConstant.loginPasswordHintText,
                    prefixIcon: Icons.lock_outlined,
                    suffixIcon: InkWell(
                      onTap: () {
                        _loginPageViewModel.obscureText.value = !_loginPageViewModel.obscureText.value;
                      },
                      child: Icon(_loginPageViewModel.obscureText.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    ),
                    obscureText: !_loginPageViewModel.obscureText.value,
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
                    onChanged: (String? value) {
                      _loginPageViewModel.loginTextFormFieldOnChanged(value, _loginPageViewModel.passwordTextController, LoginTypeEnum.PASSWORD);
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
                      onPressed: () async {
                        final result = await showModalBottomSheet<List<bool>?>(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          builder: (context) {
                            return PasswordResetScreen(
                              textEditingController: _loginPageViewModel.forgotPasswordTextController,
                              formKey: _loginPageViewModel.forgotPasswordFormKey,
                            );
                          },
                        );
                        if (result != null && result[0]) {
                          await _loginPageViewModel.resetPassword(result[1].toString().trim());
                        }
                      },
                      customLoginButtonType: CustomLoginButtonType.TEXT,
                      text: StringLoginConstant.loginForgotPasswordButtonText,
                      textStyle: CustomTextTheme(context).bodyMedium.copyWith(color: ColorTextConstant.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton.getButton(
                        onPressed: () async {
                          if (_loginPageViewModel.formKey.currentState!.validate()) {
                            await _loginPageViewModel.signInWithEmailAndPassword(_loginPageViewModel.emailTextController.text, _loginPageViewModel.passwordTextController.text);
                            _loginPageViewModel.clearTextController();
                          }
                        },
                        customLoginButtonType: CustomLoginButtonType.PRIMARY,
                        text: StringLoginConstant.loginAppBarTitle,
                        textStyle: CustomTextTheme(context).bodyMedium.copyWith(color: ColorTextConstant.white),
                      ),
                    ),
                  ],
                ),
                const _CustomDivider(),
                Center(
                  child: SocialLoginButton(
                    onTap: () async {
                      await _loginPageViewModel.signInGoogle();
                    },
                    imageUrl: AppImageConstant.google.toPng,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringLoginConstant.loginNewUserText1),
                    CustomButton.getButton(
                      onPressed: () {
                        _loginPageViewModel.clearTextController();
                        CustomNavigator().pushToMain<void>(RegisterPage());
                      },
                      customLoginButtonType: CustomLoginButtonType.TEXT,
                      text: StringLoginConstant.loginNewUserText2,
                      textStyle: CustomTextTheme(context).bodyMedium.copyWith(decoration: TextDecoration.underline, color: ColorTextConstant.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton.getButton(
                        onPressed: () {
                          _loginPageViewModel.withoutSignIn(context);
                        },
                        customLoginButtonType: CustomLoginButtonType.TEXT,
                        text: StringLoginConstant.withoutLoginText,
                        textStyle: CustomTextTheme(context).titleMedium.copyWith(color: ColorTextConstant.forestMaid, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
          const Expanded(
            child: Divider(),
          ),
          Padding(
            padding: context.padding.medium,
            child: Text(StringLoginConstant.loginDividerText),
          ),
          const Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
