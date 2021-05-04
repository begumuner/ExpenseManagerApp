class Kategori{
  int kategoriID;
  String kategoriAd;

  Kategori({this.kategoriAd});
  Kategori.withID({this.kategoriID,this.kategoriAd});

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();

    map["kategoriID"]=kategoriID;
    map["kategoriAd"]=kategoriAd;

    return map;
  }

  Kategori.fromMap(Map<String,dynamic> map){
    this.kategoriID=map["kategoriID"];
    this.kategoriAd=map["kategoriAd"];
  }
}