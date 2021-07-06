import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/blocs/NewsListScreenBloc.dart';
import 'package:news_app/repo/authentication_service.dart';
import 'package:news_app/ui/NewsDetailScreen.dart';
import 'package:news_app/ui/sign_in_page.dart';
import 'package:news_app/viewmodels/NewsListScreenVM.dart';
import 'package:stacked/stacked.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'AddNewsScreen.dart';

var TAG = 'NewsListHome';

//MR: this class will show all news list
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
                onSelected: (value) {
                  if (value == 1) {
                    signout(bloc, context);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child:
                        GestureDetector(onTap: () {}, child: Text("Signout")),
                    value: 1,
                  ),
                ],
              )
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

  //MR: handling list view
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

  //MR: navigate to add news screen
  _gooAddNewsScreen(BaseBlock bloc) async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      bloc.navigateNext(AddNewsScreen());
      // bloc.navigateNext(SignInPage());
    } else {
      log('login first than go farward');

      //MR: showing alert for login
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Alert'),
              content: Text('Only logged in user can add news, So Login first'),
              actions: <Widget>[
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.amberAccent),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      gotoSigninScreen(bloc); // navigate sign in screen
                    })
              ],
            );
          });
    }
  }

  gotoSigninScreen(BaseBlock bloc) async {

    var results = await Navigator.of(context).push(new MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return new SignInPage();
      },
    ));

    //MR: getting results from sign in screen
    if (results != null && results.containsKey('isLoggedIn')) {
      bool value = results['isLoggedIn'];

      if (value) {
        //MR: navigate add news screen
        bloc.navigateNext(AddNewsScreen());
      }
    } else {
      log('controls hould ');
    }
  }

  signout(NewsListScreenBloc bloc, BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      bloc.toast('No User found');
    } else {
      await context.read<AuthenticationService>().signOut().then(
          (value) => {log('signout reult  '), bloc.toast('signout success')});
    }
  }
}
