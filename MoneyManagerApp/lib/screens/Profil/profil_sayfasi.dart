import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Giris/giris_yap.dart';
import 'package:flutter_firebase_dersleri/screens/Giris/uye_ol.dart';
import 'package:translator/translator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
SharedPreferences mySharedPreferences;

class ProfilSayfasi extends StatefulWidget {
  @override
  _ProfilSayfasiState createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  UyeOlSayfasi idIcin = new UyeOlSayfasi();
  String nameKullan;

  String _ad = "";
  String _soyAd = "";
  TextEditingController _textFieldController;
  String name;
  bool yeniKullaniciMi;
  bool isimDegistiMi = false;
  File _secilenResim;
  var resimKullan;

  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    SharedPreferences.getInstance().then((value) {
      mySharedPreferences = value;
      setState(() {});
    });

    isimGetir();

    /* var myFuture = isimGetir();
    myFuture.then((value) {
      nameKullan = value;
    });
*/
    /* var myFuture2 = resimGetir();
    myFuture2.then((value) {
      resimKullan = value;
      setState(() {});
    });
*/
    // _secilenResim = File(mySharedPreferences.getString("resimYolu"));
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sharedPrefGetir(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return new Scaffold(
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.light,
              backgroundColor: Colors.amber,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            body: new Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(color: Colors.amber.withOpacity(0.8)),
                  clipper: getClipper(),
                ),
                Positioned(
                    width: 350.0,
                    top: MediaQuery.of(context).size.height / 5,
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                    image: mySharedPreferences
                                                .getString("resimYolu") ==
                                            null
                                        ? AssetImage(
                                            'assets/images/maniLogo.jpeg')
                                        : FileImage(File(mySharedPreferences
                                            .getString("resimYolu"))),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(75.0)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 7.0, color: Colors.black)
                                ])),
                        SizedBox(height: 90.0),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            name ?? "",
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          '',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat'),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: 40.0),
                            Container(
                              height: 30.0,
                              width: 95.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.black,
                                color: Colors.yellow[700],
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () {
                                    _displayTextInputDialog(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      'İsim Düzenle',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15.0),
                            Container(
                              height: 30.0,
                              width: 115.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.black,
                                color: Colors.yellow[700],
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () {
                                    _galeridenFotoYukle();
                                  },
                                  child: Center(
                                    child: Text(
                                      'Fotoğraf Düzenle',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15.0),
                            Expanded(
                              child: Container(
                                height: 30.0,
                                width: 95.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shadowColor: Colors.black,
                                  color: Colors.red[800],
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _cikisYap();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GirisYapmaSayfasi()),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'Çıkış Yap',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Future<String> isimGetir() async {
    mySharedPreferences = await SharedPreferences.getInstance();

    String sharedPreferencedenGelenName = mySharedPreferences.getString("isim");
    String harbiName;
    if (mySharedPreferences.getBool("isimDegistiMi") ?? false) {
      name = sharedPreferencedenGelenName;
      setState(() {});
    } else {
      _adSoyadGetir();
    }

    /*  if (firebasedenGelenName != sharedPreferencedenGelenName) {
      harbiName = sharedPreferencedenGelenName;
      debugPrint("---------fb ile sp eşit diil");
    } else {
      harbiName = firebasedenGelenName;
      debugPrint("---------fb ile sp eşit");
    }
*/

    //  debugPrint("sfden gelen " + sharedPreferencedenGelenName);
    //debugPrint("fbden gelen " + firebasedenGelenName);
    //debugPrint(harbiName);
    return harbiName;
  }

  String valueText;
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Yeni İsim'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              keyboardType: TextInputType.name,
              decoration:
                  InputDecoration(hintText: "Yeni Kullanıcı Adınızı Giriniz.."),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('İptal'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Tamam'),
                onPressed: () {
                  setState(() {
                    name = valueText;
                    mySharedPreferences.setString("isim", name);
                    mySharedPreferences.setBool("isimDegistiMi", true);
                    isimDegistiMi = true;
                    debugPrint(
                        "--------alert içindeki setString çalıştı $nameKullan");
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future _galeridenFotoYukle() async {
    //var randomNo = Random(25);

    var _picker = ImagePicker();
    var resim = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim = File(resim.path);

      mySharedPreferences.setString("resimYolu", _secilenResim.path);
    });
    return _secilenResim.path;
    /*  Reference ref = FirebaseStorage.instance
        .ref()
        .child("userPps/${randomNo.nextInt(5000).toString()}.jpg");

    UploadTask uploadTask = ref.putFile(File(_secilenResim.path));

    var url = await (await uploadTask).ref.getDownloadURL();
    debugPrint("upload edilen resmin urlsi : " + url);
 */
  }

  Future sharedPrefGetir() async {
    mySharedPreferences = await SharedPreferences.getInstance();
    return mySharedPreferences;
  }

  void _cikisYap() async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    } else {
      debugPrint("oturum açmış kullanıcı yok");
    }
  }

  Future _adSoyadGetir() async {
    String id = idIcin.oAnkiKullaniciId;

    mySharedPreferences = await SharedPreferences.getInstance();
    debugPrint(id);
    if (id != null) {
      mySharedPreferences.setString("kullaniciId", id);
      yeniKullaniciMi = true;
      debugPrint("id null degildi sf içine atıldı");
    } else {
      id = mySharedPreferences.getString("kullaniciId");
      yeniKullaniciMi = false;
      debugPrint("gelen id nulldı sfden çekildi");
    }
    debugPrint(id);
    // _ad = id;
    /*  var dokumanlar = await _firestore
        .collection("users")
        .where("userId", isEqualTo: "3a5w6tbxWJ5VS9ULUYli")
        .get();
    for (var dokuman in dokumanlar.docs) {
      debugPrint(dokuman.data()["ad"]);
      _ad = dokuman.data()["ad"];
    }
    debugPrint(_ad);
  */

    DocumentReference adRef = _firestore.doc("users/$id");
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot adData = await adRef.get();

      setState(() {
        _ad = adData.data()["ad"];

        _soyAd = adData.data()["soyad"];

        name = _ad + " " + _soyAd;
      });
    });

    return name;
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
