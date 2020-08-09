import 'package:sample_vitalsigns_1/models/timeHeartRate.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:sample_vitalsigns_1/jsonParser/reportRepository.dart';

class ChartUtil {
  Future<List<Series>> getChartData() async {
    var reports = await ReportRepository().getReports().then((reports) {
      List<TimeHeartRate> vibrationData = [];

      reports.forEach((report) {
        vibrationData.add(new TimeHeartRate(
            convertToDateTime(report.time), report.heartRate));
      });

      return _createChartData(vibrationData);
    });

    return reports;
  }

  static List<Series> _createChartData(List<TimeHeartRate> timeHeartRateData) {
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
