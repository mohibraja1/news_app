import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/ui/anims/AnimPositionedScreen.dart';
import 'package:news_app/ui/anims/AnimScreen.dart';
import 'package:news_app/ui/NewsListhome.dart';

import 'anims/Anim4.dart';
import 'anims/Anim5.dart';
import 'anims/Anim7.dart';
import 'anims/AnimController6.dart';
import 'anims/AnimController.dart';
import 'anims/AnimatedBuilder.dart';


class TempHome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {


    final bloc = BaseBlock(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child:  ListView(
          children: [

            Padding(padding: EdgeInsets.all(5)),
            Center(
              widthFactor: 100,
              child: ElevatedButton(
                onPressed: () {
                  bloc.navigateNext(NewsListHome());
                },
                child: Text('News App'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  padding: EdgeInsets.all(20), // Set padding
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),
            Center(
              widthFactor: 100,
              child: ElevatedButton(
                onPressed: () {
                  bloc.navigateNext(PageAnimation());
                },
                child: Text('AnimatedAlignScreen App'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  padding: EdgeInsets.all(20), // Set padding
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),
            Center(
              widthFactor: 100,
              child: ElevatedButton(
                onPressed: () {
                  bloc.navigateNext(AnimatedPositionedScreen());
                },
                child: Text('AnimatedPositioned App'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  padding: EdgeInsets.all(20), // Set padding
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),
            Center(
              widthFactor: 100,
              child: ElevatedButton(
                onPressed: () {
                  bloc.navigateNext(Page1());
                },
                child: Text('Anim4 App'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  padding: EdgeInsets.all(20), // Set padding
                ),
              ),
            ),


            Padding(padding: EdgeInsets.all(5)),
            Center(
              widthFactor: 100,
              child: ElevatedButton(
                onPressed: () {
                  bloc.navigateNext(MyAnim());
                },
                child: Text('Anim6 App'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  padding: EdgeInsets.all(20), // Set padding
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),
            Center(
              widthFactor: 100,
              child: ElevatedButton(
                onPressed: () {
                  bloc.navigateNext(AnimatedCirclePage());
                },
                child: Text('AnimatedCirclePage App'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  padding: EdgeInsets.all(20), // Set padding
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
