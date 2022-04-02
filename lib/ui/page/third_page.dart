import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_widget.dart';
import 'package:qinghe_ios/controller/user_controller.dart';
import 'package:qinghe_ios/data/config/base_route.dart';
import 'package:qinghe_ios/test/form_factory.dart';
import 'package:qinghe_ios/config/base_extension.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BaseWidget.statusBar(context: context),
          BaseWidget.topBar(
            context: context,
            name: "Third",
            onBack: () => Get.back(),
          ),
          Expanded(child: _BodyWidget()),
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var formList;

  void doSubmit() {
    var form = _formKey.currentState;
    if(form!.validate()){
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
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: formList.length,
            itemBuilder: (context, index) {
              return formList[index];
            },
          ).removePadding,
        ),
        Container(
          height: 48,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Obx(()=>Text(
            UserController.to.phone.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              decoration: TextDecoration.none,
            ),
          ),
          )).onClick(doSubmit).positionOn(bottom: 40, left: 48, right: 48)
      ],
    );
  }
}
