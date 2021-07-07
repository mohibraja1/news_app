import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';

class AnimatedPositionedScreen extends StatefulWidget {
  @override
  State<AnimatedPositionedScreen> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with AnimatedPositionedScreen.
class _MyStatefulWidgetState extends State<AnimatedPositionedScreen>
    with SingleTickerProviderStateMixin {
  bool selected = true;

  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 12));
    Tween<double>(begin: 100, end: 600).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final md = MediaQuery.of(context);
    final maxWidth = md.size.width - (md.viewInsets.left + md.viewInsets.right);
    final maxHeight = md.size.height - (md.viewInsets.top + md.viewInsets.bottom);


    final startPos = 0.0;
    final itemHeight = 100.0;

    log('maxWidth is = $maxWidth');
    log('maxHeight is = $maxHeight');

    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (builderContext) {
        final endPos = maxHeight -
            (itemHeight + (Scaffold.of(builderContext).appBarMaxHeight ?? 0.0));

        log('endPos is =$endPos');

        return Container(
          child: Material(
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // setState(() {

                      selected = !selected;

                      if (selected)
                        controller.forward();
                      else
                        controller.reverse();

                      log('selected sd = $selected');



                      // });
                    },
                    child: Text('button'),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.amberAccent),
                  ),
                ),
                Positioned(
                  width: itemHeight,
                  height: itemHeight,
                  top: selected ? startPos : endPos,
                  left: selected ? startPos : (maxWidth-itemHeight),
                  //duration: const Duration(seconds: 1),
                  child: Container(
                    height: itemHeight,
                    width: itemHeight,
                    color: Colors.blue,
                    child: const Center(child: Text('Tap me')),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
