import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:may/config/base_extension.dart';
import 'package:may/config/base_theme.dart';

Widget alertDialog({
  String? title = "",
  String? message = "",
  Widget? richTitle,
  Widget? richMessage,
  required VoidCallback onConfirm,
  required VoidCallback onDismiss,
}) {
  return Center(
    child: Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      color: Get.theme.to.dialogColor,
      child: Container(
        width: 270,
        height: 180,
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
            ).marginOn(left: 20,right: 20,top: 20),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
              color: const Color(0xFF8F8F8F),
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
                    ).onClick(onDismiss),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: const Color(0xFF8F8F8F),
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
                    ).onClick(onConfirm),
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