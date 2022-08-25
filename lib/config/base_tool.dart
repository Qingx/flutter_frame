import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:may/config/base_extension.dart';

class BaseTool {
  static bool eq(double num1, double num2) {
    return (num1 - num2).abs() <= 0.000005;
  }

  static void toast(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.BOTTOM);
  }

  ///是否为同一天
  static bool isSameDay(int lastTime) {
    DateTime lastDate = DateTime.fromMillisecondsSinceEpoch(lastTime);
    DateTime nowDate = DateTime.now();

    return lastDate.year == nowDate.year &&
        lastDate.month == nowDate.month &&
        lastDate.day == nowDate.day;
  }

  ///复制
  static void copyText(String text, {String infix = ""}) {
    String toast = infix.isNullOrEmpty() ? "已复制：$text" : "已复制：$infix：$text";
    Clipboard.setData(ClipboardData(text: text))
        .then((value) => BaseTool.toast(toast));
  }
}
