import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Page1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState1();
}

class _PageState1 extends State<Page1>{
  double opacity = 0;
  double padding = 0;
  bool align = false;

  @override
  void initState() {
    super.initState();
    //setState after 300ms just to see the changes
    Future.delayed(const Duration(milliseconds: 300), () => _setAnimation());
  }

  _setAnimation() => setState((){
    opacity = opacity == 0 ? 1 : 0; //when you setState to different values it will animate to those values
    align = !align;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.teal],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.5, 0.85])
          ),
          child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      alignment: align ? Alignment.topLeft : Alignment.bottomRight, //pass an Align based on the bool value, or if you want to directly pass an Alignment
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://pbs.twimg.com/media/DpeOMc3XgAIMyx_.jpg',
                        ),
                        radius: 50.0,
                      ),
                    )
                ),
                Expanded(
                  child: AnimatedOpacity(
                      opacity: opacity, //give the opacity value
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              width: double.infinity,
                              child: RaisedButton(
                                child: Text('Log in', style: TextStyle(color: Colors.teal[300], fontSize: 12)),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                onPressed: () => print('Log in'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              width: double.infinity,
                              child: RaisedButton(
                                child: Text('Sign up', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                color: Colors.teal[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                onPressed: () => _setAnimation(),
                              ),
                            )
                          ]
                      )
                  ),
                ),
              ]
          )
      ),
    );
  }
}