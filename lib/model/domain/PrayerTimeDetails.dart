// ignore_for_file: public_member_api_docs

final class PrayerTimeDetails {
  PrayerTimeDetails({
    required this.date,
    required this.times,
  });

  factory PrayerTimeDetails.fromJson(Map<String, dynamic> json) {
    return PrayerTimeDetails(
      date: json['date'] as String,
      times: List<String>.from(json['times'] as List<String>),
    );
  }
  final String date;
  final List<String> times;

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'times': times,
    };
  }
}
