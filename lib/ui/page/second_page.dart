import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:may/config/base_extension.dart';
import 'package:may/config/base_widget.dart';
import 'package:may/data/config/base_route.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseWidget.appBar(title: "Second"),
      body: const _BodyWidget(),
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
        ).onClick(() => Get.toNamed(BaseRoute.Third)).positionOn(bottom: 40),
      ],
    );
  }
}
