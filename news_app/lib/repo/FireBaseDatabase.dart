import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/NewsModel.dart';

class MyFireBaseDatabase {
  final TAG = 'MyFireBaseDatabase';
  static final _dbRef = FirebaseDatabase.instance.reference().child('MyNews');

  final KEY_NEWS_TITLE = 'NewsTitle';
  final KEY_NEWS_DESCRIPTION = 'NewsDescription';
  final KEY_NEWS_IMAGE = 'NewsImage';

   DatabaseReference getFireBaseObj(){
    return _dbRef;
  }

  Future<bool> addEntryToFireBase(NewsModel newsModel) async {
    var isSuccess = false;
   await  _dbRef
        .push()
        .set({
          KEY_NEWS_TITLE: newsModel.newsTitle,
          KEY_NEWS_DESCRIPTION: newsModel.newsDesctiption,
          KEY_NEWS_IMAGE: newsModel.imagePath,
        })
        .then((value) => {
              print('addEntryToFireBase success'),
              isSuccess = true,
            })
        .whenComplete(() => {isSuccess = true, log('whenComplete')})
        .onError((error, stackTrace) => {
              log('onError'),
              isSuccess = false,
            });


    return isSuccess;
  }

  Future<List<NewsModel>> readAllNewsData() async {
    print('readAllNewsData come in this function');

    List<NewsModel> mList = <NewsModel>[];

    await _dbRef.once().then((DataSnapshot snapshot) {

      if (snapshot == null || snapshot.value == null) {
        return mList;
      }
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        final title = values[KEY_NEWS_TITLE];
        final description = values[KEY_NEWS_DESCRIPTION];
        final imagePath = values[KEY_NEWS_IMAGE];

        final newsmodel = NewsModel(title, description, imagePath);
        mList.add(newsmodel);
      });

      print(mList);

      return mList;
    });

    return mList;
  }

  Future<List<NewsModel>> readAllNewsDataWhenChange() async {
    print('readAllNewsDataWhenChange come in this function');

    List<NewsModel> mList = <NewsModel>[];

    await _dbRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        final title = values[KEY_NEWS_TITLE];
        final description = values[KEY_NEWS_DESCRIPTION];
        final imagePath = values[KEY_NEWS_IMAGE];

        final newsmodel = NewsModel(title, description, imagePath);
        mList.add(newsmodel);
      });

      print(mList);

      return mList;
    });

    return mList;
  }

  Future<String> uploadImageToFirebase(File file1) async {
    String data = "helloworld";

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1-" + DateTime.now().toString());

    await ref.putFile(file1).then((res) async {
      await res.ref.getDownloadURL().then((value) {
        print("sds_ $value");
        data = value;
      });
    });
    return data;
  }
}

void log(Object obj) {
  print(obj);
}
