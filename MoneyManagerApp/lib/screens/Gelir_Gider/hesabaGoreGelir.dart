import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/hesap_gelir.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

class HesapGelirListesi extends StatefulWidget {
  @override
  _HesapGelirListesiState createState() => _HesapGelirListesiState();
}

class _HesapGelirListesiState extends State<HesapGelirListesi> {
  List<HesapGelir> tumHesapGelirler;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();

    tumHesapGelirler = List<HesapGelir>();
    databaseHelper = DatabaseHelper();

    databaseHelper.hesabaGoreGelirListesiniGetir().then((gList) {
      tumHesapGelirler = gList;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Hesaplara Göre Gelir Listesi',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[50],
            margin: EdgeInsets.all(4),
            elevation: 20,
            child: ListTile(
              title: Text(tumHesapGelirler[index].tip),
              trailing: Text(tumHesapGelirler[index].tutar.toString()),
            ),
          );
        },
        itemCount: tumHesapGelirler.length,
      ),
    );
  }
}
