import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';

import '../../BaseState.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'SignInButtonAnimating.dart';

class SignInAnimations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    log(TAG);

    return SignInState();
  }
}

class SignInState extends State<SignInAnimations>
    with TickerProviderStateMixin {
  late AnimationController _loginButtonController;
  var animationStatus = 0;

  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 16000), vsync: this);

    _loginButtonController.addListener(() {
      // log('_loginButtonController value is  ${_loginButtonController.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    return Scaffold(
        appBar: AppBar(),
        body: Center(

            child:  animationStatus == 0 ? InkWell(
          onTap: () {
            setState(() {
              animationStatus = 1;
            });
            _playAnimation();
          },
          child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
              ),
              margin: EdgeInsets.only(left: 22, right: 22),
              height: 60,
              child: Center(child: Text('Login My App'))),
        )

            :

            InkWell(
              onTap: (){
                setState(() {
                  animationStatus = 0;
                });
              },
              child: SignInButtonAnimating(buttonController: _loginButtonController),
            )

        ));
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      // await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }
}
