class ReportTimeHeartRate {
  final int time;
  final int heartRate;

  ReportTimeHeartRate({this.time, this.heartRate});

  factory ReportTimeHeartRate.fromJson(Map<String, dynamic> json) {
    return ReportTimeHeartRate(
        time: json['Time(s)'] as int, heartRate: json['HeartRate'] as int);
  }
}
