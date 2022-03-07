import 'package:get/get.dart';
import 'package:qinghe_ios/config/user_config.dart';
import 'package:qinghe_ios/data/entity/user_entity.dart';

class UserController extends GetxController {
  var user = UserEntity().obs;

  setUser(UserEntity entity) {
    UserConfig.getIns().user = entity;

    user.firstRebuild = true;
    user.value = entity;

    update();
  }
}
