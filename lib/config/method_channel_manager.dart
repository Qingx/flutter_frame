import 'dart:developer';

import 'package:flutter/services.dart';

class MethodChannelManager {
  static const startPageChannel = 'startPageChannel';

  static const pageMethod = "webviewMethod";

  static Future startNewPage() async {
    try {
      const platform = MethodChannel(startPageChannel);
      await platform.invokeMapMethod(pageMethod);
    } catch (e) {
      log("wangxiang");
    }
  }
}
