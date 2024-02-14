import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/services/common/core/PermissionManager.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/initialize/AppPreferences.dart';
import 'package:ramadan/utils/popups/CustomDialog.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class SliderPageViewModel extends ViewModelBase {
  late BuildContext _context;

  // Intro
  List<ContentConfig> slides = [];
  RxInt currentIndex = 0.obs;

  RxBool isLocationOk = false.obs;

  IAppPreferences _appPreferences = ServiceLocator().get<IAppPreferences>();

  SliderPageViewModel(BuildContext context) {
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
        backgroundColor: ColorBackgroundConstant.white,
      ),
    );
    slides.add(
      ContentConfig(
          title: StringSplashSliderConstant.splashSlider3TitleText,
          maxLineTitle: 3,
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

  Future<bool> onDonePress() async {
    try {
      await _appPreferences.init();
      bool hasLocationPermission = false;

      while (!hasLocationPermission) {
        CustomDialog.showLoadingDialog();
        hasLocationPermission = await PermissionManager.checkLocationPermission();

        if (hasLocationPermission) {
          Position? currentPosition = await PermissionManager.getCurrentLocation();
          if (currentPosition != null) {
            CustomDialog.dismiss();
            _appPreferences.setLocationPermission(true);
          } else {
            CustomDialog.dismiss();
            _appPreferences.setLocationPermission(false);
            await Future.delayed(Duration(seconds: 1));
          }
        } else {
          CustomDialog.dismiss();
          _appPreferences.setLocationPermission(false);
          await Future.delayed(Duration(seconds: 1));
        }
      }
      isLocationOk.value = await _appPreferences.getLocationPermission();

      return isLocationOk.value;
    } catch (e) {
      exceptionHandlingService.handleException(e);
      return false;
    }
  }

  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> handleNextPress() async {
    if (currentIndex.value == 1) {
      await onDonePress();
    }
  }
}
