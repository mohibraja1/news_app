import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';

class AddNewsScreenBloc extends BaseBlock {
  late MyFireBaseDatabase db;

  AddNewsScreenBloc(BuildContext context) : super(context) {
    db = MyFireBaseDatabase();
  }

  Future<bool>  addNewsRecordToFirebaseDB(NewsModel newsModel) {
    return db.addEntryToFireBase(newsModel);
  }

  Future<String> uploadImageToFirebase(File file) async {

    return db.uploadImageToFirebase(file);

  }
}
