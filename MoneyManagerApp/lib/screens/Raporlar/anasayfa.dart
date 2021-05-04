import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Hesaplar/hesapListesi.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/TahminSayfalari/muhendis_10000_15000.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/TahminSayfalari/muhendis_15000_20000.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/TahminSayfalari/muhendis_20000_50000.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/TahminSayfalari/muhendis_2000_5000.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/TahminSayfalari/muhendis_5000_8000.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/TahminSayfalari/muhendis_8000_10000.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/ekstra_anasayfa.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/gelir_aileUyesi_2k_5k.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/gelir_aile_uyesi_10k_15k.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/gelir_aile_uyesi_15k_20k.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/gelir_aile_uyesi_20k_50k.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/gelir_aile_uyesi_5k_8k.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/gelir_aile_uyesi_8k_10k.dart';

import 'package:flutter_firebase_dersleri/screens/Raporlar/style.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'HarcamaGrafik.dart';
import 'KategoriGrafik.dart';
import 'TahminSayfalari/avukat_10000_15000.dart';
import 'TahminSayfalari/avukat_15000_20000.dart';
import 'TahminSayfalari/avukat_20000_50000.dart';
import 'TahminSayfalari/avukat_2000_5000.dart';
import 'TahminSayfalari/avukat_5000_8000.dart';
import 'TahminSayfalari/avukat_8000_10000.dart';
import 'TahminSayfalari/doctor_10000_15000.dart';
import 'TahminSayfalari/doctor_15000_20000.dart';
import 'TahminSayfalari/doctor_20000_50000.dart';
import 'TahminSayfalari/doctor_2000_5000.dart';
import 'TahminSayfalari/doctor_5000_8000.dart';
import 'TahminSayfalari/doctor_8000_10000.dart';
import 'TahminSayfalari/memur_10000_15000.dart';
import 'TahminSayfalari/memur_15000_20000.dart';
import 'TahminSayfalari/memur_20000_50000.dart';
import 'TahminSayfalari/memur_2000_5000.dart';
import 'TahminSayfalari/memur_5000_8000.dart';
import 'TahminSayfalari/memur_8000_10000.dart';
import 'TahminSayfalari/mimar_10000_15000.dart';
import 'TahminSayfalari/mimar_15000_20000.dart';
import 'TahminSayfalari/mimar_20000_50000.dart';
import 'TahminSayfalari/mimar_2000_5000.dart';
import 'TahminSayfalari/mimar_5000_8000.dart';
import 'TahminSayfalari/mimar_8000_10000.dart';
import 'TahminSayfalari/serbest_10000_15000.dart';
import 'TahminSayfalari/serbest_15000_20000.dart';
import 'TahminSayfalari/serbest_20000_50000.dart';
import 'TahminSayfalari/serbest_2000_5000.dart';
import 'TahminSayfalari/serbest_5000_8000.dart';
import 'TahminSayfalari/serbest_8000_10000.dart';
import 'hesapGrafik.dart';

class RaporlarSayfasi extends StatefulWidget {
  @override
  _RaporlarSayfasiState createState() => _RaporlarSayfasiState();
}

class _RaporlarSayfasiState extends State<RaporlarSayfasi> {
  DatabaseHelper databaseHelper;
  var sorular;
  var meslek;
  var maas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper = DatabaseHelper();
    databaseHelper.soruGetir().then((value) {
      setState(() {
        meslek = value[value.length - 1]["meslek"];
        maas = value[value.length - 1]["aylikGelir"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Raporlar',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            );
          },
        ),
      ),
      backgroundColor: Color(0XFFFEFEFE),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _introCard(),
            _title('Grafikler'),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: _menuItem('Aylık Toplam \nHarcamalar',
                      FontAwesomeIcons.signal, blueGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RaporSayfasiGiderSutunGelismis()));
                  },
                ),
                GestureDetector(
                  child: _menuItem('Kategoriye Göre\nHarcamalar',
                      FontAwesomeIcons.chartPie, darkRedGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RaporSayfasiKategoriSutun()));
                  },
                ),
                GestureDetector(
                  child: _menuItem('Harcamalar ve \nHesaplar',
                      FontAwesomeIcons.coins, yellowGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RaporOneMoreItem()));
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            _title('Yapay Zeka Tahminleri'),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: _promotionCard('$meslek kisilik $maas gelir',
                      'assets/images/profit.png'),
                  onTap: () {
                    if (maas == "2000 - 5000") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GelirAileUyesi25()));
                    }
                    if (maas == "5000 - 8000") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GelirAileUyesi58()));
                    }
                    if (maas == "8000 - 10000") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GelirAileUyesi810()));
                    }
                    if (maas == "10000 - 15000") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GelirAileUyesi1015()));
                    }
                    if (maas == "15000 - 20000") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GelirAileUyesi1520()));
                    }
                    if (maas == "20000 - 50000") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GelirAileUyesi2050()));
                    }
                  },
                ),
                GestureDetector(
                  child: _promotionCard('', 'assets/images/cash-back.png'),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EkstraAnaSayfa()));
                  },
                ),
              ],
            ),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  _promotionCard(String title, String assetUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 110,
          width: MediaQuery.of(context).size.width / 2 - 30,
          decoration: BoxDecoration(
              color: Color(0XFFDDFF3FF),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(assetUrl, height: 80, fit: BoxFit.fitHeight),
          ),
        ),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  _menuItem(String title, IconData iconData, LinearGradient gradient) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.35,
      width: MediaQuery.of(context).size.width * 0.26,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(18),
            child: Center(
              child: Icon(iconData, size: 24, color: Colors.white),
            ),
            decoration: BoxDecoration(
              gradient: gradient,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  _title(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey[900],
      ),
    );
  }

  _introCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage('assets/images/h.jpg'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              offset: Offset(0, 3),
              spreadRadius: 5,
              blurRadius: 5,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 8),
              IconButton(
                icon: Icon(FontAwesomeIcons.longArrowAltRight,
                    size: 36, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HesapListesi()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
