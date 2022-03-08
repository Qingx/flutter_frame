import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_widget.dart';
import 'package:qinghe_ios/config/base_extension.dart';
import 'package:qinghe_ios/controller/count_controller.dart';
import 'package:qinghe_ios/controller/global_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<int>? _countStream;

  @override
  void initState() {
    super.initState();

    GlobalC.count = Get.find<CountController>(tag: "count");

    updateCount();
  }

  void updateCount() {
    if (_countStream != null) {
      _countStream?.cancel();
    }

    _countStream = Stream.periodic(const Duration(milliseconds: 1000), (i) => i)
        .take(60)
        .listen((event) {
      GlobalC.count.setCount();

      GlobalC.count.value.value.toString().printf();
      setState(() {});
    });
  }

  void resetCount() {
    _countStream?.cancel();

    GlobalC.count.reCount();
    updateCount();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    _countStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseWidget.statusBar(context, false),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 48,
                        height: 48,
                        color: Colors.blue,
                        child: const Text(
                          "重置",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ).onClick(() {
                        resetCount();
                      }),
                      Obx(
                        () => Text(
                          GlobalC.count.value.string,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ).marginOn(top: 16)
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
