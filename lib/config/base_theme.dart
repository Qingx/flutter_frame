import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    toggleableActiveColor: Colors.deepPurple,
  ).add(theme: MyTheme.light());

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff2b2b2b),
    toggleableActiveColor: Colors.deepOrange,
  ).add(theme: MyTheme.dark());
}

extension ThemeExtension on ThemeData {
  static final Map<String, MyTheme> _map = {};

  ThemeData add({required MyTheme theme}) {
    _map[brightness.name] = theme;
    return this;
  }

  MyTheme get to {
    return _map[brightness.name] ?? MyTheme.empty();
  }
}

class MyTheme {
  Color? textColor;
  Color? widgetColor;
  SystemUiOverlayStyle? statusStyle;
  Color? dialogColor;
  Color? appBarBackgroundColor;

  MyTheme({
    this.textColor,
    this.widgetColor,
    this.statusStyle,
    this.dialogColor,
  });

  factory MyTheme.empty() {
    return MyTheme();
  }

  factory MyTheme.light() {
    return MyTheme(
      textColor: Colors.black,
      widgetColor: Colors.green,
      statusStyle: SystemUiOverlayStyle.dark,
      dialogColor: const Color(0xCCF2F2F2),
    );
  }

  factory MyTheme.dark() {
    return MyTheme(
      textColor: Colors.white,
      widgetColor: Colors.blue,
      statusStyle: SystemUiOverlayStyle.light,
      dialogColor: const Color(0xBF1E1E1E),
    );
  }
}
