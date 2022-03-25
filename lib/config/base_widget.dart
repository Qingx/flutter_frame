import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qinghe_ios/config/base_theme.dart';
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
    required BuildContext context,
    String? name = "Page Name",
    bool? hasBack = true,
    bool? hasTitle = true,
    Function? onBack = emptyFunction,
  }) {
    return Container(
      height: 40,
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
              alignment: Alignment.center,
              child: SvgPicture.asset(
                R.assetsImgTopBarBack,
                width: 22,
                height: 22,
                fit: BoxFit.contain,
                color: Theme.of(context).to.textColor,
              ),
            ).onClick(onBack!),
          ),
          Visibility(
            visible: hasTitle!,
            child: Text(
              name!,
              style: TextStyle(
                color: Theme.of(context).to.textColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
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

  static Widget testItemWidget(int index) {
    return Container(
      height: 80,
      color: Colors.primaries[index % Colors.primaries.length],
      alignment: Alignment.center,
      child: Text(
        '$index',
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

}
