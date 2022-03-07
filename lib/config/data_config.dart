import 'package:qinghe_ios/config/base_sp.dart';

/// 应用数据相关缓存
class DataConfig extends BaseConfig {
  static DataConfig? _mIns;

  DataConfig._() : super("data_config");

  factory DataConfig.getIns() {
    return _mIns ??= DataConfig._();
  }

  /// 设置是否为第一次使用APP
  set firstUseApp(bool result) =>
      spInstance!.putBool(DataKeys.K_FIRST_USE, result);

  /// 检查是否为第一次使用APP
  bool get firstUserApp =>
      spInstance!.getBool(DataKeys.K_FIRST_USE, defaultVal: true);
}

class DataKeys {
  static const K_FIRST_USE = "K_FIRST_USE";
}

class BaseConfig {
  BaseSP? spInstance;

  BaseConfig(String name) {
    spInstance = BaseSP(name);
  }

  void doAfterCreated(doNext(BaseSP? sp)) {
    spInstance?.event((_) => doNext(spInstance));
  }

  void clear() => spInstance?.clear();
}
