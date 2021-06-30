import 'package:firebase_database/firebase_database.dart';

class NewsModel {

  final KEY_NEWS_TITLE = 'NewsTitle';
  final KEY_NEWS_DESCRIPTION = 'NewsDescription';
  final KEY_NEWS_IMAGE = 'NewsImage';
  final KEY_LIKES = 'totalLikes';
  final _KEY_COMMENTS = 'Comments';

  String timeStamp = '';
  String  newsTitle='', newsDesctiption ='', imagePath='';
  int totalLikes=0;
  List<String> commentList = [];


  NewsModel(
      this.timeStamp,
      this.newsTitle,
      this.newsDesctiption,
      this.imagePath,
      this.totalLikes, this.commentList);

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

  NewsModel.fromEventObject(DataSnapshot snapshot) {
    this.newsTitle = snapshot.value[KEY_NEWS_TITLE];
    this.newsDesctiption = snapshot.value[KEY_NEWS_DESCRIPTION];
    this.imagePath = snapshot.value[KEY_NEWS_IMAGE];

    /*int likes = 0;
    try {
      if (snapshot.value != null) {

        DataSnapshot commentSnap = snapshot.value[KEY_LIKES];
        Map<dynamic, dynamic> likeslisat = commentSnap.value;

        likes =likeslisat.length;
        this.totalLikes = likes;

      }


    } on Exception catch (e) {
      print('exceaptinn came  $e');
      this.totalLikes = likes;

    }


    try {
      DataSnapshot commentSnap = snapshot.value[_KEY_COMMENTS];
      Map<dynamic, dynamic> comments = commentSnap.value;

      commentList.clear();
      comments.forEach((key, value) {
        commentList.add(value);
      });
    } on Exception catch (e) {
      print('exceaptin n came  $e');
    }*/
  }

}
