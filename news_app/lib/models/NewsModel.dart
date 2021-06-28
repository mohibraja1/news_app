

class NewsModel{

  final KEY_NEWS_TITLE = 'NewsTitle';
  final KEY_NEWS_DESCRIPTION = 'NewsDescription';
  final KEY_NEWS_IMAGE = 'NewsImage';

  late String newsTitle, newsDesctiption, imagePath;

  NewsModel(this.newsTitle, this.newsDesctiption, this.imagePath);


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map[KEY_NEWS_TITLE] = this.newsTitle;
    map[newsDesctiption] = this.newsDesctiption;
    map[imagePath] = this.imagePath;

    return map;
  }

  NewsModel.fromMapObject(Map<dynamic, dynamic> map) {
    this.newsTitle = map[KEY_NEWS_TITLE];
    this.newsDesctiption = map[KEY_NEWS_DESCRIPTION];
    this.imagePath = map[KEY_NEWS_IMAGE];
  }
}