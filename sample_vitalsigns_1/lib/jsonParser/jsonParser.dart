import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> _loadCovidData() async {
  return await rootBundle.loadString('assets/60_mins_num_covid_case_data.json');
  //return await rootBundle.loadString('assets/test.json');
}

Future loadCovidData() async {
  String jsonCovid = await _loadCovidData();
  print(jsonCovid);
}
