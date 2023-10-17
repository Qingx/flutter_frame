import 'dart:developer';

import 'package:get/get.dart';
import 'package:may/data/entity/user_entity.dart';
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

  void doLoadPage() {
    change(value, status: RxStatus.loading());
    var future = Future.delayed(const Duration(milliseconds: 3000));
    Stream.fromFuture(future)
        .flatMap((event) => Stream.error("sorry on error"))
        .onErrorReturn(UserEntity.empty())
        .listen(
      (event) {
        value = event;
        change(value, status: RxStatus.success());
      },
      onError: (error, stack) {
        change(value, status: RxStatus.error(error.toString()));
      },
      onDone: () {
        doTimer();
        log("onDone:${value.toString()}");
      },
    );
  }

  void doTimer() {
    Stream.periodic(const Duration(milliseconds: 1000)).take(60).listen((event) {
      // value?.countNum++;
      number.value += 1;
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    log("getx:onInit()");
  }

  @override
  void onReady() {
    super.onReady();

    doLoadPage();
    log("getx:onReady()");
  }

  @override
  void onClose() {
    super.onClose();
    log("getx:onClose()");
  }
}
