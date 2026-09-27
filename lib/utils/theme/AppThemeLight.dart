import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan/utils/constants/color_constant.dart';

abstract final class AppThemeLight {
  static ThemeData get theme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorTextConstant.forestMaid,
      ),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      textTheme: GoogleFonts.nunitoTextTheme(),
    );

    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: ColorCommonConstant.transparent,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }

  static ThemeData getInstance(BuildContext context) => theme;
}
