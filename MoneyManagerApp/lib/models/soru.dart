class Sorular {
  String meslek;
  String aylikGelir;


    Sorular({this.meslek, this.aylikGelir});



  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["meslek"] = meslek;
    map["aylikGelir"] = aylikGelir;

    return map;
  }

  Sorular.fromMap(Map<String, dynamic> map) {
    this.aylikGelir = map["aylikGelir"];
    this.meslek = map["meslek"];

  }
}
