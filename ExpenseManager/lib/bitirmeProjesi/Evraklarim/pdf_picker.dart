import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_firebase_dersleri/bitirmeProjesi/Evraklarim/DBHelper.dart';
import 'package:flutter_firebase_dersleri/bitirmeProjesi/Evraklarim/evraklarim_anasayfa.dart';
import 'package:flutter_firebase_dersleri/bitirmeProjesi/Evraklarim/pdf_model.dart';

class PdfPicker extends StatefulWidget {
  @override
  _PdfPickerState createState() => _PdfPickerState();
}

class _PdfPickerState extends State<PdfPicker> {
  Future getPdfAndUpload() async {
    var rng = new Random();
    String randomName = "";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      randomName += rng.nextInt(100).toString();
    }
    String fileName = '$randomName.pdf';
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);
      String originFileName = file.path.split('/').last;
      savePdf(file.readAsBytesSync(), fileName, originFileName);
      debugPrint("dosya adı  " + originFileName);
    } else {
      // User canceled the picker
    }
  }

  Future savePdf(List<int> asset, String name, String dosyAdi) async {
    Reference ref = FirebaseStorage.instance.ref().child(name);
    UploadTask uploadTask = ref.putData(asset);
    String url = await (await uploadTask).ref.getDownloadURL();
    debugPrint("pdf urlsi " + url);

    PdfModel pdfIns = PdfModel(url2: url, tabloAdi: dosyAdi);
    //debugPrint(pdfIns.url);

    setState(() {
      dbHelper.savePdfYeni(pdfIns);
      changePDF(url, dosyAdi);
    });
    return url;
  }

  List<PdfModel> pdfList = [];
  DBHelper dbHelper;
  bool _isLoading = true;
  PDFDocument document;
  List<String> pdfUrlList = [];
  String appBarTitle = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    appBarTitle = "Dosya Seçiniz veya Ekleyiniz";
    //  dbHelper.pdfTableCreateYeni();
    /* dbHelper.pdfSil().then((value) {
      var s = value;
      debugPrint("silinen sayi  " + s.toString());
    });
*/
    dbHelper.getPdfsYeni().then((value) {
      pdfList = value;
      setState(() {});
      debugPrint("DBDEN GELEN  " + pdfList[0].url2);

      debugPrint("init içi pdflist.length  " + pdfList.length.toString());
    });
  }

  changePDF(String url, String fileName) async {
    setState(() => _isLoading = true);
    /* if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
        "https://firebasestorage.googleapis.com/v0/b/flutterdersleri-c701e.appspot.com/o/325308537441261777881775818143988725.pdf?alt=media&token=a298c61f-c5d2-48dc-8637-cf237e1d3a80",
      );
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    */
    document = await PDFDocument.fromURL("$url");
    appBarTitle = fileName;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => EvraklarAnaSayfa()));
        },
        child: Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
        ),
        backgroundColor: Colors.amber,
      ),
      drawer: Container(
        // width: MediaQuery.of(context).size.width / 1.75,

        child: Drawer(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            shrinkWrap: true,
            itemCount: pdfList.length,
            itemBuilder: (context, index) {
              dbHelper.getPdfsYeni().then((value) {
                pdfList = value;
                setState(() {});

                debugPrint(" pdflist.length  " + pdfList.length.toString());
              });

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: index % 2 == 0 ? Colors.amber[400] : Colors.white,
                ),
                child: ListTile(
                  title: Text(
                    pdfList[index].tabloAdi,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    changePDF(pdfList[index].url2, pdfList[index].tabloAdi);
                  },
                ),
              );
            },
          ),

          /*  RaisedButton(
              onPressed: () {
                getPdfAndUpload();
              },
              child: Text("Dosya Ekle"),
            ),
            */
          /*  SizedBox(height: 36),
              ListTile(
                title: Text('Load from Assets'),
                onTap: () {
                  changePDF(1);
                },
              ),
              ListTile(
                title: Text('Load from URL'),
                onTap: () {
                  changePDF(2);
                },
              ),
              ListTile(
                title: Text('Restore default'),
                onTap: () {
                  changePDF(3);
                },
              ),
              */
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text(
          '$appBarTitle',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              getPdfAndUpload();
            },
          )
        ],
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 1,
              ),
      ),
    );
  }
}
