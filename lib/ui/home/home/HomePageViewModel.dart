import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/model/domain/GridItemResult.dart';
import 'package:ramadan/model/domain/PrayerTimeDetails.dart';
import 'package:ramadan/model/domain/PrayerTimesModel.dart';
import 'package:ramadan/model/domain/TurkeyCity.dart';
import 'package:ramadan/model/home/PrayerTimeWord.dart';
import 'package:ramadan/rest/ramadan/RamadanDataProvider.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/services/common/notification/LocalNotificationService.dart';
import 'package:ramadan/services/common/ramadan/LocationService.dart';
import 'package:ramadan/services/home/TimeFormatterService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/utils/configuration/ProjectInfo.dart';
import 'package:ramadan/utils/constants/date_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/extension/RandomRamadanWordExtension.dart';
import 'package:ramadan/utils/initialize/AppPreferences.dart';
import 'package:ramadan/utils/manager/GridItemManager.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/popups/CustomSnackBar.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';
import 'package:ramadan/utils/manager/TimeManager.dart';

class HomePageViewModel extends ViewModelBase {
  // Init
  RxBool isLoggedIn = false.obs;
  RxBool isNotificationPermissionGranted = false.obs;
  RxBool isPageLoading = false.obs;

  // Model
  late PrayerTimesModel _prayerTimesModel;
  RxList<PrayerTimeDetails> timeList = <PrayerTimeDetails>[].obs;
  RxList<TurkeyCity> citiesList = <TurkeyCity>[].obs;
  RxList<PrayerTimeWord> _prayerTimeWordModel = <PrayerTimeWord>[].obs;
  GridItemManager _gridItemManager = GridItemManager();

  // Service
  IAuthService _authService = ServiceLocator().get<IAuthService>();
  IRamadanDataProvider _ramadanDataProvider = ServiceLocator().get<IRamadanDataProvider>();
  ILocationService _locationService = ServiceLocator().get<ILocationService>();
  ILocalNotificationService _localNotificationService = ServiceLocator().get<ILocalNotificationService>();
  IAppPreferences _appPreferences = ServiceLocator().get<IAppPreferences>();

  // Countdown
  late Timer _timer;
  Timer? _ramadanTimer;
  RxInt remainingTime = 0.obs;
  RxInt remainingramadanTime = 0.obs;

  HomePageViewModel() {}

  @override
  void onInit() async {
    try {
      fillCityList();
      fillRamadanWordList();
      await checkUserLoggedIn();
      await checkNotificationPermission();
      ProjectInfo.instance.cityName.value = await _locationService.getCityNameFromCoordinates();
      await fillPrayerTimesModel(ProjectInfo.instance.cityName.value);
    } catch (e) {
      exceptionHandlingService.handleException(e);
    }
    super.onInit();
  }

  @override
  void onClose() {
    clearModel();
    super.onClose();
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

  Future<void> checkNotificationPermission() async {
    await _appPreferences.init();
    isNotificationPermissionGranted.value = await _appPreferences.getNotificationPermission();
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
    ProjectInfo.instance.gridItemList.clear();
    _prayerTimesModel = await _ramadanDataProvider.loadRamadanData(cityName, DateConstant.getValidDate());
    timeList.value = _prayerTimesModel.times;
    GridItemResult gridItemResult = _gridItemManager.fillGridItem(_prayerTimesModel.times, ProjectInfo.instance.gridItemList, ProjectInfo.instance.isActiveList);
    ProjectInfo.instance.gridItemList = gridItemResult.gridItemList;
    ProjectInfo.instance.isActiveList = gridItemResult.isActiveList;
    await _startTimer(ProjectInfo.instance.gridItemList.firstWhere((element) => element.isActive == true).time);
    int indexOfTrue = ProjectInfo.instance.isActiveList.indexOf(true.obs);

    int targetIndex = (indexOfTrue == 0) ? 0 : 4; // Eğer kullanıcı vakitleri listerken Sahur ya da iftar vaktinde değil ise oraya göre hesaplanmasını sağla

    if (_ramadanTimer == null || !_ramadanTimer!.isActive) {
      await _startRamadanTimer(ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == targetIndex).time);
    }

    isPageLoading.value = true;
  }

  void clearModel() {
    ProjectInfo.instance.gridItemList.clear();
  }

  Future<void> refreshPage(String? city) async {
    try {
      isPageLoading.value = false;
      _timer.cancel();
      _ramadanTimer!.cancel();
      timeList.clear();
      if (city != null) {
        await fillPrayerTimesModel(city);
      } else {
        ProjectInfo.instance.cityName.value = await _locationService.getCityNameFromCoordinates();
        await fillPrayerTimesModel(ProjectInfo.instance.cityName.value);
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
        int indexOfTrue = ProjectInfo.instance.isActiveList.indexOf(true.obs);

        // Zaman durumu hangi indexte olduğunu çekiyoruz.
        if (indexOfTrue != -1 && indexOfTrue < 5) {
          ProjectInfo.instance.gridItemList.clear();
          GridItemResult gridItemResult = _gridItemManager.fillGridItem(_prayerTimesModel.times, ProjectInfo.instance.gridItemList, ProjectInfo.instance.isActiveList);
          ProjectInfo.instance.gridItemList = gridItemResult.gridItemList;
          ProjectInfo.instance.isActiveList = gridItemResult.isActiveList;
          _timer.cancel();

          if (indexOfTrue == 4) {
            if (isNotificationPermissionGranted.value) {
              await _localNotificationService.showFirebaseNotification(
                  '${ProjectInfo.instance.cityName.value.toUpperCase()} İÇİN ${TimeFormatterService.formatRemainingTimeName().value.toUpperCase()} VAKTİ.', "'${RandomRamadanWordExtension.getRandomRamadanWord(_prayerTimeWordModel)}'");
            }
          }
          await _startTimer(ProjectInfo.instance.gridItemList.firstWhere((element) => element.isActive == true).time);
        } else {
          await refreshPage(ProjectInfo.instance.cityName.value);
        }
      }
    });
  }

  Future<void> _startRamadanTimer(String time) async {
    remainingramadanTime.value = TimeManager.remainingSeconds(time);
    _ramadanTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (remainingramadanTime > 0) {
        remainingramadanTime.value--;
        TimeFormatterService.formatRemainingTime(remainingramadanTime.value);
      } else {
        _ramadanTimer!.cancel();
        if (!_ramadanTimer!.isActive) {
          await _startRamadanTimer(ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == 4).time);
        }
      }
    });
  }
}
