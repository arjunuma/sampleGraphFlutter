class ReportTimeTemperature {
  final int time;
  final double temperature;

  ReportTimeTemperature({this.time, this.temperature});

  factory ReportTimeTemperature.fromJson(Map<String, dynamic> json) {
    return ReportTimeTemperature(
        time: json['Time(s)'] as int,
        temperature: json['Temperature'] as double);
  }
}
