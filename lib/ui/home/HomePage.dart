// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/model/home/GridItem.dart';
import 'package:ramadan/services/home/TimeFormatterService.dart';
import 'package:ramadan/ui/home/HomePageViewModel.dart';
import 'package:ramadan/ui/home/city/CityListPage.dart';
import 'package:ramadan/ui/home/components/CountdownWidget.dart';
import 'package:ramadan/ui/home/components/GridCard.dart';
import 'package:ramadan/utils/configuration/ProjectInfo.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/formatter/DateTimeFormatter.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';

class HomePage extends StatelessWidget {
  late HomePageViewModel _homePageViewModel;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _homePageViewModel = Get.put(HomePageViewModel());
    return Obx(
      () => SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
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
              },
              child: Icon(Icons.location_on_outlined),
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: _Header(
                dateTitle: DateTimeFormatter().formatTodayDate().value,
                cityName: _homePageViewModel.isPageLoading.value ? ProjectInfo.instance.cityName.value : '-',
                onPressed: () async {
                  await _homePageViewModel.signOut(context);
                },
                isVisible: _homePageViewModel.isLoggedIn.value,
              ),
            ),
            body: Obx(
              () => _homePageViewModel.isPageLoading.value
                  ? Padding(
                      padding: context.padding.low,
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                            ),
                            itemCount: ProjectInfo.instance.gridItemList.length,
                            itemBuilder: (context, index) {
                              return GridCard(ProjectInfo.instance.gridItemList[index]);
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          CountdownTimerWidget(
                            title: TimeFormatterService.formatRemainingTimeName().value,
                            timeRemaining: TimeFormatterService.formatRemainingTime(_homePageViewModel.remainingramadanTime.value).value,
                            color: TimeFormatterService.formatRemainingTimeColor().value,
                          ),
                          Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String cityName;
  final bool isVisible;
  final String dateTitle;
  final void Function() onPressed;
  _Header({
    Key? key,
    required this.cityName,
    required this.isVisible,
    required this.dateTitle,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateTitle,
              style: context.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.black),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              cityName,
              style: context.textTheme.bodySmall?.copyWith(color: Colors.orangeAccent),
            )
          ],
        ),
        Spacer(),
        Visibility(
          visible: isVisible,
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
