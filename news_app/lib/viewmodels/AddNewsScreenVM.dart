import 'dart:async';
import 'dart:io';

import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/viewmodels/BaseViewModel.dart';

class AddNewsScreenVM extends BaseViewModel {
  late MyFireBaseDatabase _db;

  bool isShowingProgress = false;

  initialise() {
    _db = MyFireBaseDatabase();
  }

  Future<bool> addNewsRecordToFirebaseDB(NewsModel newsModel) {
    return _db.addEntryToFireBase(newsModel);
  }

  Future<String> uploadImageToFirebase(File file) async {
    notifyChange();
    isShowingProgress = true;
    return _db.uploadImageToFirebase(file);

  }

  shouldShowProgress(bool value){
    notifyChange();
    isShowingProgress = value;
  }
}
