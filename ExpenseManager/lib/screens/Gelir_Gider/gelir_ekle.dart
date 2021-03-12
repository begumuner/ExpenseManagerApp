import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_dersleri/models/gelirler.dart';
import 'package:flutter_firebase_dersleri/models/hesaplar.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';
import 'package:intl/intl.dart';

import 'gelir_detay.dart';
import 'gelirgiderAnasayfa.dart';

class GelirEkle extends StatefulWidget {
  _GelirEkleState createState() => _GelirEkleState();
}

class _GelirEkleState extends State<GelirEkle> {
  var formKey2 = GlobalKey<FormState>();

  List<Hesaplar> tumHesaplar;
  DatabaseHelper databaseHelper;
  int hesapID;
  String hesapAdi;
  String gelirAdi;
  String gelirAciklama;
  int gelirMiktari;
  DateTime tarih;

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
                        'Gelir Ekle',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextField(
                        onChanged: (ad) {
                          gelirAdi = ad;
                        },
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                        decoration: InputDecoration(
                          hintText: 'Gelir için başlık giriniz',
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
                          gelirMiktari = int.parse(tutar);
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
                                  ? 'Gelir Tarihini Giriniz'
                                  : DateFormat.yMd().format(tarih)),
                            ),
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                                    color: Colors.amber,
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
                                              GelirGiderSayfasi()));
                                },
                              ),

                              //KAYDET BUTONU
                              RaisedButton(
                                child: Text('Kaydet'),
                                color: Colors.yellow[700],
                                onPressed: () {
                                  databaseHelper.gelirEkle(Gelirler(
                                      gelirAdi: gelirAdi,
                                      gelirMiktari: gelirMiktari,
                                      gelirTarih: tarih.toString(),
                                      hesapID: hesapID));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GelirListesi()));
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
