import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_widget.dart';
import 'package:qinghe_ios/config/base_theme.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).get().bgColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        toolbarHeight: 0,
        backgroundColor: Colors.yellow,
        systemOverlayStyle:SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ) ,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BaseWidget.topBar(
              name: "Mine",
              bgColor: Colors.red,
              onBack: () {
                Get.back();
              })
        ],
      ),
    );
  }
}
