


import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier{


  initialise(){}

  log(Object object){
    print(object);
  }


  notifyChange(){
    notifyListeners();
  }
}