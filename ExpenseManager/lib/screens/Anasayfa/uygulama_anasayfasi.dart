import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/bitirmeProjesi/Evraklarim/evraklarim_anasayfa.dart';
import 'package:flutter_firebase_dersleri/bitirmeProjesi/ProfilSayfasi/profil_sayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/gelirgiderAnasayfa.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/kategori.dart';
import 'package:flutter_firebase_dersleri/screens/Haberler/haberler.dart';
import 'package:flutter_firebase_dersleri/screens/Hatirlatici/hatirlatici.dart';
import 'package:flutter_firebase_dersleri/screens/Hesaplar/hesapListesi.dart';
import 'package:flutter_firebase_dersleri/screens/Kurlar/anasayfa.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/anasayfa.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/style.dart';
import 'package:flutter_firebase_dersleri/screens/SoruSayfasi/SoruSayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/onBoarding/screen_one.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("MANI ANASAYFA"),
      ),
      backgroundColor: Color(0XFFFEFEFE),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, top: 10, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: _menuItem(
                      'PROFİL', FontAwesomeIcons.addressCard, blueGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilSayfasi()));
                  },
                ),
                GestureDetector(
                  child: _menuItem('HESAPLAR', FontAwesomeIcons.cashRegister,
                      darkRedGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HesapListesi()));
                  },
                ),
                GestureDetector(
                  child: _menuItem('EVRAKLAR', FontAwesomeIcons.clipboardList,
                      yellowGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EvraklarAnaSayfa()));
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: _menuItem(
                      'RAPORLAR', FontAwesomeIcons.chartPie, dortRedGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RaporlarSayfasi()));
                  },
                ),
                GestureDetector(
                  child: _menuItem(
                      'KUR', FontAwesomeIcons.dollarSign, greenGradient),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => KurAnasayfa()));
                  },
                ),
                GestureDetector(
                  child: _menuItem(
                      'HATIRLATICI', FontAwesomeIcons.bell, besRedGradient),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Hatirlatici()));
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: _menuItem(
                      'KATEGORİ', FontAwesomeIcons.boxes, ucRedGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KategoriListesi()));
                  },
                ),
                GestureDetector(
                  child: _menuItem('GELİR GİDER ANASAYFASI',
                      FontAwesomeIcons.coins, ikiRedGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GelirGiderSayfasi()));
                  },
                ),
                GestureDetector(
                  child: _menuItem(
                      'HABERLER', FontAwesomeIcons.commentDollar, altiGradient),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Haberler()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
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
            color: Colors.amber,
            spreadRadius: 1.5,
            blurRadius: 1.5,
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
}
