// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/ui/home/hadith/HadithPageViewModel.dart';
import 'package:ramadan/ui/home/hadith/components/HadithCard.dart';
import 'package:ramadan/ui/home/hadith/components/HadithCategoryFilterButton.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/theme/CustomTextTheme.dart';

class HadithPage extends StatelessWidget {
  HadithPage({super.key});
  late HadithPageViewModel _hadithPageViewModel;

  @override
  Widget build(BuildContext context) {
    _hadithPageViewModel = Get.put(HadithPageViewModel());
    return SafeArea(
      child: Obx(
        () => Scaffold(
          backgroundColor: ColorBackgroundConstant.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorCommonConstant.transparent,
            automaticallyImplyLeading: false,
            title: _Header(
              title: StringHadithConstant.hadithAppBarTitle,
              hadithCategory: _hadithPageViewModel.uniqueCategoryList,
              categoryName: _hadithPageViewModel.categoryName.value,
              onSelected: (String value) async {
                await _hadithPageViewModel.getHadithsByCategory(value);
              },
            ),
          ),
          body: Obx(
            () => _hadithPageViewModel.isLoading.value
                ? Padding(
                    padding: context.padding.low,
                    child: ListView.builder(
                      itemCount: _hadithPageViewModel.hadithList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HadithCard(
                          text: _hadithPageViewModel.hadithList[index].hadith,
                          author: _hadithPageViewModel.hadithList[index].author,
                        );
                      },
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
  const _Header({
    required this.title,
    required this.hadithCategory,
    required this.categoryName,
    required this.onSelected,
  });
  final String title;
  final List<String> hadithCategory;
  final String categoryName;
  final void Function(String)? onSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: CustomTextTheme(context).bodyMedium.copyWith(color: ColorTextConstant.black),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              categoryName,
              style: CustomTextTheme(context).bodySmall.copyWith(color: ColorTextConstant.orangeAccent),
            ),
          ],
        ),
        const Spacer(),
        HadithCategoryFilterButton(
          hadithCategory: hadithCategory,
          onSelected: onSelected,
        ),
      ],
    );
  }
}
