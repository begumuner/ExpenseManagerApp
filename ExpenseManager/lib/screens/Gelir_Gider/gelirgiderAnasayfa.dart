import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Hesaplar/hesapListesi.dart';
import 'package:flutter_firebase_dersleri/screens/Kurlar/anasayfa.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'gelir_detay.dart';
import 'gelir_ekle.dart';
import 'gider_detay.dart';
import 'gider_ekle.dart';
import 'kategori.dart';

class GelirGiderSayfasi extends StatefulWidget {
  @override
  _GelirGiderSayfasiState createState() => _GelirGiderSayfasiState();
}

class _GelirGiderSayfasiState extends State<GelirGiderSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Gelir Gider Anasayfa',
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
            _title('Gelir Gider Bağlantılar'),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: _menuItem(
                      'Gelir Ekle', FontAwesomeIcons.plus, blueGradient),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GelirEkle()));
                  },
                ),
                GestureDetector(
                  child: _menuItem(
                      'Gider Ekle', FontAwesomeIcons.minus, darkRedGradient),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HarcamaEkle()));
                  },
                ),
                GestureDetector(
                  child: _menuItem('Hesaplar', FontAwesomeIcons.cashRegister,
                      yellowGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HesapListesi()));
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
                  child: _menuItem('Gelir Detay', FontAwesomeIcons.plusCircle,
                      dortRedGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GelirListesi()));
                  },
                ),
                GestureDetector(
                  child: _menuItem('Gider Detay', FontAwesomeIcons.minusSquare,
                      greenGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GiderListesi()));
                  },
                ),
                GestureDetector(
                  child: _menuItem(
                      'Kategori', FontAwesomeIcons.coins, besRedGradient),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KategoriListesi()));
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/a.jpg',
            ),
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
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                backgroundColor: Colors.white),
          ),
          SizedBox(height: 12),
          Text(
            '',
            style: TextStyle(
              color: Colors.black,
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
                    size: 36, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => KurAnasayfa()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
