import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ramadan/ui/home/CustomNavigationPageViewModel.dart';
import 'package:ramadan/ui/home/components/CustomBottomNavigation.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';

class CustomNavigationPage extends StatelessWidget {
  late CustomNavigationPageViewModel _customNavigationPageViewModel;
  @override
  Widget build(BuildContext context) {
    _customNavigationPageViewModel = Get.put(CustomNavigationPageViewModel());
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          CustomNavigator().popFromMain();
          return false;
        },
        child: GestureDetector(
          child: DefaultTabController(
            length: CustomNavigator.navigators.length,
            child: Scaffold(
              body: TabBarView(
                controller: _customNavigationPageViewModel.tabController!.value,
                children: CustomNavigator.navigators,
              ),
              bottomNavigationBar: CustomBottomNavigation(
                tabController: _customNavigationPageViewModel.tabController!.value,
                onSelectedTab: (value) {
                  if (value == _customNavigationPageViewModel.currentTab.value) {
                    CustomNavigator().popUntilCurrentTab();
                  } else {
                    _customNavigationPageViewModel.changeTab(value);
                  }
                },
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
              floatingActionButton: FloatingActionButton(
                  elevation: 5,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.location_on_outlined, size: 32.sp, color: ColorTextConstant.forestMaid),
                  onPressed: () async {
                    await _customNavigationPageViewModel.changeCity();
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
