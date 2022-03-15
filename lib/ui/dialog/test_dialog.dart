import 'package:flutter/material.dart';
import 'package:qinghe_ios/config/base_extension.dart';

Widget alertDialog({
  String? title = "",
  String? message = "",
  Widget? richTitle,
  Widget? richMessage,
}) {
  return Center(
    child: Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: const Color(0xddf2f2f2),
      child: Container(
        padding: const EdgeInsets.only(top: 18),
        width: 264,
        height: 152,
        child: Column(
          children: [
            const Text(
              "Reality check",
              style: TextStyle(
                fontSize: 17,
                color: Color(0xff333333),
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 4),
              width: double.infinity,
              child: RichText(
                text: const TextSpan(
                  text: "You’ve been on the app for  ",
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "13 minutes.",
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              width: double.infinity,
              color: Colors.grey,
              height: 1,
            ),
            Container(
              width: double.infinity,
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "LOG OUT",
                        style: TextStyle(
                          color: Color(0xFFFD274D),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "CONTINUE",
                        style: TextStyle(
                          color: Color(0xFF23589B),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget testGetDialog({
  required Function onDismiss,
  required Function onConfirm,
}) {
  return Center(
    child: Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: Colors.transparent,
      child: SizedBox(
        width: 260,
        height: 260,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              alignment: Alignment.center,
              child: const Text(
                "cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
            ).onClick(onDismiss),
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              alignment: Alignment.center,
              child: const Text(
                "confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
            ).onClick(onConfirm),
          ],
        ),
      ),
    ),
  );
}
