import 'package:may/data/config/base_data.dart';
import 'package:may/data/config/page_data.dart';

class BasePage<T> extends DataSource {
  int timestamps = 0;
  int status = 0;
  String msg = "";
  Page<T>? data;

  BasePage({required this.timestamps, required this.status, this.data});

  BasePage.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
    timestamps = json['timestamps'];
    status = int.parse(json['status']);

    var temp = json['data'];
    if (temp != null) {
      data = Page.fromJson(temp);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map<String, dynamic>();
    map['timestamps'] = this.timestamps;
    map['status'] = this.status;
    map['msg'] = this.msg;
    map['data'] = this.data;
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
BasePage<T> json2WLPage<T>(Map<String, dynamic> map) {
  return BasePage.fromJson(map);
}
