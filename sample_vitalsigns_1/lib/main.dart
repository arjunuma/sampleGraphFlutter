import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

import 'charts/heartRate_chart_util.dart';
import 'charts/temperature_chart_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Vital Signs'),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

class HeartRatePage extends StatefulWidget {
  HeartRatePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HeartRatePageState createState() => _HeartRatePageState();
}

class _HeartRatePageState extends State<HeartRatePage> {
  List<Series> timeHeartRateData;

  @override
  Widget build(BuildContext context) {
    HeartRateChartUtil().getHeartRateChartData().then((timeHeartRateData) {
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

// temperature time widget
class TemperaturePage extends StatefulWidget {
  TemperaturePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TemperaturePageState createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  List<Series> timeTemperatureDate;

  @override
  Widget build(BuildContext context) {
    TemperatureChartUtil()
        .getTemperatureChartData()
        .then((timeTemperatureDate) {
      setState(() {
        this.timeTemperatureDate = timeTemperatureDate;
      });
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: timeTemperatureDate != null
                ? FractionallySizedBox(
                    child: TimeSeriesChart(
                      timeTemperatureDate,
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

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('View heart rate'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HeartRatePage(title: 'Time HeartRate')),
                    );
                  },
                ),
              ],
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('View temperature'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TemperaturePage(title: 'Time Temperature')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
