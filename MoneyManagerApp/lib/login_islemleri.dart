import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginIslemleri extends StatefulWidget {
  @override
  _LoginIslemleriState createState() => _LoginIslemleriState();
}

class _LoginIslemleriState extends State<LoginIslemleri> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login İşlemleri"),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: _kullaniciOlustur,
              color: Colors.amber,
              child: Text("Kullanıcı Oluştur"),
            ),
            RaisedButton(
              onPressed: _kullaniciGirisi,
              color: Colors.yellow,
              child: Text("Kullanıcı Girişi"),
            ),
            RaisedButton(
              onPressed: _cikisYap,
              color: Colors.red,
              child: Text("Çıkış Yap"),
            ),
            RaisedButton(
              onPressed: _resetPass,
              color: Colors.pink,
              child: Text("Şifremi Unuttum"),
            ),
            RaisedButton(
              onPressed: _updatePass,
              color: Colors.green,
              child: Text("Şifremi Güncelle"),
            ),
            RaisedButton(
              onPressed: _updateEmail,
              color: Colors.brown,
              child: Text("Email Güncelle"),
            ),
          ],
        ),
      ),
    );
  }

  void _kullaniciOlustur() async {
    String _email = "alperensoysal5@gmail.com";
    String _pass = "sifrem";
    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _pass);
      User _newUser = _credential.user;

      await _newUser.sendEmailVerification();
      if (_auth.currentUser != null) {
        debugPrint("mail atıldı onayla");
        await _auth.signOut();
      }

      debugPrint(_newUser.toString());
    } catch (e) {
      debugPrint("********************* HATA ***************");
      debugPrint(e.toString());
    }
  }

  void _kullaniciGirisi() async {
    try {
      String _email = "alperensoysal5@gmail.com";
      String _pass = "sifrem";
      if (_auth.currentUser == null) {
        User oturumAcanUser = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _pass))
            .user;

        if (oturumAcanUser.emailVerified) {
          debugPrint("mail onaylandı cnm thanks");
        } else {
          debugPrint("lütfen mail onayla ve giriş yap");
          _auth.signOut();
        }
      } else {
        debugPrint("zaten giriş yapılmış kullanıcı var");
      }
    } catch (e) {
      debugPrint("********************* HATA ***************");
      debugPrint(e.toString());
    }
  }

  void _cikisYap() async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    } else {
      debugPrint("oturum açmış kullanıcı yok");
    }
  }

  void _resetPass() async {
    String _email = "alperensoysal5@gmail.com";
    try {
      await _auth.sendPasswordResetEmail(email: _email);
    } catch (e) {
      debugPrint("********************* HATA ***************");
      debugPrint(e.toString());
    }
  }

  void _updatePass() async {
    try {
      await _auth.currentUser.updatePassword("sifrem2");
      debugPrint("sifre guncellendi");
    } catch (e) {
      try {
        String _email = "alperensoysal5@gmail.com";
        String _pass = "sifrem2";
        EmailAuthCredential credential =
            EmailAuthProvider.credential(email: _email, password: _pass);
        await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(
            credential); //eski mail ve şifre hatalı mı onu kontrol için

        await _auth.currentUser.updatePassword("sifrem2");
      } catch (e) {
        debugPrint("********************* HATA ***************");
        debugPrint(e.toString());
      }
      debugPrint("********************* HATA ***************");
      debugPrint(e.toString());
    }
  }

  void _updateEmail() async {
    try {
      await _auth.currentUser.updateEmail("alperensoysal5@gmail.com");
      debugPrint("email guncellendi");
    } catch (e) {
      try {
        String _email = "annecik789@gmail.com";
        String _pass = "sifrem2";
        EmailAuthCredential credential =
            EmailAuthProvider.credential(email: _email, password: _pass);
        await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(
            credential); //eski mail ve şifre hatalı mı onu kontrol için

        await _auth.currentUser.updateEmail("alperensoysal5@gmail.com");
      } catch (e) {
        debugPrint("********************* HATA ***************");
        debugPrint(e.toString());
      }
      debugPrint("********************* HATA ***************");
      debugPrint(e.toString());
    }
  }
}
