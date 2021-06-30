import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/utils/Utils.dart';

class MyFireBaseDatabase {
  final TAG = 'MyFireBaseDatabase';
  static DatabaseReference _dbRef =
      FirebaseDatabase.instance.reference().child('MyNews');

  final KEY_NEWS_TIME_STAMP = 'timeStamp';
  final KEY_NEWS_TITLE = 'NewsTitle';
  final KEY_NEWS_DESCRIPTION = 'NewsDescription';
  final KEY_NEWS_IMAGE = 'NewsImage';
  final KEY_LIKES = 'totalLikes';
  final _KEY_COMMENTS = 'Comments';

  DatabaseReference getFireBaseObj() {
    return _dbRef;
  }

  Future<bool> addEntryToFireBase(NewsModel newsModel) async {
    var isSuccess = false;

    await _dbRef
        .child(newsModel.timeStamp)
        .set({
          KEY_NEWS_TIME_STAMP: newsModel.timeStamp,
          KEY_NEWS_TITLE: newsModel.newsTitle,
          KEY_NEWS_DESCRIPTION: newsModel.newsDesctiption,
          KEY_NEWS_IMAGE: newsModel.imagePath,
          KEY_LIKES: newsModel.totalLikes,
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

    List<NewsModel> mList = [];

    await _dbRef.once().then((DataSnapshot snapshot) async{
      if (snapshot == null || snapshot.value == null) {
        return mList;
      }
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) async {
        log(values);

        final timeStamp = values[KEY_NEWS_TIME_STAMP];
        final title = values[KEY_NEWS_TITLE];
        final description = values[KEY_NEWS_DESCRIPTION];
        final imagePath = values[KEY_NEWS_IMAGE];
        final likes = values[KEY_LIKES];

        List<String> commentList = [];




        if (timeStamp.toString().isEmpty) {
          throw('time stampp can not be empy');

        }

        final newsmodel = NewsModel(
            timeStamp, title, description, imagePath, likes, commentList);
        log('comes after parsing timeStamp = $timeStamp');
        // final newsmodel = NewsModel.fromEventObject(values);
        mList.add(newsmodel);
      });

      print(mList);

      return mList;
    });

    return mList;
  }

 /* Future<List<NewsModel>> readAllNewsDataWhenChange() async {
    print('readAllNewsDataWhenChange come in this function');

    List<NewsModel> mList = <NewsModel>[];

    await _dbRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        final title = values[KEY_NEWS_TITLE];
        final description = values[KEY_NEWS_DESCRIPTION];
        final imagePath = values[KEY_NEWS_IMAGE];
        final timeStamp = values[KEY_NEWS_TIME_STAMP];

        int likes = 0;
        try {
          DataSnapshot commentSnap = values[KEY_LIKES];
          Map<dynamic, dynamic> likeslisat = commentSnap.value;

          likes = likeslisat.length;
        } on Exception catch (e) {
          print('exceaptinn came  $e');
        }

        List<String> commentList = [];

        try {
          DataSnapshot commentSnap = values[_KEY_COMMENTS];
          Map<dynamic, dynamic> comments = commentSnap.value;

          comments.forEach((key, value) {
            commentList.add(value);
          });
        } on Exception catch (e) {
          print('exceaptinn came  $e');
        }

        if (timeStamp.toString().isEmpty) {
          throw('time stampp can not be empy');

        }

        final newsmodel = NewsModel(timeStamp, title, description, imagePath,
            likes, commentList.reversed.toList());

        // final newsmodel = NewsModel.fromEventObject(values);
        mList.add(newsmodel);
      });

      print(mList);

      return mList;
    });

    return mList;
  }*/

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

  Future<bool> addComment(NewsModel newsModel, String comment) async {
    final commentNumber = newsModel.commentList.length.toString();
    log('total coments number now $commentNumber');

    var isSuccess = false;

    final path = 'MyNews/${newsModel.timeStamp}/${_KEY_COMMENTS}';
    log('time stamp = ${newsModel.timeStamp}');
    log('time title = ${newsModel.newsTitle}');
    log('path is $path');
    DatabaseReference mRef =
        FirebaseDatabase.instance.reference().child(path).reference();

    await mRef.push().set({
      commentNumber.toString(): comment,
    }).then((_) {
      print('add Comment success');
      isSuccess = true;
    });

    return isSuccess;
  }

  Future<bool> addLikeToNews(NewsModel newsModel, String timeStamp22) async {
    final add = newsModel.totalLikes + 1;

    final commentNumber = newsModel.commentList.length.toString();
    log('total coments number for like now $commentNumber');

    var isSuccess = false;

    final path = 'MyNews/${newsModel.timeStamp}';
    log('time stamp = ${newsModel.timeStamp}');
    log('time title = ${newsModel.newsTitle}');
    log('path is $path');
    DatabaseReference mRef =
        FirebaseDatabase.instance.reference().child(path).reference();

    if (newsModel.timeStamp.isEmpty) {

      log('timeStamp22 = $timeStamp22');
      throw ('time stamp can not be empty');
    }

    await mRef.reference().set({

      KEY_NEWS_TIME_STAMP: newsModel.timeStamp,
      KEY_NEWS_TITLE: newsModel.newsTitle,
      KEY_NEWS_DESCRIPTION: newsModel.newsDesctiption,
      KEY_NEWS_IMAGE: newsModel.imagePath,

      KEY_LIKES: add,
    }).then((_) {
      print('add Comment success');
      isSuccess = true;
    });

    return isSuccess;
  }

/*Future<bool> addLikeToNews(NewsModel newsModel) async {
    final add = newsModel.totalLikes + 1;

    log('$add adding to firebase');
    log('${newsModel.newsTitle} is news titile');

    var isSuccess = false;

    final mRef = FirebaseDatabase.instance
        .reference()
        .child('MyNews')
        .child(newsModel.timeStamp)
        .child(KEY_LIKES)
        .reference();

    await mRef.set({
      KEY_LIKES,add.toString()
    }).then((_) {
      print('add Like To News success');
      isSuccess = true;
    });

    return isSuccess;
  }*/
}

void log(Object obj) {
  print(obj);
}
