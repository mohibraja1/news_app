import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:news_app/models/NewsModel.dart';

class MyFireBaseDatabase {
  static final databaseReference =
      FirebaseDatabase.instance.reference().child('MyNews');

  final KEY_NEWS_TITLE = 'NewsTitle';
  final KEY_NEWS_DESCRIPTION = 'NewsDescription';
  final KEY_NEWS_IMAGE = 'NewsImage';

  void addEntryToFireBase(NewsModel newsModel) {
    databaseReference.push().set({
      KEY_NEWS_TITLE: newsModel.newsTitle,
      KEY_NEWS_DESCRIPTION: newsModel.newsDesctiption,
      KEY_NEWS_IMAGE: newsModel.imagePath,
    }).then((value) => {
      print('addEntryToFireBase success')
    });
  }

  Future<List<NewsModel>> readAllNewsData() async {
    print('readAllNewsData come in this function');

    List<NewsModel> mList = <NewsModel>[];

    await databaseReference.once().then((DataSnapshot snapshot) {
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
