import 'package:get/get.dart';
import 'package:qinghe_ios/data/entity/user_entity.dart';

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

  void showSnackBar() {
    Get.snackbar("hi", "message");
  }

  void updateCount() {
    number.value += 1;
    number.firstRebuild = true;
    update();

    // if(number.value==10){
    //   change(UserEntity(),status: RxStatus.error("waring error"));
    // }
  }

  @override
  void onInit() {
    super.onInit();
    print("wangxiang:onInit()");

    Future.delayed(const Duration(milliseconds: 1000)).then(
      (value) => change(UserEntity(phone: "111111111"), status: RxStatus.success()),
    );
  }

  @override
  void onReady() {
    super.onReady();
    print("wangxiang:onReady()");

    Stream.periodic(const Duration(milliseconds: 1000)).take(60).listen((event) {
      updateCount();
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("wangxiang:onClose()");
  }
}
