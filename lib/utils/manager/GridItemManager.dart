import 'package:get/get.dart';
import 'package:ramadan/model/domain/PrayerTimeDetails.dart';
import 'package:ramadan/model/home/GridItem.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';
import 'package:ramadan/utils/manager/TimeManager.dart';

class GridItemManager {
  (RxList<GridItem>, RxList<RxBool>) fillGridItem(List<PrayerTimeDetails> prayerTimes, RxList<GridItem> gridItemList, RxList<RxBool> isActiveList) {
    for (var i = 0; i < prayerTimes.length; i++) {
      for (var j = 0; j < prayerTimes[i].times.length; j++) {
        var prayerTime = prayerTimes[i];
        var id;
        var prayerColor;
        var prayerIcon;
        var prayerTimeText;
        var prayerTimeTitle;
        var isActive;
        isActiveList.value = TimeManager.calculatePrayerTimes(prayerTimes[i].times);

        switch (j) {
          case 0: // İmsak
            id = j;
            prayerIcon = PrayerTimeIconConstant.imsak.toPng;
            prayerColor = PrayerTimeColor.imsak;
            prayerTimeTitle = 'İmsak';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : 'Saat Bilgisi Yok';
            break;
          case 1: // Güneş
            id = j;
            prayerIcon = PrayerTimeIconConstant.gunes.toPng;
            prayerColor = PrayerTimeColor.gunes;
            prayerTimeTitle = 'Güneş';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : 'Saat Bilgisi Yok';
            break;
          case 2: // Öğle
            id = j;
            prayerIcon = PrayerTimeIconConstant.ogle.toPng;
            prayerColor = PrayerTimeColor.ogle;
            prayerTimeTitle = 'Öğle';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : 'Saat Bilgisi Yok';
            break;
          case 3: // İkindi
            id = j;
            prayerIcon = PrayerTimeIconConstant.ikindi.toPng;
            prayerColor = PrayerTimeColor.ikindi;
            prayerTimeTitle = 'İkindi';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : 'Saat Bilgisi Yok';
            break;
          case 4: // İftar
            id = j;
            prayerIcon = PrayerTimeIconConstant.iftar.toPng;
            prayerColor = PrayerTimeColor.iftar;
            prayerTimeTitle = 'İftar';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : 'Saat Bilgisi Yok';
            break;
          case 5: // Yatsı
            id = j;
            prayerIcon = PrayerTimeIconConstant.yatsi.toPng;
            prayerColor = PrayerTimeColor.yatsi;
            prayerTimeTitle = 'Yatsı';
            isActive = isActiveList[j];
            prayerTimeText = prayerTime.times.isNotEmpty ? prayerTimes[i].times[j] : 'Saat Bilgisi Yok';
            break;
          default:
            break;
        }

        gridItemList.add(GridItem(id: id, color: prayerColor, iconPath: prayerIcon, title: prayerTimeTitle, time: prayerTimeText, isActive: isActive));
      }
    }
    return (gridItemList, isActiveList);
  }
}
