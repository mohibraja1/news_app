import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';

class CustomSampleAnim extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimState();
  }
}

class AnimState extends State<CustomSampleAnim> with TickerProviderStateMixin {
  bool animStarted = false;
  bool firstAnimCompleted = false;

  late AnimationController animationController, zoomAnimationController;

  // late Animation animation;
  late Animation buttonSqueezeanimation, buttomZoomOut;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    zoomAnimationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    buttonSqueezeanimation = Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          1.0,
        ),
      ),
    );

    buttonSqueezeanimation.addListener(() {
      log('buttonSqueezeanimation is = ${buttonSqueezeanimation.value}');

      if (buttonSqueezeanimation.isCompleted) {
        log('buttonSqueezeanimation is completed');

        var delay = 5;

        _timer = new Timer(Duration(seconds: delay), () {
          setState(() {
            firstAnimCompleted = true;
            zoomAnimationController.forward();
          });
        });
      }
    });

    buttomZoomOut = Tween(
      begin: 70.0,
      end: 1000.0,
    ).animate(
      CurvedAnimation(
        parent: zoomAnimationController,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.bounceOut,
        ),
      ),
    );
    buttomZoomOut.addListener(() {
      setState(() {});
      log('buttomZoomOut is = ${buttomZoomOut.value}');
    });

    animationController.addListener(() {
      log('animationController is = ${animationController.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: animStarted
                ? AnimatedBuilder(
                    animation: animationController, builder: animatingWidget)
                : fixedContainer(),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    animStarted = !animStarted;

                    animationController.forward();
                  });
                },
                child: Text('click me'),
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Widget animatingWidget(BuildContext context, Widget? child) {
    return Hero(
      tag: 'fade',
      child: !firstAnimCompleted
          ? Container(
              width: buttonSqueezeanimation.value,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all( Radius.circular(30.0)),
                color: Colors.amber,
              ),
              margin: EdgeInsets.only(left: 22, right: 22),
              height: 70,
              child: buttonSqueezeanimation.value > 75.0
                  ? Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                      ),
                    )
                  : CircularProgressIndicator(
                      value: null,
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ))
          : Container(
              width: buttomZoomOut.value,
              height: buttomZoomOut.value,
              decoration: BoxDecoration(
                shape: buttomZoomOut.value < 500
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                color: Colors.amber,
              ),
            ),
    );
  }

  Widget fixedContainer() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
        ),
        margin: EdgeInsets.only(left: 22, right: 22),
        height: 60,
        child: Center(child: Text('Login My App')));
  }
}
