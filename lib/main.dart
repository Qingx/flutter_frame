import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:may/config/base_theme.dart';
import 'package:may/config/data_config.dart';
import 'package:may/controller/count_controller.dart';
import 'package:may/controller/user_controller.dart';
import 'package:may/data/config/base_route.dart';

void main() async {
  // ///GetStorage
  // await GetStorage.init();
  // runApp(const MyApp());

  ///SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  DataConfig.getIns().doAfterCreated(() {
    runApp(const MyApp());
  });

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    CountController.put;
    UserController.put;

    return GestureDetector(
      onTap: (){
        log("message==>onTap");
      },
      onPanCancel: (){
        log("message==>onPanCancel");
      },
      onPanEnd: (value){
        log("message==>onPanEnd");
      },
      child: GetMaterialApp(
        themeMode: DataConfig.getIns().themeMode
            ? ThemeMode.system
            : DataConfig.getIns().themeType == 0
                ? ThemeMode.light
                : ThemeMode.dark,
        theme: BaseTheme.light,
        darkTheme: BaseTheme.dark,
        debugShowCheckedModeBanner: false,
        getPages: BasePage.pages,
        defaultTransition: Transition.rightToLeft,
      ),
    );

    // ///GetX
    // return GetMaterialApp(
    //   themeMode: DataConfig.getIns().themeMode
    //       ? ThemeMode.system
    //       : DataConfig.getIns().themeType == 0
    //           ? ThemeMode.light
    //           : ThemeMode.dark,
    //   theme: BaseTheme.light,
    //   darkTheme: BaseTheme.dark,
    //   debugShowCheckedModeBanner: false,
    //   getPages: BasePage.pages,
    //   defaultTransition: Transition.rightToLeft,
    // );

    ///Bloc
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) => ThemeBloc()..add(const ThemeInitEvent()),
    //     ),
    //   ],
    //   child: BlocBuilder<ThemeBloc, ThemeState>(
    //     builder: (context, state) {
    //       var mode = state == ThemeState.Light
    //           ? ThemeMode.light
    //           : state == ThemeState.Dark
    //               ? ThemeMode.dark
    //               : ThemeMode.system;
    //       return MaterialApp(
    //         themeMode: mode,
    //         theme: BaseTheme.light,
    //         darkTheme: BaseTheme.dark,
    //         debugShowCheckedModeBanner: false,
    //         initialRoute: BaseRoute.Initial,
    //         home: const InitialPage(),
    //       );
    //     },
    //   ),
    // );
  }
}
