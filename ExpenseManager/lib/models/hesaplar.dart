class Hesaplar {
  int hesapID;
  String hesapAdi;
  int hesapMiktari;
  String hesapTuru;

  Hesaplar({this.hesapAdi, this.hesapMiktari, this.hesapTuru});

  Hesaplar.withID({this.hesapAdi, this.hesapMiktari, this.hesapID, this.hesapTuru});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["hesapAdi"] = hesapAdi;
    map["hesapMiktari"] = hesapMiktari;
    map["hesapID"] = hesapID;
    map["hesapTuru"] = hesapTuru;

    return map;
  }

  Hesaplar.fromMap(Map<String, dynamic> map) {
    this.hesapAdi = map["hesapAdi"];
    this.hesapMiktari = map["hesapMiktari"];
    this.hesapID = map["hesapID"];
    this.hesapTuru = map["hesapTuru"];
  }
}
