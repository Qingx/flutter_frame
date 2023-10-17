import 'package:may/data/config/base_api.dart';

class UserApi extends BaseApi {
  UserApi._();

  static UserApi? _mIns;

  factory UserApi.ins() => _mIns ??= UserApi._();

  ///发送验证码 type==>验证码类型: 0.登录; 1.确认当前手机号; 2.修改手机号; 3.绑定手机号
  Stream<String?> obtainSendCode(String phone, int type) {
    var data = {"call": phone, "type": type};
    return post<String>("/api/account/send-code", requestBody: data).rebase();
  }
}
