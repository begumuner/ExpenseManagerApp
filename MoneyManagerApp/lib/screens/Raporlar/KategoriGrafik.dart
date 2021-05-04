import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/kategori_harcama.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

import 'package:syncfusion_flutter_charts/charts.dart' as synn;

import 'anasayfa.dart';

class RaporSayfasiKategoriSutun extends StatefulWidget {
  @override
  _RaporSayfasiKategoriSutunState createState() =>
      _RaporSayfasiKategoriSutunState();
}

class _RaporSayfasiKategoriSutunState extends State<RaporSayfasiKategoriSutun> {
  List<Verilerim> verilerimKullan = [];
  List<Verilerim> verilerim = [];
  List<KategoriHarcama> tumKategoriHarcamalar;
  DatabaseHelper databaseHelper;
  int toplamHarcama;
  int toplamHarcamaKullan;
  int toplamGelir;
  int toplamGelirKullan;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    tumKategoriHarcamalar = List<KategoriHarcama>();
    final myFuture = getDefaultLineSeries();
    myFuture.then((value) {
      for (var m = 0; m < value.length; m++) {
        verilerimKullan.add(value[m]);
        //debugPrint("  " + verilerimKullan[m].y.toString());
        //debugPrint(value[m].y.toString());
      }
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
  }

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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
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
      body: ListView(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(24.0),
                color: Colors.white,
              ),
              //color: Colors.white,
              child: synn.SfCartesianChart(
                title: synn.ChartTitle(text: "Kategoriye Göre Giderler"),
                primaryXAxis: synn.CategoryAxis(),
                primaryYAxis: synn.NumericAxis(),
                series: <synn.ChartSeries>[
                  synn.ColumnSeries<Verilerim, String>(
                      dataSource: verilerimKullan,
                      xValueMapper: (Verilerim sales, _) => sales.x,
                      yValueMapper: (Verilerim sales, _) => sales.y,
                      dataLabelSettings: synn.DataLabelSettings(
                        isVisible: true,
                        labelPosition: synn.ChartDataLabelPosition.inside,
                      ))
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                child: myTextItems(
                    "Toplam Harcama", toplamHarcamaKullan.toString()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                child:
                    myTextItems("Toplam Gelir", toplamGelirKullan.toString()),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future getDefaultLineSeries() async {
    var kategoriAdiveMiktariListesi =
        await databaseHelper.kategoriyeGoreHarcamalarListesiniGetir();
    debugPrint(kategoriAdiveMiktariListesi[0].tip);

    Verilerim v0 = Verilerim(kategoriAdiveMiktariListesi[0].tip,
        double.parse(kategoriAdiveMiktariListesi[0].tutar.toString()));
    Verilerim v1 = Verilerim(kategoriAdiveMiktariListesi[1].tip,
        double.parse(kategoriAdiveMiktariListesi[1].tutar.toString()));
    Verilerim v2 = Verilerim(kategoriAdiveMiktariListesi[2].tip,
        double.parse(kategoriAdiveMiktariListesi[2].tutar.toString()));

    verilerim = [v0, v1, v2];

    // debugPrint(verilerim[0].x.toString());
    return verilerim;
  }

  Future toplamHarcamaGetir() async {
    toplamHarcama = await databaseHelper.toplamHarcamalarGetir();
    return toplamHarcama;
  }

  Future toplamGelirlerGetir() async {
    toplamGelir = await databaseHelper.toplamGelirGetir();
    return toplamGelir;
  }
}

class Verilerim {
  Verilerim(this.x, this.y);
  String x;
  double y;
}
