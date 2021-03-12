import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/soru.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Raporlar/anasayfa.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  var formKey2 = GlobalKey<FormState>();
  var sorular;
  DatabaseHelper databaseHelper;

  String meslekler;
  String gelir;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    databaseHelper.soruGetir().then((value) {
      sorular = value;
      debugPrint(sorular[sorular.length - 1].toString());
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
                image: AssetImage('assets/images/cash-back.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 1,
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
                        'Sorular',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueGrey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: new DropdownButton<String>(
                          value: meslekler,
                          hint: Text("Meslek"),
                          items: <String>[
                            'Mühendis',
                            'Doktor',
                            'Avukat',
                            'Memur',
                            'Mimar',
                            'Serbest Meslek'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (tur) {
                            setState(() {
                              meslekler = tur;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //Gelir
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueGrey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: new DropdownButton<String>(
                          value: gelir,
                          hint: Text("Aylik Geliriniz"),
                          items: <String>[
                            '2000 - 5000',
                            '5000 - 8000',
                            '8000 - 10000',
                            '10000 - 15000',
                            '15000 - 20000',
                            '20000 - 50000'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (tur) {
                            setState(() {
                              gelir = tur;
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
                                color: Colors.orange,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                              ),

                              //KAYDET BUTONU
                              RaisedButton(
                                child: Text('Kaydet'),
                                color: Colors.blue[900],
                                onPressed: () {
                                  databaseHelper.soruEkle(Sorular(
                                    meslek: meslekler,
                                    aylikGelir: gelir,
                                  ));

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
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
