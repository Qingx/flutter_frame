import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qinghe_ios/config/base_theme.dart';
import 'package:qinghe_ios/r.dart';
import 'package:qinghe_ios/config/base_extension.dart';

abstract class BaseWidget {
  static dynamic emptyFunction() {}

  static AppBar appBar({
    Color? iconColor,
    Color? backgroundColor,
    Color? shadowColor = Colors.transparent,
    Color? textColor,
    bool? centerTitle = true,
    String? title = "",
  }) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor ?? Get.theme.to.textColor),
      backgroundColor: backgroundColor ?? Get.theme.scaffoldBackgroundColor,
      shadowColor: shadowColor,
      title: Text(
        title!,
        style: TextStyle(color: textColor ?? Get.theme.to.textColor),
      ),
      centerTitle: centerTitle,
    );
  }

  static Widget testItemWidget(int index, {String? content}) {
    return Container(
      height: 80,
      color: Colors.primaries[index % Colors.primaries.length],
      alignment: Alignment.center,
      child: Text(
        content ?? "$index",
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  static Widget normalErrorWidget(String error) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(R.assetsImgNormalError, width: Get.width / 2, fit: BoxFit.contain),
          Text(error, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }

  static Widget normalEmptyWidget(String notice) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(R.assetsImgNormalEmpty, width: Get.width / 2, fit: BoxFit.contain),
          Text(notice, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }
}
