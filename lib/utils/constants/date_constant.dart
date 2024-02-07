import 'package:flutter/material.dart';

@immutable
class DateConstant {
  const DateConstant._();
  static String getValidDate() {
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(2024, 3, 11);
    DateTime endDate = DateTime(2024, 4, 9);

    // Eğer current date belirtilen aralığın dışındaysa, 11 Mart 2024'ü döndür
    if (currentDate.isBefore(startDate) || currentDate.isAfter(endDate)) {
      return "11 ${_getMonthName(startDate.month)} ${_getDayOfWeek(startDate)}";
    }

    // Eğer current date belirtilen aralıkta ise, current date'i döndür
    return "${currentDate.day} ${_getMonthName(currentDate.month)} ${_getDayOfWeek(currentDate)}";
  }

  static _getMonthName(int month) {
    switch (month) {
      case 3:
        return "Mart";
      case 4:
        return "Nisan";
      default:
        return "";
    }
  }

  static String _getDayOfWeek(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "Pazartesi";
      case 2:
        return "Salı";
      case 3:
        return "Çarşamba";
      case 4:
        return "Perşembe";
      case 5:
        return "Cuma";
      case 6:
        return "Cumartesi";
      case 7:
        return "Pazar";
      default:
        return "";
    }
  }
}
