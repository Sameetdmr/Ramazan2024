import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/model/domain/PrayerTimeDetails.dart';
import 'package:ramadan/model/domain/PrayerTimesModel.dart';
import 'package:ramadan/model/domain/TurkeyCity.dart';
import 'package:ramadan/rest/ramadan/RamadanDataProvider.dart';
import 'package:ramadan/services/common/core/AuthService.dart';
import 'package:ramadan/services/common/ramadan/LocationService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/login/LoginPage.dart';
import 'package:ramadan/utils/constants/date_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/popups/CustomSnackBar.dart';
import 'package:ramadan/utils/popups/CustomSnackBarType.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class HomePageViewModel extends ViewModelBase {
  IAuthService _authService = ServiceLocator().get<IAuthService>();
  IRamadanDataProvider _ramadanDataProvider = ServiceLocator().get<IRamadanDataProvider>();
  ILocationService _locationService = ServiceLocator().get<ILocationService>();

  RxBool isLoggedIn = false.obs;

  RxList<PrayerTimeDetails> timeList = <PrayerTimeDetails>[].obs;
  RxList<TurkeyCity> citiesList = <TurkeyCity>[].obs;
  RxString cityName = ''.obs;

  RxBool isPageLoading = false.obs;

  HomePageViewModel() {
    initPage();
  }

  initPage() async {
    try {
      fillCityList();
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
    PrayerTimesModel prayerTimesModel = await _ramadanDataProvider.loadRamadanData(cityName, DateConstant.getValidDate());
    timeList.value = prayerTimesModel.times;
    isPageLoading.value = true;
  }

  Future<void> refreshPage(String? city) async {
    try {
      isPageLoading.value = false;
      timeList.clear();
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
}
