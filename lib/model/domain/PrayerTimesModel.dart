import 'package:ramadan/model/domain/PrayerTimeDetails.dart';

class PrayerTimesModel {
  String cityName;
  String region;
  List<PrayerTimeDetails> times;

  PrayerTimesModel({
    required this.cityName,
    required this.region,
    required this.times,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    List<PrayerTimeDetails> timesList = [];
    json['times'].forEach((key, value) {
      timesList.add(PrayerTimeDetails.fromJson({
        'date': key,
        'times': value,
      }));
    });

    return PrayerTimesModel(
      cityName: json['place']['city'],
      region: json['place']['region'],
      times: timesList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> timesListJson = times.map((time) => time.toJson()).toList();

    return {
      'place': {
        'city': cityName,
        'region': region,
      },
      'times': Map.fromIterable(timesListJson, key: (e) => e['date'], value: (e) => e['times']),
    };
  }
}
