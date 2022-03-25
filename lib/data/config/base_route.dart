import 'package:get/get.dart';
import 'package:qinghe_ios/ui/page/home_page.dart';
import 'package:qinghe_ios/ui/page/mine_page.dart';

abstract class BaseRoute{
  static const String Initial="/";
  static const String Mine="/Mine";
}

abstract class BasePage {
  static final List<GetPage> pages = [
    GetPage(name: BaseRoute.Initial, page: () => HomePage()),
    GetPage(name: BaseRoute.Mine, page: () => MinePage(),transition: Transition.rightToLeft),
  ];
}
