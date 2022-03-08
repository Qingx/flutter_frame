import 'package:qinghe_ios/data/config/page_param.dart';
import 'package:rxdart/rxdart.dart';

abstract class BasePageController<T> {
  var isLazyLoaded = false;
  final List<T> mData = [];
  final pageParam = PageParam();

  /// 懒加载数据
  void lazyLoad() {
    if (isLazyLoaded) return;
    isLazyLoaded = true;

    Rx.timer(1, Duration(milliseconds: 400)).listen((event) {
      loadData(false);
    });
  }

  void loadData(bool loadMore);

  /// 合并数据
  void concat(List<T> list, loadMore) {
    if (!loadMore) mData.clear();

    mData.addAll(list);
  }
}
