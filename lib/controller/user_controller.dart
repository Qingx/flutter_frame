import 'package:get/get.dart';
import 'package:qinghe_ios/config/user_config.dart';
import 'package:qinghe_ios/data/entity/user_entity.dart';

class UserController extends GetxController {
  static const String _tag = "userController";

  static void get put => Get.lazyPut<UserController>(
        () => UserController(),
        tag: _tag,
        fenix: true,
      );

  static UserController get to => Get.find<UserController>(tag: _tag);

  var user = UserEntity().obs;
  RxString phone = "".obs;

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
