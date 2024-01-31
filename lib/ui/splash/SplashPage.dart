import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/ui/splash/SplashPageViewModel.dart';
import 'package:ramadan/utils/constants/color_constant.dart';

class SplashPage extends StatelessWidget {
  late SplashPageViewModel _splashPageViewModel;
  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    _splashPageViewModel = Get.put(SplashPageViewModel());
    return Scaffold(
      backgroundColor: ColorBackgroundConstant.white,
    );
  }
}
