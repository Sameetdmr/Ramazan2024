import 'package:flutter/material.dart';
import 'package:get/get.dart';

@immutable
final class TimeManager {
  static List<RxBool> calculatePrayerTimes(List<String> times) {
    final now = DateTime.now();
    final isActiveList = List<RxBool>.filled(times.length, false.obs); // İlk olarak tüm zamanları false olarak işaretliyoruz.

    // Zaman farklarını hesapla daha sonra listeye ekle
    final remainingTimes = <Duration>[];
    for (var i = 0; i < times.length; i++) {
      final currentTime = _parseTime(times[i], now);
      final currentDifference = currentTime.difference(now);
      remainingTimes.add(currentDifference);
    }

    // Negatif olmayan en küçük farkı bul
    var closestDifference = const Duration(days: 1); // 1 gün olarak başlangıç değeri
    var closestIndex = -1;

    for (var i = 0; i < remainingTimes.length; i++) {
      if (remainingTimes[i].inSeconds >= 0 && remainingTimes[i].inSeconds < closestDifference.inSeconds) {
        closestDifference = remainingTimes[i];
        closestIndex = i;
      }
    }

    // En yakın olanı true, diğerlerini false yap
    if (closestIndex != -1) {
      isActiveList[closestIndex] = true.obs;
    }

    return isActiveList;
  }

  static int remainingSeconds(String time) {
    final now = DateTime.now();
    final targetTime = _parseTime(time, now);

    // Zaman farkını hesapla
    final difference = targetTime.difference(now);

    // Negatif değilse saniye cinsinden dön, negatifse 0 dön
    return difference.isNegative ? 0 : difference.inSeconds;
  }

  static DateTime _parseTime(String time, DateTime now) {
    final parts = time.split(':').map(int.parse).toList();

    var targetTime = DateTime(now.year, now.month, now.day, parts[0], parts[1]);

    // Eğer hedef zaman şu anki zamandan geçmişse bir sonraki güne atla
    if (targetTime.isBefore(now)) {
      targetTime = targetTime.add(const Duration(days: 1));
    }

    return targetTime;
  }
}
