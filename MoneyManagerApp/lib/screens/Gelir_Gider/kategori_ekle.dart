import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_dersleri/models/hesaplar.dart';
import 'package:flutter_firebase_dersleri/models/kategori.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/gelirgiderAnasayfa.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/kategori.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

class KategoriEkle extends StatefulWidget {
  @override
  _KategoriEkleState createState() => _KategoriEkleState();
}

class _KategoriEkleState extends State<KategoriEkle> {
  var formKey2 = GlobalKey<FormState>();

  List<Kategori> tumKategoriler;
  DatabaseHelper databaseHelper;
  String kategoriAdi;
  String yeniKategoriAd;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    tumKategoriler = List<Kategori>();
    databaseHelper.kategoriListesiniGetir().then((hesList) {
      tumKategoriler = hesList;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/amber2.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  child: ListView(
                    children: <Widget>[
                      Text(
                        'Kategori Ekle',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      new DropdownButton<String>(
                        //value: yeniKategoriAd,
                        hint: Text("Kategori",
                            style: TextStyle(fontWeight: FontWeight.w400)),
                        items: <String>[
                          'Gıda',
                          'Ulaşım',
                          'Eğlence',
                          'Sağlık',
                          'Okul',
                          'Fatura',
                          'Giyim',
                          'Kira',
                          'Diğer'
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),

                        onChanged: (tur) {
                          setState(() {
                            yeniKategoriAd = tur;
                          });
                        },
                        value: yeniKategoriAd,
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      //VAZGEC BUTONU
                      Expanded(
                        child: Container(
                          child: ButtonBar(
                            alignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                child: Text('Vazgeç'),
                                color: Colors.blue[200],
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KategoriListesi()));
                                },
                              ),

                              //KAYDET BUTONU
                              RaisedButton(
                                child: Text('Kaydet'),
                                color: Colors.yellow[700],
                                onPressed: () {
                                  databaseHelper.kategoriEkle(Kategori(
                                    kategoriAd: yeniKategoriAd,
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KategoriListesi()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
