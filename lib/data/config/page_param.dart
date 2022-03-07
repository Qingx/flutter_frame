class PageParam {
  static const int INIT_PAGE = 1;
  static const int PAGE_NUM = 10;

  int size = PAGE_NUM; // 分页每页条数
  int current = INIT_PAGE; // 分页从1开始

  /// 转换为上传参数
  Map<String, dynamic> toParam({void Function(Map<String, dynamic> map)? doCreate}) {
    final Map<String, dynamic> map = Map<String, dynamic>();
    map['page'] = this.current;
    map['pageSize'] = this.size;
    if (doCreate != null) {
      doCreate(map);
    }
    return map;
  }

  /// 判断当前是否为刷新
  bool get isRefresh => current <= INIT_PAGE;

  /// 重置当前界面
  void reset() => current = INIT_PAGE;

  /// 驱动到下一页
  int next(int page) => (current = ++page);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageParam &&
          runtimeType == other.runtimeType &&
          size == other.size &&
          current == other.current;

  @override
  int get hashCode => size.hashCode ^ current.hashCode;

  @override
  String toString() {
    return 'PageParam{size: $size, current: $current}';
  }
}
