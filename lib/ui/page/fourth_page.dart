import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_widget.dart';
import 'package:qinghe_ios/controller/fourth_controller.dart';
import 'package:qinghe_ios/config/base_extension.dart';

class FourthPage extends StatelessWidget {
  const FourthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseWidget.appBar(title: "Fourth"),
      body: _BodyWidget(),
    );
  }
}

class _BodyWidget extends GetView<FourthController> {
  @override
  String? get tag => FourthController.tag;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (entity) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text("${entity!.phone}++${controller.number.value}"),
          ),
          const Expanded(child: SizedBox()),
          Container(
            width: 96,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 80),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: Theme.of(context).toggleableActiveColor,
            ),
            child: const Text(
              "on Click",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
          ).onClick(controller.showSnackBar),
        ],
      ),
      onLoading: const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
      onError: (error) {
        return Container(
          alignment: Alignment.center,
          color: Colors.red,
          child: Text(
            error ?? "error miss",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      },
      onEmpty: Container(
        alignment: Alignment.center,
        child: const Text("empty"),
      ),
    );
  }
}
