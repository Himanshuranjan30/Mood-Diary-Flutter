import 'package:flutter/material.dart';
import 'package:moodairy/helpers/mooddata.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:moodairy/models/moodcard.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class MoodChart extends StatefulWidget {
  @override
  _MoodChartState createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {
  List<Color> defaultColorList = [
    Color(0xFFff7675),
    Color(0xFF74b9ff),
    Color(0xFF55efc4),
    Color(0xFFffeaa7),
    Color(0xFFa29bfe),
    Color(0xFFfd79a8),
    Color(0xFFe17055),
    Color(0xFF00b894),
  ];

  double a = 0;
  double b = 0;
  double c = 0;
  double d = 0;
  double e = 0;
  double f = 0;
  double g = 0;
  double h = 0;
  double i = 0;
  double j = 0;
  double k = 0;
  double l = 0;
  double m = 0;
  double n = 0;
  double o = 0;
  double p = 0;
  double q = 0;
  double r = 0;
  double s = 0;

  Map<String, double> dataMap = Map();
  Map<String, double> dataMap2 = Map();
  void initState() {
    super.initState();
    Provider.of<MoodCard>(context, listen: false).data.forEach((element) {
      if (element.moodno == 1)
        a = a + 1;
      else if (element.moodno == 2)
        b = b + 1;
      else if (element.moodno == 3)
        c = c + 1;
      else if (element.moodno == 4)
        d = d + 1;
      else if (element.moodno == 5)
        e = e + 1;
      else
        f = f + 1;
    });

    Provider.of<MoodCard>(context, listen: false).actiname.forEach((element) {
      if (element == 'Sports')
        g = g + 1;
      else if (element == 'Sleep')
        h = h + 1;
      else if (element == 'Shop')
        i = i + 1;
      else if (element == 'Relax')
        j = j + 1;
      else if (element == 'Read')
        k = k + 1;
      else if (element == 'Movies')
        l = l + 1;
      else if (element == 'Gaming')
        m = m + 1;
      else if (element == 'Friends')
        n = n + 1;
      else if (element == 'Family')
        o = o + 1;
      else if (element == 'Excercise')
        p = p + 1;
      else if (element == 'Eat')
        q = q + 1;
      else if (element == 'Date')
        r = r + 1;
      else if (element == 'Clean') s = s + 1;
    });

    dataMap.putIfAbsent("Happy", () => b);
    dataMap.putIfAbsent("Sad", () => c);
    dataMap.putIfAbsent("Angry", () => a);
    dataMap.putIfAbsent("Surprised", () => d);
    dataMap.putIfAbsent("Scared", () => f);
    dataMap.putIfAbsent("Loving", () => e);
    dataMap2.putIfAbsent('Sports', () => g);
    dataMap2.putIfAbsent('Sleep', () => h);
    dataMap2.putIfAbsent('Shop', () => i);
    dataMap2.putIfAbsent('Relax', () => j);
    dataMap2.putIfAbsent('Read', () => k);
    dataMap2.putIfAbsent('Movies', () => l);
    dataMap2.putIfAbsent('Gaming', () => m);
    dataMap2.putIfAbsent('Friends', () => n);
    dataMap2.putIfAbsent('Family', () => o);
    dataMap2.putIfAbsent('Excercise', () => p);
    dataMap2.putIfAbsent('Eat', () => q);
    dataMap2.putIfAbsent('Date', () => r);
    dataMap2.putIfAbsent('Clean', () => s);
  }

  @override
  Widget build(BuildContext context) {
    List<MoodData> data = Provider.of<MoodCard>(context, listen: true).data;
    List<charts.Series<MoodData, String>> series = [
      charts.Series(
        id: 'Moods',
        data: data,
        domainFn: (MoodData series, _) => series.date,
        measureFn: (MoodData series, _) => series.moodno,
        colorFn: (MoodData series, _) => charts.ColorUtil.fromDartColor(
          Color(0xFF74b9ff),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Mood Graph'), backgroundColor: Colors.red),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        children: <Widget>[
          SizedBox(
            height: 108,
            width: 300,
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: (300 - 30) / (108 - 30),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              children: List.generate(
                  6,
                  (index) => MyMoodCard(
                        Text(
                          "${index + 1} - ${[
                            'Angry',
                            'Happy',
                            'Sad',
                            'Surprised',
                            'Loving',
                            'Scared'
                          ][index]}",
                          textAlign: TextAlign.center,
                        ),
                        direction: 1,
                      )),
            ),
          ),
          Container(
            height: 200,
            child: MyMoodCard(
              charts.BarChart(
                series,
                animate: true,
              ),
            ),
          ),
          Container(
            height: 30,
          ),
          Container(
            width: 200,
            child: MyMoodCard(
              PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32.0,
                chartRadius: MediaQuery.of(context).size.width / 2.7,
                chartType: ChartType.disc,
                legendOptions: LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                ),
              ),
            ),
          ),
          Container(
            height: 30,
          ),
          Container(
            width: 200,
            child: MyMoodCard(
              PieChart(
                dataMap: dataMap2,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32.0,
                chartRadius: MediaQuery.of(context).size.width / 2.7,
                chartType: ChartType.disc,
                legendOptions: LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyMoodCard extends StatefulWidget {
  Widget w;
  int direction; //0 - Left, 1 - Right. By default 0
  MyMoodCard(this.w, {this.direction = 0});

  @override
  _MyMoodCardState createState() => _MyMoodCardState();
}

class _MyMoodCardState extends State<MyMoodCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _slideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: widget.w,
          ),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(1 - _slideAnimation.value, 0) *
                (widget.direction == 0 ? -1 : 1) *
                40,
            child: child,
          );
        });
  }
}
