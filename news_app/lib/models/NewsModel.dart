import 'package:firebase_database/firebase_database.dart';
import 'package:news_app/utils/AppConstants.dart';

class NewsModel {
  String timeStamp = '';
  String newsTitle = '', newsDesctiption = '', imagePath = '';
  int totalLikes = 0;
  List<String> commentList = [];

  NewsModel(this.timeStamp, this.newsTitle, this.newsDesctiption,
      this.imagePath, this.totalLikes, this.commentList);

  // Map<String, dynamic> toMap() {
  //   var map = Map<String, dynamic>();
  //
  //   map[KEY_NEWS_TITLE] = this.newsTitle;
  //   map[newsDesctiption] = this.newsDesctiption;
  //   map[imagePath] = this.imagePath;
  //   map[KEY_LIKES] = this.totalLikes;
  //
  //   return map;
  // }

  /*NewsModel.fromMapObject(Map<dynamic, dynamic> map) {
    this.newsTitle = map[KEY_NEWS_TITLE];
    this.newsDesctiption = map[KEY_NEWS_DESCRIPTION];
    this.imagePath = map[KEY_NEWS_IMAGE];
    this.totalLikes = map[KEY_LIKES];
  }*/

  static NewsModel fromEventObject(DataSnapshot snapshot) {
    var timeStamp = snapshot.value[AppConstants.KEY_NEWS_TIME_STAMP];
    var newsTitle = snapshot.value[AppConstants.KEY_NEWS_TITLE];
    var newsDesctiption = snapshot.value[AppConstants.KEY_NEWS_DESCRIPTION];
    var imagePath = snapshot.value[AppConstants.KEY_NEWS_IMAGE];
    var totalLikes = snapshot.value[AppConstants.KEY_LIKES];

    List<String> commentList = [];

    if (snapshot.value[AppConstants.KEY_COMMENTS] != null) {
      List<Object?> temp = snapshot.value[AppConstants.KEY_COMMENTS];
      temp.forEach((element) {
        if (element != null && element is String) {
          commentList.add(element.toString());
        }
      });
    }
    NewsModel newsModel = NewsModel(timeStamp, newsTitle, newsDesctiption,
        imagePath, totalLikes, commentList);

    return newsModel;
  }
}
