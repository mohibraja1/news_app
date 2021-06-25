import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/utils/FireBaseDatabase.dart';

class HomeScreenBloc extends BaseBlock {
  late MyFireBaseDatabase db;

  HomeScreenBloc(BuildContext context) : super(context) {
    db = MyFireBaseDatabase();
  }

}
