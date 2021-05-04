class Harcama {
  int harcamaID;
  String harcamaAd;
  String harcamaAciklama;
  String harcamaTarih;
  int harcamaTutar;
  int kategoriID;
  int hesapID;
  String kategoriAd;
  String hesapAdi;

  Harcama(
      {this.harcamaAd,
      this.harcamaAciklama,
      this.harcamaTarih,
      this.harcamaTutar,
      this.kategoriID,
      this.hesapID});
  Harcama.withID({
    this.harcamaID,
    this.harcamaAd,
    this.harcamaAciklama,
    this.harcamaTarih,
    this.harcamaTutar,
    this.kategoriID,
    this.hesapID,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["harcamaID"] = harcamaID;
    map["harcamaAd"] = harcamaAd;
    map["harcamaAciklama"] = harcamaAciklama;
    map["harcamaTutar"] = harcamaTutar;
    map["harcamaTarih"] = harcamaTarih;
    map["kategoriID"] = kategoriID;
    map["hesapID"] = hesapID;

    return map;
  }

  Harcama.fromMap(Map<String, dynamic> map) {
    this.harcamaID = map["harcamaID"];
    this.harcamaAd = map["harcamaAd"];
    this.harcamaAciklama = map["harcamaAciklama"];
    this.harcamaTutar = map["harcamaTutar"];
    this.harcamaTarih = map["harcamaTarih"];
    this.kategoriID = map["kategoriID"];
    this.hesapID = map["hesapID"];
    this.kategoriAd = map["kategoriAd"];
    this.hesapAdi = map["hesapAdi"];
  }
}
