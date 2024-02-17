import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

@immutable
class ColorBackgroundConstant {
  const ColorBackgroundConstant._();

  static Color white = HexColor("#FFFFFF");

  static Color black = HexColor("#000000");
}

@immutable
class ColorTextConstant {
  const ColorTextConstant._();

  static Color forestMaid = HexColor("#5CB85C");

  static Color white = HexColor("#FFFFFF");

  static Color black = HexColor("#000000");

  static Color orangeAccent = Colors.orangeAccent;
}

@immutable
class PrayerTimeColor {
  static const Color imsak = Color(0xFF4B0082);
  static const Color gunes = Color(0xFFFFD700);
  static const Color ogle = Color(0xFF228B22);
  static const Color ikindi = Color(0xFFFF4500);
  static const Color iftar = Color(0xFF8B4513);
  static const Color yatsi = Color(0xFF00008B);
}

@immutable
class ColorCommonConstant {
  const ColorCommonConstant._();

  static Color transparent = Colors.transparent;

  static Color white = HexColor("#FFFFFF");

  static Color black = HexColor("#000000");

  static Color saddleBrown = Color(0xFF8B4513);
}
