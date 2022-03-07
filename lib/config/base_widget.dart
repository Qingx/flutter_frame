import 'package:flutter/material.dart';

class BaseWidget {
  static Widget statusBar(BuildContext context, bool withTrans) {
    double _statusHeight = MediaQuery.of(context).padding.top;
    Color _bgColor = withTrans ? Colors.transparent : Colors.white;
    return Container(
      height: _statusHeight,
      color: _bgColor,
    );
  }
}
