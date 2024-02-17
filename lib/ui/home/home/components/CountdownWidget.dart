// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';

class CountdownTimerWidget extends StatelessWidget {
  final String hours;
  final String minutes;
  final String seconds;
  final String title;
  final Color color;

  CountdownTimerWidget({required this.title, required this.hours, required this.minutes, required this.seconds, required this.color});

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
            BuildTimeCard(time: hours, color: color, header: StringHomeConstant.hours),
            SizedBox(width: 4.w),
            BuildTimeCard(time: minutes, color: color, header: StringHomeConstant.minutes),
            SizedBox(width: 4.w),
            BuildTimeCard(time: seconds, color: color, header: StringHomeConstant.seconds),
          ],
        ),
      ],
    );
  }
}

class BuildTimeCard extends StatelessWidget {
  final String time;
  final String header;
  final Color color;
  const BuildTimeCard({Key? key, required this.time, required this.header, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: context.padding.low,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: ColorTextConstant.black)),
          child: Text(
            time,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          header,
          style: context.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.black),
        )
      ],
    );
  }
}
