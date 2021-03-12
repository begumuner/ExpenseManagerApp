import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_dersleri/bitirmeProjesi/GirisIslemleri/giris_anasayfa.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/onBoarding/screen_one.dart';

import 'package:translator/translator.dart';
import 'package:flutter_firebase_dersleri/bitirmeProjesi/ana_sayfa.dart';
import 'package:flutter_firebase_dersleri/bitirmeProjesi/GirisIslemleri/uye_ol.dart';

import 'Animation/fade_animation.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class GirisYapmaSayfasi extends StatefulWidget {
  @override
  _GirisYapmaSayfasiState createState() => _GirisYapmaSayfasiState();
}

class _GirisYapmaSayfasiState extends State<GirisYapmaSayfasi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    _cikisYap();
  }

  final formKey = GlobalKey<FormState>();
  bool pressed = true;
  String _email;
  String _password;
  bool otoKontrol = false;
  final translator = GoogleTranslator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GirisAnaSayfa()));
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
          key: formKey,
          autovalidate: otoKontrol,
          child: FadeAnimation(
            0.5,
            ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 12),
                      child: FadeAnimation(
                          1,
                          Text(
                            "Giriş Yap",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: 25, end: 25, top: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: _email == null ? Colors.brown : Colors.red,
                            width: 1,
                          )),
                          prefixIcon: Icon(Icons.email),
                          hintText: "example@example.com",
                          labelText: "Email",
                          // border: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(10)),
                          //),
                        ),
                        validator: _emailControl,
                        onSaved: (deger) => _email = deger,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: 25, end: 25, top: 7),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.brown, width: 1)),

                          prefixIcon: Icon(Icons.lock),
                          hintText: "******",
                          labelText: "Şifre",
                          // border: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(10)),
                          //),
                        ),
                        validator: (girilenVeri) {
                          if (girilenVeri.length < 6) {
                            return "sifre en az 6 karakter içermeli";
                          } else
                            return null;
                        },
                        onSaved: (deger) => _password = deger,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 15, bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("şifremi unuttum basıldı");
                          Navigator.pushNamed(
                              context, "/SifremiUnuttumSayfasi");
                          // _resetPass();
                          // showAlertDialogSifreYenileme(context);
                          setState(() {
                            pressed = !pressed;
                          });
                        },
                        child: Text(
                          "Şifremi unuttum",
                          style: pressed
                              ? TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline)
                              : TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: _verileriOnayla,
                        child: Text("Giriş Yap"),
                        color: Colors.yellow,
                      ),
                    ),
                    Text("Henüz üye değil misiniz?"),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/UyeOlmaSayfasi");
                          /*   Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UyeOlSayfasi()));
                       */
                          debugPrint("üye ol basıldı");
                          setState(() {
                            pressed = !pressed;
                          });
                        },
                        child: Text(
                          "Üye ol",
                          style: pressed
                              ? TextStyle(
                                  color: Colors.amber[600],
                                  decoration: TextDecoration.underline)
                              : TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
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
          ),
        ),
      ),
    );
  }

  void _verileriOnayla() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      debugPrint("girilen mail: $_email");
      debugPrint("girilen sifre: $_password");

      try {
        if (_auth.currentUser == null) {
          User oturumAcanUser = (await _auth.signInWithEmailAndPassword(
                  email: _email, password: _password))
              .user;

          if (oturumAcanUser.emailVerified) {
            debugPrint("Mail onaylanmıştır giriş yapabilirsiniz");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OnboardingScreenOne()));
          } else {
            Widget okButton = FlatButton(
              child: Text("OK"),
              onPressed: () {
                // Navigator.pushNamed(context, "/");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GirisYapmaSayfasi()));
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("UYARI"),
              content: Text("Lütfen mail onaylayınız"),
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
            debugPrint("Lütfen mail onaylayınız");
            _auth.signOut();
          }
        } else {
          debugPrint("zaten giriş yapılmış kullanıcı var");
        }
      } on FirebaseAuthException catch (e) {
        debugPrint("********************* HATA ***************");
        debugPrint(e.toString());
        var result =
            await translator.translate(e.message, from: 'en', to: 'tr');

        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {
            //   Navigator.pushNamed(context, "/");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GirisYapmaSayfasi()));
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
        otoKontrol = true;
      });
    }
  }

  String _emailControl(String mail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(mail)) {
      return "lütfen geçerli bir mail adresi giriniz";
    } else
      return null;
  }

  void _cikisYap() async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    } else {
      debugPrint("oturum açmış kullanıcı yok");
    }
  }
}
