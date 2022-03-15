import 'dart:convert';

import 'package:qinghe_ios/config/base_extension.dart';
import 'package:qinghe_ios/generated/json/base/json_convert_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseSP {
  String name;

  static SharedPreferences? mSP;
  static Map<String, BaseSP> mCache = {};

  Future init() async {
    mSP = await SharedPreferences.getInstance();
  }

  BaseSP._create(this.name);

  factory BaseSP(String name) => mCache[name] ??= BaseSP._create(name);

  String _internalKey(String key) {
    return "##${name}_$key";
  }

  bool _isInternalName(String internalKey) {
    return internalKey.startsWith("##$name");
  }

  void putInt(String key, int value) {
    mSP!.setInt(_internalKey(key), value);
  }

  void putBool(String key, bool value) {
    mSP!.setBool(_internalKey(key), value);
  }

  void putString(String key, String value) {
    mSP!.setString(_internalKey(key), value);
  }

  void putDouble(String key, double value) {
    mSP!.setDouble(_internalKey(key), value);
  }

  void putStringList(String key, List<String> value) {
    mSP!.setStringList(_internalKey(key), value);
  }

  /// 添加object缓存
  void putObject<T>(String key, T value) {
    if (value != null) {
      final valueStr = json.encode(value);
      putString(key, valueStr);
    } else {
      putString(key, "");
    }
  }

  /// 清空当前实例对应的缓存
  void clear() {
    final keys = mSP!.getKeys();

    keys.forEach((element) {
      if (_isInternalName(element)) {
        mSP!.remove(element);
      }
    });
  }

  int getInt(String key, {int defaultVal = -1}) =>
      mSP?.getInt(_internalKey(key)) ?? defaultVal;

  bool getBool(String key, {bool defaultVal = false}) =>
      mSP?.getBool(_internalKey(key)) ?? defaultVal;

  String getString(String key, {String defaultVal = ""}) =>
      mSP?.getString(_internalKey(key)) ?? defaultVal;

  double getDouble(String key, {double defaultVal = -1}) =>
      mSP?.getDouble(_internalKey(key)) ?? defaultVal;

  List<String> getStringList(String key, {List<String>? defaultVal}) =>
      mSP?.getStringList(_internalKey(key)) ?? defaultVal ?? [];

  /// 获取指定类型的object
  T getObject<T>(String key, T defaultVal) {
    String valueStr = getString(key);
    if (!valueStr.isNullOrEmpty() && valueStr != "null") {
      return JsonConvert.fromJsonAsT<T>(json.decode(valueStr)) as T;
    }
    return defaultVal;
  }
}
