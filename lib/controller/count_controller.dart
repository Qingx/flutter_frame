import 'package:get/get.dart';

class CountController extends GetxController {
  CountController._();

  static const String _tag = "countController";

  static void get put => Get.lazyPut<CountController>(
        () => CountController._(),
        tag: _tag,
        fenix: true,
      );

  static CountController get find => Get.find<CountController>(tag: _tag);

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
