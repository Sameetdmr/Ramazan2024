import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';

class CountdownTimerWidget extends StatelessWidget {
  final String timeRemaining;
  final String title;
  final Color color;

  CountdownTimerWidget({required this.title, required this.timeRemaining, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding.medium,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Text(
            timeRemaining,
            style: context.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
