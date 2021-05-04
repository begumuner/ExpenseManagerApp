import 'package:flutter/material.dart';

import 'package:flutter_firebase_dersleri/models/kategori.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';

import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

import 'kategori_ekle.dart';

class KategoriListesi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            );
          },
        ),
        title: Text('Kategoriler',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
      ),
      body: Center(
        child: KategoriListe(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        tooltip: 'Kategori Ekle',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => KategoriEkle()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class KategoriListe extends StatefulWidget {
  @override
  _KategoriListeState createState() => _KategoriListeState();
}

class _KategoriListeState extends State<KategoriListe> {
  List<Kategori> tumKategoriler;
  DatabaseHelper databaseHelper;

  @override
  initState() {
    super.initState();
    tumKategoriler = List<Kategori>();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: databaseHelper.kategoriListesiniGetir(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          tumKategoriler = snapshot.data;
          return tumKategoriler.length <= 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey[50],
                      margin: EdgeInsets.all(4),
                      elevation: 20,
                      child: ExpansionTile(
                        title: Text(tumKategoriler[index].kategoriAd),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text('Kategori Adı'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(
                                          tumKategoriler[index].kategoriAd),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: InkWell(
                                          child: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red[900],
                                          ),
                                          onTap: () {
                                            kategoriSil(tumKategoriler[index]
                                                .kategoriID);
                                          }),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: tumKategoriler.length,
                );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void kategoriListesiniGuncelle() {
    databaseHelper.kategoriListesiniGetir().then((katList) {
      setState(() {
        tumKategoriler = katList;
      });
    });
  }

  void kategoriSil(int katId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Kategoriyi Sil'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Sildiğiniz kategoriye ait harcamalar da silinecek'),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Vazgeç'),
                      color: Colors.blue[200],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text('Sil'),
                      color: Colors.yellow[700],
                      onPressed: () {
                        databaseHelper.kategoriSil(katId).then((silinecek) {
                          if (silinecek != 0) {
                            setState(() {
                              kategoriListesiniGuncelle();
                            });
                          }
                        });
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
