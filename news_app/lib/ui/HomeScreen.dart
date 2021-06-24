import 'package:flutter/material.dart';
import 'package:news_app/blocs/HomeScreenBloc.dart';
import 'package:news_app/ui/AddNewsScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final bloc = HomeScreenBloc(context);

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
                child: GestureDetector(
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.amber,
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: Text('View All News',style: TextStyle(color: Colors.white),)),
                  ),
                  onTap: (){
                    //MR: navigate to next screen
                    // bloc.navigateNext(widget)
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.amber,
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: Text('Add News',style: TextStyle(color: Colors.white),)),
                  ),
                  onTap: (){
                    //MR: navigate to next screen

                    bloc.navigateNext(AddNewsScreen());
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
