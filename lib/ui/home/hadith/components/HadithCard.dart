import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/image_constant.dart';
import 'package:ramadan/utils/theme/CustomTextTheme.dart';

class HadithCard extends StatelessWidget {
  const HadithCard({
    required this.text,
    required this.author,
    super.key,
  });

  final String text;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: ColorCommonConstant.black.withOpacity(0.1))),
      child: Padding(
        padding: context.padding.low,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(alignment: Alignment.centerRight, child: SizedBox(width: 16.w, height: 24.h, child: HadithLogoConstant.logoHadith.toImg)),
            Text(
              text,
              textAlign: TextAlign.justify,
              style: CustomTextTheme(context).bodyMedium.copyWith(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                author,
                style: CustomTextTheme(context).bodySmall.copyWith(color: ColorCommonConstant.saddleBrown),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
