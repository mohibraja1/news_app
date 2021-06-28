

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text('Test screen'),),
      body: Stack(
        children: [
          
          Text('My first text'),
          Align(child: Text('My second text'),alignment: Alignment.bottomRight,),

        ],
      ),
    );
  }

}