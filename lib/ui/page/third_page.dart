import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:may/config/base_widget.dart';
import 'package:may/controller/user_controller.dart';
import 'package:may/data/config/base_route.dart';
import 'package:may/test/form_factory.dart';
import 'package:may/config/base_extension.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseWidget.appBar(title: "Third"),
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var formList;

  void doSubmit() {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
    }
  }

  @override
  void initState() {
    super.initState();

    formList = FormFactory.flatMap(BaseRoute.Third);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: formList.length,
            itemBuilder: (context, index) {
              return formList[index];
            },
          ).removePadding,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 80),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.blue,
                ),
                child: Obx(
                  () => Text(
                    UserController.to.phone.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )).onClick(doSubmit),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 24, bottom: 80),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                color: Theme.of(context).toggleableActiveColor,
              ),
              child: const Text(
                "Next Page",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
            ).onClick(() {
              Get.toNamed(BaseRoute.Fourth);
            }),
          ],
        ),
      ],
    );
  }
}
