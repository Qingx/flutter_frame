import 'package:get/get.dart';

class CountController extends GetxController {
  static const String tag = "countController";

  CountController();

  static CountController get to => Get.find<CountController>(tag: tag);

  RxInt value = 0.obs;

  setCount() {
    value.value += 1;
    value.firstRebuild = true;

    update();
  }

  reCount() {
    value.value = 0;
    value.firstRebuild = true;

    update();
  }
}
