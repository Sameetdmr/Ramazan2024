import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/model/domain/PrayerTimeDetails.dart';
import 'package:ramadan/model/domain/PrayerTimesModel.dart';
import 'package:ramadan/model/domain/TurkeyCity.dart';
import 'package:ramadan/model/home/PrayerTimeWord.dart';
import 'package:ramadan/rest/ramadan/RamadanDataProvider.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/services/common/core/PermissionManager.dart';
import 'package:ramadan/services/common/notification/LocalNotificationService.dart';
import 'package:ramadan/services/common/ramadan/LocationService.dart';
import 'package:ramadan/services/home/TimeFormatterService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/utils/configuration/ProjectInfo.dart';
import 'package:ramadan/utils/constants/date_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/formatter/DateTimeFormatter.dart';
import 'package:ramadan/utils/initialize/AppPreferences.dart';
import 'package:ramadan/utils/manager/GridItemManager.dart';
import 'package:ramadan/utils/manager/TimeManager.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/popups/CustomSnackBar.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class HomePageViewModel extends ViewModelBase {
  HomePageViewModel() {
    setCurrentScreen('Home Page');
  }
  // Init
  RxBool isLoggedIn = false.obs;
  RxBool isNotificationPermissionGranted = false.obs;
  RxBool isPageLoading = false.obs;
  RxString initLocation = 'İSTANBUL'.obs;

  // Model
  late PrayerTimesModel _prayerTimesModel;
  RxList<PrayerTimeDetails> timeList = <PrayerTimeDetails>[].obs;
  RxList<TurkeyCity> citiesList = <TurkeyCity>[].obs;
  final RxList<PrayerTimeWord> _prayerTimeWordModel = <PrayerTimeWord>[].obs;
  final GridItemManager _gridItemManager = GridItemManager();

  // Service
  final IAuthService _authService = ServiceLocator().get<IAuthService>();
  final IRamadanDataProvider _ramadanDataProvider = ServiceLocator().get<IRamadanDataProvider>();
  final ILocationService _locationService = ServiceLocator().get<ILocationService>();
  final ILocalNotificationService _localNotificationService = ServiceLocator().get<ILocalNotificationService>();
  final IAppPreferences _appPreferences = ServiceLocator().get<IAppPreferences>();

  // Countdown
  late Timer _timer;
  Timer? _ramadanTimer;
  RxInt remainingTime = 0.obs;
  RxInt remainingramadanTime = 0.obs;

  @override
  Future<void> onInit() async {
    try {
      fillCityList();
      fillRamadanWordList();
      await checkUserLoggedIn();
      await checkNotificationPermission();
      ProjectInfo.instance.cityName.value = initLocation.value;
      await fillPrayerTimesModel(ProjectInfo.instance.cityName.value);
    } catch (e) {
      await exceptionHandlingService.handleException(e);
    }
    super.onInit();
  }

  Future<void> setupNotification(DateTime day, String iftarTime, String city) async {
    final time = DateTimeFormatter().targetDateTime(iftarTime);

    final targetDateTime = DateTime(day.year, day.month, day.day, time.hour, time.minute);

    await _localNotificationService.schedulePrayerTimeNotification(city, targetDateTime);
  }

  @override
  void onClose() {
    clearModel();
    super.onClose();
  }

  void fillCityList() {
    citiesList.value = TurkeyCity.turkeyCities;
  }

  void fillRamadanWordList() {
    _prayerTimeWordModel.value = PrayerTimeWord.ramadanWordList;
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
      if (context.mounted) await CustomSnackBar.showSnackBar(context, CustomSnackBarType.SUCCESS, StringHomeConstant.successSignOutText);
    } catch (e) {
      await CustomSnackBar.showSnackBar(context, CustomSnackBarType.ERROR, StringHomeConstant.errorSignOutText);
      rethrow;
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      CustomNavigator().pushAndRemoveUntil(LoginPage());
      if (context.mounted) await CustomSnackBar.showSnackBar(context, CustomSnackBarType.SUCCESS, StringHomeConstant.successSignOutText);
    } catch (e) {
      await CustomSnackBar.showSnackBar(context, CustomSnackBarType.ERROR, StringHomeConstant.errorSignOutText);
      rethrow;
    }
  }

  Future<void> fillPrayerTimesModel(String cityName) async {
    ProjectInfo.instance.gridItemList.clear();
    _prayerTimesModel = await _ramadanDataProvider.loadRamadanData(cityName: cityName, date: DateConstant.getValidDate());
    timeList.value = _prayerTimesModel.times;
    final gridItemResult = _gridItemManager.fillGridItem(_prayerTimesModel.times, ProjectInfo.instance.gridItemList, ProjectInfo.instance.isActiveList);
    ProjectInfo.instance.gridItemList = gridItemResult.gridItemList;
    ProjectInfo.instance.isActiveList = gridItemResult.isActiveList;
    await _startTimer(ProjectInfo.instance.gridItemList.firstWhere((element) => element.isActive.value == true).time);
    final indexOfTrue = ProjectInfo.instance.isActiveList.indexOf(true.obs);

    final targetIndex = (indexOfTrue == 0) ? 0 : 4; // Eğer kullanıcı vakitleri listerken Sahur ya da iftar vaktinde değil ise oraya göre hesaplanmasını sağla

    if (_ramadanTimer == null || !_ramadanTimer!.isActive) {
      await _startRamadanTimer(ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == targetIndex).time);
    }
    await setupNotification(DateTimeFormatter().getPrayerTime(ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == 4).date), ProjectInfo.instance.gridItemList.firstWhere((element) => element.id == 4).time, cityName);
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
        final hasLocationOk = await PermissionManager.checkLocationPermission();
        if (hasLocationOk) {
          ProjectInfo.instance.cityName.value = await _locationService.getCityNameFromCoordinates();
        } else {
          ProjectInfo.instance.cityName.value = initLocation.value;
        }
        await fillPrayerTimesModel(ProjectInfo.instance.cityName.value);
      }
    } catch (e) {
      await exceptionHandlingService.handleException(e);
    }
  }

  Future<void> _startTimer(String time) async {
    remainingTime.value = TimeManager.remainingSeconds(time);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingTime > 0) {
        remainingTime.value--;
      } else {
        final indexOfTrue = ProjectInfo.instance.isActiveList.indexOf(true.obs);

        // Zaman durumu hangi indexte olduğunu çekiyoruz.
        if (indexOfTrue != -1 && indexOfTrue < 5) {
          ProjectInfo.instance.gridItemList.clear();
          final gridItemResult = _gridItemManager.fillGridItem(_prayerTimesModel.times, ProjectInfo.instance.gridItemList, ProjectInfo.instance.isActiveList);
          ProjectInfo.instance.gridItemList = gridItemResult.gridItemList;
          ProjectInfo.instance.isActiveList = gridItemResult.isActiveList;
          _timer.cancel();

          await _startTimer(ProjectInfo.instance.gridItemList.firstWhere((element) => element.isActive.value == true).time);
        } else {
          await refreshPage(ProjectInfo.instance.cityName.value);
        }
      }
    });
  }

  Future<void> _startRamadanTimer(String time) async {
    remainingramadanTime.value = TimeManager.remainingSeconds(time);
    _ramadanTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
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
