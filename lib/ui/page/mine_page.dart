import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_widget.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BaseWidget.statusBar(context: context),
          BaseWidget.topBar(
              context: context,
              name: "Mine",
              onBack: () {
                Get.back();
              })
        ],
      ),
    );
  }
}
