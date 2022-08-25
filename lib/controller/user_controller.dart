import 'package:get/get.dart';
import 'package:may/config/user_config.dart';
import 'package:may/data/entity/user_entity.dart';

class UserController extends GetxController {
  UserController._();

  static const String _tag = "userController";

  static UserController? _controller;

  static void get put => Get.lazyPut<UserController>(
        () => _controller ??= UserController._(),
        tag: _tag,
        fenix: true,
      );

  static UserController get to => Get.find<UserController>(tag: _tag);

  var user = UserEntity().obs;
  RxString phone = "default".obs;

  setUser(UserEntity entity) {
    UserConfig.getIns().user = entity;

    user.firstRebuild = true;
    user.value = entity;

    update();
  }

  setPhone(String number) {
    phone.firstRebuild = true;
    phone.value = number;

    update();
  }
}
