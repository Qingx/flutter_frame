import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_extension.dart';
import 'package:qinghe_ios/config/base_widget.dart';
import 'package:qinghe_ios/controller/fourth_controller.dart';
import 'package:qinghe_ios/data/entity/user_entity.dart';
import 'package:qinghe_ios/r.dart';

class FourthPage extends GetView<FourthController> {
  const FourthPage({Key? key}) : super(key: key);

  @override
  String? get tag => FourthController.tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseWidget.appBar(title: "Fourth"),
      body: controller.obx(
        bodyWidget,
        onLoading: const Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurpleAccent,
          ),
        ),
        onError: (error) {
          return BaseWidget.normalErrorWidget(error!);
        },
        onEmpty: BaseWidget.normalEmptyWidget("sorry on empty"),
      ),
    );
  }

  Widget bodyWidget(UserEntity? entity) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(R.assetsImgNormalSuccess, width: Get.width / 2, fit: BoxFit.contain),
              RichText(
                text: TextSpan(
                  text: "PhoneNumber:\u3000",
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: "${entity!.phone}",
                      style: const TextStyle(color: Colors.orange, fontSize: 16),
                    )
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "CountNumber:\u3000",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: "${controller.number.value}",
                      style: const TextStyle(color: Colors.pink, fontSize: 16),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                color: Get.theme.toggleableActiveColor,
              ),
              child: const Text(
                "do something",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
            ).onClick(controller.doSomething),
          ],
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
