import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/viewmodels/NewsListScreenVM.dart';
import 'package:stacked/stacked.dart';

class MyTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<NewsListScreenVM>.reactive(
      viewModelBuilder: () => NewsListScreenVM(),
      onModelReady: (viewModel) => viewModel.initialise(),

      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('rwar',style: TextStyle(color: Colors.white)),
        ),
        body: Stack(
          children: [
            Text('My first text'),
            Align(
              child: GestureDetector(child: Text('My second text'),onTap: (){



              },),
              alignment: Alignment.bottomRight,
            ),
          ],
        ),
      ),
    );
  }
}
