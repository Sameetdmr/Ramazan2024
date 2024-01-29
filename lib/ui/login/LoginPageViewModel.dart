import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/utils/enums/LoginTypeEnum.dart';
import 'package:ramadan/utils/validator/LoginValidator.dart';

class LoginPageViewModel extends ViewModelBase {
  final TextEditingController emailTextController = new TextEditingController();
  final TextEditingController passwordTextController = new TextEditingController();

  RxBool obscureText = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginPageViewModel() {
    initPage();
  }

  initPage() {}

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  void loginTextFormFieldOnChanged(String? value, TextEditingController controller, LoginTypeEnum loginTypeEnum) {
    if (value!.isEmpty) {
      return;
    } else {
      final result = LoginValidator.validateLogin(value, loginTypeEnum);
      if (result == null) {
        controller.text = value;
        print(controller.text);
      }
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }
}
