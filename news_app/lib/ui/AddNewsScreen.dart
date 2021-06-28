import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/blocs/AddNewsScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/viewmodels/AddNewsScreenVM.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';

final TAG = 'AddNewsScreen';

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

  String _imageFilePath = "";
  final _picker = ImagePicker();

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
                                    pickImageFromGallery(viewModel);
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

  void addNewsToFirebase(AddNewsScreenVM viewModel) {
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

    final newsModel = NewsModel(
        titleController.text, descriptionController.text, _imageFilePath);

    viewModel.addNewsRecordToFirebaseDB(newsModel).then((value) => {
          if (value)
            {mBloc.toast('News added successfully'), mBloc.moveToLastScreen()}
          else
            {mBloc.toast('News added failed')}
        });
  }

  Future<void> pickImageFromGallery(AddNewsScreenVM viewModel) async {
    mBloc.printLog('pickImageFromGallery');
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);

    final downloadLink =
        viewModel.uploadImageToFirebase(File(pickedFile!.path));

    downloadLink.then((value) => {
          setState(() {
            print('value is $value');
            _imageFilePath = value;
          })
        });
  }

  Widget _previewImage(AddNewsScreenVM viewModel) {
    if (_imageFilePath.isNotEmpty) {
      print(_imageFilePath);



      viewModel.shouldShowProgress(false);

      return Container( margin : EdgeInsets.only(top: 20,bottom: 20),child: Image.network(_imageFilePath));

    } else {
      return Container(
        width: 1,
        height: 1,
      );
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
}
