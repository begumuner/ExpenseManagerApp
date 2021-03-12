class HesapGelir{
  int tutar;
  String tip;

  HesapGelir(this.tutar,this.tip);

  HesapGelir.fromMap(Map<String,dynamic> map){
    this.tutar=map["gelirMiktari"];
    this.tip=map["hesapAdi"];
  }
}