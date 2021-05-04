class HesapHarcama{
  int tutar;
  String tip;

  HesapHarcama(this.tutar,this.tip);

  HesapHarcama.fromMap(Map<String,dynamic> map){
    this.tutar=map["harcamaTutar"];
    this.tip=map["hesapAdi"];
  }
}