import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

enum AppSplashSliderLottiesConstant {
  appLottie1('splash_slide-1'),
  appLottie2('splash_slide-2'),
  appLottie3('splash_slide-3');

  const AppSplashSliderLottiesConstant(this.value);
  final String value;

  String get getLottie => 'assets/lottie/splash_slider_lottie/$value.json';
  LottieBuilder get toLottie => Lottie.asset(getLottie);
}

enum AppSplashLottiesConstant {
  splash('splash_build_app');

  const AppSplashLottiesConstant(this.value);
  final String value;

  String get getLottie => 'assets/lottie/splash/$value.json';
  LottieBuilder get toLottie => Lottie.asset(getLottie);
}

enum AppImageConstant {
  facebook('login_facebook'),
  google('login_google');

  const AppImageConstant(this.value);
  final String value;

  String get toPng => 'assets/image/login/$value.png';
  AssetImage get toImg => AssetImage(toPng);
}

enum PrayerTimeIconConstant {
  imsak('moon'),
  gunes('sun'),
  ogle('cloudy'),
  ikindi('morning'),
  iftar('ramadan'),
  yatsi('half_moon');

  const PrayerTimeIconConstant(this.value);
  final String value;

  String get toPng => 'assets/image/home/$value.png';
  AssetImage get toImg => AssetImage(toPng);
}

enum HadithLogoConstant {
  logo_hadith('logo_hadith');

  const HadithLogoConstant(this.value);
  final String value;

  String get toSvg => 'assets/image/hadith/$value.svg';
  SvgPicture get toImg => SvgPicture.asset(toSvg);
}
