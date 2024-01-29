import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum AppSplashSliderLottiesConstant {
  appLottie1('splash_slide-1'),
  appLottie2('splash_slide-2'),
  appLottie3('splash_slide-3');

  final String value;
  const AppSplashSliderLottiesConstant(this.value);

  String get getLottie => "assets/lottie/splash_slider_lottie/$value.json";
  LottieBuilder get toLottie => Lottie.asset(getLottie);
}

enum AppImageConstant {
  facebook('login_facebook'),
  google('login_google');

  final String value;
  const AppImageConstant(this.value);

  String get toPng => "assets/image/login/$value.png";
  AssetImage get toImg => AssetImage(toPng);
}
