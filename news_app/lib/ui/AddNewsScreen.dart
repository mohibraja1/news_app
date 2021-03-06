import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/AddNewsScreen.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/utils/Utils.dart';
import 'package:news_app/viewmodels/AddNewsScreenVM.dart';
import 'package:stacked/stacked.dart';

final _TAG = 'AddNewsScreen';

class AddNewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<AddNewsScreen> {
  late AddNewsScreenBloc mBloc;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mBloc = AddNewsScreenBloc(context);
    final maxLines = 5;

    return WillPopScope(
      onWillPop: () async {
        // You can do some work here.
        // Returning true allows the pop to happen, returning false prevents it.
        return true;
      },
      child: ViewModelBuilder<AddNewsScreenVM>.reactive(
        viewModelBuilder: () => AddNewsScreenVM(),
        onModelReady: (viewModel) => viewModel.initialise(),
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, // change your color here
            ),
            title: Text(
              'Add News Page',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 5),
                  child: ListView(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter News title'),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        height: maxLines * 24.0,
                        child: TextField(
                          controller: descriptionController,
                          maxLines: maxLines,
                          decoration: InputDecoration(
                            hintText: "Enter a message",
                            fillColor: Colors.grey[300],
                            filled: true,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 200,
                              margin: EdgeInsets.only(top: 12),
                              color: Colors.amber,
                              child: TextButton(
                                style: ButtonStyle(),
                                onPressed: () {

                                  mBloc.printLog("add image button clicked");
                                  if (!viewModel.isShowingProgress) {
                                    viewModel.pickImageFromGallery();
                                  }
                                },
                                child: Container(
                                  child: Text(
                                    'Add Photo',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: _previewImage(viewModel),
                      ),
                      Container(
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber),
                          ),
                          onPressed: () {
                            mBloc.printLog('done button pressed');

                            addNewsToFirebase(viewModel);
                          },
                          child: Text('Add News'),
                        ),
                      )
                    ],
                  ),
                ),
                showProgressBar(viewModel.isShowingProgress),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //MR: add news to db
  void addNewsToFirebase(AddNewsScreenVM viewModel) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }
    var reporterName = user.displayName;

    log('the name is = $reporterName');

    if (titleController.text.isEmpty && descriptionController.text.isEmpty) {
      mBloc.toast('titil and desctiption is empty');
      return;
    }

    if (titleController.text.isEmpty) {
      mBloc.toast('title is empty');
      return;
    }
    if (descriptionController.text.isEmpty) {
      mBloc.toast('description is empty');
      return;
    }

    mBloc.printLog('starting adding data on firebase');
    final timeStamp = Utils().getFormatedTimeStamp();

    List<String> commentList = [];
    final newsModel = NewsModel(
        timeStamp,
        titleController.text,
        descriptionController.text,
        viewModel.imageFileLink,
        0,
        commentList,
        reporterName!);

    viewModel.addNewsRecordToFirebaseDB(newsModel).then((value) => {
          if (value)
            {mBloc.toast('News added successfully'), mBloc.moveToLastScreen()}
          else
            {mBloc.toast('News added failed')}
        });
  }

  _previewImage(AddNewsScreenVM viewModel) {
    if (viewModel.imageFileLink.isNotEmpty) {
      print(viewModel.imageFileLink);

      viewModel.shouldShowProgress(false);
      return Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Image.network(viewModel.imageFileLink));
    } else {
      return Container(width: 1, height: 1);
    }
  }

  showProgressBar(bool showProgress) {
    log('$_TAG showProgressBar');
    if (showProgress) {
      log('$_TAG showing');
      return Center(child: CircularProgressIndicator());
    } else {
      log('$_TAG not showing');
      return Container();
    }
  }
}
