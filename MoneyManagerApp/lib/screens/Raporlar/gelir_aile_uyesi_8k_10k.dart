import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

import 'anasayfa.dart';
import 'package:xml/xml.dart' as xml;

List<Verilerim> verilerimKullan = [];
List<Verilerim> verilerim = [];
DatabaseHelper databaseHelper;

class GelirAileUyesi810 extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => GelirAileUyesi810State();
}

class GelirAileUyesi810State extends State<GelirAileUyesi810> {
  final Color barBackgroundColor = Colors.white;
  final Duration animDuration = const Duration(milliseconds: 250);
  List<Verilerim> verilerimKullan = [
    Verilerim("x", 100),
    Verilerim("x", 100),
    Verilerim("x", 100),
    Verilerim("x", 100),
    Verilerim("x", 100),
    Verilerim("x", 100),
  ];
  List<Verilerim> verilerim = [];
  DatabaseHelper databaseHelper;

  int touchedIndex;

  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    final myFuture = getDefaultLineSeries(context);
    myFuture.then((value) {
      verilerimKullan = value;
      //  debugPrint(value.toString());
      // for (var m = 0; m < value.length; m++) {
      // verilerimKullan.add(value[m]);
      //  debugPrint("  " + verilerimKullan[m].y.toString());
      // debugPrint(value[m].y.toString());
      //}
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Aile Üyesi Sayısına Göre Giderler ',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            //size: 50.0,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RaporlarSayfasi()));
          },
        ),
      ),
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text('Gelir: 8000-10000',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        )),
                    const SizedBox(
                      height: 38,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          isPlaying ? randomData() : mainBarData(),
                          swapAnimationDuration: animDuration,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isPlaying = !isPlaying;
                        if (isPlaying) {
                          refreshState();
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> harcamaTarihListesi = [];
  List<String> harcamaTarihListesiDuzgunFormatta = [];
  List<int> harcamaMiktarListesi = [];
  List<int> harcamaAylikListe = [];

  Future getDefaultLineSeries(BuildContext context) async {
    String xmlString = await DefaultAssetBundle.of(context)
        .loadString("assets/ai/gelir_aileUyesi.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("tahmin810");

    var v111 = elements.map((element) {
      return Verilerim("8000-10000-1",
          double.parse(element.findElements("tahmin13").first.text));
    }).toList();
    var v222 = elements.map((element) {
      return Verilerim("8000-10000-2",
          double.parse(element.findElements("tahmin14").first.text));
    }).toList();
    var v333 = elements.map((element) {
      return Verilerim("8000-10000-3",
          double.parse(element.findElements("tahmin15").first.text));
    }).toList();
    var v444 = elements.map((element) {
      return Verilerim("8000-10000-4",
          double.parse(element.findElements("tahmin16").first.text));
    }).toList();
    var v555 = elements.map((element) {
      return Verilerim("8000-10000-5",
          double.parse(element.findElements("tahmin17").first.text));
    }).toList();
    var v666 = elements.map((element) {
      return Verilerim("8000-10000-6",
          double.parse(element.findElements("tahmin18").first.text));
    }).toList();
    var v1yS = v111[0].y.toString().substring(0, 7);
    var v2yS = v222[0].y.toString().substring(0, 7);
    var v3yS = v333[0].y.toString().substring(0, 7);
    var v4yS = v444[0].y.toString().substring(0, 7);
    var v5yS = v555[0].y.toString().substring(0, 7);
    var v6yS = v666[0].y.toString().substring(0, 7);

    Verilerim v1 = Verilerim("1", double.parse(v1yS));
    Verilerim v2 = Verilerim("2", double.parse(v2yS));
    Verilerim v3 = Verilerim("3", double.parse(v3yS));
    Verilerim v4 = Verilerim("4", double.parse(v4yS));
    Verilerim v5 = Verilerim("5", double.parse(v5yS));
    Verilerim v6 = Verilerim("6", double.parse(v6yS));

    verilerim = [
      v1,
      v2,
      v3,
      v4,
      v5,
      v6,
    ];

    debugPrint("afadsfsafasf  " + v222[0].y.toString());
    //verilerim = [v1,v2,v3,v4,v5,v6]
    return verilerim;
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.amber,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.blue[800]] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(6, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0, double.parse(verilerimKullan[0].y.toString()),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(
                1, double.parse(verilerimKullan[1].y.toString()),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(
                2, double.parse(verilerimKullan[2].y.toString()),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(
                3, double.parse(verilerimKullan[3].y.toString()),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(
                4, double.parse(verilerimKullan[4].y.toString()),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(
                5, double.parse(verilerimKullan[5].y.toString()),
                isTouched: i == touchedIndex);

          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.black,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '1 kişilik';
                  break;
                case 1:
                  weekDay = '2 kişilik';
                  break;
                case 2:
                  weekDay = '3 kişilik';
                  break;
                case 3:
                  weekDay = '4 kişilik';
                  break;
                case 4:
                  weekDay = '5 kişilik';
                  break;
                case 5:
                  weekDay = '6 kişilik';
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.white));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '1';
              case 1:
                return '2';
              case 2:
                return '3';
              case 3:
                return '4';
              case 4:
                return '5';
              case 5:
                return '5+';

              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'O';
              case 1:
                return 'Ş';
              case 2:
                return 'M';
              case 3:
                return 'N';
              case 4:
                return 'M';
              case 5:
                return 'H';

              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(6, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);

          default:
            return null;
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}

class Verilerim {
  Verilerim(this.x, this.y);
  String x;
  double y;
}
