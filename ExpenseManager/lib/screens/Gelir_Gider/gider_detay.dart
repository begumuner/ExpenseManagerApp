import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/harcamalar.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';
import 'package:intl/intl.dart';

import 'gelirgiderAnasayfa.dart';
import 'gider_ekle.dart';
import 'hesabaGoreGider.dart';
import 'kategoriyeGoreGider.dart';

class GiderListesi extends StatelessWidget {
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GelirGiderSayfasi()));
              },
            );
          },
        ),
        title: Text('Harcamalarınız',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),

        //UST UC NOKTA
        actions: <Widget>[
          PopupMenuButton(
            icon: new Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Toplam Harcamalar'),
                    leading:
                        Icon(Icons.attach_money, color: Colors.yellow[700]),
                    onTap: () {
                      Navigator.pop(context);
                      _toplamGidereGit(context);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Kategoriye Gore Harcamalar'),
                    leading: Icon(Icons.category, color: Colors.yellow[700]),
                    onTap: () {
                      Navigator.pop(context);
                      _kategoriyeGoreGidereGit(context);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Hesaba Göre Gider Listesi'),
                    leading: Icon(Icons.list_sharp, color: Colors.yellow[700]),
                    onTap: () {
                      Navigator.pop(context);
                      _harcamaGiderListesineGit(context);
                    },
                  ),
                )
              ];
            },
          )
        ],
      ),
      body: Center(
        child: HarcamaListesi(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        tooltip: 'Harcama Ekle',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HarcamaEkle()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _toplamGidereGit(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ToplamHarcama()));
  }
}

void _kategoriyeGoreGidereGit(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => KategoriGiderListesi()));
}

void _harcamaGiderListesineGit(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => HesapGiderListesi()));
}

class HarcamaListesi extends StatefulWidget {
  @override
  _HarcamaListesiState createState() => _HarcamaListesiState();
}

class _HarcamaListesiState extends State<HarcamaListesi> {
  List<Harcama> tumHarcamalar;
  DatabaseHelper databaseHelper;

  @override
  initState() {
    super.initState();
    tumHarcamalar = List<Harcama>();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: databaseHelper.harcamaListesiniGetir(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          tumHarcamalar = snapshot.data;
          return tumHarcamalar.length <= 0
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
                        title: Text(tumHarcamalar[index].harcamaAd),
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
                                      child: Text('Kategori'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child:
                                          Text(tumHarcamalar[index].kategoriAd),
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
                                      child: Text('Hesap'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child:
                                          Text(tumHarcamalar[index].hesapAdi),
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
                                      child: Text('Tarih'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(DateFormat.yMd().format(
                                          DateTime.parse(tumHarcamalar[index]
                                              .harcamaTarih))),
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
                                      child: Text('Tutar'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(tumHarcamalar[index]
                                          .harcamaTutar
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
                                            color: Colors.red[400],
                                          ),
                                          onTap: () {
                                            harcamaSil(
                                                tumHarcamalar[index].harcamaID);
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
                  itemCount: tumHarcamalar.length,
                );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void harcamaListesiniGuncelle() {
    databaseHelper.harcamaListesiniGetir().then((katList) {
      setState(() {
        tumHarcamalar = katList;
      });
    });
  }

  void harcamaSil(harcamaID) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Harcama Sil'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Harcama silmek istediğinize emin misiniz ?'),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('İptal'),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text('Sil'),
                      color: Colors.red[400],
                      onPressed: () {
                        databaseHelper.harcamaSil(harcamaID).then((silinecek) {
                          if (silinecek != 0) {
                            setState(() {
                              harcamaListesiniGuncelle();
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

class ToplamHarcama extends StatefulWidget {
  @override
  _ToplamHarcamaState createState() => _ToplamHarcamaState();
}

class _ToplamHarcamaState extends State<ToplamHarcama> {
  int toplamHarcamalar;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    databaseHelper.toplamHarcamalarGetir().then((t) {
      toplamHarcamalar = t;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Toplam Harcamalar',
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Toplam Harcama Tutarı',
                style: TextStyle(color: Colors.brown),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    toplamHarcamalar.toString(),
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
