import 'package:qinghe_ios/config/data_config.dart';
import 'package:qinghe_ios/data/entity/user_entity.dart';

/// 用户数据相关缓存
class UserConfig extends BaseConfig {
  static UserConfig? _mIns;

  UserConfig._() : super("user_config");

  factory UserConfig.getIns() {
    return _mIns ??= UserConfig._();
  }

  /// 设置用户信息
  set user(UserEntity entity) =>
      spInstance!.putObject(UserKeys.K_USER_DATA, entity);

  /// 获取用户信息
  UserEntity get user => spInstance!
      .getObject<UserEntity>(UserKeys.K_USER_DATA, UserEntity());

  /// 设置文件签名
  set sign(String sign) => spInstance!.putString(UserKeys.K_HTTP_SIGN, sign);

  /// 获取文件签名
  String get sign => spInstance!.getString(UserKeys.K_HTTP_SIGN);

  /// 设置用户token
  set token(String token) =>
      spInstance!.putString(UserKeys.K_HTTP_TOKEN, token);

  /// 获取用户token
  String get token =>
      spInstance!.getString(UserKeys.K_HTTP_TOKEN, defaultVal: "empty_token");
}

class UserKeys {
  static const K_USER_DATA = "K_USER_DATA";
  static const K_HTTP_SIGN = "K_HTTP_SIGN";
  static const K_HTTP_TOKEN = "K_HTTP_TOKEN";
}
