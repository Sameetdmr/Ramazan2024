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

enum AppSplashLottiesConstant {
  splash('splash_build_app');

  final String value;
  const AppSplashLottiesConstant(this.value);

  String get getLottie => "assets/lottie/splash/$value.json";
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

enum PrayerTimeIconConstant {
  imsak('moon'),
  gunes('sun'),
  ogle('cloudy'),
  ikindi('morning'),
  iftar('ramadan'),
  yatsi('half_moon');

  final String value;
  const PrayerTimeIconConstant(this.value);

  String get toPng => "assets/image/home/$value.png";
  AssetImage get toImg => AssetImage(toPng);
}
