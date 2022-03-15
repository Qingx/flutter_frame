import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qinghe_ios/r.dart';
import 'package:qinghe_ios/config/base_extension.dart';

abstract class BaseWidget {
  static dynamic emptyFunction() {}

  static Widget statusBar({
    required BuildContext context,
    Color? color = Colors.white,
  }) {
    return Container(
      height: MediaQuery.of(context).padding.top,
    );
  }

  static Widget topBar({
    String? name = "Page Name",
    bool? hasBack = true,
    bool? hasTitle = true,
    Color? bgColor = Colors.white,
    Color? titleColor = Colors.white,
    Function? onBack = emptyFunction,
  }) {
    return Container(
      height: 40,
      color: bgColor,
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: hasBack!,
            replacement: const SizedBox(
              width: 40,
              height: 40,
            ),
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                R.assetsImgTopBarBack,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ).onClick(onBack!),
          ),
          Visibility(
            visible: hasTitle!,
            child: Text(
              name!,
              style: TextStyle(
                color: titleColor,
                fontSize: 17,
                decoration: TextDecoration.none,
              ),
            ),
            replacement: const SizedBox(),
          ),
          const SizedBox(
            width: 40,
          ),
        ],
      ),
    );
  }
}
