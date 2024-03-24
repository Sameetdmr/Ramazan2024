import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/ui/home/city/CityListPage.dart';
import 'package:ramadan/ui/home/components/CustomBottomNavigation.dart';
import 'package:ramadan/ui/home/home/HomePageViewModel.dart';
import 'package:ramadan/utils/configuration/ProjectInfo.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';

class CustomNavigationPageViewModel extends ViewModelBase with GetSingleTickerProviderStateMixin {
  CustomNavigationPageViewModel();
  Rx<TabController>? tabController;

  Rx<TabItem> currentTab = TabItem.home.obs;
  RxInt currentTabIndex = 0.obs;
  RxInt currentStateIndex = 0.obs;

  late HomePageViewModel _homePageViewModel;

  void changeTab(TabItem newTab) {
    currentStateIndex.value = newTab.index;
    currentTabIndex.value = newTab.index;
    currentTab.value = newTab;
    tabController!.value.animateTo(currentTabIndex.value);
  }

  @override
  void onInit() {
    _homePageViewModel = Get.put(HomePageViewModel());
    tabController = TabController(length: 2, vsync: this).obs;
    tabController!.value.addListener(() {
      currentTabIndex.value = tabController!.value.index;
    });
    super.onInit();
  }

  Future<void> changeCity() async {
    final result = await CustomNavigator().pushToMain<int?>(
      CityListPage(
        turkeyCities: _homePageViewModel.citiesList,
      ),
    );
    if (result != null) {
      ProjectInfo.instance.cityName.value = _homePageViewModel.citiesList[result].name;
      await _homePageViewModel.refreshPage(_homePageViewModel.citiesList[result].lowercaseName);
    } else {
      await _homePageViewModel.refreshPage(null);
    }
  }
}
