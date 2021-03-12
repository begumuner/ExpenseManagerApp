import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_dersleri/bitirmeProjesi/GirisIslemleri/giris_yap.dart';
import 'package:translator/translator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Animation/fade_animation.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
String _oAnkiKullaniciId;

class UyeOlSayfasi extends StatefulWidget {
  String get oAnkiKullaniciId => _oAnkiKullaniciId;

  @override
  _UyeOlSayfasiState createState() => _UyeOlSayfasiState();
}

class _UyeOlSayfasiState extends State<UyeOlSayfasi> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey2 = GlobalKey<FormState>();
  bool _otoKontrol2 = false;
  String _email2;
  String _password2;
  String _ad;
  String _soyAd;
  final translator = GoogleTranslator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Form(
            key: _formKey2,
            autovalidate: _otoKontrol2,
            child: FadeAnimation(
              0.5,
              ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 88),
                        child: FadeAnimation(
                            1,
                            Text(
                              "Üye Ol",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 25, end: 25, top: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
                            hintText: "Ad",
                            //labelText: "ismini gir..",
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 1)),
                            /*  border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),*/
                          ),
                          // initialValue: "İsim",

                          onSaved: (deger) => _ad = deger,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 25, end: 25, top: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
                            hintText: "Soyad",
                            //labelText: "ismini gir..",
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 1)),
                            /*  border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),*/
                          ),
                          // initialValue: "İsim",

                          onSaved: (deger) => _soyAd = deger,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 25, end: 25, top: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 1)),

                            prefixIcon: Icon(Icons.email),
                            hintText: "Email",
                            //labelText: "emailini gir..",
                            /* border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),*/
                          ),
                          validator: _emailControl,
                          onSaved: (deger) => _email2 = deger,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 25, end: 25, top: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.brown, width: 1)),

                            prefixIcon: Icon(Icons.lock),
                            hintText: "Şifre (En az 6 karakter olmalı)",
                            //labelText: "emailini gir..",
                            /*border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),*/
                          ),
                          validator: (girilenVeri) {
                            if (girilenVeri.length < 6) {
                              return "en az 6 karakter gerekli";
                            } else
                              return null;
                          },
                          onSaved: (deger) => _password2 = deger,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 25, end: 25, top: 15),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            onPressed: verileriOnayla,
                            child: Text("Üye Ol"),
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      FadeAnimation(
                          1.2,
                          Container(
                            // padding: EdgeInsets.only(top: 5),
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/background.png'),
                                    fit: BoxFit.cover)),
                          ))
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  String _emailControl(String mail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(mail)) {
      return "gecersiz mail adresi";
    } else
      return null;
  }

  void verileriOnayla() async {
    if (_formKey2.currentState.validate()) {
      _formKey2.currentState.save();
      firestoreIslemleri();
      debugPrint("girilen ad: $_ad");
      debugPrint("girilen soyad: $_soyAd");
      debugPrint("girilen mail: $_email2");
      debugPrint("girilen sifre: $_password2");

      try {
        UserCredential _credential = await _auth.createUserWithEmailAndPassword(
            email: _email2, password: _password2);
        User _newUser = _credential.user;

        await _newUser.sendEmailVerification();
        showAlertDialogEmailOnay(context);
        if (_auth.currentUser != null) {
          debugPrint("mail atıldı onayla");

          await _auth.signOut();
        }

        debugPrint(_newUser.toString());
      } on FirebaseAuthException catch (e) {
        debugPrint("********************* HATA ***************");
        debugPrint(e.toString());
        var result =
            await translator.translate(e.message, from: 'en', to: 'tr');

        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {
            // Navigator.pushNamed(context, "/");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UyeOlSayfasi()));
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("UYARI"),
          content: Text(result.toString()),
          actions: [
            okButton,
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    } else {
      setState(() {
        _otoKontrol2 = true;
      });
    }
  }

  void firestoreIslemleri() {
    /*Map<String, dynamic> userEkle = Map();
    userEkle["ad"] = _ad;
    userEkle["soyad"] = _soyAd;
*/
    _oAnkiKullaniciId = _firestore.collection("users").doc().id;

    _firestore.doc("users/$_oAnkiKullaniciId").set({
      "ad": "$_ad",
      "soyad": "$_soyAd",
      "userId": "$_oAnkiKullaniciId"
    }).then((value) => debugPrint("$_oAnkiKullaniciId eklendi"));
    debugPrint(_oAnkiKullaniciId);
  }

  showAlertDialogEmailOnay(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, "/");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GirisYapmaSayfasi()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Onay maili gönderilmiştir"),
      content: Text("Onayladıktan sonra giriş yapabilirsiniz"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
