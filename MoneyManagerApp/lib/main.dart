import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_firebase_dersleri/login_islemleri.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/gider_detay.dart';
import 'package:flutter_firebase_dersleri/screens/Gelir_Gider/kategori.dart';
import 'package:flutter_firebase_dersleri/screens/Giris/giris_anasayfa.dart';
import 'package:flutter_firebase_dersleri/screens/Giris/giris_yap.dart';
import 'package:flutter_firebase_dersleri/screens/Giris/sifremi_unuttum_sayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Giris/uye_ol.dart';
import 'package:flutter_firebase_dersleri/screens/Hatirlatici/hatirlatici.dart';

import 'package:flutter_firebase_dersleri/screens/SoruSayfasi/SoruSayfasi.dart';

import 'screens/Hatirlatici/screens/add_new_medicine/add_new_medicine.dart';
import 'screens/Raporlar/anasayfa.dart';
import 'screens/Raporlar/gelir_aileUyesi_2k_5k.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // '/': (context) => GirisYapmaSayfasi(),
        '/UyeOlmaSayfasi': (context) => UyeOlSayfasi(),
        '/GirisYapmaSayfasi': (context) => GirisYapmaSayfasi(),
        '/SifremiUnuttumSayfasi': (context) => SifremiUnuttumSayfasi(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("hata çıktı baby... : " + snapshot.error.toString()),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GirisAnaSayfa();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
