// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'package:ramadan/model/domain/PrayerTimeDetails.dart';

class PrayerTimesModel {
  PrayerTimesModel({
    required this.cityName,
    required this.region,
    required this.times,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    final timesList = <PrayerTimeDetails>[];
    json['times'].forEach((String key, dynamic value) {
      timesList.add(
        PrayerTimeDetails.fromJson({
          'date': key,
          'times': value,
        }),
      );
    });

    return PrayerTimesModel(
      cityName: json['place']['city'] as String,
      region: json['place']['region'] as String,
      times: timesList,
    );
  }
  final String cityName;
  final String region;
  final List<PrayerTimeDetails> times;

  Map<String, dynamic> toJson() {
    final timesListJson = times.map((time) => time.toJson()).toList();

    return {
      'place': {
        'city': cityName,
        'region': region,
      },
      'times': {for (final e in timesListJson) e['date']: e['times']},
    };
  }
}
