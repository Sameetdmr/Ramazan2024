import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/utils/configuration/ProjectInfo.dart';
import 'package:ramadan/utils/constants/string_constant.dart';

class TimeFormatterService {
  static formatRemainingTime(int remainingSeconds) {
    Duration remainingDuration = Duration(seconds: remainingSeconds);

    int hours = remainingDuration.inHours;
    int minutes = (remainingDuration.inMinutes % 60);
    int seconds = (remainingDuration.inSeconds % 60);

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$formattedHours : $formattedMinutes : $formattedSeconds'.obs;
  }

  static RxString formatRemainingTimeName() {
    int indexOfTrue = ProjectInfo.instance.isActiveList.indexOf(true.obs);
    if (indexOfTrue == 0) {
      return StringHomeConstant.timeUntilFajr.obs;
    } else if (indexOfTrue < 5 && indexOfTrue > 0) {
      return StringHomeConstant.timeUntilSunset.obs;
    } else {
      return StringHomeConstant.timeUntilFajr.obs;
    }
  }

  static Rx<Color> formatRemainingTimeColor() {
    int indexOfTrue = ProjectInfo.instance.isActiveList.indexOf(true.obs);
    if (indexOfTrue == 0) {
      return ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == indexOfTrue).color.obs;
    } else if (indexOfTrue < 5 && indexOfTrue > 0) {
      return ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == 4).color.obs;
    } else {
      return ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == indexOfTrue).color.obs;
    }
  }
}
