import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'ProfilSayfasi/profil_sayfasi.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  PickedFile _secilenResim;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ana Sayfa")),
      body: Column(children: [
        RaisedButton(
          onPressed: _cikisYap,
          color: Colors.red,
          child: Text("Çıkış Yap"),
        ),
        RaisedButton(
          onPressed: _galeridenFotoYukle,
          color: Colors.blue,
          child: Text("Galeriden Foto ekle"),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilSayfasi()),
            );
          },
          color: Colors.yellow,
          child: Text("Profil Sayfasına Git"),
        ),
        Expanded(
          child: _secilenResim == null
              ? Text("Resim YOK")
              : Image.file(File(_secilenResim.path)),
        )
      ]),
    );
  }

  void _cikisYap() async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    } else {
      debugPrint("oturum açmış kullanıcı yok");
    }
  }

  void _galeridenFotoYukle() async {
    var randomNo = Random(25);
    var _picker = ImagePicker();
    var resim = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim = resim;
    });

    /* Reference ref = FirebaseStorage.instance
        .ref()
        .child("userPps/${randomNo.nextInt(5000).toString()}.jpg");

    UploadTask uploadTask = ref.putFile(File(_secilenResim.path));
*/
    /* var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    debugPrint("upload edilen resmin urlsi : " + url);
  
  */
  }
}
