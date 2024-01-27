import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';

class SplashPageViewModel extends GetxController {
  late BuildContext _context;
  List<ContentConfig> slides = [];

  SplashPageViewModel(BuildContext context) {
    this._context = context;
    initPage(_context);
  }

  initPage(BuildContext context) {
    slides.add(
      ContentConfig(
          title: StringSplashSliderConstant.splashSlider1TitleText,
          styleTitle: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(
              color: ColorTextConstant.forestMaid,
              fontWeight: FontWeight.bold,
            ),
          ),
          description: StringSplashSliderConstant.splashSlider1SubTitleText,
          styleDescription: GoogleFonts.nunito(
            textStyle: context.general.textTheme.labelMedium?.copyWith(color: ColorTextConstant.black),
          ),
          centerWidget: AppSplashSliderLottiesConstant.appLottie1.toLottie,
          backgroundColor: ColorBackgroundConstant.white),
    );
    slides.add(
      ContentConfig(
          title: StringSplashSliderConstant.splashSlider2TitleText,
          styleTitle: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(
              color: ColorTextConstant.forestMaid,
              fontWeight: FontWeight.bold,
            ),
          ),
          description: StringSplashSliderConstant.splashSlider2SubTitleText,
          styleDescription: GoogleFonts.nunito(
            textStyle: context.general.textTheme.labelMedium?.copyWith(color: ColorTextConstant.black),
          ),
          centerWidget: AppSplashSliderLottiesConstant.appLottie2.toLottie,
          backgroundColor: ColorBackgroundConstant.white),
    );
    slides.add(
      ContentConfig(
          title: StringSplashSliderConstant.splashSlider3TitleText,
          styleTitle: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(
              color: ColorTextConstant.forestMaid,
              fontWeight: FontWeight.bold,
            ),
          ),
          description: StringSplashSliderConstant.splashSlider3SubTitleText,
          styleDescription: GoogleFonts.nunito(
            textStyle: context.general.textTheme.labelMedium?.copyWith(color: ColorTextConstant.black),
          ),
          centerWidget: AppSplashSliderLottiesConstant.appLottie3.toLottie,
          backgroundColor: ColorBackgroundConstant.white),
    );
  }

  void onDonePress() {
    log('End of slides');
  }
}
