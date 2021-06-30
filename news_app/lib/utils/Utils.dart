import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {

  static double getScreenHeight(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width;
  }

  static Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            Text('Approve'),
          ],
        );
      },
    );
  }

  String getFormatedTimeStamp() {

    DateTime dateToday =new DateTime.now();

    final format = 'yyyyMMdd-hhmmss';

    var formattedDate = DateFormat(format).format(dateToday);

    print(formattedDate); // 2021-06-24

    if (formattedDate.isEmpty) {
      throw('this can not be empty');
    }
    return formattedDate;

  }

}
