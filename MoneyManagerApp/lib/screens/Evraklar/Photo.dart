/*class Photo {
  int id;
  String photoName;

  Photo(this.id, this.photoName);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photoName': photoName,
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    photoName = map['photoName'];
  }
}
*/
class Photo {
  int id;
  String resimYolu;

  Photo(this.id, this.resimYolu);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'resimYolu': resimYolu,
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    resimYolu = map['resimYolu'];
  }
}
