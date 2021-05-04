import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/screens/Anasayfa/uygulama_anasayfasi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'kripto/home_page.dart';
import 'kur_anasayfasi.dart';

class KurAnasayfa extends StatefulWidget {
  @override
  _KurAnasayfaState createState() => _KurAnasayfaState();
}

class _KurAnasayfaState extends State<KurAnasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Kurlar',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            );
          },
        ),
      ),
      backgroundColor: Color(0XFFFEFEFE),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, top: 50, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _introCard(),
            SizedBox(
              height: 30,
            ),
            _introCardiki(),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  _introCardiki() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/profit.png',
            ),
            fit: BoxFit.fill,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.amber,
              offset: Offset(0, 3),
              spreadRadius: 5,
              blurRadius: 5,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Döviz Kurları',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 8),
              IconButton(
                icon: Icon(FontAwesomeIcons.longArrowAltRight,
                    size: 36, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Currency()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  _introCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage('assets/images/cash-back.png'),
            fit: BoxFit.fill,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.amber,
              offset: Offset(0, 3),
              spreadRadius: 5,
              blurRadius: 5,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Kripto Para',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 8),
              IconButton(
                icon: Icon(FontAwesomeIcons.longArrowAltRight,
                    size: 36, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePageKripto()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
