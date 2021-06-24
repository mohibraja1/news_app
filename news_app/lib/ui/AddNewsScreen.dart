

import 'package:flutter/material.dart';

class AddNewsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(

      onWillPop: () async {
        // You can do some work here.
        // Returning true allows the pop to happen, returning false prevents it.
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Add News Page', style: TextStyle(color: Colors.white),),),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}