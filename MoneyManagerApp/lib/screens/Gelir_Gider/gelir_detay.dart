import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/gelirler.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';
import 'package:intl/intl.dart';

import 'gelir_ekle.dart';
import 'gelirgiderAnasayfa.dart';
import 'hesabaGoreGelir.dart';

class GelirListesi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GelirGiderSayfasi()));
              },
            );
          },
        ),
        title: Text('Gelirleriniz',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        actions: <Widget>[
          //USTTEKI UC NOKTA
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Toplam Gelirleriniz'),
                    leading: Icon(
                      Icons.attach_money,
                      color: Colors.yellow[700],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _toplamGelireGit(context);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Hesaplara Göre Gelir Listesi'),
                    leading: Icon(Icons.category, color: Colors.yellow[700]),
                    onTap: () {
                      Navigator.pop(context);
                      _hesapGelirListesineGit(context);
                    },
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: GelirListesiL(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        tooltip: 'Gelir Ekle',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GelirEkle()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _toplamGelireGit(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ToplamGelir()));
  }

  void _hesapGelirListesineGit(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HesapGelirListesi()));
  }
}

class GelirListesiL extends StatefulWidget {
  @override
  _GelirListesiLState createState() => _GelirListesiLState();
}

class _GelirListesiLState extends State<GelirListesiL> {
  List<Gelirler> tumGelirler;
  DatabaseHelper databaseHelper;

  @override
  initState() {
    super.initState();
    tumGelirler = List<Gelirler>();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: databaseHelper.gelirListesiniGetir(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          tumGelirler = snapshot.data;
          return tumGelirler.length <= 0
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
                        title: Text(tumGelirler[index].gelirAdi),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
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
                                          DateTime.parse(
                                              tumGelirler[index].gelirTarih))),
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
                                      child: Text(tumGelirler[index]
                                          .gelirMiktari
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
                                            gelirSil(
                                                tumGelirler[index].gelirID);
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
                  itemCount: tumGelirler.length,
                );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void gelirListesiniGuncelle() {
    databaseHelper.gelirListesiniGetir().then((katList) {
      setState(() {
        tumGelirler = katList;
      });
    });
  }

  void gelirSil(gelirID) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Gelir Sil'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Geliri silmek istediğinize emin misiniz ?'),
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
                        databaseHelper.gelirSil(gelirID).then((silinecek) {
                          if (silinecek != 0) {
                            setState(() {
                              gelirListesiniGuncelle();
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

class ToplamGelir extends StatefulWidget {
  @override
  _ToplamGelirState createState() => _ToplamGelirState();
}

class _ToplamGelirState extends State<ToplamGelir> {
  int toplamGelir;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    databaseHelper.toplamGelirGetir().then((t) {
      toplamGelir = t;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Toplam Gelirler',
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Gelir Toplamı',
                style: TextStyle(color: Colors.brown),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    toplamGelir.toString(),
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
