import 'package:get/get.dart';

class CountController extends GetxController {
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
