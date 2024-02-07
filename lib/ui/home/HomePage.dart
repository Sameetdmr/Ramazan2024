import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/ui/home/HomePageViewModel.dart';
import 'package:ramadan/ui/home/city/CityListPage.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';

class HomePage extends StatelessWidget {
  late HomePageViewModel _homePageViewModel;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _homePageViewModel = Get.put(HomePageViewModel());
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            title: Text(_homePageViewModel.isPageLoading.value ? _homePageViewModel.cityName.value : '-'),
            actions: [
              Obx(
                () => Visibility(
                    visible: _homePageViewModel.isLoggedIn.value,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await _homePageViewModel.signOut(context);
                            },
                            icon: Icon(Icons.exit_to_app_outlined)),
                        SizedBox(
                          width: 5,
                        ),
                        IconButton(
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
                            icon: Icon(Icons.location_searching_outlined)),
                      ],
                    )),
              )
            ],
          ),
          body: Obx(
            () => _homePageViewModel.isPageLoading.value
                ? ListView.builder(
                    itemCount: _homePageViewModel.timeList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(_homePageViewModel.timeList[index].date),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _homePageViewModel.timeList[index].times.length,
                            itemBuilder: (context, i) {
                              return Text(_homePageViewModel.timeList[index].times[i]);
                            },
                          )
                        ],
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          )),
    );
  }
}
