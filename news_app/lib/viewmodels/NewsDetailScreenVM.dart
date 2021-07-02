import 'dart:async';

import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/ui/AddNewsScreen.dart';
import 'package:news_app/viewmodels/BaseViewModel.dart';

import 'package:firebase_database/firebase_database.dart';

class NewsDetailScreenVM extends BaseViewModel {
  late MyFireBaseDatabase _db;

  List<NewsModel> newsList = [];
  bool isUpdatedOnce = false;

  var totalLikText = '';

  late NewsModel newsModel;

  late StreamSubscription<Event> _onNoteAddedSubscription;

  NewsDetailScreenVM(this.newsModel) {
    _db = MyFireBaseDatabase();

    _onNoteAddedSubscription =
        _db.getFireBaseObj().onChildAdded.listen((event) {
      _onNoteAdded(event);
    });

    log('comments list  is =${newsModel.commentList.length}');
  }

  get _TAG => 'News List Screen VM';

  void _onNoteAdded(Event event) {
    notifyChange();
    newsList.add(NewsModel.fromEventObject(event.snapshot));
  }

  Future<List<NewsModel>> getNewsListFromFirebase() async {
    _db.readAllNewsData().then((value) => {
          notifyChange(),
          log('mvalue $value'),
          isUpdatedOnce = true,
          newsList = value,
        });

    return newsList;
  }

  Future<bool> addLikeToNews() {
    return _db.addLikeToNews(newsModel, newsModel.timeStamp);
  }

  void updateTotalLike(int addValue) {
    final addCount = newsModel.totalLikes + addValue;

    log(' likes are  =$addCount');

    newsModel.totalLikes = addCount;
    notifyChange();
    if (addCount == 0) {
      totalLikText = 'Like';
    } else if (addCount == 1) {
      totalLikText = '${newsModel.totalLikes}  Like';
    } else {
      totalLikText = '${newsModel.totalLikes} Likes';
    }

    log('final like text  = $totalLikText');
  }


  Future<bool> addComment(String comment) async {

    final fortune = _db.addComment(newsModel, comment);
    fortune.then((value) => {

      if (value) {notifyChange(),
        newsModel.commentList.insert(0, comment)}
    });
    return fortune;
  }
}
