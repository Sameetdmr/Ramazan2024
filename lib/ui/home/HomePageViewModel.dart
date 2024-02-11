import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/model/domain/PrayerTimeDetails.dart';
import 'package:ramadan/model/domain/PrayerTimesModel.dart';
import 'package:ramadan/model/domain/TurkeyCity.dart';
import 'package:ramadan/model/home/GridItem.dart';
import 'package:ramadan/model/home/PrayerTimeWord.dart';
import 'package:ramadan/rest/ramadan/RamadanDataProvider.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/services/common/notification/LocalNotificationService.dart';
import 'package:ramadan/services/common/ramadan/LocationService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/utils/constants/date_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/manager/GridItemManager.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/popups/CustomSnackBar.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';
import 'package:ramadan/utils/manager/TimeManager.dart';

class HomePageViewModel extends ViewModelBase {
  RxList<GridItem> gridItemList = <GridItem>[].obs;
  GridItemManager _gridItemManager = GridItemManager();

  IAuthService _authService = ServiceLocator().get<IAuthService>();
  IRamadanDataProvider _ramadanDataProvider = ServiceLocator().get<IRamadanDataProvider>();
  ILocationService _locationService = ServiceLocator().get<ILocationService>();
  ILocalNotificationService _localNotificationService = ServiceLocator().get<ILocalNotificationService>();

  RxBool isLoggedIn = false.obs;

  late PrayerTimesModel _prayerTimesModel;
  RxList<PrayerTimeDetails> timeList = <PrayerTimeDetails>[].obs;
  RxList<TurkeyCity> citiesList = <TurkeyCity>[].obs;
  RxList<PrayerTimeWord> _prayerTimeWordModel = <PrayerTimeWord>[].obs;
  RxString cityName = ''.obs;

  RxBool isPageLoading = false.obs;

  late Timer _timer;
  Timer? _ramadanTimer;
  RxList<RxBool> isActiveList = <RxBool>[].obs;
  RxInt remainingTime = 0.obs;
  RxInt remainingramadanTime = 0.obs;

  HomePageViewModel() {
    initPage();
  }

  initPage() async {
    try {
      fillCityList();
      fillRamadanWordList();
      await checkUserLoggedIn();

      cityName.value = await _locationService.getCityNameFromCoordinates();

      await fillPrayerTimesModel(cityName.value);
    } catch (e) {
      exceptionHandlingService.handleException(e);
    }
  }

  void fillCityList() {
    citiesList.value = TurkeyCityModel.turkeyCities;
  }

  void fillRamadanWordList() {
    _prayerTimeWordModel.value = PrayerTimeWordModel.ramadanWordList;
  }

  Future<void> checkUserLoggedIn() async {
    isLoggedIn.value = await _authService.isUserLoggedIn();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _authService.signOut();
      CustomNavigator().pushAndRemoveUntil(LoginPage());
      CustomSnackBar.showSnackBar(context, CustomSnackBarType.SUCCESS, StringHomeConstant.successSignOutText);
    } catch (e) {
      CustomSnackBar.showSnackBar(context, CustomSnackBarType.ERROR, StringHomeConstant.errorSignOutText);
      throw e;
    }
  }

  Future<void> fillPrayerTimesModel(String cityName) async {
    _prayerTimesModel = await _ramadanDataProvider.loadRamadanData(cityName, DateConstant.getValidDate());
    timeList.value = _prayerTimesModel.times;
    var data = _gridItemManager.fillGridItem(_prayerTimesModel.times, gridItemList, isActiveList);
    gridItemList = data.$1;
    isActiveList = data.$2;
    await _startTimer(gridItemList.firstWhere((element) => element.isActive == true).time);
    int indexOfTrue = isActiveList.indexOf(true.obs);

    int targetIndex = (indexOfTrue == 0) ? 0 : 4;

    if (_ramadanTimer == null || !_ramadanTimer!.isActive) {
      await _startRamadanTimer(gridItemList.firstWhere((element) => element.id == targetIndex).time);
    }

    isPageLoading.value = true;
  }

  Future<void> refreshPage(String? city) async {
    try {
      isPageLoading.value = false;
      _timer.cancel();
      _ramadanTimer!.cancel();
      timeList.clear();
      gridItemList.clear();
      if (city != null) {
        await fillPrayerTimesModel(city);
      } else {
        cityName.value = await _locationService.getCityNameFromCoordinates();
        await fillPrayerTimesModel(cityName.value);
      }
    } catch (e) {
      exceptionHandlingService.handleException(e);
    }
  }

  Future<void> _startTimer(String time) async {
    remainingTime.value = TimeManager.remainingSeconds(time);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (remainingTime > 0) {
        remainingTime.value--;
      } else {
        int indexOfTrue = isActiveList.indexOf(true.obs);

        // Zaman durumu hangi indexte olduğunu çekiyoruz.
        if (indexOfTrue != -1 && indexOfTrue < 5) {
          gridItemList.clear();
          var data = _gridItemManager.fillGridItem(_prayerTimesModel.times, gridItemList, isActiveList);
          gridItemList = data.$1;
          isActiveList = data.$2;
          _timer.cancel();

          if (indexOfTrue == 4) {
            await _localNotificationService.showFirebaseNotification('${cityName.value.toUpperCase()} İÇİN ${formatRemainingTimeName().value.toUpperCase()} VAKTİ.', "'${getRandomRamadanWord()}'");
          }
          await _startTimer(gridItemList.firstWhere((element) => element.isActive == true).time);
        } else {
          await refreshPage(cityName.value);
        }
      }
    });
  }

  Future<void> _startRamadanTimer(String time) async {
    remainingramadanTime.value = TimeManager.remainingSeconds(time);
    _ramadanTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (remainingramadanTime > 0) {
        remainingramadanTime.value--;
        formatRemainingTime(remainingramadanTime.value);
      } else {
        _ramadanTimer!.cancel();
        if (!_ramadanTimer!.isActive) {
          await _startRamadanTimer(gridItemList.firstWhere((element) => element.id == 4).time);
        }
      }
    });
  }

  RxString formatRemainingTime(int remainingSeconds) {
    Duration remainingDuration = Duration(seconds: remainingSeconds);

    int hours = remainingDuration.inHours;
    int minutes = (remainingDuration.inMinutes % 60);
    int seconds = (remainingDuration.inSeconds % 60);

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$formattedHours : $formattedMinutes : $formattedSeconds'.obs;
  }

  RxString formatRemainingTimeName() {
    int indexOfTrue = isActiveList.indexOf(true.obs);
    if (indexOfTrue == 0) {
      return 'Sahur\'a Kalan Süre'.obs;
    } else if (indexOfTrue < 5 && indexOfTrue > 0) {
      return 'İftar\'a Kalan Süre'.obs;
    } else {
      return 'Sahur\'a  Kalan Süre'.obs;
    }
  }

  String getRandomRamadanWord() {
    Random random = Random();
    int randomIndex = random.nextInt(_prayerTimeWordModel.length);
    String currentLocale = Get.locale?.languageCode ?? 'tr';
    return currentLocale == 'tr' ? _prayerTimeWordModel[randomIndex].trWord : _prayerTimeWordModel[randomIndex].enWord;
  }
}
