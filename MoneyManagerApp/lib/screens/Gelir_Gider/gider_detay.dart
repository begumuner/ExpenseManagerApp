import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/harcamalar.dart';
import 'package:flutter_firebase_dersleri/models/kategori_harcama.dart';
import 'package:flutter_firebase_dersleri/tools/database_helper.dart';
import 'package:intl/intl.dart';

import 'gelirgiderAnasayfa.dart';
import 'gider_ekle.dart';
import 'hesabaGoreGider.dart';
import 'kategoriyeGoreGider.dart';

import 'package:xml/xml.dart' as xml;

class GiderListesi extends StatefulWidget {
  @override
  _GiderListesiState createState() => _GiderListesiState();
}

class _GiderListesiState extends State<GiderListesi> {
  @override
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
  List<Map<String, dynamic>> gelirMapi = [];
  List<Verilerim> verilerimKullan = [];
  List<Verilerim> verilerim = [];
  List<String> gelirTarihListesi = [];
  List<String> gelirTarihListesiDuzgunFormatta = [];
  List<int> gelirMiktarListesi = [];
  List<int> gelirAylikListe = [];
  List<int> gelirMiktarListesiKullan = [];

  List<String> harcamaTarihListesi = [];
  List<String> harcamaTarihListesiDuzgunFormatta = [];
  List<int> harcamaMiktarListesi = [];
  List<int> harcamaAylikListe = [];
  List<int> giderMiktarListesiKullan = [];
  List<String> harcamaKategoriListesi = [];
  List<KategoriHarcama> tumKategoriHarcamalar;
  var sorular;
  String aileUyesi;
  String maas;
  var giderler2;
  List<String> harcamaTarihListesi2 = [];
  List<String> harcamaTarihListesiDuzgunFormatta2 = [];
  var ocakGida = 0;
  var ocakUlasim = 0;
  var ocakEglence = 0;
  var ocakFatura = 0;
  var ocakGiyim = 0;
  var subatGida = 0;
  var subatUlasim = 0;
  var subatEglence = 0;
  var subatFatura = 0;
  var subatGiyim = 0;
  var martGida = 0;
  var martUlasim = 0;
  var martEglence = 0;
  var martFatura = 0;
  var martGiyim = 0;
  var nisanGida = 0;
  var nisanUlasim = 0;
  var nisanEglence = 0;
  var nisanFatura = 0;
  var nisanGiyim = 0;
  var mayisGida = 0;
  var mayisUlasim = 0;
  var mayisEglence = 0;
  var mayisFatura = 0;
  var mayisGiyim = 0;
  var haziranGida = 0;
  var haziranUlasim = 0;
  var haziranEglence = 0;
  var haziranFatura = 0;
  var haziranGiyim = 0;
  var temmuzGida = 0;
  var temmuzUlasim = 0;
  var temmuzEglence = 0;
  var temmuzFatura = 0;
  var temmuzGiyim = 0;
  var agustosGida = 0;
  var agustosUlasim = 0;
  var agustosEglence = 0;
  var agustosFatura = 0;
  var agustosGiyim = 0;
  var eylulGida = 0;
  var eylulUlasim = 0;
  var eylulEglence = 0;
  var eylulFatura = 0;
  var eylulGiyim = 0;
  var ekimGida = 0;
  var ekimUlasim = 0;
  var ekimEglence = 0;
  var ekimFatura = 0;
  var ekimGiyim = 0;
  var kasimGida = 0;
  var kasimUlasim = 0;
  var kasimEglence = 0;
  var kasimFatura = 0;
  var kasimGiyim = 0;
  var aralikGida = 0;
  var aralikUlasim = 0;
  var aralikEglence = 0;
  var aralikFatura = 0;
  var aralikGiyim = 0;

  @override
  initState() {
    super.initState();
    tumKategoriHarcamalar = List<KategoriHarcama>();
    DateTime now = new DateTime.now();
    int ay = now.month;
    debugPrint(ay.toString());

    tumHarcamalar = List<Harcama>();
    databaseHelper = DatabaseHelper();
    databaseHelper.soruGetir().then((value) {
      setState(() {
        aileUyesi = value[value.length - 1]["meslek"];
        maas = value[value.length - 1]["aylikGelir"];
        debugPrint("aile uyesi: $aileUyesi  maas: $maas");
      });
    });
    final myFuture = gelirleriGetir();

    databaseHelper.harcamaListesiniGetir().then((value) {
      giderler2 = value;
      debugPrint("ayrinti... " + giderler2[0].harcamaTarih.substring(5, 7));
      for (var k = 0; k < giderler2.length; k++) {
        if (giderler2[k].harcamaTarih.substring(5, 7) == "01") {
          if (giderler2[k].kategoriAd == "Gıda") {
            ocakGida = ocakGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            ocakUlasim = ocakUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            ocakEglence = ocakEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            ocakFatura = ocakFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            ocakGiyim = ocakGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "02") {
          if (giderler2[k].kategoriAd == "Gıda") {
            subatGida = subatGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            subatUlasim = subatUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            subatEglence = subatEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            subatFatura = subatFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            subatGiyim = subatGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "03") {
          if (giderler2[k].kategoriAd == "Gıda") {
            martGida = martGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            martUlasim = martUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            martEglence = martEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            martFatura = martFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            martGiyim = martGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "04") {
          if (giderler2[k].kategoriAd == "Gıda") {
            nisanGida = nisanGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            nisanUlasim = nisanUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            nisanEglence = nisanEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            nisanFatura = nisanFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            nisanGiyim = nisanGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "05") {
          if (giderler2[k].kategoriAd == "Gıda") {
            mayisGida = mayisGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            mayisUlasim = mayisUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            mayisEglence = mayisEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            mayisFatura = mayisFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            mayisGiyim = mayisGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "06") {
          if (giderler2[k].kategoriAd == "Gıda") {
            haziranGida = haziranGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            haziranUlasim = haziranUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            haziranEglence = haziranEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            haziranFatura = haziranFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            haziranGiyim = haziranGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "07") {
          if (giderler2[k].kategoriAd == "Gıda") {
            temmuzGida = temmuzGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            temmuzUlasim = temmuzUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            temmuzEglence = temmuzEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            temmuzFatura = temmuzFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            temmuzGiyim = temmuzGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "08") {
          if (giderler2[k].kategoriAd == "Gıda") {
            agustosGida = agustosGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            agustosUlasim = agustosUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            agustosEglence = agustosEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            agustosFatura = agustosFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            agustosGiyim = agustosGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "09") {
          if (giderler2[k].kategoriAd == "Gıda") {
            eylulGida = eylulGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            eylulUlasim = eylulUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            eylulEglence = eylulEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            eylulFatura = eylulFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            eylulGiyim = eylulGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "10") {
          if (giderler2[k].kategoriAd == "Gıda") {
            ekimGida = ekimGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            ekimUlasim = ekimUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            ekimEglence = ekimEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            ekimFatura = ekimFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            ekimGiyim = ekimGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "11") {
          if (giderler2[k].kategoriAd == "Gıda") {
            kasimGida = kasimGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            kasimUlasim = kasimUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            kasimEglence = kasimEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            kasimFatura = kasimFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            kasimGiyim = kasimGiyim + giderler2[k].harcamaTutar;
          }
        }

        if (giderler2[k].harcamaTarih.substring(5, 7) == "12") {
          if (giderler2[k].kategoriAd == "Gıda") {
            aralikGida = aralikGida + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Ulaşım") {
            aralikUlasim = aralikUlasim + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Eğlence") {
            aralikEglence = aralikEglence + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Fatura") {
            aralikFatura = aralikFatura + giderler2[k].harcamaTutar;
          }
          if (giderler2[k].kategoriAd == "Giyim") {
            aralikGiyim = aralikGiyim + giderler2[k].harcamaTutar;
          }
        }
      }
      debugPrint("kkk " + nisanGida.toString());
    });

    myFuture.then((value) {
      gelirMiktarListesiKullan = value;
      debugPrint("gelirler  " + gelirMiktarListesiKullan.toString());

      final myFuture2 = giderleriGetir();
      myFuture2.then((value) {
        giderMiktarListesiKullan = value;

        debugPrint("giderler  " + giderMiktarListesiKullan.toString());
        if (maas == "2000 - 5000") {
          final myFuture99 = yapayZekaHarcamaTahminiGetir25(context);
          myFuture99.then((value) {
            verilerimKullan = value;
            if (aileUyesi == "1") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[0].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "2") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[1].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "3") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[2].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "4") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[3].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[4].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5+") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[5].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
          });
        }

        if (maas == "5000 - 8000") {
          final myFuture99 = yapayZekaHarcamaTahminiGetir58(context);
          myFuture99.then((value) {
            verilerimKullan = value;
            if (aileUyesi == "1") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[0].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "2") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[1].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "3") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[2].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "4") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[3].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[4].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5+") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[5].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
          });
        }

        if (maas == "8000 - 10000") {
          final myFuture99 = yapayZekaHarcamaTahminiGetir810(context);
          myFuture99.then((value) {
            verilerimKullan = value;
            if (aileUyesi == "1") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[0].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "2") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[1].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "3") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[2].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "4") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[3].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[4].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5+") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[5].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
          });
        }

        if (maas == "10000 - 15000") {
          final myFuture99 = yapayZekaHarcamaTahminiGetir1015(context);
          myFuture99.then((value) {
            verilerimKullan = value;
            if (aileUyesi == "1") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[0].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "2") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[1].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "3") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[2].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "4") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[3].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[4].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5+") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[5].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
          });
        }

        if (maas == "15000 - 20000") {
          final myFuture99 = yapayZekaHarcamaTahminiGetir1520(context);
          myFuture99.then((value) {
            verilerimKullan = value;
            if (aileUyesi == "1") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[0].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "2") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[1].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "3") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[2].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "4") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[3].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[4].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5+") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[5].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
          });
        }

        if (maas == "20000 - 50000") {
          final myFuture99 = yapayZekaHarcamaTahminiGetir2050(context);
          myFuture99.then((value) {
            verilerimKullan = value;
            if (aileUyesi == "1") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[0].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "2") {
              debugPrint("sdfdsfds" + verilerimKullan[1].y.round().toString());
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[1].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "3") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[2].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "4") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[3].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[4].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
            if (aileUyesi == "5+") {
              if (giderMiktarListesiKullan[4] >
                  (((verilerimKullan[5].y.round()) * 80) / 100)) {
                alertCikartYapayZeka();
              }
            }
          });
        }
        if (ay == 1) {
          if (giderMiktarListesiKullan[0] > gelirMiktarListesiKullan[0]) {
            alertCikartGelirGider("Ocak");
          }
          if (giderMiktarListesiKullan[1] > giderMiktarListesiKullan[11]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (ocakGida > 300) {
              alertCikartKategori("Ocak", "Gıda", "300");
            }
            if (ocakUlasim > 140) {
              alertCikartKategori("Ocak", "Ulaşım", "140");
            }
            if (ocakEglence > 500) {
              alertCikartKategori("Ocak", "Eğlence", "500");
            }
            if (ocakFatura > 450) {
              alertCikartKategori("Ocak", "Fatura", "450");
            }
            if (ocakGiyim > 300) {
              alertCikartKategori("Ocak", "Giyim", "300");
            }
          }

          if (aileUyesi == "2") {
            if (ocakGida > 450) {
              alertCikartKategori("Ocak", "Gıda", "450");
            }
            if (ocakUlasim > 200) {
              alertCikartKategori("Ocak", "Ulaşım", "200");
            }
            if (ocakEglence > 700) {
              alertCikartKategori("Ocak", "Eğlence", "700");
            }
            if (ocakFatura > 500) {
              alertCikartKategori("Ocak", "Fatura", "500");
            }
            if (ocakGiyim > 500) {
              alertCikartKategori("Ocak", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (ocakGida > 550) {
              alertCikartKategori("Ocak", "Gıda", "550");
            }
            if (ocakUlasim > 250) {
              alertCikartKategori("Ocak", "Ulaşım", "250");
            }
            if (ocakEglence > 800) {
              alertCikartKategori("Ocak", "Eğlence", "800");
            }
            if (ocakFatura > 600) {
              alertCikartKategori("Ocak", "Fatura", "600");
            }
            if (ocakGiyim > 700) {
              alertCikartKategori("Ocak", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (ocakGida > 650) {
              alertCikartKategori("Ocak", "Gıda", "650");
            }
            if (ocakUlasim > 300) {
              alertCikartKategori("Ocak", "Ulaşım", "300");
            }
            if (ocakEglence > 900) {
              alertCikartKategori("Ocak", "Eğlence", "900");
            }
            if (ocakFatura > 700) {
              alertCikartKategori("Ocak", "Fatura", "700");
            }
            if (ocakGiyim > 800) {
              alertCikartKategori("Ocak", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (ocakGida > 750) {
              alertCikartKategori("Ocak", "Gıda", "750");
            }
            if (ocakUlasim > 350) {
              alertCikartKategori("Ocak", "Ulaşım", "350");
            }
            if (ocakEglence > 1000) {
              alertCikartKategori("Ocak", "Eğlence", "1000");
            }
            if (ocakFatura > 750) {
              alertCikartKategori("Ocak", "Fatura", "750");
            }
            if (ocakGiyim > 900) {
              alertCikartKategori("Ocak", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (ocakGida > 850) {
              alertCikartKategori("Ocak", "Gıda", "850");
            }
            if (ocakUlasim > 400) {
              alertCikartKategori("Ocak", "Ulaşım", "400");
            }
            if (ocakEglence > 1100) {
              alertCikartKategori("Ocak", "Eğlence", "1100");
            }
            if (ocakFatura > 850) {
              alertCikartKategori("Ocak", "Fatura", "850");
            }
            if (ocakGiyim > 1000) {
              alertCikartKategori("Ocak", "Giyim", "1000");
            }
          }
        }
        if (ay == 2) {
          if (giderMiktarListesiKullan[1] > gelirMiktarListesiKullan[1]) {
            alertCikartGelirGider("Şubat");
          }
          if (giderMiktarListesiKullan[1] > giderMiktarListesiKullan[0]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (subatGida > 300) {
              alertCikartKategori("Şubat", "Gıda", "300");
            }
            if (subatUlasim > 140) {
              alertCikartKategori("Şubat", "Ulaşım", "140");
            }
            if (subatEglence > 500) {
              alertCikartKategori("Şubat", "Eğlence", "500");
            }
            if (subatFatura > 450) {
              alertCikartKategori("Şubat", "Fatura", "450");
            }
            if (subatGiyim > 300) {
              alertCikartKategori("Şubat", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (subatGida > 450) {
              alertCikartKategori("Şubat", "Gıda", "450");
            }
            if (subatUlasim > 200) {
              alertCikartKategori("Şubat", "Ulaşım", "200");
            }
            if (subatEglence > 700) {
              alertCikartKategori("Şubat", "Eğlence", "700");
            }
            if (subatFatura > 500) {
              alertCikartKategori("Şubat", "Fatura", "500");
            }
            if (subatGiyim > 500) {
              alertCikartKategori("Şubat", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (subatGida > 550) {
              alertCikartKategori("Şubat", "Gıda", "550");
            }
            if (subatUlasim > 250) {
              alertCikartKategori("Şubat", "Ulaşım", "250");
            }
            if (subatEglence > 800) {
              alertCikartKategori("Şubat", "Eğlence", "800");
            }
            if (subatFatura > 600) {
              alertCikartKategori("Şubat", "Fatura", "600");
            }
            if (subatGiyim > 700) {
              alertCikartKategori("Şubat", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (subatGida > 650) {
              alertCikartKategori("Şubat", "Gıda", "650");
            }
            if (subatUlasim > 300) {
              alertCikartKategori("Şubat", "Ulaşım", "300");
            }
            if (subatEglence > 900) {
              alertCikartKategori("Şubat", "Eğlence", "900");
            }
            if (subatFatura > 700) {
              alertCikartKategori("Şubat", "Fatura", "700");
            }
            if (subatGiyim > 800) {
              alertCikartKategori("Şubat", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (subatGida > 750) {
              alertCikartKategori("Şubat", "Gıda", "750");
            }
            if (subatUlasim > 350) {
              alertCikartKategori("Şubat", "Ulaşım", "350");
            }
            if (subatEglence > 1000) {
              alertCikartKategori("Şubat", "Eğlence", "1000");
            }
            if (subatFatura > 750) {
              alertCikartKategori("Şubat", "Fatura", "750");
            }
            if (subatGiyim > 900) {
              alertCikartKategori("Şubat", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (subatGida > 850) {
              alertCikartKategori("Şubat", "Gıda", "850");
            }
            if (subatUlasim > 400) {
              alertCikartKategori("Şubat", "Ulaşım", "400");
            }
            if (subatEglence > 1100) {
              alertCikartKategori("Şubat", "Eğlence", "1100");
            }
            if (subatFatura > 850) {
              alertCikartKategori("Şubat", "Fatura", "850");
            }
            if (subatGiyim > 1000) {
              alertCikartKategori("Şubat", "Giyim", "1000");
            }
          }
        }
        if (ay == 3) {
          if (giderMiktarListesiKullan[2] > gelirMiktarListesiKullan[2]) {
            alertCikartGelirGider("Mart");
          }
          if (giderMiktarListesiKullan[2] > giderMiktarListesiKullan[1]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (martGida > 300) {
              alertCikartKategori("Mart", "Gıda", "300");
            }
            if (martUlasim > 140) {
              alertCikartKategori("Mart", "Ulaşım", "140");
            }
            if (martEglence > 500) {
              alertCikartKategori("Mart", "Eğlence", "500");
            }
            if (martFatura > 450) {
              alertCikartKategori("Mart", "Fatura", "450");
            }
            if (martGiyim > 300) {
              alertCikartKategori("Mart", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (martGida > 450) {
              alertCikartKategori("Mart", "Gıda", "450");
            }
            if (martUlasim > 200) {
              alertCikartKategori("Mart", "Ulaşım", "200");
            }
            if (martEglence > 700) {
              alertCikartKategori("Mart", "Eğlence", "700");
            }
            if (martFatura > 500) {
              alertCikartKategori("Mart", "Fatura", "500");
            }
            if (martGiyim > 500) {
              alertCikartKategori("Mart", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (martGida > 550) {
              alertCikartKategori("Mart", "Gıda", "550");
            }
            if (martUlasim > 250) {
              alertCikartKategori("Mart", "Ulaşım", "250");
            }
            if (martEglence > 800) {
              alertCikartKategori("Mart", "Eğlence", "800");
            }
            if (martFatura > 600) {
              alertCikartKategori("Mart", "Fatura", "600");
            }
            if (martGiyim > 700) {
              alertCikartKategori("Mart", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (martGida > 650) {
              alertCikartKategori("Mart", "Gıda", "650");
            }
            if (martUlasim > 300) {
              alertCikartKategori("Mart", "Ulaşım", "300");
            }
            if (martEglence > 900) {
              alertCikartKategori("Mart", "Eğlence", "900");
            }
            if (martFatura > 700) {
              alertCikartKategori("Mart", "Fatura", "700");
            }
            if (martGiyim > 800) {
              alertCikartKategori("Mart", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (martGida > 750) {
              alertCikartKategori("Mart", "Gıda", "750");
            }
            if (martUlasim > 350) {
              alertCikartKategori("Mart", "Ulaşım", "350");
            }
            if (martEglence > 1000) {
              alertCikartKategori("Mart", "Eğlence", "1000");
            }
            if (martFatura > 750) {
              alertCikartKategori("Mart", "Fatura", "750");
            }
            if (martGiyim > 900) {
              alertCikartKategori("Mart", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (martGida > 850) {
              alertCikartKategori("Mart", "Gıda", "850");
            }
            if (martUlasim > 400) {
              alertCikartKategori("Mart", "Ulaşım", "400");
            }
            if (martEglence > 1100) {
              alertCikartKategori("Mart", "Eğlence", "1100");
            }
            if (martFatura > 850) {
              alertCikartKategori("Mart", "Fatura", "850");
            }
            if (martGiyim > 1000) {
              alertCikartKategori("Mart", "Giyim", "1000");
            }
          }
        }
        if (ay == 4) {
          if (giderMiktarListesiKullan[3] > gelirMiktarListesiKullan[3]) {
            alertCikartGelirGider("Nisan");
          }
          if (giderMiktarListesiKullan[3] > giderMiktarListesiKullan[2]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (nisanGida > 300) {
              alertCikartKategori("Nisan", "Gıda", "300");
            }
            if (nisanUlasim > 140) {
              alertCikartKategori("Nisan", "Ulaşım", "140");
            }
            if (nisanEglence > 500) {
              alertCikartKategori("Nisan", "Eğlence", "500");
            }
            if (nisanFatura > 450) {
              alertCikartKategori("Nisan", "Fatura", "450");
            }
            if (nisanGiyim > 300) {
              alertCikartKategori("Nisan", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (nisanGida > 450) {
              alertCikartKategori("Nisan", "Gıda", "450");
            }
            if (nisanUlasim > 200) {
              alertCikartKategori("Nisan", "Ulaşım", "200");
            }
            if (nisanEglence > 700) {
              alertCikartKategori("Nisan", "Eğlence", "700");
            }
            if (nisanFatura > 500) {
              alertCikartKategori("Nisan", "Fatura", "500");
            }
            if (nisanGiyim > 500) {
              alertCikartKategori("Nisan", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (nisanGida > 550) {
              alertCikartKategori("Nisan", "Gıda", "550");
            }
            if (nisanUlasim > 250) {
              alertCikartKategori("Nisan", "Ulaşım", "250");
            }
            if (nisanEglence > 800) {
              alertCikartKategori("Nisan", "Eğlence", "800");
            }
            if (nisanFatura > 600) {
              alertCikartKategori("Nisan", "Fatura", "600");
            }
            if (nisanGiyim > 700) {
              alertCikartKategori("Nisan", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (nisanGida > 650) {
              alertCikartKategori("Nisan", "Gıda", "650");
            }
            if (nisanUlasim > 300) {
              alertCikartKategori("Nisan", "Ulaşım", "300");
            }
            if (nisanEglence > 900) {
              alertCikartKategori("Nisan", "Eğlence", "900");
            }
            if (nisanFatura > 700) {
              alertCikartKategori("Nisan", "Fatura", "700");
            }
            if (nisanGiyim > 800) {
              alertCikartKategori("Nisan", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (nisanGida > 750) {
              alertCikartKategori("Nisan", "Gıda", "750");
            }
            if (nisanUlasim > 350) {
              alertCikartKategori("Nisan", "Ulaşım", "350");
            }
            if (nisanEglence > 1000) {
              alertCikartKategori("Nisan", "Eğlence", "1000");
            }
            if (nisanFatura > 750) {
              alertCikartKategori("Nisan", "Fatura", "750");
            }
            if (nisanGiyim > 900) {
              alertCikartKategori("Nisan", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (nisanGida > 850) {
              alertCikartKategori("Nisan", "Gıda", "850");
            }
            if (nisanUlasim > 400) {
              alertCikartKategori("Nisan", "Ulaşım", "400");
            }
            if (nisanEglence > 1100) {
              alertCikartKategori("Nisan", "Eğlence", "1100");
            }
            if (nisanFatura > 850) {
              alertCikartKategori("Nisan", "Fatura", "850");
            }
            if (nisanGiyim > 1000) {
              alertCikartKategori("Nisan", "Giyim", "1000");
            }
          }
        }
        if (ay == 5) {
          if (giderMiktarListesiKullan[4] > gelirMiktarListesiKullan[4]) {
            alertCikartGelirGider("Mayıs");
          }
          if (giderMiktarListesiKullan[4] > giderMiktarListesiKullan[3]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (mayisGida > 300) {
              alertCikartKategori("Mayıs", "Gıda", "300");
            }
            if (mayisUlasim > 140) {
              alertCikartKategori("Mayıs", "Ulaşım", "140");
            }
            if (mayisEglence > 500) {
              alertCikartKategori("Mayıs", "Eğlence", "500");
            }
            if (mayisFatura > 450) {
              alertCikartKategori("Mayıs", "Fatura", "450");
            }
            if (mayisGiyim > 300) {
              alertCikartKategori("Mayıs", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (mayisGida > 450) {
              alertCikartKategori("Mayıs", "Gıda", "450");
            }
            if (mayisUlasim > 200) {
              alertCikartKategori("Mayıs", "Ulaşım", "200");
            }
            if (mayisEglence > 700) {
              alertCikartKategori("Mayıs", "Eğlence", "700");
            }
            if (mayisFatura > 500) {
              alertCikartKategori("Mayıs", "Fatura", "500");
            }
            if (mayisGiyim > 500) {
              alertCikartKategori("Mayıs", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (mayisGida > 550) {
              alertCikartKategori("Mayıs", "Gıda", "550");
            }
            if (mayisUlasim > 250) {
              alertCikartKategori("Mayıs", "Ulaşım", "250");
            }
            if (mayisEglence > 800) {
              alertCikartKategori("Mayıs", "Eğlence", "800");
            }
            if (mayisFatura > 600) {
              alertCikartKategori("Mayıs", "Fatura", "600");
            }
            if (mayisGiyim > 700) {
              alertCikartKategori("Mayıs", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (mayisGida > 650) {
              alertCikartKategori("Mayıs", "Gıda", "650");
            }
            if (mayisUlasim > 300) {
              alertCikartKategori("Mayıs", "Ulaşım", "300");
            }
            if (mayisEglence > 900) {
              alertCikartKategori("Mayıs", "Eğlence", "900");
            }
            if (mayisFatura > 700) {
              alertCikartKategori("Mayıs", "Fatura", "700");
            }
            if (mayisGiyim > 800) {
              alertCikartKategori("Mayıs", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (mayisGida > 750) {
              alertCikartKategori("Mayıs", "Gıda", "750");
            }
            if (mayisUlasim > 350) {
              alertCikartKategori("Mayıs", "Ulaşım", "350");
            }
            if (mayisEglence > 1000) {
              alertCikartKategori("Mayıs", "Eğlence", "1000");
            }
            if (mayisFatura > 750) {
              alertCikartKategori("Mayıs", "Fatura", "750");
            }
            if (mayisGiyim > 900) {
              alertCikartKategori("Mayıs", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (mayisGida > 850) {
              alertCikartKategori("Mayıs", "Gıda", "850");
            }
            if (mayisUlasim > 400) {
              alertCikartKategori("Mayıs", "Ulaşım", "400");
            }
            if (mayisEglence > 1100) {
              alertCikartKategori("Mayıs", "Eğlence", "1100");
            }
            if (mayisFatura > 850) {
              alertCikartKategori("Mayıs", "Fatura", "850");
            }
            if (mayisGiyim > 1000) {
              alertCikartKategori("Mayıs", "Giyim", "1000");
            }
          }
        }
        if (ay == 6) {
          if (giderMiktarListesiKullan[5] > gelirMiktarListesiKullan[5]) {
            alertCikartGelirGider("Haziran");
          }
          if (giderMiktarListesiKullan[5] > giderMiktarListesiKullan[4]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (haziranGida > 300) {
              alertCikartKategori("Haziran", "Gıda", "300");
            }
            if (haziranUlasim > 140) {
              alertCikartKategori("Haziran", "Ulaşım", "140");
            }
            if (haziranEglence > 500) {
              alertCikartKategori("Haziran", "Eğlence", "500");
            }
            if (haziranFatura > 450) {
              alertCikartKategori("Haziran", "Fatura", "450");
            }
            if (haziranGiyim > 300) {
              alertCikartKategori("Haziran", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (haziranGida > 450) {
              alertCikartKategori("Haziran", "Gıda", "450");
            }
            if (haziranUlasim > 200) {
              alertCikartKategori("Haziran", "Ulaşım", "200");
            }
            if (haziranEglence > 700) {
              alertCikartKategori("Haziran", "Eğlence", "700");
            }
            if (haziranFatura > 500) {
              alertCikartKategori("Haziran", "Fatura", "500");
            }
            if (haziranGiyim > 500) {
              alertCikartKategori("Haziran", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (haziranGida > 550) {
              alertCikartKategori("Haziran", "Gıda", "550");
            }
            if (haziranUlasim > 250) {
              alertCikartKategori("Haziran", "Ulaşım", "250");
            }
            if (haziranEglence > 800) {
              alertCikartKategori("Haziran", "Eğlence", "800");
            }
            if (haziranFatura > 600) {
              alertCikartKategori("Haziran", "Fatura", "600");
            }
            if (haziranGiyim > 700) {
              alertCikartKategori("Haziran", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (haziranGida > 650) {
              alertCikartKategori("Haziran", "Gıda", "650");
            }
            if (haziranUlasim > 300) {
              alertCikartKategori("Haziran", "Ulaşım", "300");
            }
            if (haziranEglence > 900) {
              alertCikartKategori("Haziran", "Eğlence", "900");
            }
            if (haziranFatura > 700) {
              alertCikartKategori("Haziran", "Fatura", "700");
            }
            if (haziranGiyim > 800) {
              alertCikartKategori("Haziran", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (haziranGida > 750) {
              alertCikartKategori("Haziran", "Gıda", "750");
            }
            if (haziranUlasim > 350) {
              alertCikartKategori("Haziran", "Ulaşım", "350");
            }
            if (haziranEglence > 1000) {
              alertCikartKategori("Haziran", "Eğlence", "1000");
            }
            if (haziranFatura > 750) {
              alertCikartKategori("Haziran", "Fatura", "750");
            }
            if (haziranGiyim > 900) {
              alertCikartKategori("Haziran", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (haziranGida > 850) {
              alertCikartKategori("Haziran", "Gıda", "850");
            }
            if (haziranUlasim > 400) {
              alertCikartKategori("Haziran", "Ulaşım", "400");
            }
            if (haziranEglence > 1100) {
              alertCikartKategori("Haziran", "Eğlence", "1100");
            }
            if (haziranFatura > 850) {
              alertCikartKategori("Haziran", "Fatura", "850");
            }
            if (haziranGiyim > 1000) {
              alertCikartKategori("Haziran", "Giyim", "1000");
            }
          }
        }
        if (ay == 7) {
          if (giderMiktarListesiKullan[6] > gelirMiktarListesiKullan[6]) {
            alertCikartGelirGider("Temmuz");
          }
          if (giderMiktarListesiKullan[6] > giderMiktarListesiKullan[5]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (temmuzGida > 300) {
              alertCikartKategori("Temmuz", "Gıda", "300");
            }
            if (temmuzUlasim > 140) {
              alertCikartKategori("Temmuz", "Ulaşım", "140");
            }
            if (temmuzEglence > 500) {
              alertCikartKategori("Temmuz", "Eğlence", "500");
            }
            if (temmuzFatura > 450) {
              alertCikartKategori("Temmuz", "Fatura", "450");
            }
            if (temmuzGiyim > 300) {
              alertCikartKategori("Temmuz", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (temmuzGida > 450) {
              alertCikartKategori("Temmuz", "Gıda", "450");
            }
            if (temmuzUlasim > 200) {
              alertCikartKategori("Temmuz", "Ulaşım", "200");
            }
            if (temmuzEglence > 700) {
              alertCikartKategori("Temmuz", "Eğlence", "700");
            }
            if (temmuzFatura > 500) {
              alertCikartKategori("Temmuz", "Fatura", "500");
            }
            if (temmuzGiyim > 500) {
              alertCikartKategori("Temmuz", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (temmuzGida > 550) {
              alertCikartKategori("Temmuz", "Gıda", "550");
            }
            if (temmuzUlasim > 250) {
              alertCikartKategori("Temmuz", "Ulaşım", "250");
            }
            if (temmuzEglence > 800) {
              alertCikartKategori("Temmuz", "Eğlence", "800");
            }
            if (temmuzFatura > 600) {
              alertCikartKategori("Temmuz", "Fatura", "600");
            }
            if (temmuzGiyim > 700) {
              alertCikartKategori("Temmuz", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (temmuzGida > 650) {
              alertCikartKategori("Temmuz", "Gıda", "650");
            }
            if (temmuzUlasim > 300) {
              alertCikartKategori("Temmuz", "Ulaşım", "300");
            }
            if (temmuzEglence > 900) {
              alertCikartKategori("Temmuz", "Eğlence", "900");
            }
            if (temmuzFatura > 700) {
              alertCikartKategori("Temmuz", "Fatura", "700");
            }
            if (temmuzGiyim > 800) {
              alertCikartKategori("Temmuz", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (temmuzGida > 750) {
              alertCikartKategori("Temmuz", "Gıda", "750");
            }
            if (temmuzUlasim > 350) {
              alertCikartKategori("Temmuz", "Ulaşım", "350");
            }
            if (temmuzEglence > 1000) {
              alertCikartKategori("Temmuz", "Eğlence", "1000");
            }
            if (temmuzFatura > 750) {
              alertCikartKategori("Temmuz", "Fatura", "750");
            }
            if (temmuzGiyim > 900) {
              alertCikartKategori("Temmuz", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (temmuzGida > 850) {
              alertCikartKategori("Temmuz", "Gıda", "850");
            }
            if (temmuzUlasim > 400) {
              alertCikartKategori("Temmuz", "Ulaşım", "400");
            }
            if (temmuzEglence > 1100) {
              alertCikartKategori("Temmuz", "Eğlence", "1100");
            }
            if (temmuzFatura > 850) {
              alertCikartKategori("Temmuz", "Fatura", "850");
            }
            if (temmuzGiyim > 1000) {
              alertCikartKategori("Temmuz", "Giyim", "1000");
            }
          }
        }
        if (ay == 8) {
          if (giderMiktarListesiKullan[7] > gelirMiktarListesiKullan[7]) {
            alertCikartGelirGider("Ağustos");
          }
          if (giderMiktarListesiKullan[7] > giderMiktarListesiKullan[6]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (agustosGida > 300) {
              alertCikartKategori("Ağustos", "Gıda", "300");
            }
            if (agustosUlasim > 140) {
              alertCikartKategori("Ağustos", "Ulaşım", "140");
            }
            if (agustosEglence > 500) {
              alertCikartKategori("Ağustos", "Eğlence", "500");
            }
            if (agustosFatura > 450) {
              alertCikartKategori("Ağustos", "Fatura", "450");
            }
            if (agustosGiyim > 300) {
              alertCikartKategori("Ağustos", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (agustosGida > 450) {
              alertCikartKategori("Ağustos", "Gıda", "450");
            }
            if (agustosUlasim > 200) {
              alertCikartKategori("Ağustos", "Ulaşım", "200");
            }
            if (agustosEglence > 700) {
              alertCikartKategori("Ağustos", "Eğlence", "700");
            }
            if (agustosFatura > 500) {
              alertCikartKategori("Ağustos", "Fatura", "500");
            }
            if (agustosGiyim > 500) {
              alertCikartKategori("Ağustos", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (agustosGida > 550) {
              alertCikartKategori("Ağustos", "Gıda", "550");
            }
            if (agustosUlasim > 250) {
              alertCikartKategori("Ağustos", "Ulaşım", "250");
            }
            if (agustosEglence > 800) {
              alertCikartKategori("Ağustos", "Eğlence", "800");
            }
            if (agustosFatura > 600) {
              alertCikartKategori("Ağustos", "Fatura", "600");
            }
            if (agustosGiyim > 700) {
              alertCikartKategori("Ağustos", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (agustosGida > 650) {
              alertCikartKategori("Ağustos", "Gıda", "650");
            }
            if (agustosUlasim > 300) {
              alertCikartKategori("Ağustos", "Ulaşım", "300");
            }
            if (agustosEglence > 900) {
              alertCikartKategori("Ağustos", "Eğlence", "900");
            }
            if (agustosFatura > 700) {
              alertCikartKategori("Ağustos", "Fatura", "700");
            }
            if (agustosGiyim > 800) {
              alertCikartKategori("Ağustos", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (agustosGida > 750) {
              alertCikartKategori("Ağustos", "Gıda", "750");
            }
            if (agustosUlasim > 350) {
              alertCikartKategori("Ağustos", "Ulaşım", "350");
            }
            if (agustosEglence > 1000) {
              alertCikartKategori("Ağustos", "Eğlence", "1000");
            }
            if (agustosFatura > 750) {
              alertCikartKategori("Ağustos", "Fatura", "750");
            }
            if (agustosGiyim > 900) {
              alertCikartKategori("Ağustos", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (agustosGida > 850) {
              alertCikartKategori("Ağustos", "Gıda", "850");
            }
            if (agustosUlasim > 400) {
              alertCikartKategori("Ağustos", "Ulaşım", "400");
            }
            if (agustosEglence > 1100) {
              alertCikartKategori("Ağustos", "Eğlence", "1100");
            }
            if (agustosFatura > 850) {
              alertCikartKategori("Ağustos", "Fatura", "850");
            }
            if (agustosGiyim > 1000) {
              alertCikartKategori("Ağustos", "Giyim", "1000");
            }
          }
        }
        if (ay == 9) {
          if (giderMiktarListesiKullan[8] > gelirMiktarListesiKullan[8]) {
            alertCikartGelirGider("Eylül");
          }
          if (giderMiktarListesiKullan[8] > giderMiktarListesiKullan[7]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (eylulGida > 300) {
              alertCikartKategori("Eylül", "Gıda", "300");
            }
            if (eylulUlasim > 140) {
              alertCikartKategori("Eylül", "Ulaşım", "140");
            }
            if (eylulEglence > 500) {
              alertCikartKategori("Eylül", "Eğlence", "500");
            }
            if (eylulFatura > 450) {
              alertCikartKategori("Eylül", "Fatura", "450");
            }
            if (eylulGiyim > 300) {
              alertCikartKategori("Eylül", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (eylulGida > 450) {
              alertCikartKategori("Eylül", "Gıda", "450");
            }
            if (eylulUlasim > 200) {
              alertCikartKategori("Eylül", "Ulaşım", "200");
            }
            if (eylulEglence > 700) {
              alertCikartKategori("Eylül", "Eğlence", "700");
            }
            if (eylulFatura > 500) {
              alertCikartKategori("Eylül", "Fatura", "500");
            }
            if (eylulGiyim > 500) {
              alertCikartKategori("Eylül", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (eylulGida > 550) {
              alertCikartKategori("Eylül", "Gıda", "550");
            }
            if (eylulUlasim > 250) {
              alertCikartKategori("Eylül", "Ulaşım", "250");
            }
            if (eylulEglence > 800) {
              alertCikartKategori("Eylül", "Eğlence", "800");
            }
            if (eylulFatura > 600) {
              alertCikartKategori("Eylül", "Fatura", "600");
            }
            if (eylulGiyim > 700) {
              alertCikartKategori("Eylül", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (eylulGida > 650) {
              alertCikartKategori("Eylül", "Gıda", "650");
            }
            if (eylulUlasim > 300) {
              alertCikartKategori("Eylül", "Ulaşım", "300");
            }
            if (eylulEglence > 900) {
              alertCikartKategori("Eylül", "Eğlence", "900");
            }
            if (eylulFatura > 700) {
              alertCikartKategori("Eylül", "Fatura", "700");
            }
            if (eylulGiyim > 800) {
              alertCikartKategori("Eylül", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (eylulGida > 750) {
              alertCikartKategori("Eylül", "Gıda", "750");
            }
            if (eylulUlasim > 350) {
              alertCikartKategori("Eylül", "Ulaşım", "350");
            }
            if (eylulEglence > 1000) {
              alertCikartKategori("Eylül", "Eğlence", "1000");
            }
            if (eylulFatura > 750) {
              alertCikartKategori("Eylül", "Fatura", "750");
            }
            if (eylulGiyim > 900) {
              alertCikartKategori("Eylül", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (eylulGida > 850) {
              alertCikartKategori("Eylül", "Gıda", "850");
            }
            if (eylulUlasim > 400) {
              alertCikartKategori("Eylül", "Ulaşım", "400");
            }
            if (eylulEglence > 1100) {
              alertCikartKategori("Eylül", "Eğlence", "1100");
            }
            if (eylulFatura > 850) {
              alertCikartKategori("Eylül", "Fatura", "850");
            }
            if (eylulGiyim > 1000) {
              alertCikartKategori("Eylül", "Giyim", "1000");
            }
          }
        }
        if (ay == 10) {
          if (giderMiktarListesiKullan[9] > gelirMiktarListesiKullan[9]) {
            alertCikartGelirGider("Ekim");
          }
          if (giderMiktarListesiKullan[9] > giderMiktarListesiKullan[8]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (ekimGida > 300) {
              alertCikartKategori("Ekim", "Gıda", "300");
            }
            if (ekimUlasim > 140) {
              alertCikartKategori("Ekim", "Ulaşım", "140");
            }
            if (ekimEglence > 500) {
              alertCikartKategori("Ekim", "Eğlence", "500");
            }
            if (ekimFatura > 450) {
              alertCikartKategori("Ekim", "Fatura", "450");
            }
            if (ekimGiyim > 300) {
              alertCikartKategori("Ekim", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (ekimGida > 450) {
              alertCikartKategori("Ekim", "Gıda", "450");
            }
            if (ekimUlasim > 200) {
              alertCikartKategori("Ekim", "Ulaşım", "200");
            }
            if (ekimEglence > 700) {
              alertCikartKategori("Ekim", "Eğlence", "700");
            }
            if (ekimFatura > 500) {
              alertCikartKategori("Ekim", "Fatura", "500");
            }
            if (ekimGiyim > 500) {
              alertCikartKategori("Ekim", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (ekimGida > 550) {
              alertCikartKategori("Ekim", "Gıda", "550");
            }
            if (ekimUlasim > 250) {
              alertCikartKategori("Ekim", "Ulaşım", "250");
            }
            if (ekimEglence > 800) {
              alertCikartKategori("Ekim", "Eğlence", "800");
            }
            if (ekimFatura > 600) {
              alertCikartKategori("Ekim", "Fatura", "600");
            }
            if (ekimGiyim > 700) {
              alertCikartKategori("Ekim", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (ekimGida > 650) {
              alertCikartKategori("Ekim", "Gıda", "650");
            }
            if (ekimUlasim > 300) {
              alertCikartKategori("Ekim", "Ulaşım", "300");
            }
            if (ekimEglence > 900) {
              alertCikartKategori("Ekim", "Eğlence", "900");
            }
            if (ekimFatura > 700) {
              alertCikartKategori("Ekim", "Fatura", "700");
            }
            if (ekimGiyim > 800) {
              alertCikartKategori("Ekim", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (ekimGida > 750) {
              alertCikartKategori("Ekim", "Gıda", "750");
            }
            if (ekimUlasim > 350) {
              alertCikartKategori("Ekim", "Ulaşım", "350");
            }
            if (ekimEglence > 1000) {
              alertCikartKategori("Ekim", "Eğlence", "1000");
            }
            if (ekimFatura > 750) {
              alertCikartKategori("Ekim", "Fatura", "750");
            }
            if (ekimGiyim > 900) {
              alertCikartKategori("Ekim", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (ekimGida > 850) {
              alertCikartKategori("Ekim", "Gıda", "850");
            }
            if (ekimUlasim > 400) {
              alertCikartKategori("Ekim", "Ulaşım", "400");
            }
            if (ekimEglence > 1100) {
              alertCikartKategori("Ekim", "Eğlence", "1100");
            }
            if (ekimFatura > 850) {
              alertCikartKategori("Ekim", "Fatura", "850");
            }
            if (ekimGiyim > 1000) {
              alertCikartKategori("Ekim", "Giyim", "1000");
            }
          }
        }
        if (ay == 11) {
          if (giderMiktarListesiKullan[10] > gelirMiktarListesiKullan[10]) {
            alertCikartGelirGider("Kasım");
          }
          if (giderMiktarListesiKullan[10] > giderMiktarListesiKullan[9]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (kasimGida > 300) {
              alertCikartKategori("Kasım", "Gıda", "300");
            }
            if (kasimUlasim > 140) {
              alertCikartKategori("Kasım", "Ulaşım", "140");
            }
            if (kasimEglence > 500) {
              alertCikartKategori("Kasım", "Eğlence", "500");
            }
            if (kasimFatura > 450) {
              alertCikartKategori("Kasım", "Fatura", "450");
            }
            if (kasimGiyim > 300) {
              alertCikartKategori("Kasım", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (kasimGida > 450) {
              alertCikartKategori("Kasım", "Gıda", "450");
            }
            if (kasimUlasim > 200) {
              alertCikartKategori("Kasım", "Ulaşım", "200");
            }
            if (kasimEglence > 700) {
              alertCikartKategori("Kasım", "Eğlence", "700");
            }
            if (kasimFatura > 500) {
              alertCikartKategori("Kasım", "Fatura", "500");
            }
            if (kasimGiyim > 500) {
              alertCikartKategori("Kasım", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (kasimGida > 550) {
              alertCikartKategori("Kasım", "Gıda", "550");
            }
            if (kasimUlasim > 250) {
              alertCikartKategori("Kasım", "Ulaşım", "250");
            }
            if (kasimEglence > 800) {
              alertCikartKategori("Kasım", "Eğlence", "800");
            }
            if (kasimFatura > 600) {
              alertCikartKategori("Kasım", "Fatura", "600");
            }
            if (kasimGiyim > 700) {
              alertCikartKategori("Kasım", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (kasimGida > 650) {
              alertCikartKategori("Kasım", "Gıda", "650");
            }
            if (kasimUlasim > 300) {
              alertCikartKategori("Kasım", "Ulaşım", "300");
            }
            if (kasimEglence > 900) {
              alertCikartKategori("Kasım", "Eğlence", "900");
            }
            if (kasimFatura > 700) {
              alertCikartKategori("Kasım", "Fatura", "700");
            }
            if (kasimGiyim > 800) {
              alertCikartKategori("Kasım", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (kasimGida > 750) {
              alertCikartKategori("Kasım", "Gıda", "750");
            }
            if (kasimUlasim > 350) {
              alertCikartKategori("Kasım", "Ulaşım", "350");
            }
            if (kasimEglence > 1000) {
              alertCikartKategori("Kasım", "Eğlence", "1000");
            }
            if (kasimFatura > 750) {
              alertCikartKategori("Kasım", "Fatura", "750");
            }
            if (kasimGiyim > 900) {
              alertCikartKategori("Kasım", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (kasimGida > 850) {
              alertCikartKategori("Kasım", "Gıda", "850");
            }
            if (kasimUlasim > 400) {
              alertCikartKategori("Kasım", "Ulaşım", "400");
            }
            if (kasimEglence > 1100) {
              alertCikartKategori("Kasım", "Eğlence", "1100");
            }
            if (kasimFatura > 850) {
              alertCikartKategori("Kasım", "Fatura", "850");
            }
            if (kasimGiyim > 1000) {
              alertCikartKategori("Kasım", "Giyim", "1000");
            }
          }
        }
        if (ay == 12) {
          if (giderMiktarListesiKullan[11] > gelirMiktarListesiKullan[11]) {
            alertCikartGelirGider("Aralık");
          }
          if (giderMiktarListesiKullan[11] > giderMiktarListesiKullan[10]) {
            alertCikartOncekiAy();
          }
          if (aileUyesi == "1") {
            if (aralikGida > 300) {
              alertCikartKategori("Aralık", "Gıda", "300");
            }
            if (aralikUlasim > 140) {
              alertCikartKategori("Aralık", "Ulaşım", "140");
            }
            if (aralikEglence > 500) {
              alertCikartKategori("Aralık", "Eğlence", "500");
            }
            if (aralikFatura > 450) {
              alertCikartKategori("Aralık", "Fatura", "450");
            }
            if (aralikGiyim > 300) {
              alertCikartKategori("Aralık", "Giyim", "300");
            }
          }
          if (aileUyesi == "2") {
            if (aralikGida > 450) {
              alertCikartKategori("Aralık", "Gıda", "450");
            }
            if (aralikUlasim > 200) {
              alertCikartKategori("Aralık", "Ulaşım", "200");
            }
            if (aralikEglence > 700) {
              alertCikartKategori("Aralık", "Eğlence", "700");
            }
            if (aralikFatura > 500) {
              alertCikartKategori("Aralık", "Fatura", "500");
            }
            if (aralikGiyim > 500) {
              alertCikartKategori("Aralık", "Giyim", "500");
            }
          }

          if (aileUyesi == "3") {
            if (aralikGida > 550) {
              alertCikartKategori("Aralık", "Gıda", "550");
            }
            if (aralikUlasim > 250) {
              alertCikartKategori("Aralık", "Ulaşım", "250");
            }
            if (aralikEglence > 800) {
              alertCikartKategori("Aralık", "Eğlence", "800");
            }
            if (aralikFatura > 600) {
              alertCikartKategori("Aralık", "Fatura", "600");
            }
            if (aralikGiyim > 700) {
              alertCikartKategori("Aralık", "Giyim", "700");
            }
          }
          if (aileUyesi == "4") {
            if (aralikGida > 650) {
              alertCikartKategori("Aralık", "Gıda", "650");
            }
            if (aralikUlasim > 300) {
              alertCikartKategori("Aralık", "Ulaşım", "300");
            }
            if (aralikEglence > 900) {
              alertCikartKategori("Aralık", "Eğlence", "900");
            }
            if (aralikFatura > 700) {
              alertCikartKategori("Aralık", "Fatura", "700");
            }
            if (aralikGiyim > 800) {
              alertCikartKategori("Aralık", "Giyim", "800");
            }
          }

          if (aileUyesi == "5") {
            if (aralikGida > 750) {
              alertCikartKategori("Aralık", "Gıda", "750");
            }
            if (aralikUlasim > 350) {
              alertCikartKategori("Aralık", "Ulaşım", "350");
            }
            if (aralikEglence > 1000) {
              alertCikartKategori("Aralık", "Eğlence", "1000");
            }
            if (aralikFatura > 750) {
              alertCikartKategori("Aralık", "Fatura", "750");
            }
            if (aralikGiyim > 900) {
              alertCikartKategori("Aralık", "Giyim", "900");
            }
          }

          if (aileUyesi == "5+") {
            if (aralikGida > 850) {
              alertCikartKategori("Aralık", "Gıda", "850");
            }
            if (aralikUlasim > 400) {
              alertCikartKategori("Aralık", "Ulaşım", "400");
            }
            if (aralikEglence > 1100) {
              alertCikartKategori("Aralık", "Eğlence", "1100");
            }
            if (aralikFatura > 850) {
              alertCikartKategori("Aralık", "Fatura", "850");
            }
            if (aralikGiyim > 1000) {
              alertCikartKategori("Aralık", "Giyim", "1000");
            }
          }
        }
      });
    });
  }

  var aileUyesi1;
  var aileUyesi2;
  var aileUyesi3;
  var aileUyesi4;
  var aileUyesi5;
  var aileUyesi5arti;

  Future yapayZekaHarcamaTahminiGetir58(context) async {
    String xmlString = await DefaultAssetBundle.of(context)
        .loadString("assets/ai/gelir_aileUyesi.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("tahmin58");

    var v111 = elements.map((element) {
      return Verilerim("5000-8000-1",
          double.parse(element.findElements("tahmin7").first.text));
    }).toList();
    var v222 = elements.map((element) {
      return Verilerim("5000-8000-2",
          double.parse(element.findElements("tahmin8").first.text));
    }).toList();
    var v333 = elements.map((element) {
      return Verilerim("5000-8000-3",
          double.parse(element.findElements("tahmin9").first.text));
    }).toList();
    var v444 = elements.map((element) {
      return Verilerim("5000-8000-4",
          double.parse(element.findElements("tahmin10").first.text));
    }).toList();
    var v555 = elements.map((element) {
      return Verilerim("5000-8000-5",
          double.parse(element.findElements("tahmin11").first.text));
    }).toList();
    var v666 = elements.map((element) {
      return Verilerim("5000-8000-6",
          double.parse(element.findElements("tahmin12").first.text));
    }).toList();
    var v1yS = v111[0].y.toString().substring(0, 7);
    var v2yS = v222[0].y.toString().substring(0, 7);
    var v3yS = v333[0].y.toString().substring(0, 7);
    var v4yS = v444[0].y.toString().substring(0, 7);
    var v5yS = v555[0].y.toString().substring(0, 7);
    var v6yS = v666[0].y.toString().substring(0, 7);

    Verilerim v1 = Verilerim("1", double.parse(v1yS));
    Verilerim v2 = Verilerim("2", double.parse(v2yS));
    Verilerim v3 = Verilerim("3", double.parse(v3yS));
    Verilerim v4 = Verilerim("4", double.parse(v4yS));
    Verilerim v5 = Verilerim("5", double.parse(v5yS));
    Verilerim v6 = Verilerim("6", double.parse(v6yS));

    verilerim = [
      v1,
      v2,
      v3,
      v4,
      v5,
      v6,
    ];

    //verilerim = [v1,v2,v3,v4,v5,v6]
    return verilerim;
  }

  Future yapayZekaHarcamaTahminiGetir25(context) async {
    String xmlString = await DefaultAssetBundle.of(context)
        .loadString("assets/ai/gelir_aileUyesi.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("tahmin25a");

    var v111 = elements.map((element) {
      return Verilerim("2000-5000-1",
          double.parse(element.findElements("tahmin1").first.text));
    }).toList();
    var v222 = elements.map((element) {
      return Verilerim("2000-5000-2",
          double.parse(element.findElements("tahmin2").first.text));
    }).toList();
    var v333 = elements.map((element) {
      return Verilerim("2000-5000-3",
          double.parse(element.findElements("tahmin3").first.text));
    }).toList();
    var v444 = elements.map((element) {
      return Verilerim("2000-5000-4",
          double.parse(element.findElements("tahmin4").first.text));
    }).toList();
    var v555 = elements.map((element) {
      return Verilerim("2000-5000-5",
          double.parse(element.findElements("tahmin5").first.text));
    }).toList();
    var v666 = elements.map((element) {
      return Verilerim("2000-5000-6",
          double.parse(element.findElements("tahmin6").first.text));
    }).toList();
    var v1yS = v111[0].y.toString().substring(0, 7);
    var v2yS = v222[0].y.toString().substring(0, 7);
    var v3yS = v333[0].y.toString().substring(0, 7);
    var v4yS = v444[0].y.toString().substring(0, 7);
    var v5yS = v555[0].y.toString().substring(0, 7);
    var v6yS = v666[0].y.toString().substring(0, 7);

    Verilerim v1 = Verilerim("1", double.parse(v1yS));
    Verilerim v2 = Verilerim("2", double.parse(v2yS));
    Verilerim v3 = Verilerim("3", double.parse(v3yS));
    Verilerim v4 = Verilerim("4", double.parse(v4yS));
    Verilerim v5 = Verilerim("5", double.parse(v5yS));
    Verilerim v6 = Verilerim("6", double.parse(v6yS));

    verilerim = [
      v1,
      v2,
      v3,
      v4,
      v5,
      v6,
    ];

    //verilerim = [v1,v2,v3,v4,v5,v6]
    return verilerim;
  }

  Future yapayZekaHarcamaTahminiGetir810(context) async {
    String xmlString = await DefaultAssetBundle.of(context)
        .loadString("assets/ai/gelir_aileUyesi.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("tahmin810");

    var v111 = elements.map((element) {
      return Verilerim("8000-10000-1",
          double.parse(element.findElements("tahmin13").first.text));
    }).toList();
    var v222 = elements.map((element) {
      return Verilerim("8000-10000-2",
          double.parse(element.findElements("tahmin14").first.text));
    }).toList();
    var v333 = elements.map((element) {
      return Verilerim("8000-10000-3",
          double.parse(element.findElements("tahmin15").first.text));
    }).toList();
    var v444 = elements.map((element) {
      return Verilerim("8000-10000-4",
          double.parse(element.findElements("tahmin16").first.text));
    }).toList();
    var v555 = elements.map((element) {
      return Verilerim("8000-10000-5",
          double.parse(element.findElements("tahmin17").first.text));
    }).toList();
    var v666 = elements.map((element) {
      return Verilerim("8000-10000-6",
          double.parse(element.findElements("tahmin18").first.text));
    }).toList();
    var v1yS = v111[0].y.toString().substring(0, 7);
    var v2yS = v222[0].y.toString().substring(0, 7);
    var v3yS = v333[0].y.toString().substring(0, 7);
    var v4yS = v444[0].y.toString().substring(0, 7);
    var v5yS = v555[0].y.toString().substring(0, 7);
    var v6yS = v666[0].y.toString().substring(0, 7);

    Verilerim v1 = Verilerim("1", double.parse(v1yS));
    Verilerim v2 = Verilerim("2", double.parse(v2yS));
    Verilerim v3 = Verilerim("3", double.parse(v3yS));
    Verilerim v4 = Verilerim("4", double.parse(v4yS));
    Verilerim v5 = Verilerim("5", double.parse(v5yS));
    Verilerim v6 = Verilerim("6", double.parse(v6yS));

    verilerim = [
      v1,
      v2,
      v3,
      v4,
      v5,
      v6,
    ];

    return verilerim;
  }

  Future yapayZekaHarcamaTahminiGetir1015(context) async {
    String xmlString = await DefaultAssetBundle.of(context)
        .loadString("assets/ai/gelir_aileUyesi.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("tahmin1015");

    var v111 = elements.map((element) {
      return Verilerim("10000-15000-1",
          double.parse(element.findElements("tahmin19").first.text));
    }).toList();
    var v222 = elements.map((element) {
      return Verilerim("10000-15000-2",
          double.parse(element.findElements("tahmin20").first.text));
    }).toList();
    var v333 = elements.map((element) {
      return Verilerim("10000-15000-3",
          double.parse(element.findElements("tahmin21").first.text));
    }).toList();
    var v444 = elements.map((element) {
      return Verilerim("10000-15000-4",
          double.parse(element.findElements("tahmin22").first.text));
    }).toList();
    var v555 = elements.map((element) {
      return Verilerim("10000-15000-5",
          double.parse(element.findElements("tahmin23").first.text));
    }).toList();
    var v666 = elements.map((element) {
      return Verilerim("10000-15000-6",
          double.parse(element.findElements("tahmin24").first.text));
    }).toList();
    var v1yS = v111[0].y.toString().substring(0, 7);
    var v2yS = v222[0].y.toString().substring(0, 7);
    var v3yS = v333[0].y.toString().substring(0, 7);
    var v4yS = v444[0].y.toString().substring(0, 7);
    var v5yS = v555[0].y.toString().substring(0, 7);
    var v6yS = v666[0].y.toString().substring(0, 7);

    Verilerim v1 = Verilerim("1", double.parse(v1yS));
    Verilerim v2 = Verilerim("2", double.parse(v2yS));
    Verilerim v3 = Verilerim("3", double.parse(v3yS));
    Verilerim v4 = Verilerim("4", double.parse(v4yS));
    Verilerim v5 = Verilerim("5", double.parse(v5yS));
    Verilerim v6 = Verilerim("6", double.parse(v6yS));

    verilerim = [
      v1,
      v2,
      v3,
      v4,
      v5,
      v6,
    ];

    return verilerim;
  }

  Future yapayZekaHarcamaTahminiGetir1520(context) async {
    String xmlString = await DefaultAssetBundle.of(context)
        .loadString("assets/ai/gelir_aileUyesi.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("tahmin1520");

    var v111 = elements.map((element) {
      return Verilerim("15000-20000-1",
          double.parse(element.findElements("tahmin25").first.text));
    }).toList();
    var v222 = elements.map((element) {
      return Verilerim("15000-20000-2",
          double.parse(element.findElements("tahmin26").first.text));
    }).toList();
    var v333 = elements.map((element) {
      return Verilerim("15000-20000-3",
          double.parse(element.findElements("tahmin27").first.text));
    }).toList();
    var v444 = elements.map((element) {
      return Verilerim("15000-20000-4",
          double.parse(element.findElements("tahmin28").first.text));
    }).toList();
    var v555 = elements.map((element) {
      return Verilerim("15000-20000-5",
          double.parse(element.findElements("tahmin29").first.text));
    }).toList();
    var v666 = elements.map((element) {
      return Verilerim("15000-20000-6",
          double.parse(element.findElements("tahmin30").first.text));
    }).toList();
    var v1yS = v111[0].y.toString().substring(0, 7);
    var v2yS = v222[0].y.toString().substring(0, 7);
    var v3yS = v333[0].y.toString().substring(0, 7);
    var v4yS = v444[0].y.toString().substring(0, 7);
    var v5yS = v555[0].y.toString().substring(0, 7);
    var v6yS = v666[0].y.toString().substring(0, 7);

    Verilerim v1 = Verilerim("1", double.parse(v1yS));
    Verilerim v2 = Verilerim("2", double.parse(v2yS));
    Verilerim v3 = Verilerim("3", double.parse(v3yS));
    Verilerim v4 = Verilerim("4", double.parse(v4yS));
    Verilerim v5 = Verilerim("5", double.parse(v5yS));
    Verilerim v6 = Verilerim("6", double.parse(v6yS));

    verilerim = [
      v1,
      v2,
      v3,
      v4,
      v5,
      v6,
    ];

    return verilerim;
  }

  Future yapayZekaHarcamaTahminiGetir2050(context) async {
    String xmlString = await DefaultAssetBundle.of(context)
        .loadString("assets/ai/gelir_aileUyesi.xml");
    var raw = xml.XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("tahmin2050");

    var v111 = elements.map((element) {
      return Verilerim("15000-20000-1",
          double.parse(element.findElements("tahmin31").first.text));
    }).toList();
    var v222 = elements.map((element) {
      return Verilerim("15000-20000-2",
          double.parse(element.findElements("tahmin32").first.text));
    }).toList();
    var v333 = elements.map((element) {
      return Verilerim("15000-20000-3",
          double.parse(element.findElements("tahmin33").first.text));
    }).toList();
    var v444 = elements.map((element) {
      return Verilerim("15000-20000-4",
          double.parse(element.findElements("tahmin34").first.text));
    }).toList();
    var v555 = elements.map((element) {
      return Verilerim("15000-20000-5",
          double.parse(element.findElements("tahmin35").first.text));
    }).toList();
    var v666 = elements.map((element) {
      return Verilerim("15000-20000-6",
          double.parse(element.findElements("tahmin36").first.text));
    }).toList();
    var v1yS = v111[0].y.toString().substring(0, 7);
    var v2yS = v222[0].y.toString().substring(0, 7);
    var v3yS = v333[0].y.toString().substring(0, 7);
    var v4yS = v444[0].y.toString().substring(0, 7);
    var v5yS = v555[0].y.toString().substring(0, 7);
    var v6yS = v666[0].y.toString().substring(0, 7);

    Verilerim v1 = Verilerim("1", double.parse(v1yS));
    Verilerim v2 = Verilerim("2", double.parse(v2yS));
    Verilerim v3 = Verilerim("3", double.parse(v3yS));
    Verilerim v4 = Verilerim("4", double.parse(v4yS));
    Verilerim v5 = Verilerim("5", double.parse(v5yS));
    Verilerim v6 = Verilerim("6", double.parse(v6yS));

    verilerim = [
      v1,
      v2,
      v3,
      v4,
      v5,
      v6,
    ];

    return verilerim;
  }

  Future gelirleriGetir() async {
    var gelirMapi = await databaseHelper.gelirGetir();
    int ocak1 = 0;
    int subat2 = 0;
    int mart3 = 0;
    int nisan4 = 0;
    int mayis5 = 0;
    int haziran6 = 0;
    int temmuz7 = 0;
    int agustos8 = 0;
    int eylul9 = 0;
    int ekim10 = 0;
    int kasim11 = 0;
    int aralik12 = 0;
    for (Map okunanHarcamaMapi in gelirMapi) {
      gelirTarihListesi.add(okunanHarcamaMapi["gelirTarih"]);
      gelirMiktarListesi.add(okunanHarcamaMapi["gelirMiktari"]);
    }

    for (var i = 0; i < gelirTarihListesi.length; i++) {
      String temp = gelirTarihListesi[i];
      gelirTarihListesiDuzgunFormatta.add(temp.substring(5, 7));
    }

    debugPrint(gelirMiktarListesi.toString());
    debugPrint(gelirTarihListesiDuzgunFormatta.toString());

    for (var z = 0; z < gelirTarihListesiDuzgunFormatta.length; z++) {
      if (gelirTarihListesiDuzgunFormatta[z] == "01") {
        ocak1 = ocak1 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "02") {
        subat2 = subat2 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "03") {
        mart3 = mart3 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "04") {
        nisan4 = nisan4 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "05") {
        mayis5 = mayis5 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "06") {
        haziran6 = haziran6 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "07") {
        temmuz7 = temmuz7 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "08") {
        agustos8 = agustos8 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "09") {
        eylul9 = eylul9 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "10") {
        ekim10 = ekim10 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "11") {
        kasim11 = kasim11 + gelirMiktarListesi[z];
      }
      if (gelirTarihListesiDuzgunFormatta[z] == "12") {
        aralik12 = aralik12 + gelirMiktarListesi[z];
      }
    }

    gelirAylikListe = [
      ocak1,
      subat2,
      mart3,
      nisan4,
      mayis5,
      haziran6,
      temmuz7,
      agustos8,
      eylul9,
      ekim10,
      kasim11,
      aralik12
    ];
    return gelirAylikListe;
  }

  Future giderleriGetir() async {
    var harcamaMapi = await databaseHelper.giderGetir();
    int ocak1 = 0;
    int subat2 = 0;
    int mart3 = 0;
    int nisan4 = 0;
    int mayis5 = 0;
    int haziran6 = 0;
    int temmuz7 = 0;
    int agustos8 = 0;
    int eylul9 = 0;
    int ekim10 = 0;
    int kasim11 = 0;
    int aralik12 = 0;

    for (Map okunanHarcamaMapi in harcamaMapi) {
      harcamaTarihListesi.add(okunanHarcamaMapi["harcamaTarih"]);
      harcamaMiktarListesi.add(okunanHarcamaMapi["harcamaTutar"]);
    }

    for (var i = 0; i < harcamaTarihListesi.length; i++) {
      String temp = harcamaTarihListesi[i];
      harcamaTarihListesiDuzgunFormatta.add(temp.substring(5, 7));
    }

    for (var z = 0; z < harcamaTarihListesiDuzgunFormatta.length; z++) {
      if (harcamaTarihListesiDuzgunFormatta[z] == "01") {
        ocak1 = ocak1 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "02") {
        subat2 = subat2 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "03") {
        mart3 = mart3 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "04") {
        nisan4 = nisan4 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "05") {
        mayis5 = mayis5 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "06") {
        haziran6 = haziran6 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "07") {
        temmuz7 = temmuz7 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "08") {
        agustos8 = agustos8 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "09") {
        eylul9 = eylul9 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "10") {
        ekim10 = ekim10 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "11") {
        kasim11 = kasim11 + harcamaMiktarListesi[z];
      }
      if (harcamaTarihListesiDuzgunFormatta[z] == "12") {
        aralik12 = aralik12 + harcamaMiktarListesi[z];
      }
    }

    harcamaAylikListe = [
      ocak1,
      subat2,
      mart3,
      nisan4,
      mayis5,
      haziran6,
      temmuz7,
      agustos8,
      eylul9,
      ekim10,
      kasim11,
      aralik12
    ];
    return harcamaAylikListe;
  }

  alertCikartGelirGider(String hangiAy) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Harcama Alarmı',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('$hangiAy ayı giderleri gelirlerini geçti'),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Kapat'),
                      color: Colors.red[900],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  alertCikartOncekiAy() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Harcama Alarmı'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Önceki aydan fazla harcadın'),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Kapat'),
                      color: Colors.red[900],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  alertCikartKategori(String hangiAy, String hangiKategori, String kac) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Harcama Alarmı'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    '$hangiAy ayı $hangiKategori harcamaları $kac lirayı aştı '),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Kapat'),
                      color: Colors.red[900],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  alertCikartYapayZeka() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Harcama Alarmı'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Yapay Zekanın size özel tahmin etmiş olduğu harcama miktarının %80 ini geçtiniz \nHarcamalarınıza dikkat etmenizi öneririz'),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Kapat'),
                      color: Colors.red[900],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
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

class Verilerim {
  Verilerim(this.x, this.y);
  String x;
  double y;
}
