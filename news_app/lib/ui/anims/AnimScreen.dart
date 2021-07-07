import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class AnimatedAlignScreen extends StatefulWidget {

  @override
  State<AnimatedAlignScreen> createState() => _AnimatedAlignScreenState();
}

/// This is the private State class that goes with AnimatedAlignScreen.
class _AnimatedAlignScreenState extends State<AnimatedAlignScreen> {
  bool selected = true;
  bool view2Selected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [

          AnimatedAlign(
            alignment: selected ? Alignment.topLeft : Alignment.bottomRight,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: 22,
              height: 22,
              color: Colors.amberAccent,
            ),
          ),
          AnimatedAlign(
            alignment: selected ? Alignment.bottomRight : Alignment.topLeft,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: 22,
              height: 22,
              color: Colors.amberAccent,
            ),
          ),

          AnimatedAlign(
            alignment:
                view2Selected ? Alignment.topRight : Alignment.bottomLeft,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: 22,
              height: 22,
              color: Colors.amberAccent,
            ),
          ),
          AnimatedAlign(
            alignment:
                view2Selected ? Alignment.bottomLeft : Alignment.topRight,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: 22,
              height: 22,
              color: Colors.amberAccent,
            ),
          ),

          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  view2Selected = !view2Selected;
                  selected = !selected;
                });
              },
              child: Text('button'),
              style: ElevatedButton.styleFrom(primary: Colors.amberAccent),
            ),
          ),

        ],
      ),
    );
  }
}
