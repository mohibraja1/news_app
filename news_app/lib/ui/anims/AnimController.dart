import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageAnimation extends StatefulWidget {
  @override
  PageAnimationState createState() => PageAnimationState();
}

class PageAnimationState extends State<PageAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      // animate 0 to 1 over duration specified
        duration: Duration(seconds: 3),
        vsync: this);

    animation = Tween<double>(begin: 0, end: 250).animate(
        new CurvedAnimation(parent: controller, curve: Curves.bounceOut))
      ..addListener(() {
        print('controller value is = ${controller.value}');
        setState(() {});
      });

    controller.forward(from: 0);
    _isRunning = true;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context);
    final maxWidth = md.size.width - (md.viewInsets.left + md.viewInsets.right);
    final maxHeight = md.size.height -
        (md.viewInsets.top + md.viewInsets.bottom);
    final startPos = 0.0;
    final itemHeight = 100.0;
    return Scaffold(
        appBar: AppBar(),
        body: Builder(
            builder: (builderContext) {
              final endPos = maxHeight - (itemHeight + (Scaffold
                  .of(builderContext)
                  .appBarMaxHeight ?? 0.0));

              return Stack(
                children: [
                  Positioned(
                    left: animation.value,
                    top: animation.value,
                    child: Container(
                        width: itemHeight, height: itemHeight, color: Colors.red),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(onPressed: () {
                      if (controller.isAnimating) {
                        controller.stop();
                      } else {
                        controller.forward(from: 0);
                      }
                    }, child: Text('click me')),
                  ),

                ],

              );
            }));
  }
}
