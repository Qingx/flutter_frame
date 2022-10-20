import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:may/config/base_extension.dart';
import 'package:may/config/base_widget.dart';
import 'package:may/config/method_channel_manager.dart';
import 'package:may/data/config/base_route.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();

    var channel = const BasicMessageChannel("aa", StandardMessageCodec());
    channel.setMessageHandler((message) async {
      log("wangxiang:$message");
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseWidget.appBar(title: "Second"),
      // body: const _BodyWidget(),
      body: Platform.isAndroid
          ? const AndroidView(
              viewType: "android.testView",
              creationParams: "123",
              creationParamsCodec: StandardMessageCodec(),
            )
          // ? _BodyWidget()
          : const UiKitView(
              viewType: "iOS.testView",
              creationParams: "123",
              creationParamsCodec: StandardMessageCodec(),
            ),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  State<_BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {
  var widgetList;

  @override
  void initState() {
    super.initState();

    widgetList = List.generate(50, (index) => BaseWidget.testItemWidget(index));

    // Stream.periodic(const Duration(seconds: 1), (i) => i).take(5).listen((event) {
    //   widgetList.insert(1, testWidget(event));
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: widgetList.length,
          itemBuilder: (context, index) {
            return widgetList[index];
          },
        ).removePadding,
        Container(
          height: 48,
          width: MediaQuery.of(context).size.width / 2,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Next Page",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ).onClick(() {
          // Get.toNamed(BaseRoute.Third);
          MethodChannelManager.startNewPage();
        }).positionOn(bottom: 40),
      ],
    );
  }
}
