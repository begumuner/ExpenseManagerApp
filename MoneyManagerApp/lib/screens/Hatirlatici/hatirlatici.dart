import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/screens/Hatirlatici/screens/add_new_medicine/add_new_medicine.dart';
import 'package:flutter_firebase_dersleri/screens/Hatirlatici/screens/home/home.dart';
import 'package:flutter_firebase_dersleri/screens/Hatirlatici/screens/welcome/welcome.dart';

class Hatirlatici extends StatefulWidget {
  @override
  _HatirlaticiState createState() => _HatirlaticiState();
}

class _HatirlaticiState extends State<Hatirlatici> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Popins",
          primaryColor: Colors.amber,
          textTheme: TextTheme(
              headline1: ThemeData.light().textTheme.headline1.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 38.0,
                    fontFamily: "Popins",
                  ),
              headline5: ThemeData.light().textTheme.headline1.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 17.0,
                    fontFamily: "Popins",
                  ),
              headline3: ThemeData.light().textTheme.headline3.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    fontFamily: "Popins",
                  ))),
      routes: {
        "/": (context) => Welcome(),
        "/home": (context) => Home(),
        "/add_new_medicine": (context) => AddNewMedicine(),
      },
      initialRoute: "/",
    );
  }
}
