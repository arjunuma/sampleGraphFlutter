import 'package:charts_flutter/flutter.dart';
import 'package:sample_vitalsigns_1/repositories/temperatureRepository.dart';
import 'package:sample_vitalsigns_1/models/timeTemperature.dart';

class TemperatureChartUtil {
  Future<List<Series>> getTemperatureChartData() async {
    var reports = await ReportRepository().getReports().then((reports) {
      List<TimeTemperature> temperatureData = [];

      reports.forEach((report) {
        temperatureData.add(new TimeTemperature(
            convertToDateTime(report.time), report.temperature));
      });

      return _createTemperatureChartData(temperatureData);
    });

    return reports;
  }

  static List<Series> _createTemperatureChartData(
      List<TimeTemperature> timeTemperatureData) {
    var data = [
      new Series<TimeTemperature, DateTime>(
        id: 'Desktop',
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
        domainFn: (TimeTemperature timeTemperatureData, _) =>
            timeTemperatureData.time,
        measureFn: (TimeTemperature timeTemperatureData, _) =>
            timeTemperatureData.temperature,
        data: timeTemperatureData,
      ),
    ];

    return data;
  }
}

convertToDateTime(int time) {
  return DateTime.fromMillisecondsSinceEpoch(time * 1000);
}
