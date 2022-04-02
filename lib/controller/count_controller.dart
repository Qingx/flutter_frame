import 'package:get/get.dart';

class CountController extends GetxController {
  static const String _tag = "countController";

  CountController();

  static void get put => Get.lazyPut<CountController>(
        () => CountController(),
        tag: _tag,
        fenix: true,
      );

  static CountController get to => Get.find<CountController>(tag: _tag);

  RxInt number = 0.obs;

  setCount() {
    number.value += 1;
    number.firstRebuild = true;

    update();
  }

  reCount() {
    number.value = 0;
    number.firstRebuild = true;

    update();
  }
}
