import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/NewsArticle.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';

import 'package:url_launcher/url_launcher.dart';
import 'data.dart';

class Haberler extends StatefulWidget {
  @override
  _HaberlerState createState() => _HaberlerState();
}

class _HaberlerState extends State<Haberler> {
  List<Articles> articles = [];

  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            );
          },
        ),
        backgroundColor: Colors.amber,
        title: Text('Haberler',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        centerTitle: true,
      ),
      body: Center(
          child: Card(
        color: Colors.grey[100],
        margin: EdgeInsets.all(4),
        elevation: 20,
        child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Image.network(articles[index].urlToImage),
                    ListTile(
                      leading: Icon(Icons.arrow_drop_down_circle),
                      title: Text(articles[index].title),
                      //subtitle: Text(articles[index].author),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(articles[index].description),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                            onPressed: () async {
                              await launch(articles[index].url);
                            },
                            child: Text('Habere Git')),
                      ],
                    ),
                  ],
                ),
              );
            }),
      )),
    );
  }
}
