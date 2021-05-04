import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/hesap_harcama.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/gider_detay.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

class HesapGiderListesi extends StatefulWidget {
  @override
  _HesapGiderListesiState createState() => _HesapGiderListesiState();
}

class _HesapGiderListesiState extends State<HesapGiderListesi> {
  List<HesapHarcama> tumHesapHarcamalar;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();

    tumHesapHarcamalar = List<HesapHarcama>();
    databaseHelper = DatabaseHelper();

    databaseHelper.hesabaGoreHarcamalarListesiniGetir().then((hgList) {
      tumHesapHarcamalar = hgList;
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
        title: Text('Hesaplara Göre Gider Listesi',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[50],
            margin: EdgeInsets.all(4),
            elevation: 20,
            child: ListTile(
              title: Text(tumHesapHarcamalar[index].tip),
              trailing: Text(tumHesapHarcamalar[index].tutar.toString()),
            ),
          );
        },
        itemCount: tumHesapHarcamalar.length,
      ),
    );
  }
}
