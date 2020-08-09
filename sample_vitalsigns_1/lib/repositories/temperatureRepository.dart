import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sample_vitalsigns_1/models/reports/reportTimeTemperature.dart';

class ReportRepository {
  Future<List<ReportTimeTemperature>> getReports() async {
    String jsonString = await _loadFromAsset();
    return parseReports(jsonString);
  }

  List<ReportTimeTemperature> parseReports(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ReportTimeTemperature>(
            (json) => ReportTimeTemperature.fromJson(json))
        .toList();
  }

  Future<String> _loadFromAsset() async {
    return await rootBundle
        .loadString("assets/60_mins_num_covid_case_data.json");
  }
}
