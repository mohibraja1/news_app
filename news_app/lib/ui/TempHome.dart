

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/ui/NewsListhome.dart';


class TempHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    final bloc = BaseBlock(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child:  ElevatedButton(
          onPressed: () {
            bloc.navigateNext(NewsListHome());
          },
          child: Text('Add More News'),
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            padding: EdgeInsets.all(20), // Set padding
          ),
        ),
      ),
    );

  }
}