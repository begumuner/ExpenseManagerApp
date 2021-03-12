class KategoriHarcama{
  int tutar;
  String tip;

  KategoriHarcama(this.tutar,this.tip);

  KategoriHarcama.fromMap(Map<String,dynamic> map){
    this.tutar=map["harcamaTutar"];
    this.tip=map["kategoriAd"];
  }
}