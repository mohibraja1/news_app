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

  getAppToolBar(String title) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 22,
          ),
          Container(
            height: 56,
            width: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        "images/ic_left_arrow.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                    onTap: () {
                      moveToLastScreen();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg_title.png"),
          fit: BoxFit.cover,
        ),
      ),
      width: double.infinity,
      height: 78,
    );
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

    printLog(message);

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
