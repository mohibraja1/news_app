import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home Screen'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  color: Colors.amber,
                  padding: EdgeInsets.all(10),
                  child: Text('View All News'),
                ),
              ),
            ],
          ),
        ));
  }
}
