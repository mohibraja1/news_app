import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/utils/FireBaseDatabase.dart';

class AddNewsScreenBloc extends BaseBlock {
  late MyFireBaseDatabase db;

  AddNewsScreenBloc(BuildContext context) : super(context) {
    db = MyFireBaseDatabase();
  }

  void addNewsRecordToFirebaseDB(NewsModel newsModel) {
    db.addEntryToFireBase(newsModel);
  }

  void readAllNewsData() {
    db.readAllNewsData();
  }

  Future<String> uploadImageToFirebase(File file) async {

    return db.uploadImageToFirebase(file);

  }
}
