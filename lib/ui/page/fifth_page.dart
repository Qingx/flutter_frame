import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FifthPage extends StatelessWidget {
  FifthPage() {
    log("wangxiang:0");
  }

  @override
  Widget build(BuildContext context) {
    var controller = WebViewController();


    log("wangxiang:1");
    return Scaffold(
      body: Container(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
