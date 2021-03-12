import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/kategori.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';

class KategoriListesi extends StatefulWidget {
  @override
  _KategoriListesiState createState() => _KategoriListesiState();
}

class _KategoriListesiState extends State<KategoriListesi> {
  List<Kategori> kategoriler;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kategoriler == null) {
      kategoriler = List<Kategori>();
      //kategori listesini güncelle
      kategoriListesiniGuncelle();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Kategoriler',
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //kategori ekle
            kategoriEkle();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[50],
              margin: EdgeInsets.all(4),
              elevation: 20,
              child: ListTile(
                title: Text(kategoriler[index].kategoriAd),
                trailing: InkWell(
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.red[700],
                    ),
                    onTap: () {
                      kategoriSil(kategoriler[index].kategoriID);
                    }),
                onTap: () {
                  return kategoriGuncelle(kategoriler[index]);
                },
              ),
            );
          },
          itemCount: kategoriler.length,
        ));
  }

  void kategoriListesiniGuncelle() {
    databaseHelper.kategoriListesiniGetir().then((katList) {
      setState(() {
        kategoriler = katList;
      });
    });
  }

  void kategoriEkle() {
    var formKey = GlobalKey<FormState>();
    String yeniKategoriAd;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Text(
                    'Kategori Ekle',
                    style: TextStyle(color: Colors.brown, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      onSaved: (yeni) {
                        yeniKategoriAd = yeni;
                      },
                      decoration: InputDecoration(
                          labelText: 'Kategori Adı',
                          border: OutlineInputBorder()),
                      validator: (girilen) {
                        if (girilen.length <= 0) {
                          return 'Kategori Adını Giriniz';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Vazgeç'),
                        color: Colors.blue[200],
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            databaseHelper
                                .kategoriEkle(
                                    Kategori(kategoriAd: yeniKategoriAd))
                                .then((kategoriID) {
                              if (kategoriID > 0) {
                                setState(() {
                                  kategoriListesiniGuncelle();
                                  Navigator.pop(context);
                                });
                              }
                            });
                          }
                        },
                        child: Text('Ekle'),
                        color: Colors.yellow[700],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void kategoriGuncelle(Kategori kat) {
    var formKey = GlobalKey<FormState>();
    String guncellenecekKategoriAd;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Text(
                    'Kategori Güncelle',
                    style: TextStyle(color: Colors.brown, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      onSaved: (yeni) {
                        guncellenecekKategoriAd = yeni;
                      },
                      decoration: InputDecoration(
                          labelText: kat.kategoriAd,
                          border: OutlineInputBorder()),
                      validator: (girilen) {
                        if (girilen.length <= 0) {
                          return 'Kategori Adını Giriniz';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Vazgeç'),
                        color: Colors.blue[200],
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            databaseHelper
                                .kategoriGuncelle(Kategori.withID(
                                    kategoriID: kat.kategoriID,
                                    kategoriAd: guncellenecekKategoriAd))
                                .then((kategoriId) {
                              if (kategoriId != 0) {
                                setState(() {
                                  kategoriListesiniGuncelle();
                                  Navigator.pop(context);
                                });
                              }
                            });
                          }
                        },
                        child: Text('Güncelle'),
                        color: Colors.yellow[700],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
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
                        Navigator.canPop(context);
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
