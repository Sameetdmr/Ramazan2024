// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ramadan/ui/home/home/components/TimeCard.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';

class CountdownTimerWidget extends StatelessWidget {
  final String hours;
  final String minutes;
  final String seconds;
  final String title;
  final Color color;

  const CountdownTimerWidget({required this.title, required this.hours, required this.minutes, required this.seconds, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(color: ColorTextConstant.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeCard(time: hours, color: color, header: StringHomeConstant.hours),
            SizedBox(width: 4.w),
            TimeCard(time: minutes, color: color, header: StringHomeConstant.minutes),
            SizedBox(width: 4.w),
            TimeCard(time: seconds, color: color, header: StringHomeConstant.seconds),
          ],
        ),
      ],
    );
  }
}
