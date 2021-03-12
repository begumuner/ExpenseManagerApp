import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Animation/fade_animation.dart';
import 'giris_yap.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SifremiUnuttumSayfasi extends StatefulWidget {
  @override
  _SifremiUnuttumSayfasiState createState() => _SifremiUnuttumSayfasiState();
}

class _SifremiUnuttumSayfasiState extends State<SifremiUnuttumSayfasi> {
  final _formKey3 = GlobalKey<FormState>();
  String _email3;
  bool otoKontrol = false;
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GirisYapmaSayfasi()));
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
            key: _formKey3,
            autovalidate: otoKontrol,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 14),
                  child: FadeAnimation(
                      1,
                      Text(
                        "Şifremi Unuttum",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.only(start: 25, end: 25, top: 55),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: _email3 == null ? Colors.brown : Colors.red,
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
                    onSaved: (deger) => _email3 = deger,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                      if (_formKey3.currentState.validate()) {
                        _formKey3.currentState.save();
                        _resetPass(_email3);
                        showAlertDialogSifreYenileme(context);
                      }
                    },
                    child: Text("Şifre yenileme isteği gönder"),
                    color: Colors.yellow,
                  ),
                ),
                Expanded(
                    child: FadeAnimation(
                        1.2,
                        Container(
                          // padding: EdgeInsets.only(top: 5),
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/background.png'),
                                  fit: BoxFit.cover)),
                        )))
              ],
            )),
      ),
    );
  }

  showAlertDialogSifreYenileme(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        //  Navigator.pushNamed(context, "/");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GirisYapmaSayfasi()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Şifre yenileme maili gönderilmiştir"),
      content: Text("Şifrenizi değiştirdikten sonra giriş yapabilirsiniz"),
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

  void _resetPass(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint("********************* HATA ***************");
      debugPrint(e.toString());
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          // Navigator.pushNamed(context, "/");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GirisYapmaSayfasi()));
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("UYARI"),
        content: Text(e.message),
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
}
