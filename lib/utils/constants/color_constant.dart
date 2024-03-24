import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

@immutable
final class ColorBackgroundConstant {
  const ColorBackgroundConstant._();

  static Color white = HexColor('#FFFFFF');
  static Color black = HexColor('#000000');
}

@immutable
final class ColorTextConstant {
  const ColorTextConstant._();

  static Color forestMaid = HexColor('#5CB85C');
  static Color white = HexColor('#FFFFFF');
  static Color black = HexColor('#000000');
  static Color orangeAccent = HexColor('#FF9800');
}

@immutable
final class PrayerTimeColor {
  const PrayerTimeColor._();

  static Color imsak = HexColor('#4B0082');
  static Color gunes = HexColor('#FFD700');
  static Color ogle = HexColor('#228B22');
  static Color ikindi = HexColor('#FF4500');
  static Color iftar = HexColor('#8B4513');
  static Color yatsi = HexColor('#00008B');
}

@immutable
final class ColorCommonConstant {
  const ColorCommonConstant._();

  static Color transparent = Colors.transparent;
  static Color white = HexColor('#FFFFFF');
  static Color black = HexColor('#000000');
  static Color saddleBrown = HexColor('#8B4513');

  //TextField
  static Color grey = HexColor('#9E9E9E');
  static Color greyShade100 = HexColor('#F5F5F5');
  static Color red = HexColor('#F44336');

  //BottomNavigation
  static Color blue = HexColor('#2196F3');
}
