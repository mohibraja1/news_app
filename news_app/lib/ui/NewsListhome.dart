import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app/blocs/NewsListScreenBloc.dart';
import 'package:news_app/ui/AddNewsScreen.dart';
import 'package:news_app/ui/NewsDetailScreen.dart';
import 'package:news_app/viewmodels/NewsListScreenVM.dart';
import 'package:stacked/stacked.dart';

class NewsListHome extends StatefulWidget {
  NewsListHome({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<NewsListHome> {
  @override
  Widget build(BuildContext context) {
    final bloc = NewsListScreenBloc(context);

    return ViewModelBuilder<NewsListScreenVM>.reactive(
      viewModelBuilder: () => NewsListScreenVM(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              bloc.navigateNext(AddNewsScreen());
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.amber,
          ),
          appBar: AppBar(
            title: Text('News List', style: TextStyle(color: Colors.white)),
          ),
          body: Stack(
            children: [
              addItems(context, viewModel, bloc),
              // addFutureItems(context, viewModel, bloc),
              /*Container(
                margin: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      bloc.navigateNext(AddNewsScreen());
                    },
                    child: Text('Add More News'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      padding: EdgeInsets.all(20), // Set padding
                    ),
                  ),
                ),
              ),*/
            ],
          )),
    );
  }

  addFutureItems(BuildContext context, NewsListScreenVM viewModel,
      NewsListScreenBloc bloc) {
    return Container(
      child: FutureBuilder(
          future: viewModel.getNewsListFromFirebase(),
          builder: (context, snapShot) {
            if (!viewModel.isUpdatedOnce) {
              return showProgressBar(!viewModel.isUpdatedOnce);
            } else if (viewModel.newsList.isEmpty) {
              return Center(
                child: Text('No Data found yet'),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.newsList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        child: Card(
                          margin: EdgeInsets.only(
                              left: 11, right: 11, top: 5, bottom: 5),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 12, right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "News title: " +
                                      viewModel.newsList[index].newsTitle,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      textBaseline: TextBaseline.alphabetic),
                                  maxLines: 2,
                                ),
                                Text(
                                  "News Description: " +
                                      viewModel.newsList[index].newsDesctiption,
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          final item = viewModel.newsList[index];
                          bloc.navigateNext(NewsDetailScreen(item));
                        },
                      ));
            }
          }),
    );
  }

  addItems(BuildContext context, NewsListScreenVM viewModel,
      NewsListScreenBloc bloc) {
    if (!viewModel.isUpdatedOnce) {
      return showProgressBar(!viewModel.isUpdatedOnce);
    } else if (viewModel.newsList.isEmpty) {
      return Center(
        child: Text('No Data found yet'),
      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.newsList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Card(
                margin: EdgeInsets.only(left: 11, right: 11, top: 5, bottom: 5),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "News title: " + viewModel.newsList[index].newsTitle,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            textBaseline: TextBaseline.alphabetic),
                        maxLines: 2,
                      ),
                      Text(
                        "News Description: " +
                            viewModel.newsList[index].newsDesctiption,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w300,
                            textBaseline: TextBaseline.alphabetic),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {

                final item = viewModel.newsList[index];
                bloc.navigateNext(NewsDetailScreen(item));
              },
            );
          });
    }
  }

  showProgressBar(bool showProgress) {
    log('$TAG showProgressBar');
    if (showProgress) {
      log('$TAG showing');
      return Center(child: CircularProgressIndicator());
    } else {
      log('$TAG not showing');
      return Container();
    }
  }

  log(Object ob) {
    print(ob);
  }
}
