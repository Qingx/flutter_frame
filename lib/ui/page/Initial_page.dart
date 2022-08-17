import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_tool.dart';
import 'package:qinghe_ios/config/base_widget.dart';
import 'package:qinghe_ios/config/base_extension.dart';
import 'package:qinghe_ios/config/data_config.dart';
import 'package:qinghe_ios/controller/count_controller.dart';
import 'package:qinghe_ios/data/config/base_route.dart';
import 'package:qinghe_ios/theme/theme_bloc.dart';
import 'package:qinghe_ios/theme/theme_event.dart';
import 'package:qinghe_ios/ui/dialog/alert_dialog.dart';
import 'package:qinghe_ios/config/base_theme.dart';
import 'package:qinghe_ios/ui/page/fifth_page.dart';
import 'package:qinghe_ios/ui/page/second_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> with WidgetsBindingObserver {
  StreamSubscription<int>? _countStream;
  var isVisible = false;

  @override
  void initState() {
    super.initState();

    onSystemThemeChangedListener();
    // doSystemThemeChangedListener();
    updateCount();

    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();

    _countStream?.cancel();

    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("-didChangeAppLifecycleState-" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        doChangeVisible(true);
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        doChangeVisible(false);
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        doChangeVisible(true);
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
  }

  void doChangeVisible(bool value) {
    // isVisible = value;
    // setState(() {});
  }

  ///Bloc
  void doSystemThemeChangedListener() {
    var window = WidgetsBinding.instance!.window;
    window.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance?.handlePlatformBrightnessChanged();
      var brightness = window.platformBrightness;
      if (DataConfig.getIns().themeMode) {
        BaseTool.toast("themeType:${brightness.toString()}");
        DataConfig.getIns().themeType = brightness == Brightness.light ? 0 : 1;
      }
    };
  }

  ///Bloc
  void doFollowSystemChanged(bool value) {
    var window = WidgetsBinding.instance!.window;
    var state = window.platformBrightness;

    BlocProvider.of<ThemeBloc>(context).add(ThemeFollowSystemChangeEvent(state));
    setState(() {});
  }

  ///Bloc
  void doLocalThemeChanged(bool value) {
    BlocProvider.of<ThemeBloc>(context).add(const ThemeLocalChangeEvent());
    setState(() {});
  }

  ///GetX
  void onSystemThemeChangedListener() {
    var window = WidgetsBinding.instance!.window;
    window.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance?.handlePlatformBrightnessChanged();
      var brightness = window.platformBrightness;
      if (DataConfig.getIns().themeMode) {
        BaseTool.toast("themeType:${brightness.toString()}");
        DataConfig.getIns().themeType = brightness == Brightness.light ? 0 : 1;
      }
    };
  }

  ///GetX
  void onFollowSystemChanged(bool value) {
    var lastMode = DataConfig.getIns().themeMode;
    DataConfig.getIns().themeMode = !lastMode;

    if (!lastMode) {
      Get.changeThemeMode(ThemeMode.system);
      var window = WidgetsBinding.instance!.window;
      var state = window.platformBrightness;
      DataConfig.getIns().themeType = state == Brightness.light ? 0 : 1;
    } else {
      Get.changeThemeMode(Get.isDarkMode ? ThemeMode.dark : ThemeMode.light);
    }

    setState(() {});
  }

  ///GetX
  void onLocalThemeChanged(bool value) {
    var lastMode = DataConfig.getIns().themeMode;

    if (!lastMode) {
      var lastTheme = DataConfig.getIns().themeType;
      if (0 != lastTheme) {
        DataConfig.getIns().themeType = 0;
        Get.changeThemeMode(ThemeMode.light);
      } else {
        DataConfig.getIns().themeType = 1;
        Get.changeThemeMode(ThemeMode.dark);
      }

      setState(() {});
    }
  }

  void updateCount() {
    if (_countStream != null) {
      _countStream?.cancel();
    }

    _countStream =
        Stream.periodic(const Duration(milliseconds: 1000), (i) => i).take(120).listen((event) {
      CountController.find.setCount();

      // CountController.find.number.value.toString().printf;
      setState(() {});
    });
  }

  void resetCount() {
    _countStream?.cancel();

    CountController.find.reCount();
    updateCount();
    setState(() {});
  }

  void testClick() {
    // Get.snackbar("hi", "message");
    // Get.defaultDialog(title: "hi message");
    testDialog();
  }

  void testDialog() {
    Get.dialog(
      alertDialog(
        onDismiss: () {
          Get.back();
        },
        onConfirm: () {
          BaseTool.toast("onConfirm");
        },
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseWidget.appBar(title: "Initial"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 48,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 24, right: 24),
            margin: const EdgeInsets.only(top: 80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "主题模式跟随系统",
                  style: TextStyle(
                    color: Theme.of(context).to.widgetColor,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
                Switch(
                  value: DataConfig.getIns().themeMode,
                  onChanged: onFollowSystemChanged,
                ),
              ],
            ),
          ),
          Visibility(
            visible: !DataConfig.getIns().themeMode,
            replacement: const SizedBox(
              width: double.infinity,
              height: 48,
            ),
            child: Container(
              height: 48,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "开启暗黑模式",
                    style: TextStyle(
                      color: Theme.of(context).to.textColor,
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Switch(
                    value: DataConfig.getIns().themeType == 1,
                    onChanged: onLocalThemeChanged,
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 80,
            margin: const EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).to.widgetColor,
            ),
            child:  const Text(
              "dialog",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
          ).onClick(testClick),
          Text(
            CountController.find.number.string,
            style: TextStyle(
              color: Theme.of(context).to.widgetColor,
              fontSize: 24,
              decoration: TextDecoration.none,
            ),
          ).marginOn(top: 32),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.only(bottom: 80),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: Theme.of(context).toggleableActiveColor,
                ),
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
              ).onClick(resetCount),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.only(bottom: 80, left: 24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: Theme.of(context).toggleableActiveColor,
                ),
                child: const Text(
                  "Next Page",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
              ).onClick(() {
                Get.toNamed(BaseRoute.Fifth);
                // Get.to(SecondPage());
              }),
            ],
          ),
          Expanded(
            child: Visibility(
              visible: isVisible,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
