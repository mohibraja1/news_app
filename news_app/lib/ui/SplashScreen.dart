import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/NewsListhome.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    Timer(
        Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => NewsListHome())));

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
              child: Text("News App"),
            )
          ],
        ),
      ),
    );
  }
}
