


import 'package:flutter/cupertino.dart';



class BaseViewModel extends ChangeNotifier{

  final _TAG = 'BaseViewModel';

  initialise(){}

  log(Object object){
    print(object);
  }


  notifyChange(){
    notifyListeners();
  }
}