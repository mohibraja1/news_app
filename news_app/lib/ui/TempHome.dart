

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/ui/AnimScreen.dart';
import 'package:news_app/ui/NewsListhome.dart';


class TempHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    final bloc = BaseBlock(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child:  ListView(
          children: [
            Padding(padding: EdgeInsets.all(10)),

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

            Padding(padding: EdgeInsets.all(10)),
            Center(
              widthFactor: 100,
              child: ElevatedButton(
                onPressed: () {
                  bloc.navigateNext(AnimatedAlignScreen());
                },
                child: Text('AnimatedAlignScreen App'),
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