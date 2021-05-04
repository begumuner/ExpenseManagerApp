class Gelirler {
  int gelirID;
  String gelirAdi;
  int gelirMiktari;
  int hesapID;
  String gelirTarih;
  String hesapAdi;

  Gelirler({this.gelirAdi, this.gelirMiktari, this.hesapID, this.gelirTarih});

  Gelirler.withID(
      {this.gelirID,
      this.gelirAdi,
      this.gelirMiktari,
      this.hesapID,
      this.gelirTarih});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["gelirID"] = gelirID;
    map["gelirAdi"] = gelirAdi;
    map["gelirMiktari"] = gelirMiktari;
    map["hesapID"] = hesapID;
    map["gelirTarih"] = gelirTarih;

    return map;
  }

  Gelirler.fromMap(Map<String, dynamic> map) {
    this.gelirAdi = map["gelirAdi"];
    this.gelirID = map["gelirID"];
    this.gelirMiktari = map["gelirMiktari"];
    this.hesapID = map["hesapID"];
    this.gelirTarih = map["gelirTarih"];
  }
}
