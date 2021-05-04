import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/currency.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Kurlar/anasayfa.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Currency extends StatefulWidget {
  @override
  _CurrencyState createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  var tryDegeri = 1.0;
  List<String> kur = List(8);
  List<DovizListem> dovizListesi = List<DovizListem>();
  Welcome currency;
  String url =
      "http://data.fixer.io/api/latest?access_key=37381f6be5bc25559393ce9dbb6b6159";

  Future<Welcome> kurGetir() async {
    var responce = await http.get(url);
    var decodedJson = json.decode(responce.body);
    currency = Welcome.fromJson(decodedJson);
    return currency;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => KurAnasayfa()));
              },
            );
          },
        ),
        backgroundColor: Colors.amber,
        title: Text("Finansal Veriler",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
      ),
      body: FutureBuilder(
        future: kurGetir(),
        builder: (context, AsyncSnapshot<Welcome> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            snapshot.data.rates.forEach((key, value) {
              dovizListesi.add(DovizListem(paraAdi: key, paraDegeri: value));
            });
          }
          //TL BASE
          double tlBul() {
            for (var i = 0; i < dovizListesi.length; i++) {
              if (dovizListesi[i].paraAdi == "TRY") {
                return dovizListesi[i].paraDegeri;
              }
            }
          }

          tryDegeri = tlBul();
          //BELLI KURLAR
          List istenilenKUR() {
            for (var i = 0; i < dovizListesi.length; i++) {
              if (dovizListesi[i].paraAdi == "USD") {
                kur[0] = (tryDegeri / dovizListesi[i].paraDegeri).toString();
              } else if (dovizListesi[i].paraAdi == "EUR") {
                kur[1] = (tryDegeri / dovizListesi[i].paraDegeri).toString();
              } else if (dovizListesi[i].paraAdi == "GBP") {
                kur[2] = (tryDegeri / dovizListesi[i].paraDegeri).toString();
              } else if (dovizListesi[i].paraAdi == "CAD") {
                kur[3] = (tryDegeri / dovizListesi[i].paraDegeri).toString();
              } else if (dovizListesi[i].paraAdi == "XAG") {
                kur[4] = (tryDegeri / dovizListesi[i].paraDegeri).toString();
              } else if (dovizListesi[i].paraAdi == "XAU") {
                kur[5] = (tryDegeri / dovizListesi[i].paraDegeri).toString();
              } else if (dovizListesi[i].paraAdi == "CHF") {
                kur[6] = (tryDegeri / dovizListesi[i].paraDegeri).toString();
              } else if (dovizListesi[i].paraAdi == "JPY") {
                kur[7] = (tryDegeri / dovizListesi[i].paraDegeri).toString();
              }
            }

            return kur;
          }

          istenilenKUR();
          List<String> isim = [
            "USD",
            "EUR",
            "GBP",
            "CAD",
            "XAG",
            "XAU",
            "CHF",
            "JPY"
          ];

          return ListView.builder(
            itemCount: kur.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.grey[100],
                  margin: EdgeInsets.all(15),
                  elevation: 10,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      // koselerini renklendiriyoruz
                      border: Border.all(
                          color: Colors.amber,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          isim[index],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(kur[index]),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}

class DovizListem {
  DovizListem({this.paraAdi, this.paraDegeri});

  String paraAdi;
  double paraDegeri;
}
