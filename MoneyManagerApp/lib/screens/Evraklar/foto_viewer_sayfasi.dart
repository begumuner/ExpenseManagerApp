import 'dart:io' as ioo;

import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

import 'evraklarim_foto.dart';

class FotoGoruntule extends StatefulWidget {
  final String resims;
  FotoGoruntule(this.resims);
  @override
  _FotoGoruntuleState createState() => _FotoGoruntuleState();
}

class _FotoGoruntuleState extends State<FotoGoruntule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SaveImageDemoSQLite()));
              },
            );
          },
        ),
      ),
      body: Container(
        child: PhotoView(
          imageProvider: FileImage(ioo.File(widget.resims)),
        ),
      ),
    );
  }
}
