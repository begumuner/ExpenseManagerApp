import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/hesaplar.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/hesabaGoreGelir.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/hesabaGoreGider.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

import 'hesapEkle.dart';

class HesapListesi extends StatelessWidget {
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
        title: Text('Hesaplarınız',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        actions: <Widget>[
          //USTTEKI UC NOKTA
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Hesaplara Göre Gelir Listesi'),
                    leading: Icon(
                      Icons.add_circle_outline_sharp,
                      color: Colors.amber,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _hesapGelirListesineGit(context);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Hesaplara Göre Harcama Listesi'),
                    leading: Icon(
                      Icons.indeterminate_check_box_outlined,
                      color: Colors.amber,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _hesapHarcamaListesineGit(context);
                    },
                  ),
                )
              ];
            },
          )
        ],
      ),
      body: Center(
        child: HesapListe(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        tooltip: 'Gelir Ekle',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HesapEkle()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _hesapHarcamaListesineGit(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HesapGiderListesi()));
  }

  void _hesapGelirListesineGit(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HesapGelirListesi()));
  }
}

class HesapListe extends StatefulWidget {
  @override
  _HesapListeState createState() => _HesapListeState();
}

class _HesapListeState extends State<HesapListe> {
  List<Hesaplar> tumHesaplar;
  DatabaseHelper databaseHelper;

  @override
  initState() {
    super.initState();
    tumHesaplar = List<Hesaplar>();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: databaseHelper.hesapListesiniGetir(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          tumHesaplar = snapshot.data;
          return tumHesaplar.length <= 0
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
                        title: Text(tumHesaplar[index].hesapAdi),
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
                                      child: Text('Hesap Adı'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(tumHesaplar[index].hesapAdi),
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
                                      child: Text('Hesap Türü'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(tumHesaplar[index].hesapTuru),
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
                                      child: Text('Hesap Miktarı'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(tumHesaplar[index]
                                          .hesapMiktari
                                          .toString()),
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
                                            hesapSil(
                                                tumHesaplar[index].hesapID);
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
                  itemCount: tumHesaplar.length,
                );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void hesapListesiniGuncelle() {
    databaseHelper.hesapListesiniGetir().then((katList) {
      setState(() {
        tumHesaplar = katList;
      });
    });
  }

  void hesapSil(hesapID) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Hesap Sil'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Hesabı silmek istediğinize emin misiniz ?'),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('İptal'),
                      color: Colors.red[900],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text('Sil'),
                      color: Colors.blue[800],
                      onPressed: () {
                        databaseHelper.hesapSil(hesapID).then((silinecek) {
                          if (silinecek != 0) {
                            setState(() {
                              hesapListesiniGuncelle();
                              Navigator.pop(context);
                            });
                          }
                        });
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
