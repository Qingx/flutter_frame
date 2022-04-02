import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_extension.dart';
import 'package:qinghe_ios/config/base_widget.dart';
import 'package:qinghe_ios/data/config/base_route.dart';

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
            onBack: () => Get.back(),
          ),
          const Expanded(child: _BodyWidget()),
        ],
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
        ).onClick(() => Get.toNamed(BaseRoute.Third)).positionOn(bottom: 40),
      ],
    );
  }
}
