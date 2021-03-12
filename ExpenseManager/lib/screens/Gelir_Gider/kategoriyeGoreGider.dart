import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/kategori.dart';
import 'package:flutter_firebase_dersleri/models/kategori_harcama.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/gider_detay.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

import 'kategori.dart';

class KategoriGiderListesi extends StatefulWidget {
  @override
  _KategoriGiderListesiState createState() => _KategoriGiderListesiState();
}

class _KategoriGiderListesiState extends State<KategoriGiderListesi> {
  List<KategoriHarcama> tumKategoriHarcamalar;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();

    tumKategoriHarcamalar = List<KategoriHarcama>();
    databaseHelper = DatabaseHelper();

    databaseHelper.kategoriyeGoreHarcamalarListesiniGetir().then((harList) {
      tumKategoriHarcamalar = harList;
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
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => GiderListesi()));
              },
            );
          },
        ),
        backgroundColor: Colors.amber,
        title: Text('Kategoriye Göre Harcamalar',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[50],
            margin: EdgeInsets.all(4),
            elevation: 20,
            child: ListTile(
              title: Text(tumKategoriHarcamalar[index].tip),
              trailing: Text(tumKategoriHarcamalar[index].tutar.toString()),
            ),
          );
        },
        itemCount: tumKategoriHarcamalar.length,
      ),
    );
  }
}
