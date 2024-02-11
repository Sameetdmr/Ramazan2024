import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridItem {
  GridItem({
    required this.id,
    required this.color,
    required this.iconPath,
    required this.title,
    required this.time,
    required this.isActive,
  });

  final int id;
  final Color color;
  final String iconPath;
  final String title;
  final String time;
  final RxBool isActive;
}
