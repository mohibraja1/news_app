import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/models/NewsModel.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';

class NewsListScreenBloc extends BaseBlock {

  late MyFireBaseDatabase db;

  NewsListScreenBloc(BuildContext context) : super(context) {
    db = MyFireBaseDatabase();
  }


}
