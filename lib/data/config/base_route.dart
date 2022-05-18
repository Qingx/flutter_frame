import 'package:get/get.dart';
import 'package:qinghe_ios/controller/fourth_controller.dart';
import 'package:qinghe_ios/ui/page/Initial_page.dart';
import 'package:qinghe_ios/ui/page/fourth_page.dart';
import 'package:qinghe_ios/ui/page/second_page.dart';
import 'package:qinghe_ios/ui/page/third_page.dart';

abstract class BaseRoute {
  static const String Initial = "/";
  static const String Second = "/Second";
  static const String Third = "/Third";
  static const String Fourth = "/Fourth";
}

abstract class BasePage {
  static final List<GetPage> pages = [
    GetPage(name: BaseRoute.Initial, page: () => InitialPage()),
    GetPage(name: BaseRoute.Second, page: () => SecondPage()),
    GetPage(name: BaseRoute.Third, page: () => ThirdPage()),
    GetPage(
      name: BaseRoute.Fourth,
      page: () => const FourthPage(),
      binding: BindingsBuilder(() => {FourthController.put}),
    ),
  ];
}
