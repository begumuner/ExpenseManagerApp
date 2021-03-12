import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Utility.dart';
import 'DBHelper.dart';
import 'Photo.dart';
import 'dart:async';

import 'evraklarim_anasayfa.dart';
import 'evraklarim_foto.dart';
import 'foto_viewer_sayfasi.dart';

class FotoGenis extends StatefulWidget {
  //
  FotoGenis() : super();

  final String title = "     Fotoğraf Ekle veya Görüntüle";

  @override
  _FotoGenisState createState() => _FotoGenisState();
}

class _FotoGenisState extends State<FotoGenis> {
  //
  Future<File> imageFile;
  Image image;
  DBHelper dbHelper;
  List<Photo> images;
  File _secilenResim;
  List fotoList = [];

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
    //dbHelper.fotoTableCreateYeni();
    dbHelper.getFotoYeni().then((value) {
      fotoList = value;
      setState(() {});
    });

    refreshImages();
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  pickImageFromGallery() async {
    var _picker = ImagePicker();
    var resim = await _picker.getImage(source: ImageSource.gallery);
    Photo foto = Photo(0, resim.path);
    dbHelper.saveFotoYeni(foto);

    dbHelper.getFotoYeni().then((value) {
      fotoList = value;
      setState(() {});
    });
  }

  gridView() {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: GridView.builder(
          itemCount: fotoList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FotoGoruntule(fotoList[index].resimYolu)));
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(
                      File(fotoList[index].resimYolu),
                    ),
                  ),
                ),
              ),
            );
          },
        )

        /*   GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map((photo) {
          return Utility.imageFromBase64String(photo.photoName);
        }).toList(),
      ),
      */
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SaveImageDemoSQLite()));
        },
        child: Icon(
          Icons.open_in_new_rounded,
          color: Colors.black,
        ),
        backgroundColor: Colors.amber,
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EvraklarAnaSayfa()));
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              pickImageFromGallery();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridView(),
            )
          ],
        ),
      ),
    );
  }
}
