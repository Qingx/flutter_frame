import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/data/entity/user_entity.dart';
import 'package:rxdart/rxdart.dart';

class FourthController extends GetxController with StateMixin<UserEntity> {
  FourthController._();

  static const String tag = "fourthController";

  static void get put => Get.lazyPut<FourthController>(
        () => FourthController._(),
        fenix: true,
        tag: tag,
      );

  static FourthController get find => Get.find<FourthController>(tag: tag);

  RxInt number = 0.obs;

  void doSomething() {
    Get.snackbar("hi", "message");

    // Get.defaultDialog(title: "hi message");

    // Get.bottomSheet(
    //   SizedBox(width: Get.width, height: Get.width / 2),
    //   backgroundColor: Colors.white,
    // );

    // Get.dialog(
    //   Center(child: Container(width: Get.width / 2, height: Get.width / 2, color: Colors.white)),
    // );

  }

  void _updateCount() {
    number.value += 1;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    print("wangxiang:onInit()");

    Stream.fromFuture(Future.delayed(const Duration(milliseconds: 1000)))
        .flatMap((event) => Stream.error("sorry on error"))
        .onErrorReturn(UserEntity(phone: "11111111"))
        .listen(
      (event) {
        change(UserEntity(phone: "22222222"), status: RxStatus.success());
      },
      onError: (error, stack) {
        change(UserEntity(), status: RxStatus.error(error.toString()));
      },
      onDone: () {},
    );
  }

  @override
  void onReady() {
    super.onReady();
    print("wangxiang:onReady()");

    Stream.periodic(const Duration(milliseconds: 1000)).take(60).listen((event) {
      _updateCount();
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("wangxiang:onClose()");
  }
}
