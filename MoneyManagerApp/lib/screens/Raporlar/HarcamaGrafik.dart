import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

import 'anasayfa.dart';

List<Verilerim> verilerimKullan = [];
List<Verilerim> verilerim = [];
DatabaseHelper databaseHelper;

class RaporSayfasiGiderSutunGelismis extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => RaporSayfasiGiderSutunGelismisState();
}

class RaporSayfasiGiderSutunGelismisState
    extends State<RaporSayfasiGiderSutunGelismis> {
  final Color barBackgroundColor = Colors.white;
  final Duration animDuration = const Duration(milliseconds: 250);
  List<Verilerim> verilerimKullan = [
    Verilerim("x", 100),
    Verilerim("x", 100),
    Verilerim("x", 100),
    Verilerim("x", 100),
    Verilerim("x", 100),
    Verilerim("x", 100),
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
    final myFuture = getDefaultLineSeries();
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
        title: Text('Aylık Harcama Grafiği ',
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
                    Text('Harcamalar',
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

  Future getDefaultLineSeries() async {
    var harcamaMapi = await databaseHelper.giderGetir();
    int ocak1 = 0;
    int subat2 = 0;
    int mart3 = 0;
    int nisan4 = 0;
    int mayis5 = 0;
    int haziran6 = 0;
    int temmuz7 = 0;
    int agustos8 = 0;
    int eylul9 = 0;
    int ekim10 = 0;
    int kasim11 = 0;
    int aralik12 = 0;

    for (Map okunanHarcamaMapi in harcamaMapi) {
      harcamaTarihListesi.add(okunanHarcamaMapi["harcamaTarih"]);
      harcamaMiktarListesi.add(okunanHarcamaMapi["harcamaTutar"]);
    }

    for (var i = 0; i < harcamaTarihListesi.length; i++) {
      String temp = harcamaTarihListesi[i];
      harcamaTarihListesiDuzgunFormatta.add(temp.substring(5, 7));
    }

    for (var z = 0; z < harcamaTarihListesiDuzgunFormatta.length; z++) {
      if (harcamaTarihListesiDuzgunFormatta[z] == "01") {
        ocak1 = ocak1 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "02") {
        subat2 = subat2 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "03") {
        mart3 = mart3 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "04") {
        nisan4 = nisan4 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "05") {
        mayis5 = mayis5 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "06") {
        haziran6 = haziran6 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "07") {
        temmuz7 = temmuz7 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "08") {
        agustos8 = agustos8 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "09") {
        eylul9 = eylul9 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "10") {
        ekim10 = ekim10 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "11") {
        kasim11 = kasim11 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "12") {
        aralik12 = aralik12 + harcamaMiktarListesi[z];
      }
    }

    harcamaAylikListe = [
      ocak1,
      subat2,
      mart3,
      nisan4,
      mayis5,
      haziran6,
      temmuz7,
      agustos8,
      eylul9,
      ekim10,
      kasim11,
      aralik12
    ];
    debugPrint(harcamaAylikListe.toString());

    debugPrint(harcamaTarihListesiDuzgunFormatta.toString());
    debugPrint(harcamaMiktarListesi.toString());

    Verilerim v1 =
        Verilerim("1", double.parse(harcamaAylikListe[0].toString()));
    Verilerim v2 =
        Verilerim("2", double.parse(harcamaAylikListe[1].toString()));
    Verilerim v3 =
        Verilerim("3", double.parse(harcamaAylikListe[2].toString()));
    Verilerim v4 =
        Verilerim("4", double.parse(harcamaAylikListe[3].toString()));
    Verilerim v5 =
        Verilerim("5", double.parse(harcamaAylikListe[4].toString()));
    Verilerim v6 =
        Verilerim("6", double.parse(harcamaAylikListe[5].toString()));
    Verilerim v7 =
        Verilerim("7", double.parse(harcamaAylikListe[6].toString()));
    Verilerim v8 =
        Verilerim("8", double.parse(harcamaAylikListe[7].toString()));
    Verilerim v9 =
        Verilerim("9", double.parse(harcamaAylikListe[8].toString()));
    Verilerim v10 =
        Verilerim("10", double.parse(harcamaAylikListe[9].toString()));
    Verilerim v11 =
        Verilerim("11", double.parse(harcamaAylikListe[10].toString()));
    Verilerim v12 =
        Verilerim("12", double.parse(harcamaAylikListe[11].toString()));

    verilerim = [
      v1,
      v2,
      v3,
      v4,
      v5,
      v6,
      v7,
      v8,
      v9,
      v10,
      v11,
      v12,
    ];

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

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
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
          case 6:
            return makeGroupData(
                6, double.parse(verilerimKullan[6].y.toString()),
                isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(
                7, double.parse(verilerimKullan[7].y.toString()),
                isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(
                8, double.parse(verilerimKullan[8].y.toString()),
                isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(
                9, double.parse(verilerimKullan[9].y.toString()),
                isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(
                10, double.parse(verilerimKullan[10].y.toString()),
                isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(
                11, double.parse(verilerimKullan[11].y.toString()),
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
                  weekDay = 'Ocak';
                  break;
                case 1:
                  weekDay = 'Şubat';
                  break;
                case 2:
                  weekDay = 'Mart';
                  break;
                case 3:
                  weekDay = 'Nisan';
                  break;
                case 4:
                  weekDay = 'Mayıs';
                  break;
                case 5:
                  weekDay = 'Haziran';
                  break;
                case 6:
                  weekDay = 'Temmuz';
                  break;
                case 7:
                  weekDay = 'Ağustos';
                  break;
                case 8:
                  weekDay = 'Eylül';
                  break;
                case 9:
                  weekDay = 'Ekim';
                  break;
                case 10:
                  weekDay = 'Kasım';
                  break;
                case 11:
                  weekDay = 'Aralık';
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
              case 6:
                return 'T';
              case 7:
                return 'A';
              case 8:
                return 'E';
              case 9:
                return 'E';
              case 10:
                return 'K';
              case 11:
                return 'A';
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
              case 6:
                return 'T';
              case 7:
                return 'A';
              case 8:
                return 'E';
              case 9:
                return 'E';
              case 10:
                return 'K';
              case 11:
                return 'A';
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
      barGroups: List.generate(12, (i) {
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
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 7:
            return makeGroupData(7, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 8:
            return makeGroupData(8, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 9:
            return makeGroupData(9, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 10:
            return makeGroupData(10, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 11:
            return makeGroupData(11, Random().nextInt(15).toDouble() + 6,
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
