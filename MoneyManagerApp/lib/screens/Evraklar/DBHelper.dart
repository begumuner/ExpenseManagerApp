import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'Photo.dart';
import 'pdf_model.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String ID2 = 'id';
  static const String NAME = 'photoName';
  static const String URL = 'url';
  static const String TABLE = 'PhotosTable';
  static const String DB_NAME = 'photos.db';
  static const String TABLE2 = 'PdfTable';
  static const String TABLE3 = 'PdfTableYeni';
  static const String URL2 = 'url2';
  static const String TABLOADI = 'tabloAdi';
  static const String TABLE4 = 'fotoTable';
  static const String ID4 = 'id';
  static const String RESIMYOLU = 'resimYolu';

  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER, $NAME TEXT)");
  }

  Future pdfTableCreateYeni() async {
    var dbClient = await db;
    await dbClient.execute("CREATE TABLE $TABLE3 ($URL2 TEXT, $TABLOADI TEXT)");
    debugPrint("yeni tablo oluştu-------");
  }

  Future fotoTableCreateYeni() async {
    var dbClient = await db;
    await dbClient
        .execute("CREATE TABLE $TABLE4 ($ID4 INTEGER, $RESIMYOLU TEXT)");
    debugPrint("yeni tablo oluştu-------");
  }

  Future<Photo> save(Photo employee) async {
    var dbClient = await db;

    employee.id = await dbClient.insert(TABLE, employee.toMap());
    return employee;
  }

  /* Future<int> savePdf(PdfModel kat) async {
    var dbClient = await db;
    var sonuc = await dbClient.insert(TABLE2, kat.toMap());
    return sonuc;
  }
*/
  Future<int> savePdfYeni(PdfModel kat) async {
    var dbClient = await db;
    var sonuc = await dbClient.insert(TABLE3, kat.toMap());
    return sonuc;
  }

  Future<int> saveFotoYeni(Photo kat) async {
    var dbClient = await db;
    var sonuc = await dbClient.insert(TABLE4, kat.toMap());
    debugPrint("foto eklendiiiiiiiiiiiii");
    return sonuc;
  }

  Future<int> pdfSil() async {
    var dbClient = await db;
    var sonuc = await dbClient.delete(TABLE2, where: "$URL = ?", whereArgs: [
      "https://firebasestorage.googleapis.com/v0/b/flutterdersleri-c701e.appspot.com/o/356128714761240276698595239154748347.pdf?alt=media&token=9aae2479-1a77-4d86-915f-5b0d8f6db289"
    ]);
    return sonuc; //kac satır silindiğini döndürür
  }

  /*Future<PdfModel> savePdf(PdfModel pdf) async {
    var dbClient = await db;
    pdf.id = await dbClient.insert(TABLE2, pdf.toMap());
    return pdf;
  }
*/
  Future<List<Photo>> getPhotos() async {
    var dbClient = await db;

    List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME]);
    List<Photo> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Photo.fromMap(maps[i]));
      }
    }
    return employees;
  }

/*  Future<List<PdfModel>> getPdfs() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE2, columns: [ID2, URL]);
    List<PdfModel> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(PdfModel.fromMap(maps[i]));
      }
    }
    return employees;
  }
*/
  Future<List<PdfModel>> getPdfsYeni() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE3, columns: [URL2, TABLOADI]);
    List<PdfModel> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(PdfModel.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future<List<Photo>> getFotoYeni() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE4, columns: [ID4, RESIMYOLU]);
    List<Photo> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Photo.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
