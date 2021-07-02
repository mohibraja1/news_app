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

  late StreamSubscription<Event> _onNoteAddedSubscription;

  NewsListScreenVM() {
    _db = MyFireBaseDatabase();

    _onNoteAddedSubscription = _db.getFireBaseObj().onChildAdded.listen((event) {
      _onNoteAdded(event);
    });
  }

  get _TAG => 'News List Screen VM';

  void _onNoteAdded(Event event) {

    log('come in fun _onNoteAdded');
    // notifyChange();
    newsList.add(NewsModel.fromEventObject(event.snapshot));

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

      log('${newsList.length} is size of list')});

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
}
