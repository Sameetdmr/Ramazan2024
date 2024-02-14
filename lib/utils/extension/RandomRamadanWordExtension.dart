import 'dart:math';

import 'package:get/get.dart';
import 'package:ramadan/model/home/PrayerTimeWord.dart';

class RandomRamadanWordExtension {
  static String getRandomRamadanWord(RxList<PrayerTimeWord> _prayerTimeWordModel) {
    Random random = Random();
    int randomIndex = random.nextInt(_prayerTimeWordModel.length);
    String currentLocale = Get.locale?.languageCode ?? 'tr';
    return currentLocale == 'tr' ? _prayerTimeWordModel[randomIndex].trWord : _prayerTimeWordModel[randomIndex].enWord;
  }
}
