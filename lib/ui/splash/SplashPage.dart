import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/ui/splash/SplashPageViewModel.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';

class SplashPage extends StatelessWidget {
  late SplashPageViewModel _splashPageViewModel;
  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    _splashPageViewModel = Get.put(SplashPageViewModel());
    return Obx(
      () => Scaffold(
          backgroundColor: ColorBackgroundConstant.white,
          body: !_splashPageViewModel.isCurrentVersionOk.value
              ? Padding(
                  padding: context.padding.medium,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSplashLottiesConstant.splash.toLottie,
                      Text(
                        'Uygulamanın ${_splashPageViewModel.appVersion.value} versiyonu mevcuttur. Lütfen güncelleyiniz.',
                        style: context.textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : SizedBox()),
    );
  }
}
