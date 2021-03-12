import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/kategori_harcama.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pie_chart/pie_chart.dart';

import 'anasayfa.dart';

class RaporOneMoreItem extends StatefulWidget {
  @override
  _RaporOneMoreItemState createState() => _RaporOneMoreItemState();
}

class _RaporOneMoreItemState extends State<RaporOneMoreItem> {
  //var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];
  DatabaseHelper databaseHelper;
  List<double> harcamaMiktarListesi = [];
  List<double> harcamaDoubleListesi = [];
  int toplamHarcama;
  int toplamHarcamaKullan;
  int toplamGelir;
  int toplamGelirKullan;
  int toplamVarlik;
  int toplamVarlikKullan;
  List<Color> colorsList = [];
  Map<String, double> dataMap = {};
  Map<String, double> dataMapKullan = {"okul": 22, "market": 44};

  List<KategoriHarcama> tumKategoriHarcamalar;
  int hesaplarToplamiKullan = 0;

  Material myTextItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material mychart1Items(String title, String priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      priceVal,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: harcamaDoubleListesi,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material mychart2Items(String title, String priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      priceVal,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: data1,
                      fillMode: FillMode.below,
                      fillGradient: new LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.amber[800], Colors.amber[200]],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tumKategoriHarcamalar = List<KategoriHarcama>();
    databaseHelper = DatabaseHelper();
    colorsList = [Colors.red, Colors.purple, Colors.amber];
    final myFuture = harcamaBilgileriniGetir();
    myFuture.then((value) {
      harcamaDoubleListesi = value;
      setState(() {});
    });
    final myFuture2 = toplamHarcamaGetir();
    myFuture2.then((value) {
      toplamHarcamaKullan = value;
      setState(() {});
    });
    debugPrint("gider" + toplamHarcamaKullan.toString());
    final myFuture3 = toplamGelirlerGetir();
    myFuture3.then((value) {
      toplamGelirKullan = value;
      setState(() {});
    });
    debugPrint("gelir" + toplamGelirKullan.toString());
    final myFuture4 = hesabaGoreHarcamaGetir();
    myFuture4.then((value) {
      dataMapKullan = value;
      setState(() {});
    });
    final myFuture5 = hesapToplamGetir();
    myFuture5.then((value) {
      hesaplarToplamiKullan = value;
      setState(() {});
    });
    final myFuture6 = toplamVarlikGetir();
    myFuture6.then((value) {
      toplamVarlikKullan = value;
      setState(() {});
    });
  }

  Future harcamaBilgileriniGetir() async {
    var harcamaMapi = await databaseHelper.giderGetir();
    for (Map okunanHarcamaMapi in harcamaMapi) {
      harcamaMiktarListesi
          .add(double.parse(okunanHarcamaMapi["harcamaTutar"].toString()));
    }
    //debugPrint(harcamaMiktarListesi.toString());
    return harcamaMiktarListesi;
  }

  Future toplamHarcamaGetir() async {
    toplamHarcama = await databaseHelper.toplamHarcamalarGetir();
    return toplamHarcama;
  }

  Future toplamGelirlerGetir() async {
    toplamGelir = await databaseHelper.toplamGelirGetir();
    return toplamGelir;
  }

  Future hesabaGoreHarcamaGetir() async {
    var hesapAdiveMiktariListesi =
        await databaseHelper.hesabaGoreHarcamalarListesiniGetir();
    // debugPrint(hesapAdiveMiktariListesi[0].tip);

    dataMap = {
      hesapAdiveMiktariListesi[0].tip:
          double.parse(hesapAdiveMiktariListesi[0].tutar.toString()),
      hesapAdiveMiktariListesi[1].tip:
          double.parse(hesapAdiveMiktariListesi[1].tutar.toString()),
      hesapAdiveMiktariListesi[2].tip:
          double.parse(hesapAdiveMiktariListesi[2].tutar.toString()),
    };

    // debugPrint(verilerim[0].x.toString());
    return dataMap;
  }

  Future hesapToplamGetir() async {
    var hesaplarToplami = 0;
    var hesapAdiveMiktariListesi = await databaseHelper.hesapListesiniGetir();

    for (var i = 0; i < hesapAdiveMiktariListesi.length; i++) {
      hesaplarToplami =
          hesaplarToplami + hesapAdiveMiktariListesi[i].hesapMiktari;
    }

    return hesaplarToplami;
  }

  Future toplamVarlikGetir() async {
    int varlikIcinToplamGelir = await toplamGelirlerGetir();
    int varlikIcinToplamGider = await toplamHarcamaGetir();
    toplamVarlik = varlikIcinToplamGelir - varlikIcinToplamGider;
    return toplamVarlik;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Grafikler',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back, color: Colors.black,
            //size: 50.0,
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RaporlarSayfasi()));
          },
        ),
      ),
      body: Container(
        color: Color(0xffE5E5E5),
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: mychart1Items("Harcamalarım", "", ""),
            ),
            /* Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child:
                  myTextItems("Toplam Harcama", toplamHarcamaKullan.toString()),
            ),
            */
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: myTextItems(
                  "Toplam Hesaplarım", hesaplarToplamiKullan.toString()),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: myTextItems(
                  "Toplam Varlıklarım", toplamVarlikKullan.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChart(
                dataMap: dataMapKullan,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 2.3,
                colorList: colorsList,
                initialAngleInDegree: 0,
                chartType: ChartType.disc,
                ringStrokeWidth: 32,
                centerText: "Hesaplar",
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  showLegends: true,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                ),
              ),
            ),

            /*  Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: myTextItems("Toplam Gelir", toplamGelirKullan.toString()),
            ),
            */
          ],
          staggeredTiles: [
            StaggeredTile.extent(4, 250.0),
            StaggeredTile.extent(2, 120.0),
            StaggeredTile.extent(2, 120.0),
            StaggeredTile.extent(4, 250.0),
            //StaggeredTile.extent(4, 250.0),
          ],
        ),
      ),
    );
  }
}
