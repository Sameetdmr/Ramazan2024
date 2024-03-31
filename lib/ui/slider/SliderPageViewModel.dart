// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/theme/CustomTextTheme.dart';

class SliderPageViewModel extends ViewModelBase {
  SliderPageViewModel(BuildContext context) {
    setCurrentScreen('Slider Page');
    _context = context;
  }
  late BuildContext _context;

  // Intro
  List<ContentConfig> slides = [];
  RxInt currentIndex = 0.obs;

  RxBool isLocationOk = false.obs;

  @override
  void onInit() {
    slides.addAll([
      ContentConfig(
        title: StringSplashSliderConstant.splashSlider1TitleText,
        styleTitle: GoogleFonts.nunito(
          textStyle: CustomTextTheme(_context).bodyMedium.copyWith(
                color: ColorTextConstant.forestMaid,
                fontWeight: FontWeight.bold,
              ),
        ),
        description: StringSplashSliderConstant.splashSlider1SubTitleText,
        styleDescription: GoogleFonts.nunito(
          textStyle: CustomTextTheme(_context).labelMedium.copyWith(color: ColorTextConstant.black),
        ),
        centerWidget: AppSplashSliderLottiesConstant.appLottie1.toLottie,
        backgroundColor: ColorBackgroundConstant.white,
      ),
      ContentConfig(
        title: StringSplashSliderConstant.splashSlider2TitleText,
        styleTitle: GoogleFonts.nunito(
          textStyle: CustomTextTheme(_context).bodyMedium.copyWith(
                color: ColorTextConstant.forestMaid,
                fontWeight: FontWeight.bold,
              ),
        ),
        description: StringSplashSliderConstant.splashSlider2SubTitleText,
        styleDescription: GoogleFonts.nunito(
          textStyle: CustomTextTheme(_context).labelMedium.copyWith(color: ColorTextConstant.black),
        ),
        centerWidget: AppSplashSliderLottiesConstant.appLottie2.toLottie,
        backgroundColor: ColorBackgroundConstant.white,
      ),
      ContentConfig(
        title: StringSplashSliderConstant.splashSlider3TitleText,
        maxLineTitle: 3,
        styleTitle: GoogleFonts.nunito(
          textStyle: CustomTextTheme(_context).bodyMedium.copyWith(
                color: ColorTextConstant.forestMaid,
                fontWeight: FontWeight.bold,
              ),
        ),
        description: StringSplashSliderConstant.splashSlider3SubTitleText,
        styleDescription: GoogleFonts.nunito(
          textStyle: CustomTextTheme(_context).labelMedium.copyWith(color: ColorTextConstant.black),
        ),
        centerWidget: AppSplashSliderLottiesConstant.appLottie3.toLottie,
        backgroundColor: ColorBackgroundConstant.white,
      ),
    ]);

    super.onInit();
  }

  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }
}
