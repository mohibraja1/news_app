import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';


class SplashScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen())));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/app_icon.png',
              height: 100,
              width: 100,
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: Text("eZy Distance calculator"),
            )
          ],
        ),
      ),
    );
  }
}
