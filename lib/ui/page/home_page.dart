import 'dart:async';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<int>? _countStream;

  @override
  void initState() {
    super.initState();

    onSystemThemeChangedListener();
    // doSystemThemeChangedListener();
    updateCount();
  }

  @override
  void dispose() {
    super.dispose();

    _countStream?.cancel();
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

    BlocProvider.of<ThemeBloc>(context)
        .add(ThemeFollowSystemChangeEvent(state));
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
        // Get.changeTheme(TestTheme.light);
        Get.changeThemeMode(ThemeMode.light);
      } else {
        DataConfig.getIns().themeType = 1;
        // Get.changeTheme(TestTheme.dark);
        Get.changeThemeMode(ThemeMode.dark);
      }

      setState(() {});
    }
  }

  void updateCount() {
    if (_countStream != null) {
      _countStream?.cancel();
    }

    _countStream = Stream.periodic(const Duration(milliseconds: 1000), (i) => i)
        .take(120)
        .listen((event) {
      CountController.to.setCount();

      CountController.to.number.value.toString().printf;
      setState(() {});
    });
  }

  void resetCount() {
    _countStream?.cancel();

    CountController.to.reCount();
    updateCount();
    setState(() {});
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BaseWidget.statusBar(context: context),
          BaseWidget.topBar(
            context: context,
            name: "Home",
            hasBack: false,
          ),
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
            child: const Text(
              "dialog",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
          ).onClick(testDialog),
          Text(
            CountController.to.number.string,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                Get.toNamed(BaseRoute.Third);
              }),
            ],
          )
        ],
      ),
    ).systemUI(context: context);
  }
}
