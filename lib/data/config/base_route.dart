import 'package:get/get.dart';
import 'package:may/controller/fourth_controller.dart';
import 'package:may/ui/page/Initial_page.dart';
import 'package:may/ui/page/fifth_page.dart';
import 'package:may/ui/page/fourth_page.dart';
import 'package:may/ui/page/second_page.dart';
import 'package:may/ui/page/splash_page.dart';
import 'package:may/ui/page/third_page.dart';

class BaseRoute {
  // static String Splash = DataConfig.getIns().isFirstUseApp ? "/" : "/Splash";
  // static String Initial = DataConfig.getIns().isFirstUseApp ? "/Initial" : "/";
  static String Splash = "/";
  static String Initial = "/Initial";
  static String Second = "/Second";
  static const String Third = "/Third";
  static const String Fourth = "/Fourth";
  static const String Fifth = "/Fifth";
}

class BasePage {
  static final List<GetPage> pages = [
    GetPage(name: BaseRoute.Splash, page: () => const SplashPage()),
    GetPage(name: BaseRoute.Initial, page: () => const InitialPage()),
    GetPage(name: BaseRoute.Second, page: () => const SecondPage()),
    GetPage(name: BaseRoute.Third, page: () => const ThirdPage()),
    GetPage(
      name: BaseRoute.Fourth,
      page: () => const FourthPage(),
      binding: BindingsBuilder(() => FourthController.put),
    ),
    GetPage(name: BaseRoute.Fifth, page: () => FifthPage()),
  ];
}
