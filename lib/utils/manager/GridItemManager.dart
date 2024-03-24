// ignore_for_file: lines_longer_than_80_chars, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/model/domain/GridItemResult.dart';
import 'package:ramadan/model/domain/PrayerTimeDetails.dart';
import 'package:ramadan/model/home/GridItem.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/manager/TimeManager.dart';

final class GridItemManager {
  int? id;
  String? prayerIcon;
  Color? prayerColor;
  String? prayerTimeTitle;
  RxBool? isActive;
  String? prayerDate;
  String? prayerTimeText;
  GridItemResult fillGridItem(List<PrayerTimeDetails> prayerTimes, RxList<GridItem> gridItemList, RxList<RxBool> isActiveList) {
    for (var i = 0; i < prayerTimes.length; i++) {
      for (var j = 0; j < prayerTimes[i].times.length; j++) {
        final prayerTime = prayerTimes[i];

        isActiveList.value = TimeManager.calculatePrayerTimes(prayerTimes[i].times);

        switch (j) {
          case 0: // İmsak
            id = j;
            prayerIcon = PrayerTimeIconConstant.imsak.toPng;
            prayerColor = PrayerTimeColor.imsak;
            prayerTimeTitle = StringHomeConstant.fajr;
            isActive = isActiveList[j];
            prayerDate = prayerTime.date.isNotEmpty ? prayerTimes[i].date : StringCommonConstant.noDateInformation;
            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : StringCommonConstant.noTimeInformation;
          case 1: // Güneş
            id = j;
            prayerIcon = PrayerTimeIconConstant.gunes.toPng;
            prayerColor = PrayerTimeColor.gunes;
            prayerTimeTitle = StringHomeConstant.sunrise;
            isActive = isActiveList[j];
            prayerDate = prayerTime.date.isNotEmpty ? prayerTimes[i].date : StringCommonConstant.noDateInformation;

            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : StringCommonConstant.noTimeInformation;
          case 2: // Öğle
            id = j;
            prayerIcon = PrayerTimeIconConstant.ogle.toPng;
            prayerColor = PrayerTimeColor.ogle;
            prayerTimeTitle = StringHomeConstant.dhuhr;
            isActive = isActiveList[j];
            prayerDate = prayerTime.date.isNotEmpty ? prayerTimes[i].date : StringCommonConstant.noDateInformation;

            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : StringCommonConstant.noTimeInformation;
          case 3: // İkindi
            id = j;
            prayerIcon = PrayerTimeIconConstant.ikindi.toPng;
            prayerColor = PrayerTimeColor.ikindi;
            prayerTimeTitle = StringHomeConstant.asr;
            isActive = isActiveList[j];
            prayerDate = prayerTime.date.isNotEmpty ? prayerTimes[i].date : StringCommonConstant.noDateInformation;

            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : StringCommonConstant.noTimeInformation;
          case 4: // İftar
            id = j;
            prayerIcon = PrayerTimeIconConstant.iftar.toPng;
            prayerColor = PrayerTimeColor.iftar;
            prayerTimeTitle = StringHomeConstant.sunset;
            isActive = isActiveList[j];
            prayerDate = prayerTime.date.isNotEmpty ? prayerTimes[i].date : StringCommonConstant.noDateInformation;

            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : StringCommonConstant.noTimeInformation;
          case 5: // Yatsı
            id = j;
            prayerIcon = PrayerTimeIconConstant.yatsi.toPng;
            prayerColor = PrayerTimeColor.yatsi;
            prayerTimeTitle = StringHomeConstant.isha;
            isActive = isActiveList[j];
            prayerDate = prayerTime.date.isNotEmpty ? prayerTimes[i].date : StringCommonConstant.noDateInformation;

            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : StringCommonConstant.noTimeInformation;
          default:
            break;
        }

        gridItemList.add(
          GridItem(
            id: id!,
            color: prayerColor!,
            iconPath: prayerIcon!,
            title: prayerTimeTitle!,
            time: prayerTimeText!,
            date: prayerDate!,
            isActive: isActive!,
          ),
        );
      }
    }
    return GridItemResult(gridItemList, isActiveList);
  }
}
