import 'package:sample_vitalsigns_1/models/timeHeartRate.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:sample_vitalsigns_1/repositories/heartRateRepository.dart';

class HeartRateChartUtil {
  Future<List<Series>> getHeartRateChartData() async {
    var reports = await ReportRepository().getReports().then((reports) {
      List<TimeHeartRate> vibrationData = [];

      reports.forEach((report) {
        vibrationData.add(new TimeHeartRate(
            convertToDateTime(report.time), report.heartRate));
      });

      return _createHeartRateChartData(vibrationData);
    });

    return reports;
  }

  static List<Series> _createHeartRateChartData(
      List<TimeHeartRate> timeHeartRateData) {
    var data = [
      new Series<TimeHeartRate, DateTime>(
        id: 'Desktop',
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
        domainFn: (TimeHeartRate timeHeartRateData, _) =>
            timeHeartRateData.time,
        measureFn: (TimeHeartRate timeHeartRateData, _) =>
            timeHeartRateData.heartRate,
        data: timeHeartRateData,
      ),
    ];

    return data;
  }
}

convertToDateTime(int time) {
  return DateTime.fromMillisecondsSinceEpoch(time * 1000);
}
