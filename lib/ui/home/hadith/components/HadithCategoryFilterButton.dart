import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ramadan/utils/constants/color_constant.dart';

class HadithCategoryFilterButton extends StatelessWidget {
  HadithCategoryFilterButton({required this.onSelected, required this.hadithCategory, super.key});
  void Function(String)? onSelected;
  final List<String> hadithCategory;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.filter_list_outlined, size: 24.sp, color: ColorCommonConstant.black),
      offset: const Offset(0, 32),
      onSelected: onSelected,
      itemBuilder: (context) {
        return hadithCategory
            .map(
              (item) => PopupMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
            .toList();
      },
    );
  }
}
