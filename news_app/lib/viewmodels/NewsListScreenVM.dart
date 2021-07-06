import 'dart:async';

import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/ui/AddNewsScreen.dart';
import 'package:news_app/viewmodels/BaseViewModel.dart';

import 'package:firebase_database/firebase_database.dart';

class NewsListScreenVM extends BaseViewModel {
  late MyFireBaseDatabase _db;

  List<NewsModel> newsList = [];
  bool isUpdatedOnce = false;

  NewsListScreenVM() {
    _db = MyFireBaseDatabase();

    _db.getFireBaseObj().onChildAdded.listen((event) {
      _onNewsAdded(event);
    });

    _db.getFireBaseObj().onChildRemoved.listen((event) {
      _onNewsRemoved(event);
    });
  }

  get _TAG => 'News List Screen VM';

  void _onNewsAdded(Event event) {
    log('come in fun _onNewsAdded');
    notifyChange();
    newsList.add(NewsModel.fromEventObject(event.snapshot));
  }

  void _onNewsRemoved(Event event) {
    notifyChange();

    log('come in fun _onNewsRemoved');
    newsList.remove(NewsModel.fromEventObject(event.snapshot));
  }

  initialise() {
    log(_TAG + ' initialise method called');
    getNewsListFromFirebase();
  }

  Future<List<NewsModel>> getNewsListFromFirebase() async {
    _db.readAllNewsData().then((value) => {
          notifyChange(),
          log('isUpdatedOnce yes  & getting value $value'),
          isUpdatedOnce = true,
          newsList = value,
          log('${newsList.length} is size of list')
        });

    return newsList;
  }

  Future<List<NewsModel>> readAllNewsDataWhenChange() async {
    /*_db.readAllNewsDataWhenChange().then((value) => {
          notifyChange(),
          log('isUpdatedOnce yes  & getting value $value'),
          isUpdatedOnce = true,
          newsList = value,

      log('${newsList.length} is size of list')});*/

    return newsList;
  }

  Future<void> deleteNewsModel(NewsModel newsModel) async {
    return await _db.deleteNews(newsModel);
  }
}
