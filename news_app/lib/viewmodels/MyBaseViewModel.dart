import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class MyBaseViewModel extends BaseViewModel {
  final _TAG = 'BaseViewModel';

  initialise() {
    log(_TAG + ' method called');
  }

  log(Object object) {
    print(object);
  }

  notifyChange() {
    notifyListeners();
  }

  toast(String message) {
    print('toast msg is = ' + message);

    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
