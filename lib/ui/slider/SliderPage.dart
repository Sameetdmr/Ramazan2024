import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/ui/slider/SliderPageViewModel.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';

class SliderPage extends StatelessWidget {
  SliderPage({super.key});
  late SliderPageViewModel _sliderPageViewModel;

  @override
  Widget build(BuildContext context) {
    _sliderPageViewModel = Get.put(SliderPageViewModel(context));
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: _sliderPageViewModel.slides,
      onDonePress: () {
        if (_sliderPageViewModel.isLocationOk.value) {
          CustomNavigator().pushToMain(LoginPage());
        } else {
          //Todo? İzin vermesi gerektiğini gösteren dialog.
        }
      },
      onTabChangeCompleted: (index) {
        _sliderPageViewModel.updateCurrentIndex(index);
      },
      onNextPress: () async {
        await _sliderPageViewModel.handleNextPress();
      },
      isShowSkipBtn: false,
      renderNextBtn: Text(StringSplashSliderConstant.splashSliderNextButtonText,
          style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.forestMaid),
          )),
      renderPrevBtn: Text(StringSplashSliderConstant.splashSliderPrevButtonText,
          style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.forestMaid),
          )),
      renderDoneBtn: Text(
        StringSplashSliderConstant.splashSliderDoneButtonText,
        style: GoogleFonts.nunito(
          textStyle: context.general.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.forestMaid),
        ),
      ),
    );
  }
}
