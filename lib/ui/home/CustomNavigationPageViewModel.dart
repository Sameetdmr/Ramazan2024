import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/home/components/CustomBottomNavigation.dart';
import 'package:ramadan/ui/home/home/HomePageViewModel.dart';
import 'package:ramadan/ui/home/city/CityListPage.dart';
import 'package:ramadan/utils/configuration/ProjectInfo.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';

class CustomNavigationPageViewModel extends ViewModelBase with GetSingleTickerProviderStateMixin {
  Rx<TabController>? tabController;

  var currentTab = TabItem.home.obs;
  RxInt currentTabIndex = 0.obs;
  RxInt currentStateIndex = 0.obs;

  late HomePageViewModel _homePageViewModel;

  CustomNavigationPageViewModel() {}

  void changeTab(TabItem newTab) {
    currentStateIndex.value = newTab.index;
    currentTabIndex.value = newTab.index;
    currentTab.value = newTab;
    tabController!.value.animateTo(currentTabIndex.value);
  }

  @override
  onInit() {
    _homePageViewModel = Get.put(HomePageViewModel());
    tabController = TabController(length: 2, vsync: this).obs;
    tabController!.value.addListener(() {
      currentTabIndex.value = tabController!.value.index;
    });
    super.onInit();
  }

  Future<void> changeCity() async {
    dynamic result = await CustomNavigator().pushToMain<dynamic>(CityListPage(
      turkeyCities: _homePageViewModel.citiesList,
    ));
    if (result != null) {
      if (result != 0) {
        ProjectInfo.instance.cityName.value = _homePageViewModel.citiesList[result].name;
        _homePageViewModel.refreshPage(_homePageViewModel.citiesList[result].lowercaseName);
      } else {
        _homePageViewModel.refreshPage(null);
      }
    }
  }
}
