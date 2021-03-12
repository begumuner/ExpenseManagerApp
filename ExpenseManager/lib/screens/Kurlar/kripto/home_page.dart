import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/models/coin.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:flutter_firebase_dersleri/screens/Kurlar/kripto/services.dart';
import 'dart:async';

import '../anasayfa.dart';
import 'coin_details.dart';

class HomePageKripto extends StatefulWidget {
  @override
  _HomePageKriptoState createState() => _HomePageKriptoState();
}

class _HomePageKriptoState extends State<HomePageKripto> {
  int coinCounter;
  List<Coin> coins = List();
  List<Coin> filteredCoins = List();

  @override
  void initState() {
    super.initState();
    Services.getCoins().then((coinsList) {
      coins = coinsList;
      filteredCoins = coins;
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      filteredCoins = coins;
    });
    return null;
  }

  Widget buildBody() {
    return FutureBuilder(
      future: Services.getCoins(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
            ),
          );
        }
        coins = snapshot.data;
        return RefreshIndicator(
          onRefresh: _refresh,
          color: Colors.white70,
          backgroundColor: Colors.pink,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 50),
                        hintText: 'Enter Coin Name'),
                    onChanged: (string) {
                      setState(() {
                        filteredCoins = coins
                            .where((u) =>
                                (u.fullName
                                    .toLowerCase()
                                    .contains(string.toLowerCase())) ||
                                (u.name
                                    .toLowerCase()
                                    .contains(string.toLowerCase())))
                            .toList();
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: filteredCoins.length,
                  itemBuilder: (BuildContext context, int index) {
                    coinCounter = index;
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(filteredCoins[index])));
                        },
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${coinCounter + 1}',
                            ),
                          ],
                        ),
                        title: Text(
                          filteredCoins[index].fullName,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        subtitle: Text(
                          filteredCoins[index].name,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        trailing: Text(
                          '\$${filteredCoins[index].price.toStringAsFixed(4)}',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kripto Para',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        backgroundColor: Colors.amber,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => KurAnasayfa()));
              },
            );
          },
        ),
      ),
      body: buildBody(),
    );
  }
}
