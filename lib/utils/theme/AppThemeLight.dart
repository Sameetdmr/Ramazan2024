// ignore_for_file: prefer_constructors_over_static_methods

import 'package:flutter/material.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/theme/CustomTextTheme.dart';

class AppThemeLight {
  AppThemeLight._init(this.context);
  final BuildContext context;

  static AppThemeLight? _instance;

  static AppThemeLight getInstance(BuildContext context) {
    _instance ??= AppThemeLight._init(context);
    return _instance!;
  }

  ThemeData get theme => ThemeData(
        primaryTextTheme: _textThemes,
        textTheme: _textThemes,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        appBarTheme: appBarTheme,
      );

  AppBarTheme get appBarTheme {
    return ThemeData.light().appBarTheme.copyWith(
          backgroundColor: ColorCommonConstant.transparent,
          elevation: 0,
          centerTitle: false,
        );
  }

  TextTheme get _textThemes {
    return ThemeData.light().textTheme.copyWith(
          bodyMedium: CustomTextTheme(context).bodyMedium,
          titleMedium: CustomTextTheme(context).titleMedium,
          labelMedium: CustomTextTheme(context).labelMedium,
          bodySmall: CustomTextTheme(context).bodySmall,
          headlineMedium: CustomTextTheme(context).headlineMedium,
          labelSmall: CustomTextTheme(context).labelSmall,
        );
  }
}
