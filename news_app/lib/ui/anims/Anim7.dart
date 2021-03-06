import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAnim extends StatefulWidget {
  @override
  State<MyAnim> createState() => MyAnimState();
}

class MyAnimState extends State<MyAnim> with SingleTickerProviderStateMixin {
  late AnimationController control;

  late Animation<double> rot;
  late Animation<double> trasl;

  @override
  void initState() {
    super.initState();

    control = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    rot = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(control);

    trasl = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(control);

    control.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: control,
        builder: (_, child) => Container(

          child: Positioned(
            top: 100,
            left: trasl.value,
            child: Transform(
              transform: Matrix4.rotationZ(rot.value),
              alignment: Alignment.center,
              child: Text('what is, World!',
                  style: Theme.of(context).textTheme.headline4),
            ),
          ),
        ));
  }
}