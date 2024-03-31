import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextTheme {
  CustomTextTheme(this.context);
  final BuildContext context;

  TextStyle get bodyMedium => context.textTheme.bodyMedium!;

  TextStyle get labelMedium => context.textTheme.labelMedium!;

  TextStyle get titleMedium => context.textTheme.titleMedium!;

  TextStyle get bodySmall => context.textTheme.bodySmall!;

  TextStyle get headlineMedium => context.textTheme.headlineMedium!;

  TextStyle get labelSmall => context.textTheme.labelSmall!;
}
