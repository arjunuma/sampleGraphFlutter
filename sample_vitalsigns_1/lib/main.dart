import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import 'charts/chart_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Vital Signs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Series> timeHeartRateData;

  @override
  Widget build(BuildContext context) {
    ChartUtil().getChartData().then((timeHeartRateData) {
      setState(() {
        this.timeHeartRateData = timeHeartRateData;
      });
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: timeHeartRateData != null
                ? FractionallySizedBox(
                    child: TimeSeriesChart(
                      timeHeartRateData,
                      defaultRenderer: new LineRendererConfig(
                          includeArea: true, stacked: true),
                      animate: false,
                      domainAxis:
                          new DateTimeAxisSpec(renderSpec: NoneRenderSpec()),
                    ),
                    heightFactor: .5,
                  )
                : CircularProgressIndicator()));
  }
}
