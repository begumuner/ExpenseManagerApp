class PdfModel {
  String tabloAdi;
  String url2;

  PdfModel({this.url2, this.tabloAdi});
  PdfModel.withID({this.tabloAdi, this.url2});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["tabloAdi"] = tabloAdi;
    map["url2"] = url2;

    return map;
  }

  PdfModel.fromMap(Map<String, dynamic> map) {
    this.tabloAdi = map["tabloAdi"];
    this.url2 = map["url2"];
  }
}
