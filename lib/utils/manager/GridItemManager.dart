import 'package:get/get.dart';
import 'package:ramadan/model/domain/PrayerTimeDetails.dart';
import 'package:ramadan/model/home/GridItem.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';
import 'package:ramadan/utils/manager/TimeManager.dart';

class GridItemManager {
  (RxList<GridItem>, RxList<RxBool>) fillGridItem(List<PrayerTimeDetails> prayerTimes, RxList<GridItem> gridItemList, RxList<RxBool> isActiveList) {
    List<String> deneme = [
      "20:59",
      "21:00",
      "21:01",
      "21:02",
      "21:03",
      "21:04",
    ]; // TODO test aşaması için bu alan kullanılmaktadır.

    for (var i = 0; i < prayerTimes.length; i++) {
      for (var j = 0; j < prayerTimes[i].times.length; j++) {
        var prayerTime = prayerTimes[i];
        var prayerColor;
        var prayerIcon;
        var prayerTimeText;
        var prayerTimeTitle;
        var isActive;
        isActiveList.value = TimeManager.calculatePrayerTimes(deneme);

        switch (j) {
          case 0: // İmsak
            prayerIcon = PrayerTimeIconConstant.imsak.toPng;
            prayerColor = PrayerTimeColor.imsak;
            prayerTimeTitle = 'İmsak';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? deneme[j] : 'Saat Bilgisi Yok';
            break;
          case 1: // Güneş
            prayerIcon = PrayerTimeIconConstant.gunes.toPng;
            prayerColor = PrayerTimeColor.gunes;
            prayerTimeTitle = 'Güneş';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? deneme[j] : 'Saat Bilgisi Yok';
            break;
          case 2: // Öğle
            prayerIcon = PrayerTimeIconConstant.ogle.toPng;
            prayerColor = PrayerTimeColor.ogle;
            prayerTimeTitle = 'Öğle';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? deneme[j] : 'Saat Bilgisi Yok';
            break;
          case 3: // İkindi
            prayerIcon = PrayerTimeIconConstant.ikindi.toPng;
            prayerColor = PrayerTimeColor.ikindi;
            prayerTimeTitle = 'İkindi';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? deneme[j] : 'Saat Bilgisi Yok';
            break;
          case 4: // İftar
            prayerIcon = PrayerTimeIconConstant.iftar.toPng;
            prayerColor = PrayerTimeColor.iftar;
            prayerTimeTitle = 'İftar';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? deneme[j] : 'Saat Bilgisi Yok';
            break;
          case 5: // Yatsı
            prayerIcon = PrayerTimeIconConstant.yatsi.toPng;
            prayerColor = PrayerTimeColor.yatsi;
            prayerTimeTitle = 'Yatsı';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? deneme[j] : 'Saat Bilgisi Yok';
            break;
          default:
            break;
        }

        gridItemList.add(GridItem(color: prayerColor, iconPath: prayerIcon, title: prayerTimeTitle, time: prayerTimeText, isActive: isActive));
      }
    }
    return (gridItemList, isActiveList);
  }
}
