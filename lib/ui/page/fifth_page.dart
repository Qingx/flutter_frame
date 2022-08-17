import 'dart:developer';

import 'package:flutter/material.dart';

class FifthPage extends StatelessWidget {
  FifthPage() {
    log("wangxiang:0");
  }

  @override
  Widget build(BuildContext context) {
    log("wangxiang:1");
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextField(
                controller: TextEditingController(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
