import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/blocs/AddNewsScreen.dart';
import 'package:image_picker/image_picker.dart';

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

  PickedFile? _imageFile;
  dynamic _pickImageError;
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add News Page',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 5),
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
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 12),
                  color: Colors.amber,
                  child: TextButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      mBloc.printLog("add image button clicked");
                      pickImageFromGallery();
                    },
                    child: Text(
                      'Add Photo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: _previewImage(),
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

                      addNewsToFirebase();
                    },
                    child: Text('Add News'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addNewsToFirebase() {
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
  }

  Future<void> pickImageFromGallery() async {
    mBloc.printLog('pickImageFromGallery');
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      return Semantics(
          child: Image.file(File(_imageFile!.path)),
          label: 'image_picker_example_picked_image');
    } else {
      return Container(
        width: 1,
        height: 1,
      );
    }
  }
}
