import 'dart:async';

import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/viewmodels/BaseViewModel.dart';

import 'package:firebase_database/firebase_database.dart';

class NewsListScreenVM extends BaseViewModel {
  late MyFireBaseDatabase _db;

  List<NewsModel> newsList = [];
  bool isUpdatedOnce = false;

  late StreamSubscription<Event> _onNoteAddedSubscription;
  NewsListScreenVM() {
    _db = MyFireBaseDatabase();

    _onNoteAddedSubscription =
        _db.getFireBaseObj().onChildAdded.listen((event) {
      _onNoteAdded(event);
    });
  }

  void _onNoteAdded(Event event) {

    notifyChange();
    newsList.add(new NewsModel.fromEventObject(event.snapshot));

  }

  initialise() {
    getNewsListFromFirebase();
  }

  getNewsListFromFirebase() async {
    _db.readAllNewsData().then(
        (value) => {
          notifyChange(),
          log('mvalue $value'),
          isUpdatedOnce = true,
          newsList = value,
         });
  }

}
