import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/utils/configuration/ProjectInfo.dart';
import 'package:ramadan/utils/constants/string_constant.dart';

final class TimeFormatterService {
  static (RxString, RxString, RxString) formatRemainingTime(int remainingSeconds) {
    final remainingDuration = Duration(seconds: remainingSeconds);

    final hours = remainingDuration.inHours;
    final minutes = remainingDuration.inMinutes % 60;
    final seconds = remainingDuration.inSeconds % 60;

    final formattedHours = hours.toString().padLeft(2, '0');
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = seconds.toString().padLeft(2, '0');

    return (formattedHours.obs, formattedMinutes.obs, formattedSeconds.obs);
  }

  static RxString formatRemainingTimeName() {
    final indexOfTrue = ProjectInfo.instance.isActiveList.indexOf(true.obs);
    if (indexOfTrue == 0) {
      return StringHomeConstant.timeUntilFajr.obs;
    } else if (indexOfTrue < 5 && indexOfTrue > 0) {
      return StringHomeConstant.timeUntilSunset.obs;
    } else {
      return StringHomeConstant.timeUntilFajr.obs;
    }
  }

  static Rx<Color> formatRemainingTimeColor() {
    final indexOfTrue = ProjectInfo.instance.isActiveList.indexOf(true.obs);
    if (indexOfTrue == 0) {
      return ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == indexOfTrue).color.obs;
    } else if (indexOfTrue < 5 && indexOfTrue > 0) {
      return ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == 4).color.obs;
    } else {
      return ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == indexOfTrue).color.obs;
    }
  }
}
