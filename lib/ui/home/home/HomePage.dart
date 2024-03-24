// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/services/home/TimeFormatterService.dart';
import 'package:ramadan/ui/home/home/HomePageViewModel.dart';
import 'package:ramadan/ui/home/home/components/CountdownWidget.dart';
import 'package:ramadan/ui/home/home/components/GridCard.dart';
import 'package:ramadan/utils/configuration/ProjectInfo.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/formatter/DateTimeFormatter.dart';

class HomePage extends StatelessWidget {
  late HomePageViewModel _homePageViewModel;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _homePageViewModel = Get.find<HomePageViewModel>();
    return Obx(
      () => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorCommonConstant.transparent,
            automaticallyImplyLeading: false,
            title: _Header(
              dateTitle: DateTimeFormatter().formatTodayDate().value,
              cityName: _homePageViewModel.isPageLoading.value ? ProjectInfo.instance.cityName.value : '-',
              signOutOnPressed: () async {
                await _homePageViewModel.signOut(context);
              },
              loginOnPressed: () async {
                await _homePageViewModel.signIn(context);
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
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: ProjectInfo.instance.gridItemList.length,
                          itemBuilder: (context, index) {
                            return GridCard(ProjectInfo.instance.gridItemList[index]);
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                          child: const Divider(
                            thickness: 2,
                          ),
                        ),
                        CountdownTimerWidget(
                          title: TimeFormatterService.formatRemainingTimeName().value,
                          hours: TimeFormatterService.formatRemainingTime(_homePageViewModel.remainingramadanTime.value).$1.value,
                          minutes: TimeFormatterService.formatRemainingTime(_homePageViewModel.remainingramadanTime.value).$2.value,
                          seconds: TimeFormatterService.formatRemainingTime(_homePageViewModel.remainingramadanTime.value).$3.value,
                          color: TimeFormatterService.formatRemainingTimeColor().value,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String cityName;
  final bool isVisible;
  final String dateTitle;
  final void Function() signOutOnPressed;
  final void Function() loginOnPressed;

  const _Header({
    required this.cityName,
    required this.isVisible,
    required this.dateTitle,
    required this.signOutOnPressed,
    required this.loginOnPressed,
  });
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
              style: context.textTheme.bodySmall?.copyWith(color: ColorTextConstant.orangeAccent),
            ),
          ],
        ),
        const Spacer(),
        Visibility(
          visible: isVisible,
          replacement: IconButton(
            onPressed: loginOnPressed,
            icon: Icon(
              Icons.login_outlined,
              color: ColorCommonConstant.black,
            ),
          ),
          child: IconButton(
            onPressed: signOutOnPressed,
            icon: Icon(
              Icons.logout_outlined,
              color: ColorCommonConstant.black,
            ),
          ),
        ),
      ],
    );
  }
}
