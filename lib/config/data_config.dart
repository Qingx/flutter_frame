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

  ///主题模式 true:跟随系统 false:不跟随系统
  set themeMode(bool isSystem) =>
      spInstance!.putBool(DataKeys.K_THEME_MODE, isSystem);

  ///获取当前主题模式
  bool get themeMode =>
      spInstance!.getBool(DataKeys.K_THEME_MODE, defaultVal: false);

  set themeType(int value) => spInstance!.putInt(DataKeys.K_THEME_TYPE, value);

  int get themeType => spInstance!.getInt(DataKeys.K_THEME_TYPE, defaultVal: 0);
}

class DataKeys {
  static const K_FIRST_USE = "K_FIRST_USE";
  static const K_THEME_MODE = "K_THEME_MODE";
  static const K_THEME_TYPE = "K_THEME_TYPE";
}

class BaseConfig {
  BaseSP? spInstance;

  BaseConfig(String name) {
    spInstance = BaseSP(name);
  }

  void doAfterCreated(Function doNext) {
    spInstance?.init().then((value) {
      doNext();
    });
  }

  void clear() => spInstance?.clear();
}
