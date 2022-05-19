import 'package:get/get.dart';
import 'package:qinghe_ios/controller/fourth_controller.dart';
import 'package:qinghe_ios/ui/page/Initial_page.dart';
import 'package:qinghe_ios/ui/page/fourth_page.dart';
import 'package:qinghe_ios/ui/page/second_page.dart';
import 'package:qinghe_ios/ui/page/third_page.dart';

class BaseRoute {
  static const String Initial = "/";
  static const String Second = "/Second";
  static const String Third = "/Third";
  static const String Fourth = "/Fourth";
}

class BasePage {
  static final List<GetPage> pages = [
    GetPage(name: BaseRoute.Initial, page: () => const InitialPage()),
    GetPage(name: BaseRoute.Second, page: () => const SecondPage()),
    GetPage(name: BaseRoute.Third, page: () => const ThirdPage()),
    GetPage(
      name: BaseRoute.Fourth,
      page: () => const FourthPage(),
      binding: BindingsBuilder(() => {FourthController.put}),
    ),
  ];
}
