import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_widget.dart';
import 'package:qinghe_ios/config/base_extension.dart';
import 'package:qinghe_ios/data/config/base_route.dart';
import 'package:qinghe_ios/test/form_factory.dart';
import 'package:qinghe_ios/config/base_extension.dart';

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
  var widgetList = List.generate(50, (index) => BaseWidget.testItemWidget(index));

  @override
  void initState() {
    super.initState();

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
    var widgets = FormBuilder.flatMap(BaseRoute.Initial);
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return widgets[index].show(context);
          },
        ).removePadding,
        const Expanded(child: SizedBox()),
        Container(
          height: 48,
          margin: const EdgeInsets.only(left: 64, right: 64, bottom: 64),
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Confirm",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
