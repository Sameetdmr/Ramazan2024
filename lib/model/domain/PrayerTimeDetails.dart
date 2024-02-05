class PrayerTimeDetails {
  String date;
  List<String> times;

  PrayerTimeDetails({
    required this.date,
    required this.times,
  });

  factory PrayerTimeDetails.fromJson(Map<String, dynamic> json) {
    return PrayerTimeDetails(
      date: json['date'],
      times: List<String>.from(json['times']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'times': times,
    };
  }
}
