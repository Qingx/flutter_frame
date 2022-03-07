import 'dart:core';

import 'package:qinghe_ios/generated/json/base/json_convert_content.dart';

abstract class DataSource {
  bool get isDataEmpty;

  int get code;

  String get msg;
}

class BaseData<T> extends DataSource {
  int timestamps = 0;
  int status = 0;
  String msg = "";
  T? data;

  BaseData({required this.timestamps, required this.status, this.data});

  BaseData.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
    timestamps = json['timestamps'];
    status = int.parse(json['status']);

    final type = T.toString();

    if (type == (int).toString()) {
      data = json['data'];
    } else if (type == (bool).toString()) {
      data = json['data'];
    } else if (type == (double).toString()) {
      data = json['data'];
    } else if (type == (String).toString()) {
      data = json['data'];
    } else {
      var data = json['data'];

      if (data == null) {
        if (T.toString().startsWith("List")) {
          this.data = JsonConvert.fromJsonAsT<T>([]);
        }
        return;
      }

      this.data = JsonConvert.fromJsonAsT<T>(data);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['timestamps'] = timestamps;
    map['status'] = status;
    map['msg'] = msg;
    map['data'] = data;
    return map;
  }

  bool get success => status > 0;

  @override
  bool get isDataEmpty {
    if (data == null) return true;

    if (data is DataSource) {
      return (data as DataSource).isDataEmpty;
    }

    return false;
  }

  @override
  int get code => status;
}

/// 转换WlData数据
BaseData<T> json2WLData<T>(Map<String, dynamic> map) {
  return BaseData.fromJson(map);
}
