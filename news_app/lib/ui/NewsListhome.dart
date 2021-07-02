import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/blocs/NewsListScreenBloc.dart';
import 'package:news_app/ui/AddNewsScreen.dart';
import 'package:news_app/ui/NewsDetailScreen.dart';
import 'package:news_app/ui/sign_in_page.dart';
import 'package:news_app/viewmodels/NewsListScreenVM.dart';
import 'package:stacked/stacked.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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
            onPressed: () async {
              _gooAddNewsScreen(bloc);
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.amber,
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              PopupMenuButton(

                  color: Colors.white,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: GestureDetector(
                              onTap: () {
                                User? user = FirebaseAuth.instance.currentUser;

                                if (user == null) {
                                  bloc.toast('No User found');
                                } else {
                                  signout();
                                }
                              },
                              child: Text("Signout")),
                          value: 1,
                        ),
                      ])
            ],
            title: Text('World News', style: TextStyle(color: Colors.white)),
          ),
          body: Stack(
            children: [
              addItems(context, viewModel, bloc),
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
                          log('clicked item time stamp = ${item.timeStamp}');
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
    log('$TAG comes in show Progress Bar fun');
    if (showProgress) {
      log('$TAG showing pb');
      return Center(child: CircularProgressIndicator());
    } else {
      log('$TAG not showing pb');
      return Container();
    }
  }

  log(Object ob) {
    print(ob);
  }

  _gooAddNewsScreen(BaseBlock bloc) async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      bloc.navigateNext(AddNewsScreen());
      // bloc.navigateNext(SignInPage());
    } else {
      log('login first than go farward');

      var results =
          await Navigator.of(context).push(new MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return new SignInPage();
        },
      ));

      log('jjjj');
      if (results != null && results.containsKey('isLoggedIn')) {
        bool value = results['isLoggedIn'];

        if (value) {
          bloc.navigateNext(AddNewsScreen());
        }
      } else {
        log('controls hould ');
      }
    }
  }

  signout() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => {log('signout reult  ')});
  }
}
