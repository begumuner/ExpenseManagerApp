import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_dersleri/models/harcamalar.dart';
import 'package:flutter_firebase_dersleri/models/hesaplar.dart';
import 'package:flutter_firebase_dersleri/models/kategori.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

import 'gelirgiderAnasayfa.dart';
import 'gider_detay.dart';
import 'package:intl/intl.dart';

class HarcamaEkle extends StatefulWidget {
  @override
  _HarcamaEkleState createState() => _HarcamaEkleState();
}

class _HarcamaEkleState extends State<HarcamaEkle> {
  var formKey = GlobalKey<FormState>();
  List<Hesaplar> tumHesaplar;
  List<Kategori> tumKategoriler;
  DatabaseHelper databaseHelper;
  int kategoriID;
  String harcamaAd;
  String harcamaAciklama;
  int harcamaTutari;
  DateTime tarih;
  int hesapID;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    tumKategoriler = List<Kategori>();
    databaseHelper.kategoriListesiniGetir().then((katList) {
      tumKategoriler = katList;
      setState(() {});
    });
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
                        'Gider Ekle',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (ad) {
                          harcamaAd = ad;
                        },
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                        decoration: InputDecoration(
                          hintText: 'Gider için başlık giriniz',
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
                          harcamaTutari = int.parse(tutar);
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Miktar giriniz',
                          labelText: 'Miktar giriniz',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.yellow[700], width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2001),
                                    lastDate: DateTime(2023))
                                .then((t) {
                              setState(() {
                                tarih = t;
                              });
                            });
                          },
                          child: Container(
                            child: Center(
                              child: Text(tarih == null
                                  ? 'Harcama Tarihini Giriniz'
                                  : DateFormat.yMd().format(tarih)),
                            ),
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //KATEGORILER
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.yellow[700], width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: DropdownButtonHideUnderline(
                          child: tumKategoriler.length <= 0
                              ? CircularProgressIndicator()
                              : DropdownButton<int>(
                                  hint: Text("Kategoriler",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400)),
                                  icon: Icon(
                                    Icons.category,
                                    color: Colors.yellow[700],
                                  ),
                                  items: kategoriItemOlustur(),
                                  value: kategoriID,
                                  onChanged: (kategoriId) {
                                    setState(() {
                                      kategoriID = kategoriId;
                                    });
                                  },
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.yellow[700], width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: DropdownButtonHideUnderline(
                          child: tumHesaplar.length <= 0
                              ? CircularProgressIndicator()
                              : DropdownButton<int>(
                                  hint: Text(
                                    "Hesaplar",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  icon: Icon(
                                    Icons.account_box,
                                    color: Colors.yellow[700],
                                  ),
                                  items: hesapItemOlustur(),
                                  value: hesapID,
                                  onChanged: (hesapId) {
                                    setState(() {
                                      hesapID = hesapId;
                                    });
                                  },
                                ),
                        ),
                      ),

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
                                              GelirGiderSayfasi()));
                                },
                              ),

                              //KAYDET BUTONU
                              RaisedButton(
                                child: Text('Kaydet'),
                                color: Colors.yellow[700],
                                onPressed: () {
                                  databaseHelper.harcamaEkle(Harcama(
                                    harcamaAd: harcamaAd,
                                    harcamaAciklama: harcamaAciklama,
                                    harcamaTutar: harcamaTutari,
                                    harcamaTarih: tarih.toString(),
                                    hesapID: hesapID,
                                    kategoriID: kategoriID,
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GiderListesi()));
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

//KATEGORILERI LISTEYE CEVIRIYOR
  List<DropdownMenuItem<int>> kategoriItemOlustur() {
    return tumKategoriler
        .map((kategori) => DropdownMenuItem<int>(
              value: kategori.kategoriID,
              child: Center(
                child: Text(
                  kategori.kategoriAd,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ))
        .toList();
  }

//HESAPLARI LISTEYE CEVIRIYOR
  List<DropdownMenuItem<int>> hesapItemOlustur() {
    return tumHesaplar
        .map((hesap) => DropdownMenuItem<int>(
              value: hesap.hesapID,
              child: Center(
                child: Text(
                  hesap.hesapAdi,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ))
        .toList();
  }
}
