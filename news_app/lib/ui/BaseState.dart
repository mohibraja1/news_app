

import 'package:flutter/cupertino.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';

var TAG = 'BaseStateFul';

class BaseStateFul extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {

    log('$TAG createState conroll should not come here');
    return _SState();
  }

}


class _SState extends State<BaseStateFul>{
  @override
  Widget build(BuildContext context) {

    log('$TAG controll should never come her');
    return Text('dsdfsa');
  }

}