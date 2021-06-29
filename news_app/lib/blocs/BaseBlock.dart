import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/Utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseBlock {
  late BuildContext context;
  late double screenWidth;
  late double screenHeight;

  BaseBlock(BuildContext context) {
    this.context = context;
    this.screenWidth = Utils.getScreenWidth(context);
    this.screenHeight = Utils.getScreenHeight(context);
  }

  navigateNextReplacement(Widget widget) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  navigateNext(Widget widget) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  moveToLastScreen() {
    Navigator.pop(context);
  }

  printLog(String msg) {
    print(msg);
  }

  showSnackBar(String value) {
    printLog(value);
    SnackBar(content: Text(value));
  }

  toast(String message) {
    printLog('toast msg is = ' + message);

    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

/*String unixToStringFormat1(int timestamp, String format) {
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    return date.format(format);
  }

  String unixToStringFormat(String timestamp, String format) {
    var time = int.parse(timestamp);
    var date = new DateTime.fromMicrosecondsSinceEpoch(time * 1000);
    return date.format(format);
  }*/

}
