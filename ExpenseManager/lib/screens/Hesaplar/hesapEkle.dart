import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_dersleri/models/hesaplar.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/gelirgiderAnasayfa.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

import 'hesapListesi.dart';

class HesapEkle extends StatefulWidget {
  @override
  _HesapEkleState createState() => _HesapEkleState();
}

class _HesapEkleState extends State<HesapEkle> {
  var formKey2 = GlobalKey<FormState>();

  List<Hesaplar> tumHesaplar;
  DatabaseHelper databaseHelper;
  String hesapAdi;
  int hesapMiktari;
  String hesapTuru;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    tumHesaplar = List<Hesaplar>();
    databaseHelper.hesapListesiniGetir().then((hesList) {
      tumHesaplar = hesList;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                        'Hesap Ekle',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextField(
                        onChanged: (ad) {
                          hesapAdi = ad;
                        },
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                        decoration: InputDecoration(
                          hintText: 'Hesap için başlık giriniz',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (tutar) {
                          hesapMiktari = int.parse(tutar);
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Miktar giriniz',
                          labelText: 'Miktar giriniz',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueGrey, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: new DropdownButton<String>(
                          value: hesapTuru,
                          hint: Text("Hesap Türü"),
                          items: <String>['USD', 'TRY', 'EUR', 'CAD']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (tur) {
                            setState(() {
                              hesapTuru = tur;
                            });
                          },
                        ),
                      ),

                      SizedBox(
                        height: 20,
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
                                              HesapListesi()));
                                },
                              ),

                              //KAYDET BUTONU
                              RaisedButton(
                                child: Text('Kaydet'),
                                color: Colors.yellow[700],
                                onPressed: () {
                                  databaseHelper.hesapEkle(Hesaplar(
                                    hesapAdi: hesapAdi,
                                    hesapMiktari: hesapMiktari,
                                    hesapTuru: hesapTuru,
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HesapListesi()));
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
