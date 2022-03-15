import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTheme {
  static final ThemeData light = ThemeData.light()
      .copyWith(
          primaryColor: Color(0xff000000),
          toggleableActiveColor: Colors.deepPurple,
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.green,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          )))
      .add(
        theme: MyTheme(
          bgColor: Colors.white,
          widgetColor: Colors.blue,
          textColor: Colors.white,
        ),
      );

  static final ThemeData dark = ThemeData.dark()
      .copyWith(
        primaryColor: Color(0xffffffff),
        toggleableActiveColor: Colors.deepOrange,
      )
      .add(
        theme: MyTheme(
          bgColor: Colors.grey,
          widgetColor: Colors.red,
          textColor: Colors.white,
        ),
      );
}

extension ThemeExtension on ThemeData {
  static final Map<String, MyTheme> _map = {};

  ThemeData add({required MyTheme theme}) {
    _map[brightness.name] = theme;
    return this;
  }

  MyTheme get() {
    return _map[brightness.name] ?? MyTheme.empty();
  }
}

class MyTheme {
  Color? bgColor;
  Color? widgetColor;
  Color? textColor;

  MyTheme({this.bgColor, this.widgetColor, this.textColor});

  factory MyTheme.empty() {
    return MyTheme(
      bgColor: Colors.white,
      widgetColor: Colors.green,
      textColor: Colors.yellow,
    );
  }
}
