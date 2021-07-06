import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/utils/AppConstants.dart';
import 'package:news_app/utils/Utils.dart';

class MyFireBaseDatabase {
  final _TAG = 'MyFireBaseDatabase';
  static DatabaseReference _dbRef =
      FirebaseDatabase.instance.reference().child('MyNews');

  DatabaseReference getFireBaseObj() {
    return _dbRef;
  }

  Future<bool> addEntryToFireBase(NewsModel newsModel) async {
    var isSuccess = false;

    await _dbRef
        .child(newsModel.timeStamp)
        .set({
          AppConstants.KEY_NEWS_TIME_STAMP: newsModel.timeStamp,
          AppConstants.KEY_NEWS_TITLE: newsModel.newsTitle,
          AppConstants.KEY_NEWS_DESCRIPTION: newsModel.newsDesctiption,
          AppConstants.KEY_NEWS_IMAGE: newsModel.imagePath,
          AppConstants.KEY_LIKES: newsModel.totalLikes,
          AppConstants.KEY_REPORTER_NAME: newsModel.reporterName,
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

    await _dbRef.once().then((DataSnapshot snapshot) async {
      if (snapshot == null || snapshot.value == null) {
        return mList;
      }
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) async {
        log(values);

        final timeStamp = values[AppConstants.KEY_NEWS_TIME_STAMP];
        final title = values[AppConstants.KEY_NEWS_TITLE];
        final description = values[AppConstants.KEY_NEWS_DESCRIPTION];
        final imagePath = values[AppConstants.KEY_NEWS_IMAGE];
        final likes = values[AppConstants.KEY_LIKES];
        final reporterName = values[AppConstants.KEY_REPORTER_NAME];

        List<String> commentList = [];
        List<Object?> objList = [];

        log('came try section for comments');

        DatabaseReference mReef = _dbRef.child(timeStamp).child(AppConstants.KEY_COMMENTS);

        rootFirebaseIsExists(mReef).then((value) async => {
              if (value)
                {
                  await mReef.once().then((value) async => {
                        log('the value is = $value'),
                        if (value != null && value.value != null)
                          {
                            objList = value.value,
                            log(objList),
                            objList.forEach((element) {
                              if (element != null) {
                                commentList.add(element.toString());
                              }
                            }),
                            commentList.forEach((element) {
                              log('element is = ' + element);
                            })
                          },
                      })
                }
              else
                {log('${mReef} not exist')}
            });

        log('reading data and cometns  = ${commentList.length}');

        final newsmodel = NewsModel(
            timeStamp, title, description, imagePath, likes, commentList,reporterName);
        log('comes after parsing timeStamp = $timeStamp');
        // final newsmodel = NewsModel.fromEventObject(values);
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
        final title = values[AppConstants.KEY_NEWS_TITLE];
        final description = values[AppConstants.KEY_NEWS_DESCRIPTION];
        final imagePath = values[AppConstants.KEY_NEWS_IMAGE];
        final timeStamp = values[AppConstants.KEY_NEWS_TIME_STAMP];
        final reporterName = values[AppConstants.KEY_REPORTER_NAME];
        final likes = values[AppConstants.KEY_LIKES];



        List<String> commentList = [];
        List<Object?> objList = [];

        DatabaseReference mReef = _dbRef.child(timeStamp).child(AppConstants.KEY_COMMENTS);

        rootFirebaseIsExists(mReef).then((value) async => {
          if (value)
            {
              await mReef.once().then((value) async => {
                log('the value is = $value'),
                if (value != null && value.value != null)
                  {
                    objList = value.value,
                    log(objList),
                    objList.forEach((element) {
                      if (element != null) {
                        commentList.add(element.toString());
                      }
                    }),
                    commentList.forEach((element) {
                      log('element is = ' + element);
                    })
                  },
              })
            }
          else
            {log('${mReef} not exist')}
        });

        log('reading data and cometns  = ${commentList.length}');
        if (timeStamp.toString().isEmpty) {
          throw('time stampp can not be empy');

        }

        final newsmodel = NewsModel(timeStamp, title, description, imagePath,
            likes, commentList.reversed.toList(),reporterName);

        // final newsmodel = NewsModel.fromEventObject(values);
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

  Future<bool> addComment(NewsModel newsModel, String comment) async {
    final commentNumber = newsModel.commentList.length.toString();
    log('total coments number now $commentNumber');

    var isSuccess = false;

    final path = 'MyNews/${newsModel.timeStamp}/${AppConstants.KEY_COMMENTS}';
    log('time stamp = ${newsModel.timeStamp}');
    log('time title = ${newsModel.newsTitle}');
    log('path is $path');

    DatabaseReference mRef =
        FirebaseDatabase.instance.reference().child(path).reference();

    await mRef.child(commentNumber.toString()).set(comment).then((_) {
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

    await mRef.child(AppConstants.KEY_LIKES).set(add).then((_) {
      print('add Comment success');
      isSuccess = true;
    });

    return isSuccess;
  }

  Future<bool> rootFirebaseIsExists(DatabaseReference databaseReference) async {
    DataSnapshot snapshot = await databaseReference.once();

    return snapshot != null;
  }
}

void log(Object obj) {
  print(obj);
}
