// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/model/home/GridItem.dart';
import 'package:ramadan/ui/home/HomePageViewModel.dart';
import 'package:ramadan/ui/home/city/CityListPage.dart';
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
                    _homePageViewModel.cityName.value = _homePageViewModel.citiesList[result].name;
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
                cityName: _homePageViewModel.isPageLoading.value ? _homePageViewModel.cityName.value : '-',
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
                            itemCount: _homePageViewModel.gridItemList.length,
                            itemBuilder: (context, index) {
                              return _GridCard(_homePageViewModel.gridItemList[index]);
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          _RemainingTime(homePageViewModel: _homePageViewModel),
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

class _RemainingTime extends StatelessWidget {
  const _RemainingTime({
    required HomePageViewModel homePageViewModel,
  }) : _homePageViewModel = homePageViewModel;

  final HomePageViewModel _homePageViewModel;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _homePageViewModel.formatRemainingTimeName().value,
            style: context.textTheme.titleMedium?.copyWith(
              color: ColorTextConstant.forestMaid,
            ),
          ),
          Text(
            _homePageViewModel.formatRemainingTime(_homePageViewModel.remainingramadanTime.value).value,
            style: context.textTheme.headlineMedium?.copyWith(color: Colors.black),
          ),
        ],
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
            child: Row(
              children: [
                IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      Icons.logout_outlined,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 5,
                ),
              ],
            )),
      ],
    );
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard(this.item);
  final GridItem item;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: item.isActive.value ? BorderSide(color: item.color, width: 2.0) : BorderSide.none,
        ),
        color: item.isActive.value ? item.color.withOpacity(0.5) : item.color.withOpacity(0.1),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Align(alignment: Alignment.topLeft, child: Text(item.title, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold))),
                const Spacer(),
                Flexible(
                  flex: 20,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      item.iconPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(alignment: Alignment.bottomLeft, child: Text(item.time, style: context.textTheme.titleMedium?.copyWith())),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
