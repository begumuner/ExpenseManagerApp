import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

class Toplam extends StatefulWidget {
  @override
  _ToplamState createState() => _ToplamState();
}

class _ToplamState extends State<Toplam> {
  int toplamGelir;
  int toplamGider;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    databaseHelper.toplamGelirGetir().then((t) {
      toplamGelir = t;
      setState(() {});
    });
    databaseHelper.toplamHarcamalarGetir().then((t) {
      toplamGider = t;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              );
            },
          ),
          backgroundColor: Colors.amber,
          title: Text('Toplam Para',
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Toplam Para',
                style: TextStyle(color: Colors.brown),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${toplamGelir - toplamGider}",
                    style: TextStyle(fontSize: 50),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.money_off)
                ],
              )
            ],
          ),
        ));
  }
}
