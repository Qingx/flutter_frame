import 'package:qinghe_ios/generated/json/base/json_convert_content.dart';

class Page<T> {
  int size = 0;
  int pages = 0;
  int total = 0;
  int current = 0;
  bool? searchCount = false;

  List<T>? records = [];

  Page(
      {required this.size,
      required this.pages,
      required this.total,
      required this.current,
      required this.searchCount,
      this.records});

  /// 判断是否还有分页
  bool get hasData => current < pages;

  /// 判断分页列表是否为空
  bool get isDataEmpty => records?.isEmpty ?? true;

  Page.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    pages = json['pages'];
    total = json['total'];
    current = json['current'];
    records = JsonConvert.fromJsonAsT<List<T>>(json['records']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map<String, dynamic>();
    map['size'] = this.size;
    map['pages'] = this.pages;
    map['total'] = this.total;
    map['current'] = this.current;
    map['records'] = this.records;
    return map;
  }

  @override
  String toString() {
    return 'Page{size: $size, pages: $pages, total: $total, current: $current, searchCount: $searchCount, records: $records}';
  }
}
