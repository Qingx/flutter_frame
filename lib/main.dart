import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/controller/count_controller.dart';
import 'package:qinghe_ios/ui/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CountController(),tag: "count");

    return GetMaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
