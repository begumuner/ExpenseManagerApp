import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_dersleri/models/gelirler.dart';
import 'package:flutter_firebase_dersleri/models/harcamalar.dart';
import 'package:flutter_firebase_dersleri/models/hesap_gelir.dart';
import 'package:flutter_firebase_dersleri/models/hesap_harcama.dart';
import 'package:flutter_firebase_dersleri/models/hesaplar.dart';
import 'package:flutter_firebase_dersleri/models/kategori.dart';
import 'package:flutter_firebase_dersleri/models/kategori_harcama.dart';
import 'package:flutter_firebase_dersleri/models/soru.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await initDB();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> initDB() async {
    var lock = Lock();
    Database _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "app.db");
          var file = new File(path);

          // check if file exists
          if (!await file.exists()) {
            // Copy from asset
            ByteData data =
                await rootBundle.load(join("assets", "harcamalar.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          // open the database
          _db = await openDatabase(path);
        }
      });
    }

    return _db;
  }

  Future<List<Map<String, dynamic>>> kategorileriGetir() async {
    var db = await getDatabase();
    var sonuc = await db.query('kategoriler', orderBy: 'kategoriID DESC');
    return sonuc;
  }

  Future<List<Kategori>> kategoriListesiniGetir() async {
    var map = await kategorileriGetir();
    var kategoriListesi = List<Kategori>();

    for (Map m in map) {
      kategoriListesi.add(Kategori.fromMap(m));
    }
    return kategoriListesi;
  }

  Future<int> kategoriEkle(Kategori kat) async {
    var db = await getDatabase();
    var sonuc = await db.insert("kategoriler", kat.toMap());
    return sonuc;
  }

  Future<int> kategoriGuncelle(Kategori kat) async {
    var db = await getDatabase();
    var sonuc = await db.update("kategoriler", kat.toMap(),
        where: 'kategoriID=?', whereArgs: [kat.kategoriID]);
    return sonuc;
  }

  Future<int> kategoriSil(int katID) async {
    var db = await getDatabase();
    var sonuc = await db
        .delete("kategoriler", where: 'kategoriID=?', whereArgs: [katID]);
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> harcamalariGetir() async {
    var db = await getDatabase();
    //var sonuc=await db.query('harcamalar');
    var sonuc = await db.rawQuery(
        "select * from harcamalar inner join kategoriler on kategoriler.kategoriID=harcamalar.kategoriID inner join hesaplar on hesaplar.hesapID=harcamalar.hesapID order by harcamaID Desc");
    return sonuc;
  }

  Future<List<Harcama>> harcamaListesiniGetir() async {
    var map = await harcamalariGetir();
    var harcamaListesi = List<Harcama>();

    for (Map m in map) {
      harcamaListesi.add(Harcama.fromMap(m));
    }
    return harcamaListesi;
  }

  Future<int> harcamaEkle(Harcama har) async {
    var db = await getDatabase();
    var sonuc = await db.insert("harcamalar", har.toMap());
    return sonuc;
  }

  Future<int> harcamaGuncelle(Harcama har) async {
    var db = await getDatabase();
    var sonuc = await db.update("harcamalar", har.toMap(),
        where: 'harcamaID=?', whereArgs: [har.harcamaID]);
    return sonuc;
  }

  Future<int> harcamaSil(int harID) async {
    var db = await getDatabase();
    var sonuc =
        await db.delete("harcamalar", where: 'harcamaID=?', whereArgs: [harID]);
    return sonuc;
  }

  Future<int> toplamHarcamalarGetir() async {
    var db = await getDatabase();

    List<Map> list = await db
        .rawQuery("select SUM(harcamaTutar) as harcamaTutar from harcamalar");
    return list.isNotEmpty ? list[0]["harcamaTutar"] : Null;
  }

  Future<List<Map<String, dynamic>>> kategoriyeGoreHarcamalariGetir() async {
    var db = await getDatabase();
    var sonuc = db.rawQuery(
        "select SUM(harcamaTutar) as harcamaTutar, kategoriAd from harcamalar inner join kategoriler on kategoriler.kategoriID=harcamalar.kategoriID group by kategoriAd");
    return sonuc;
  }

  Future<List<KategoriHarcama>> kategoriyeGoreHarcamalarListesiniGetir() async {
    var map = await kategoriyeGoreHarcamalariGetir();
    var harcamaListesi = List<KategoriHarcama>();

    for (Map m in map) {
      harcamaListesi.add(KategoriHarcama.fromMap(m));
    }
    return harcamaListesi;
  }

  Future<List<Map<String, dynamic>>> gelirleriGetir() async {
    var db = await getDatabase();
    //var sonuc=await db.query('harcamalar');
    var sonuc = await db.rawQuery(
        "select * from gelirler inner join hesaplar on gelirler.hesapID=hesaplar.hesapID order by hesapID Desc");
    return sonuc;
  }

  Future<List<Gelirler>> gelirListesiniGetir() async {
    var map = await gelirleriGetir();
    var gelirListesi = List<Gelirler>();

    for (Map m in map) {
      gelirListesi.add(Gelirler.fromMap(m));
    }
    return gelirListesi;
  }

  Future<int> gelirEkle(Gelirler g) async {
    var db = await getDatabase();
    var sonuc = await db.insert("gelirler", g.toMap());
    debugPrint("gelir eklendi");
    return sonuc;
  }

  Future<int> gelirGuncelle(Gelirler g) async {
    var db = await getDatabase();
    var sonuc = await db.update("gelirler", g.toMap(),
        where: 'gelirID=?', whereArgs: [g.gelirID]);
    return sonuc;
  }

  Future<int> gelirSil(int gID) async {
    var db = await getDatabase();
    var sonuc =
        await db.delete("gelirler", where: 'gelirID=?', whereArgs: [gID]);
    return sonuc;
  }

  Future<int> toplamGelirGetir() async {
    var db = await getDatabase();

    List<Map> list = await db
        .rawQuery("select SUM(gelirMiktari) as gelirMiktari from gelirler");
    return list.isNotEmpty ? list[0]["gelirMiktari"] : Null;
  }

  Future<List<Map<String, dynamic>>> hesaplariGetir() async {
    var db = await getDatabase();
    var sonuc = await db.query('hesaplar', orderBy: 'hesapID DESC');
    return sonuc;
  }

  Future<List<Hesaplar>> hesapListesiniGetir() async {
    var map = await hesaplariGetir();
    var hesapListesi = List<Hesaplar>();

    for (Map m in map) {
      hesapListesi.add(Hesaplar.fromMap(m));
    }
    return hesapListesi;
  }

  Future<int> hesapEkle(Hesaplar hesap) async {
    var db = await getDatabase();
    var sonuc = await db.insert("hesaplar", hesap.toMap());
    return sonuc;
  }

  Future<int> hesapGuncelle(Hesaplar hesap) async {
    var db = await getDatabase();
    var sonuc = await db.update("hesaplar", hesap.toMap(),
        where: 'hesapID=?', whereArgs: [hesap.hesapID]);
    return sonuc;
  }

  Future<int> hesapSil(int hID) async {
    var db = await getDatabase();
    var sonuc =
        await db.delete("hesaplar", where: 'hesapID=?', whereArgs: [hID]);
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> hesabaGoreHarcamalariGetir() async {
    var db = await getDatabase();
    var sonuc = db.rawQuery(
        "select SUM(harcamaTutar) as harcamaTutar, hesapAdi from harcamalar inner join hesaplar on hesaplar.hesapID=harcamalar.hesapID group by hesapAdi");
    return sonuc;
  }

  Future<List<HesapHarcama>> hesabaGoreHarcamalarListesiniGetir() async {
    var map = await hesabaGoreHarcamalariGetir();
    var hesapListesi = List<HesapHarcama>();

    for (Map m in map) {
      hesapListesi.add(HesapHarcama.fromMap(m));
    }
    return hesapListesi;
  }

  Future<List<Map<String, dynamic>>> hesabaGoreGelirGetir() async {
    var db = await getDatabase();
    var sonuc = db.rawQuery(
        "select SUM(gelirMiktari) as gelirMiktari, hesapAdi from gelirler inner join hesaplar on hesaplar.hesapID=gelirler.hesapID group by hesapAdi");
    return sonuc;
  }

  Future<List<HesapGelir>> hesabaGoreGelirListesiniGetir() async {
    var map = await hesabaGoreGelirGetir();
    var gelirListesi = List<HesapGelir>();

    for (Map m in map) {
      gelirListesi.add(HesapGelir.fromMap(m));
    }
    return gelirListesi;
  }

  Future<int> toplamPara() async {
    var db = await getDatabase();

    List<Map> list = await db.rawQuery(
        "select gelirMiktari - harcamaTutari as gelirMiktari from gelirler, harcamalar");
    return list.isNotEmpty ? list[0]["gelirMiktari"] : "0";
  }

  Future<int> toplamGelirGetirOcak() async {
    var db = await getDatabase();

    List<Map> list = await db.rawQuery(
        "select SUM(gelirMiktari) as gelirMiktari from gelirler where gelirTarih ==  2021-01-00 00:00:00");
    return list.isNotEmpty ? list[0]["gelirMiktari"] : Null;
  }

//grafik icin
  Future<List<Map<String, dynamic>>> giderGetir() async {
    var db = await getDatabase();
    var sonuc = await db.query("harcamalar");
    return sonuc;
  }

  Future<int> soruEkle(Sorular g) async {
    var db = await getDatabase();
    var sonuc = await db.insert("sorular", g.toMap());
    debugPrint("soru eklendi");
    return sonuc;
  }

  Future soruGetir() async {
    var db = await getDatabase();
    var sonuc = await db.query("sorular");
    return sonuc;
  }
}
