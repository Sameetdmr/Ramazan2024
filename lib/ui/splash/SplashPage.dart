import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/ui/splash/SplashPageViewModel.dart';
import 'package:ramadan/utils/constants/color_constant.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});
  late SplashPageViewModel _splashPageViewModel;

  @override
  Widget build(BuildContext context) {
    _splashPageViewModel = Get.put(SplashPageViewModel(context));
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: _splashPageViewModel.slides,
      onDonePress: _splashPageViewModel.onDonePress,
      renderNextBtn: Text('Sonraki',
          style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.forestMaid),
          )),
      renderPrevBtn: Text('Önceki',
          style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.forestMaid),
          )),
      renderSkipBtn: Text('Atla',
          style: GoogleFonts.nunito(
            textStyle: context.general.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.forestMaid),
          )),
      renderDoneBtn: TextButton(
        onPressed: () {},
        child: Text('Başla!',
            style: GoogleFonts.nunito(
              textStyle: context.general.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.forestMaid),
            )),
      ),
    );
  }
}
