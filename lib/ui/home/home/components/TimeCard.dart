import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/utils/constants/color_constant.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({required this.time, required this.header, required this.color, super.key});
  final String time;
  final String header;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: context.padding.low,
          decoration: BoxDecoration(color: ColorCommonConstant.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: ColorTextConstant.black)),
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
        ),
      ],
    );
  }
}
