import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';

String TAG = 'Anim6';

class Anim6 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyStatefulWidgetState();
  }
}

class _MyStatefulWidgetState extends State<Anim6>
    with SingleTickerProviderStateMixin {
  double rotatingAngle = 40;
  bool isForwarding = true;
  var screenWidth, screenHeight;

  var horizontalPos = 0.0;
  var verticalPos = 0.0;

  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context);

    final itemHeight = 100.0;
    screenWidth = md.size.width - (md.viewInsets.left + md.viewInsets.right+itemHeight);
    screenHeight = md.size.height - (md.viewInsets.top + md.viewInsets.bottom+itemHeight);

    log('maxWidth is = $screenWidth');
    log('maxHeight is = $screenHeight');

    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder:  (builderContext) {

          var appbarHeith = Scaffold.of(builderContext).appBarMaxHeight;

          if (appbarHeith == null) {
            appbarHeith = 0.0;
          }

          screenHeight = screenHeight -appbarHeith;
          log('appbarHeith is = $appbarHeith');


          return SafeArea(
            child: Stack(
              children: [
                Positioned(
                  width: itemHeight,
                  height: itemHeight,
                  left: horizontalPos,
                  top: verticalPos,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Best Rotate App'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      padding: EdgeInsets.all(20), // Set padding
                    ),
                  ),
                ),

                /*
              andle base aniation

              Transform.rotate(
                angle: rotatingAngle,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Best Rotate App'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    padding: EdgeInsets.all(20), // Set padding
                  ),
                ),
              ),*/
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      isForwarding = !isForwarding;
                      animThings();
                    },
                    child: Text('News App'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      padding: EdgeInsets.all(20), // Set padding
                    ),
                  ),
                ),
              ],
            ),
          );

        }
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    // animationController.repeat(max: 2);
    animationController.addListener(() {
      log('animationController is = ${animationController.value}');

      setState(() {
        horizontalPos = animationController.value * screenWidth;
        verticalPos = animationController.value * screenHeight;
        rotatingAngle = animationController.value + 4;

        log('verticalPos is = $verticalPos');
      });
    });
    log('initState of $TAG');
  }

  animThings() {
    isForwarding
        ? animationController.forward(from: 0)
        : animationController.reverse(from: 1);
  }
}
