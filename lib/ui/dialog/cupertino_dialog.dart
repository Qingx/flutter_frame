import 'package:flutter/cupertino.dart';

const TextStyle _kCupertinoDialogTitleStyle = TextStyle(
  fontFamily: '.SF UI Display',
  inherit: false,
  fontSize: 17.0,
  fontWeight: FontWeight.w600,
  height: 1.3,
  letterSpacing: -0.5,
  textBaseline: TextBaseline.alphabetic,
);

const TextStyle _kCupertinoDialogContentStyle = TextStyle(
  fontFamily: '.SF UI Text',
  inherit: false,
  fontSize: 13.0,
  fontWeight: FontWeight.w400,
  height: 1.35,
  letterSpacing: -0.2,
  textBaseline: TextBaseline.alphabetic,
);

const TextStyle _kCupertinoDialogActionStyle = TextStyle(
  fontFamily: '.SF UI Text',
  inherit: false,
  fontSize: 16.8,
  fontWeight: FontWeight.w400,
  textBaseline: TextBaseline.alphabetic,
);

class MyCupertinoDialog extends StatefulWidget {
  const MyCupertinoDialog({Key? key}) : super(key: key);

  @override
  State<MyCupertinoDialog> createState() => _MyCupertinoDialogState();
}

class _MyCupertinoDialogState extends State<MyCupertinoDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 180,
    );
  }
}
