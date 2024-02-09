import 'package:get/get.dart';
import 'package:ramadan/utils/constants/string_constant.dart';

class DateTimeFormatter {
  RxString formatTodayDate() {
    DateTime today = DateTime.now();

    // Türkçe gün isimleri için sabit bir liste oluştur
    List<String> dayNames = [
      StringHomeConstant.mon,
      StringHomeConstant.tue,
      StringHomeConstant.wed,
      StringHomeConstant.thu,
      StringHomeConstant.fri,
      StringHomeConstant.sat,
      StringHomeConstant.sun,
    ];

    // Tarih bilgisini oluşturulan listeye göre formatla
    String formattedDate = '${dayNames[today.weekday - 1]}, ${today.day} ${_getMonth(today.month)}';

    return formattedDate.obs;
  }

  String _getMonth(int month) {
    // Türkçe ay isimleri için sabit bir liste oluştur
    List<String> monthNames = [
      StringHomeConstant.jan,
      StringHomeConstant.feb,
      StringHomeConstant.mar,
      StringHomeConstant.apr,
      StringHomeConstant.may,
      StringHomeConstant.jun,
      StringHomeConstant.jul,
      StringHomeConstant.aug,
      StringHomeConstant.sep,
      StringHomeConstant.oct,
      StringHomeConstant.nov,
      StringHomeConstant.dec,
    ];

    return monthNames[month - 1];
  }
}
